
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Residuos extends CI_Model {
    private $table_origen = 'tbl_residuos_origen';
    private $table = 'tbl_residuos';
    private $class_origen = 'OrigenResiduos';
    private $class = 'ent_residuo';

    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function get_almacenes_ingreso(){
        $q = '
            SELECT
            ar.*
            FROM tbl_residuos_solicitud rs
            JOIN almacen_residuos ar ON ar.`alm_id` = rs.`alm_id_almacenamiento`
            WHERE rs.`rss_autorizado` = 1
            GROUP BY (rs.`alm_id_almacenamiento`)

        ';
        return $this->db->query($q)->result_object();
    }
    public function get_deps_en_ingresos($opc, $iddep = 0){
        switch ($opc) {
            case 1:
                $q = '
                    SELECT
                    dd.*
                    FROM tbl_residuos_solicitud rs
                    JOIN dependencia d ON d.`idDepend` = rs.`uni_id_unidad_remitente`
                    JOIN dependencia dd ON dd.`idDepend` = d.`reportaDpend`
                    WHERE rs.`rss_autorizado` = 1
                    GROUP BY (d.`reportaDpend`)
                ';
                break;
            case 2:
                $q = '
                    SELECT
                    d.*
                    FROM tbl_residuos_solicitud rs
                    JOIN dependencia d ON d.`idDepend` = rs.`uni_id_unidad_remitente`
                    WHERE rs.`rss_autorizado` = 1 AND
                    d.`reportaDpend` = '.$iddep.'
                    GROUP BY (d.`reportaDpend`)

                ';
                break;
        }

        return $this->db->query($q)->result_object();

    }
    public function eliminar_declaracion($iddec){
        $this->db->where('rd_id_declaracion', $iddec);
        $this->db->delete('rel_resdec_fuente');

        $this->db->where('rd_id', $iddec);
        $this->db->delete('tbl_residuos_declaracion');
    }
    public function get_residuos_declaracion(){
        $this->db->select('tbl_residuos.*');
        $this->db->group_by('res_id_residuo');
        $this->db->join('tbl_residuos', 'tbl_residuos.res_id = tbl_residuos_declaracion.res_id_residuo');
        return $this->db->get('tbl_residuos_declaracion')->result_object();
    }
    public function getdatadeclaracion($iddec){

        $this->db->select();
        $this->db->where('rd_id', $iddec);
        $this->db->join('instalaciones', 'instalaciones.ins_id = tbl_residuos_declaracion.ins_id_instalacion');
        $this->db->join('tbl_residuos', 'tbl_residuos.res_id = tbl_residuos_declaracion.res_id_residuo');
        $lst = $this->db->get('tbl_residuos_declaracion')->row();

        $this->load->model('Model_Unidad','uni');
        $values['idInstalacion'] = $this->uni->listar_by_instalacion($lst->ins_id_instalacion);
        $values['idResiduo'] = $lst->res_id_residuo;
        $values['idYear'] = $lst->rd_year;
        $lst->datatotal = $this->reporte_residuo_declaracion($values);

        $lst->rd_fuentes = array();
        $this->db->select();
        $this->db->where('rd_id_declaracion', $lst->rd_id);
        $lst->rd_fuentes = $this->db->get('rel_resdec_fuente')->result_object();

        return $lst;
        // print_rr($lst);
    }
    public function registrar_declaracion($values){
        $fixval = $this->db->fields_filter($values,'tbl_residuos_declaracion',true);
        // print_rr($fixval);
        $this->db->insert('tbl_residuos_declaracion', $fixval);

        $isdec = $this->db->insert_id();
        $ret = $this->db->affected_rows() > 0 ? true : false;
        foreach ($values['fuentes'] as $key => $valueF) {
            $valueF['rd_id_declaracion'] = $isdec;
            $this->insertar_fuentes_declara($valueF);
        }
        return $ret;

    }
    public function actualizar_fuente_dec($values){
        $valF = $this->db->fields_filter($values,'rel_resdec_fuente',true);
        $this->db->set($valF);
        $this->db->where('rdf_id', $values['rdf_idsss']);
        $this->db->update('rel_resdec_fuente');
    }
    public function eliminar_fuente_dec($idfd){
        $this->db->where('rdf_id', $idfd);
        $this->db->delete('rel_resdec_fuente');
    }
    public function actualizar_declaracion($values){
        $fixval = $this->db->fields_filter($values,'tbl_residuos_declaracion',true);
        $this->db->set($fixval);
        $this->db->where('rd_id', $values['rd_id']);
        $this->db->update('tbl_residuos_declaracion');
        // $values['fuentes']['rd_id_declaracion']
        foreach ($values['fuentes'] as $key => $valF) {
            if($valF['rdf_idsss'] == 'new-data')
                $this->insertar_fuentes_declara($valF);
            else
                $this->actualizar_fuente_dec($valF);
        }
        return true;
    }
    public function insertar_fuentes_declara($values){
        $valF = $this->db->fields_filter($values,'rel_resdec_fuente',true);
        $this->db->insert('rel_resdec_fuente', $valF);
    }
    public function listar_by_solicitud($idinstalacion, $year){
        //identificar todas las unidades que pertenecen a la instlación
        $this->load->model('Model_Unidad','uni');
        $lstRes = $this->uni->listar_by_instalacion($idinstalacion);
        if(count($lstRes) == 0){
            return array();
            exit;
        }
        // print_rr($lstRes);
        $this->db->select('tbl_residuos.*');
        $this->db->join('tbl_residuos', 'tbl_residuos.res_id = tbl_residuos_solicitud.res_id_residuo');
        // $this->db->where('uni_id_unidad_remitente', $idinstalacion);
        $this->db->where('YEAR(rss_fecha_autorizado)', $year);
        $this->db->where('rss_autorizado', 1);

        if(count($lstRes) > 0){
            $this->db->group_start();
            foreach ($lstRes as $key => $value) {
                $this->db->or_where('uni_id_unidad_remitente', $value->idDepend);
            }
            $this->db->group_end();
        }

        $this->db->group_by('res_id_residuo');
        $q = $this->db->get('tbl_residuos_solicitud')->result_object();
        // print_rr($this->db->last_query());
        return $q;
    }
    public function reporte_residuo_declaracion($values){
        $numIds = count($values['idInstalacion']);
        $qUni = '';
        $qUniDos = '';
        if($numIds > 0){
            if($numIds > 1){
                $qUni = ' AND (';
                $qUniDos = ' AND (';
                for ($i = 0; $i < $numIds; $i++) {
                    $qUni .= 'rsa.`uni_id_unidad_remitente` = '.$values['idInstalacion'][$i]->idDepend;
                    $qUniDos .= 'rs.`uni_id_unidad_remitente` = '.$values['idInstalacion'][$i]->idDepend;
                    if($i < ($numIds - 1)){
                        $qUni .=' OR ';
                        $qUniDos .=' OR ';
                    }
                }
                $qUni .= ')';
                $qUniDos .= ')';
                // echo $q;
            }else{
                $qUni .= ' AND rsa.`uni_id_unidad_remitente` = '.$values['idInstalacion'][0]->idDepend;
                $qUniDos .= ' AND rs.`uni_id_unidad_remitente` = '.$values['idInstalacion'][0]->idDepend;
            }
        }else{
            return array();
        }

        $queryMese = '';
        for ($i = 1; $i <=12 ; $i++) {
            $t = '
                (
                  SELECT SUM(rsa.rss_peso) FROM `tbl_residuos_solicitud` rsa
                  WHERE rsa.rss_autorizado = 1 AND
                  MONTH(rsa.rss_fecha_autorizado) = %1$d AND
                  rsa.res_id_residuo = rs.`res_id_residuo` AND
                  YEAR(rsa.`rss_fecha_autorizado`) = YEAR(rs.`rss_fecha_autorizado`)
                  '.$qUni.'
                  GROUP BY(rsa.res_id_residuo)
                ) AS resp_%1$d,
                (
                  SELECT SUM(rsa.rss_volumen) FROM `tbl_residuos_solicitud` rsa
                  WHERE rsa.rss_autorizado = 1 AND
                  MONTH(rsa.rss_fecha_autorizado) = %1$d AND
                  rsa.res_id_residuo = rs.`res_id_residuo` AND
                  YEAR(rsa.`rss_fecha_autorizado`) = YEAR(rs.`rss_fecha_autorizado`)
                  '.$qUni.'
                  GROUP BY(rsa.res_id_residuo)
                ) AS resv_%1$d,
                (
                  SELECT SUM(rsa.rss_unidades) FROM `tbl_residuos_solicitud` rsa
                  WHERE rsa.rss_autorizado = 1 AND
                  MONTH(rsa.rss_fecha_autorizado) = %1$d AND
                  rsa.res_id_residuo = rs.`res_id_residuo` AND
                  YEAR(rsa.`rss_fecha_autorizado`) = YEAR(rs.`rss_fecha_autorizado`)
                  '.$qUni.'
                  GROUP BY(rsa.res_id_residuo)
                ) AS resc_%1$d,
            ';
            $queryMese .= sprintf($t, $i);

        }
        $query = '
            SELECT
            r.res_nombre,
            rs.`res_id_residuo`,
            r.`res_peligro`,
           '.$queryMese.'
            SUM(rs.`rss_peso`) AS res_peso,
            SUM(rs.`rss_volumen`) AS res_volumen,
            SUM(rs.`rss_unidades`) AS res_cantidad
            FROM `tbl_residuos_solicitud` rs
            JOIN tbl_residuos r ON r.res_id = rs.res_id_residuo
            WHERE
            YEAR(rs.`rss_fecha_autorizado`) = %1$d AND
            rs.`res_id_residuo` = '.$values['idResiduo'].' AND
            rs.`rss_autorizado` = 1
            '.$qUniDos.'
            GROUP BY rs.`res_id_residuo`
        ';
        $query = sprintf($query, $values['idYear']);
        // print_rr($query);exit;
        $lst = $this->db->query($query)->row();
        // foreach ($lst as $key => $value) {
            foreach ($lst as $keyObj => $valueObj) {


                if($valueObj == '' || $valueObj == null) {$lst->$keyObj = 0;}

            }
        // }
        return $lst;
    }
    public function reporte_general($values){
        $queryMese = '';
        for ($i = 1; $i <=12 ; $i++) {
            $t = '
                (
                  SELECT SUM(rsa.rss_peso) FROM `tbl_residuos_solicitud` rsa
                  WHERE rsa.rss_autorizado = 1 AND
                  MONTH(rsa.rss_fecha_autorizado) = %1$d AND
                  rsa.res_id_residuo = rs.`res_id_residuo` AND
                  rsa.`uni_id_unidad_remitente` = rs.`uni_id_unidad_remitente` AND
                  YEAR(rsa.`rss_fecha_autorizado`) = YEAR(rs.`rss_fecha_autorizado`)
                  GROUP BY(rsa.res_id_residuo)
                ) AS res_%1$d,
            ';
            $queryMese .= sprintf($t, $i);

        }
        // $queryMese = $t;
        $queryRes = '';
        for ($i = 0; $i < count($values['residuos']); $i++) {
            $tt = 'rs.`res_id_residuo` = '.$values['residuos'][$i];
            if($i < (count($values['residuos'])) - 1){

                $queryRes .= $tt.' OR
                ';
            }else $queryRes .= $tt;

        }
        $queryRes = '('.$queryRes.')';
        if(+$values['unidad'] != -1)
            $queryUni = ' AND rs.`uni_id_unidad_remitente` = '.$values['unidad'].' AND';
        else $queryUni = ' AND ';
        $query = '
            SELECT
            r.res_nombre,
            rs.`res_id_residuo`,
           '.$queryMese.'
            SUM(rs.`rss_peso`) AS res_peso
            FROM `tbl_residuos_solicitud` rs
            JOIN tbl_residuos r ON r.res_id = rs.res_id_residuo
            WHERE
            YEAR(rs.`rss_fecha_autorizado`) = %1$d AND
            '.$queryRes.$queryUni.'
            rs.`rss_autorizado` = 1
            GROUP BY rs.`res_id_residuo`
        ';
        $query = sprintf($query, $values['date']);

        $lst = $this->db->query($query)->result_object();
        foreach ($lst as $key => $value) {
            if($value->res_1 == '' || $value->res_1 == null) $value->res_1 = 0;
            if($value->res_2 == '' || $value->res_2 == null) $value->res_2 = 0;
            if($value->res_3 == '' || $value->res_3 == null) $value->res_3 = 0;
            if($value->res_4 == '' || $value->res_4 == null) $value->res_4 = 0;
            if($value->res_5 == '' || $value->res_5 == null) $value->res_5 = 0;
            if($value->res_6 == '' || $value->res_6 == null) $value->res_6 = 0;
            if($value->res_7 == '' || $value->res_7 == null) $value->res_7 = 0;
            if($value->res_8 == '' || $value->res_8 == null) $value->res_8 = 0;
            if($value->res_9 == '' || $value->res_9 == null) $value->res_9 = 0;
            if($value->res_10 == '' || $value->res_10 == null) $value->res_10 = 0;
            if($value->res_11 == '' || $value->res_11 == null) $value->res_11 = 0;
            if($value->res_12 == '' || $value->res_12 == null) $value->res_12 = 0;

            if($value->res_peso == '' || $value->res_peso == null) $value->res_peso = 0;

        }
        return $lst;

        // print_rr($query);
    }
    public function reporte_general_solidos($year){
        $query = '
            SELECT
            MONTH(rs.`rss_fecha_autorizado`) as mes,
            (
                SELECT
                SUM(rsa.`rss_peso`)
                FROM tbl_residuos_solicitud rsa
                JOIN `tbl_residuos` ra ON ra.res_id = rsa.`res_id_residuo`
                WHERE rsa.`rss_autorizado` = rs.`rss_autorizado`
                AND ra.`res_organico` = 1
                AND ra.`res_peligro` = 0
                AND YEAR(rsa.`rss_fecha_autorizado`) = %1$d
                AND MONTH(rsa.rss_fecha_autorizado) = MONTH(rs.rss_fecha_autorizado)

            ) AS no_pel_org,
            (
                SELECT
                SUM(rsa.`rss_peso`)
                FROM tbl_residuos_solicitud rsa
                JOIN `tbl_residuos` ra ON ra.res_id = rsa.`res_id_residuo`
                WHERE rsa.`rss_autorizado` = rs.`rss_autorizado`
                AND ra.`res_organico` = 0
                AND ra.`res_peligro` = 0
                AND YEAR(rsa.`rss_fecha_autorizado`) = %1$d
                AND MONTH(rsa.rss_fecha_autorizado) = MONTH(rs.rss_fecha_autorizado)
            ) AS no_pel_ino,
            (
                SELECT
                SUM(rsa.`rss_peso`)
                FROM tbl_residuos_solicitud rsa
                JOIN `tbl_residuos` ra ON ra.res_id = rsa.`res_id_residuo`
                WHERE rsa.`rss_autorizado` = rs.`rss_autorizado`
                AND ra.`res_peligro` = 1
                AND YEAR(rsa.`rss_fecha_autorizado`) = %1$d
                AND MONTH(rsa.rss_fecha_autorizado) = MONTH(rs.rss_fecha_autorizado)

            ) AS pel,
            SUM(rs.`rss_peso`) as total_solidos
            FROM tbl_residuos_solicitud rs
            JOIN `tbl_residuos` r ON r.res_id = rs.`res_id_residuo`
            WHERE rs.`rss_autorizado` = 1
            AND r.`res_estado` = 1
            AND YEAR(rs.`rss_fecha_autorizado`) = %1$d
            GROUP BY MONTH(rs.rss_fecha_autorizado)
        ';

        $query = sprintf($query, $year);

        $lst = $this->db->query($query)->result_object();
        foreach ($lst as $key => $value) {
            if($value->no_pel_org == '' || $value->no_pel_org == null) $value->no_pel_org = 0;
            if($value->no_pel_ino == '' || $value->no_pel_ino == null) $value->no_pel_ino = 0;
            if($value->pel == '' || $value->pel == null) $value->pel = 0;
        }
        return $lst;
        // print_rr($lst);

    }
    public function get_years_residuos_by_ins($idins){
        $this->load->model('Model_Unidad','uni');
        $idUni = $this->uni->listar_by_instalacion($idins);
        $numIds = count($idUni);
        $qUni = '';
        if($numIds > 0){
            if($numIds > 1){
                $qUni = ' AND (';
                for ($i = 0; $i < $numIds; $i++) {
                    $qUni .= 'rs.`uni_id_unidad_remitente` = '.$idUni[$i]->idDepend;

                    if($i < ($numIds - 1)){
                        $qUni .=' OR ';

                    }
                }
                $qUni .= ')';

                // echo $q;
            }else{
                $qUni .= ' AND rs.`uni_id_unidad_remitente` = '.$idUni[0]->idDepend;

            }
            $q = '
                SELECT
                YEAR(rs.`rss_fecha_autorizado`) as get_year
                FROM tbl_residuos_solicitud rs
                WHERE rs.`rss_autorizado` = 1
                '.$qUni.'
                GROUP BY YEAR(rs.rss_fecha_autorizado)
                ORDER BY 1 ASC
            ';
            return $this->db->query($q)->result_object();
        }
        return array();

    }
    public function get_years_declaraciones(){
        $this->db->select('rd_year');
        $this->db->group_by('rd_year');
        return $this->db->get('tbl_residuos_declaracion')->result_object();

    }
    public function get_years_residuos(){
        $q = '
            SELECT
            YEAR(rs.`rss_fecha_autorizado`) as get_year
            FROM tbl_residuos_solicitud rs
            WHERE rs.`rss_autorizado` = 1
            GROUP BY YEAR(rs.rss_fecha_autorizado)
            ORDER BY 1 ASC
        ';
        return $this->db->query($q)->result_object();
    }
    public function registrar_incolucrados($values){
        $this->db->set($values);
        $this->db->insert('rel_res_solicitud_involucrados');
        return $this->db->insert_id();
    }
    public function autorizar_solicitud_residuo($id_residuo){
        $this->db->set(array(
            'rss_autorizado' => 1
            ));
        $this->db->set('rss_fecha_autorizado','now()',false);
        $this->db->where('rss_id', $id_residuo);
        $this->db->update('tbl_residuos_solicitud');
        if($this->db->affected_rows() > 0)
            return true;
        return false;
    }
    public function registrar_autorizacion($values){

        $fixval = $this->db->fields_filter($values,'tbl_residuos_solicitud',true);
        // exit;
        $this->db->set($fixval);
        $this->db->set('rss_fecha_solicitud','now()',false);
        $this->db->insert('tbl_residuos_solicitud');
        return $this->db->insert_id();
    }
    public function listar_by_opciones($opciones = false){
        $this->db->select();
        if($opciones){
            foreach ($opciones as $key => $value) {
                $this->db->where($value['col'], $value['val']);
            }
        }

        $this->db->from($this->table);
        return $this->db->get()->result_object();
    }
    public function insert(ent_residuo $obj)
    {
        // print_rr($obj);
        $values = $this->db->fields_filter($obj,$this->table,true);
        // print_rr($values);
        $this->db->insert($this->table, $values);
        return $this->db->affected_rows() == 1 ? true : false;
    }

    public function actualizar(ent_residuo $obj){
        $values = $this->db->fields_filter($obj,$this->table,true);
        // print_rr($values);exit;
        $this->db->where('res_id', $obj->res_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function eliminar($id){
        $this->db->db_debug = false;
        $this->db->where('res_id', $id);
        $this->db->delete($this->table);
        $referror = $this->db->error();
        // if(+$referror['code'] == 1451){
        //     //descativar el residuo
        //     $this->db->set(array(
        //         'res_activo' => 0
        //         ));
        //     $this->db->where('res_id', $id);
        //     $this->db->update('tbl_residuos');

        // }




        if($this->db->affected_rows() >= 1){
            return true;
        }
        $this->db->db_debug = true;
        return false;
    }
    public function get_obj(ent_residuo $obj)
    {
        $this->db->select();
        $this->db->where('res_id', $obj->res_id);
        // $this->db->join('unidades', 'unidades.uni_id = tbl_residuos_origen.uni_id_unidad');
        // $this->db->join('departamentos', 'departamentos.dep_id = unidades.column', 'left');
        $q = $this->db->get($this->table);
        return $q->row();
    }
    public function getsimpleresiduo($id){
        $this->db->select();
        $this->db->where('res_id', $id);
        return $this->db->get('tbl_residuos')->row();
    }
    public function getdatasimple($id_solicitud){
        $this->db->select();
        $this->db->where('rss_id', $id_solicitud);
        return $this->db->get('tbl_residuos_solicitud')->row();
    }
    public function getcompletedata($id_solicitud){
        $this->load->model('Model_Departamento','dep');
        $this->db->select(array(
            'tbl_residuos_solicitud.*',
            'r.*',
            'ro.*',
            'ar.*',
            'ec.*'

            ));
        $this->db->join('tbl_residuos r', 'r.res_id = tbl_residuos_solicitud.res_id_residuo');
        $this->db->join('tbl_residuos_origen ro', 'ro.rso_id = tbl_residuos_solicitud.rso_id_origen');
        $this->db->join('almacen_residuos ar', 'ar.alm_id = tbl_residuos_solicitud.alm_id_almacenamiento','left');
        $this->db->join('empresa_contratista ec', 'ec.empc_id = tbl_residuos_solicitud.empc_id_empresa');
        $this->db->where('rss_id', $id_solicitud);
        $objRes = $this->db->get('tbl_residuos_solicitud')->row();

        $objRes->unidad_generadora = $this->dep->get_obj_by_unidad($objRes->uni_id_unidad_remitente);
        $objRes->involucrados['elaborador'] = $this->get_involucrados($objRes->rss_id, 1);
        $objRes->involucrados['autorizador'] = $this->get_involucrados($objRes->rss_id, 2);
        return $objRes;
    }
    public function get_involucrados($id_solicitud, $tipo){
        $this->db->select();
        $this->db->where('rss_id_soliciud', $id_solicitud);
        $this->db->where('rsi_tipo_invo', $tipo);
        return $this->db->get('rel_res_solicitud_involucrados')->row();

    }
    public function insert_origen(OrigenResiduos $obj, $rid = false)
    {
        $values = $this->db->fields_filter($obj,$this->table_origen,true);
        $this->db->insert($this->table_origen, $values);
        if(!$rid)
            return $this->db->affected_rows() == 1 ? true : false;
        return $this->db->insert_id();
    }
    public function listar_origen()
    {
        $this->db->select();
        return $this->db->get('tbl_residuos_origen')->result_object();
    }
    public function listar(){
        $this->db->select();
        return $this->db->get($this->table)->result_object();
    }

    public function actualizar_origen(OrigenResiduos $obj){
        $values = $this->db->fields_filter($obj,$this->table_origen);
        $this->db->where('rso_id', $obj->rso_id);
        $this->db->update($this->table_origen, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function eliminar_origen($id){
        $this->db->where('rso_id', $id);
        $this->db->delete($this->table_origen);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function get_obj_origen(OrigenResiduos $obj)
    {
        $this->db->select();
        $this->db->where('rso_id', $obj->rso_id);
        $this->db->join('dependencia dd', 'dd.idDepend = tbl_residuos_origen.uni_id_unidad');
        // $this->db->join('departamentos', 'departamentos.dep_id = unidades.column', 'left');
        $q = $this->db->get($this->table_origen);
        return $q->row();
    }







}