<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Carpeta extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function get_carpetadoc_dep($iddep){
        $this->db->select('idCarpeta');
        $this->db->where('idDepenCarpeta', $iddep);
        $this->db->where('idArchivoCarpeta', 1);
        $this->db->where('nivelCarpeta', Ficheros::getCarpetaSubRaiz());
        return $this->db->get('carpeta')->row();

    }
    private function eliminarDir($ruta_carpeta)
    {

        foreach(glob($ruta_carpeta . DS."*") as $archivos_carpeta)
        {
            // echo $archivos_carpeta;

            if (is_dir($archivos_carpeta))
            {
                $this->eliminarDir($archivos_carpeta);
            }
            else
            {
                unlink($archivos_carpeta);
            }
        }
        if(file_exists($ruta_carpeta))
            return rmdir($ruta_carpeta);


    }

    public function actualizar($values){
        $objCar = $this->get_obj($values['idCarpeta']);
        // print_rr($values);
        // echo $this->existeCarpetaDesc($values['descripcionCarpeta'], $objCar->nivelCarpeta);


        if(!$this->existeCarpetaDesc($values['descripcionCarpeta'],$objCar->nivelCarpeta,$objCar->idCarpeta)){
            $this->db->where('idCarpeta', $values['idCarpeta']);

            $this->db->update('carpeta', $values);
            // echo $this->db->affected_rows();
            if($this->db->affected_rows() >= 1){
                return true;
            }
        }else{

        }

        return false;
    }
    public function get_folder_uni_primernivel($iddepfolder, $idunidad){
        $this->db->select();
        $this->db->where('idDepenCarpeta', $idunidad);
        $this->db->where('nivelCarpeta', $iddepfolder);
        $this->db->where('idArchivoCarpeta', 1);
        return $this->db->get('carpeta')->result_object();
    }
    public function get_folder_dep($iddep){
        $this->db->select();
        $this->db->where('idDepenCarpeta', $iddep);
        $this->db->where('nivelCarpeta', Ficheros::getCarpetaSubRaiz());
        $this->db->where('idArchivoCarpeta', 1);
        return $this->db->get('carpeta')->row();

    }
    public function get_obj($id_carpeta){

        $this->db->select();
        $this->db->where('idCarpeta', $id_carpeta);
        $q = $this->db->get('carpeta');
        return $q->row();
    }
    public function getHijosTotalCarpeta($idCarpeta, &$carpetas){
            // if(!$carpetas)
            //     $carpetas = array();

            if(is_array($idCarpeta)){
                // echo 'XXXXXXXXXXXXXXXXXX||';
                $a = array();
                foreach ($idCarpeta as $key => $value) {
                    // print_rr($value);
                    $t = $this->getHijoCarpeta($value->idCarpeta);
                    // print_rr($t);
                    $a = array_merge($a,$t);
                }
                $b = array_merge($a,$idCarpeta);
                $carpetas = array_merge($carpetas,$idCarpeta);
                // echo '</br>_________________';
                // print_rr($idCarpeta);
                // echo '</br>_________________';
                if(count($a) > 0)
                    $carpetas = $this->getHijosTotalCarpeta($a,$carpetas);
                // if(count($a) == 0)
                //     return  array_merge($b,$carpetas);
                return $carpetas;
                // return array_merge($b,$carpetas);

            }else{
                $temp = $this->getHijoCarpeta($idCarpeta);
                // print_rr($temp);

                if(count($temp) > 0)
                    $carpetas = $this->getHijosTotalCarpeta($temp,$carpetas);

                // $idCarpeta = +$temp->idCarpeta;
                // $carpetas[] = $temp;
                // return array_merge($carpetas,$temp);
                return $carpetas;
            }
            // do{


            // }while($idCarpeta!=Ficheros::getCarpetaRaiz() && $idCarpeta!=Ficheros::getCarpetaSubRaiz());

            // $carpetas = array_reverse($carpetas);
            // print_rr($carpetas);
            // return $carpetas;
    }
    public function eliminar_carpeta($id_carpeta){
        $res['respuesta'] = false;
        $padre = $this->getPadreTotalCarpeta($id_carpeta);

        $pre_ruta = '';
        for ($i = 0 ; $i < count($padre); $i++) {
            $pre_ruta.=$padre[$i]->desCarpeta.DS;
        }
        // echo DOCSPATH.$pre_ruta;


        //eliminar carpetas y archivos de la BD
        $otra = array();
        $this->getHijosTotalCarpeta($id_carpeta,$otra);
        $id_carpeta_eliminar = array();
        foreach ($otra as $key => $value) {
            $id_carpeta_eliminar[] = $value->idCarpeta;
        }
        $id_carpeta_eliminar[] = $id_carpeta;
        // print_rr($id_carpeta_eliminar);
        if(is_dir(DOCSPATH.$pre_ruta)){
            $res['respuesta'] = $this->eliminarDir(DOCSPATH.$pre_ruta);
                // print_rr($padre);
        }
        foreach ($id_carpeta_eliminar as $key => $value) {
            $res['respuesta'] = true;
            $this->eliminar($value);
        }


        return $res;

    }
    public function eliminar($id){
        $this->db->where('idCarpeta', $id);
        $this->db->delete('carpeta');
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function existeId($idcarpeta){
         $this->db->select('idCarpeta');
        $this->db->where('idCarpeta', $idcarpeta);
        $q = $this->db->get('carpeta');
        if($q->row())
            return true;
        return false;
    }
    public function existeCarpeta($carpeta,$nivel){
        $this->db->select('desCarpeta');
        $this->db->where('desCarpeta', $carpeta);
        $this->db->where('nivelCarpeta', $nivel);
        $q = $this->db->get('carpeta');
        if($q->row())
            return true;
        return false;

    }
    public function existeCarpetaDesc($carpeta,$nivel, $idcar = false){

           $this->db->select();
            $this->db->where('descripcionCarpeta', $carpeta);
            $this->db->where('nivelCarpeta', $nivel);
            $this->db->where_not_in('idCarpeta', $idcar);
            $q = $this->db->get('carpeta')->row();
            // print_rr($q);
            if($q){
                return true;
                // if($idcar)
                //     return +$q->idCarpeta == +$idcar ? false : true;
                // else return true;
            }
            return false;
    }
    private function getDesCarpeta($titulo){
        $nt = trim(strtolower($titulo));
        $nt = preg_replace('/\s\s+/', ' ', $nt);
        $nt = preg_replace('/\s/', '_', $nt);
        return $nt;
    }
    public function getPadreTotalCarpeta($idCarpeta){
            $carpetas = array();
            do{
                $temp = $this->getPadreCarpeta($idCarpeta);
                // print_rr($temp);
                $idCarpeta = +$temp->nivelCarpeta;
                $carpetas[] = $temp;

            }while($idCarpeta!=Ficheros::getCarpetaRaiz() && $idCarpeta!=Ficheros::getCarpetaSubRaiz());

            $carpetas = array_reverse($carpetas);
            return $carpetas;
    }
    public function crearCarpetaDocDep($values){
        $this->db->set('fechaCarpeta','now()',false);

        while($this->existeCarpeta($values['desCarpeta'],$values['nivelCarpeta'])){
            $values['desCarpeta'] .= '0';
        }
        $q = $this->db->insert('carpeta',$values);
        mkdir(DOCSPATH.$values['desCarpeta'], 0700);
    }
    public function crearCarpetaGeneral($values){
        $res = array(
            'proceso' => false,
            'mensaje' => ''
            );
        $this->db->set('fechaCarpeta','now()',false) ;
        // $values['fechaCarpeta'] = 'now()';
        $values['desCarpeta'] = $this->getDesCarpeta($values['descripcionCarpeta']);
        while($this->existeCarpeta($values['desCarpeta'],$values['nivelCarpeta'])){
            $values['desCarpeta'] .= '0';
        }
        if(!$this->existeCarpetaDesc($values['descripcionCarpeta'],$values['nivelCarpeta'])){
            // print_rr($this->db);
            $q = $this->db->insert('carpeta',$values);
            if($q){
                $res['id_carpeta'] = $this->db->insert_id();

                $res['proceso'] = true;
                $res['mensaje'] = 'Carpeta creada';
                if(!file_exists(DOCSPATH)){
                    // echo 'crear carpeta docs';
                    mkdir(DOCSPATH,700);
                    // echo 'sí';
                }
                $tt = $this->getPadreTotalCarpeta($res['id_carpeta']);
                // print_rr($tt);
                $pre_ruta = '';
                for ($i = 0 ; $i < count($tt) - 1; $i++) {
                    $pre_ruta.=$tt[$i]->desCarpeta.DS;
                    if(!file_exists(DOCSPATH.$pre_ruta))
                        mkdir(DOCSPATH.$pre_ruta, 0700);
                }
                // echo $pre_ruta;
                // echo '<br>';
                // echo DOCSPATH.$pre_ruta.$values['desCarpeta'];
                // exit;
                mkdir(DOCSPATH.$pre_ruta.$values['desCarpeta'], 0700);


                $this->db->where('nivelCarpeta', Ficheros::getCarpetaRaiz());
                //Cambiar
                //valor order de datatable
                $this->db->order_by('desCarpeta', 'asc');
                // $this->db->order_by('descripcionCarpeta', 'desc');
                $q = $this->db->get('carpeta');

                $r = $q->result();
                // print_rr($r);
                $i = 1;
                foreach ($r as $key => $value) {
                    if($value->idCarpeta == $res['id_carpeta'])
                        break;
                    $i++;
                }
                //obtener el paginador en base al lennght del datatable
                $lenght = 10;
                $res['num_lugar'] = $i ;
                $res['num_paginador'] = floor($i/$lenght);
                $res['num_paginador_aa'] = $res['num_lugar']%10;
                // var_dump((+$res['num_paginador']%10) == 0);
                if((+$res['num_lugar']%10) == 0){
                    // echo 'si pe';
                    $res['num_paginador'] = $res['num_paginador'] - 1;
                }

                // print_rr($i);


            }else{
                $res['proceso'] = true;
                $res['mensaje'] = 'Error en DB';
            }
            // echo $this->db->last_query();
            return $res;

        }
        $res['mensaje'] = 'El nombre de carpeta ys existe';
        return $res;

    }
    public function listarCarpetas($idDependencia, $idCarpetaPadre = 7777){
         // $sql="SELECT * FROM dependencia, carpeta, archivo WHERE idDepend = idDepenCarpeta AND idArchivoCarpeta=idArchivo AND idDepend ='$id' AND nivelCarpeta='7777' ORDER BY desCarpeta ASC";
        // $sql = "select*from carpeta";
        $this->db->select();
        $this->db->where('idDepenCarpeta', $idDependencia);
        $this->db->where('nivelCarpeta', $idCarpetaPadre);
        $this->db->order_by('desCarpeta', 'asc');
        $q = $this->db->get('carpeta');
        return $q->result();
    }
    public function listarCategorias($visible = false){
        $this->db->select(array(
            'idArchivo',
            'nomArchivo',
            'estadoArchivo','url'
            ));
        if(!$visible)
            $this->db->where('estadoArchivo', 1);

        $this->db->order_by('nomArchivo', 'asc');
        $q = $this->db->get('archivo');

        return $q->result();
    }
    public function getPadreCarpeta($idCarpetaPadre){

        $this->db->select(array(
            'idCarpeta',
            'desCarpeta',
            'nivelCarpeta',
            'descripcionCarpeta',
            'idDepenCarpeta'
            ));
        $this->db->where('idCarpeta', $idCarpetaPadre);
        $q = $this->db->get('carpeta');
        return $q->row();

    }
    public function getHijoCarpeta($idCarpetaPadre, $visible = false){

        $this->db->select(array('idCarpeta','desCarpeta','nivelCarpeta','descripcionCarpeta'));
        $this->db->where('nivelCarpeta', $idCarpetaPadre);
        if($visible)
            $this->db->where('estadoCarpeta', $visible);
        $q = $this->db->get('carpeta');
        return $q->result();

    }
    public function getPadreCarpeta2($idCarpetaPadre){

        $this->db->select(array('idCarpeta','desCarpeta','nivelCarpeta'));
        $this->db->where('nivelCarpeta', $idCarpetaPadre);
        $q = $this->db->get('carpeta');
        return $q->row();

    }

    public function getCarpeta($idCarpeta){
        $this->db->select();
        $this->db->where('idCarpeta', $idCarpeta);
        $q = $this->db->get('carpeta');
        return $q->row();
    }

    public function actualizarCarpeta(Ficheros $objF){
        // print_r($objF);exit;
        $data = array(
            'descripcionCarpeta' => $objF->Descripcion,
            'idArchivoCarpeta' => $objF->CategoriaFichero,
            'estadoCarpeta' => $objF->Estado
            );
        $this->db->where('idCarpeta', $objF->IdFichero);
        $this->db->update('carpeta', $data);

        return $this->db->affected_rows() >= 1 ? true : false;

    }

    public function listar_datatable(){

    }
    public function listar_by_categoria($categoria, $visible = false, $nivel = false, $order = false){
        $this->db->select();
        $this->db->where('idArchivoCarpeta', $categoria);
        if($nivel)
            $this->db->where('nivelCarpeta', $nivel);
        if($visible)
            $this->db->where('estadoCarpeta', $visible);
        if($order)
            $this->db->order_by('descripcionCarpeta', $order);
        $q = $this->db->get('carpeta');
        // echo $this->db->last_query();
        return $q->result();
    }

    public function listar_by_unidad($id_unidad, $niveles = array()){
        $this->db->select();
        $this->db->where('idDepenCarpeta', $id_unidad);
        $this->db->where('estadoCarpeta', 9);
        $this->db->where('idArchivoCarpeta != 1');
        if($niveles)
            $this->db->where_in('nivelCarpeta', $niveles);

        $q = $this->db->get('carpeta');

        return $q->result();
    }

    // public function listar_by_depatamento($id_departamento){
    //     $this->db->select();
    //     $this->db->where('idDepenCarpeta', $id_departamento);
    //     $this->db->where('estadoCarpeta', $id_departamento);
    //     $this->db->where('idArchivoCarpeta != 1');
    //     $q = $this->db->get('carpeta');
    //     return $q->result();
    // }

}