
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_ProcesosActividad extends CI_Model {
    private $table = 'tbl_procesos_actividad';
    private $class = 'ent_proceso_actividad';
    private $id = 'pac_id';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }

    public function listar_peligros_categoria_to_blancos($idact, $idpel = -1){
        $this->load->model('Model_PeligroCategoria','cate');
        $lstCate = $this->cate->listar_peligro(1);
        $tmplst = $this->getpeligros($idact);
        $idspel = array();
        foreach ($tmplst as $key => $value) {
            if($value->pel_id != $idpel)
                $idspel[] = $value->pel_id;
        }
        $final = array();
        foreach ($lstCate as $key => $value) {
            $this->db->select();
            $this->db->where('cat_id_categoria', $value->cat_id);
            if(count($idspel) > 0)
                $this->db->where_not_in('pel_id', $idspel);
            $lstE = $this->db->get('tbl_peligros')->result_object();
            if(count($lstE) > 0){
                $final[] = array(
                    'categoria' => $value->cat_nombre,
                    'elementos' => $lstE
                    );
            }
        }
        return $final;

    }
    public function listar_ambiental_categoria_to_blancos($idact, $idamb = -1){


        $this->load->model('Model_PeligroCategoria','cate');
        $lstCate = $this->cate->listar_ambiental(1);
        $tmplst = $this->getaspectos($idact);
        $idspel = array();
        foreach ($tmplst as $key => $value) {
            if($value->asp_id != $idamb) //evitar que un aspamb sea filtrado
                $idspel[] = $value->asp_id;
        }
        $final = array();
        foreach ($lstCate as $key => $value) {
            $this->db->select();
            $this->db->where('cat_id_categoria', $value->cat_id);
            if(count($idspel) > 0)
                $this->db->where_not_in('asp_id', $idspel);
            $lstE = $this->db->get('tbl_aspecto_ambiental')->result_object();
            if(count($lstE) > 0){
                $final[] = array(
                    'categoria' => $value->cat_nombre,
                    'elementos' => $lstE
                    );
            }
        }
        return $final;

    }

    public function getpeligros($idact){
        $this->db->select();
        $this->db->where('pac_id_actividad', $idact);
        $this->db->join('tbl_peligros p', 'p.pel_id = pa.pel_id_peligro');
        $lstP = $this->db->get('rel_actividad_blanco_peligro pa')->result_object();

        foreach ($lstP as $key => $value) {
            $ids = explode(',', $value->rie_id_riesgo);
            $this->db->select();
            $this->db->where_in('rie_id', $ids);
            $value->lst_riesgos = $this->db->get('tbl_riesgos')->result_object();
        }
        return $lstP;
    }
    public function getaspectos($idact){
        $this->db->select();
        $this->db->where('pac_id_actividad', $idact);
        $this->db->join('tbl_aspecto_ambiental a', 'a.asp_id = aa.asp_id_ambiental');
        $lstA = $this->db->get('rel_actividad_blanco_aspamb aa')->result_object();

        foreach ($lstA as $key => $value) {
            $ids = explode(',', $value->imp_id_impacto);
            $this->db->select();
            $this->db->where_in('imp_id', $ids);
            $value->lst_impactos = $this->db->get('tbl_impacto_ambiental')->result_object();
        }
        return $lstA;

    }
    public function insertar(ent_proceso_actividad &$obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        if($this->db->insert($this->table, $values))
            $obj->pac_id = $this->db->insert_id();
        return $this->db->affected_rows() == 1 ? true : false;

    }
    public function listar_by_etapa($idpet){
        $this->db->select();
        $this->db->where('pet_id_procesos_etapa', $idpet);
        return $this->db->get('tbl_procesos_actividad')->result_object();
    }
    public function listar(){
        $this->db->select();
        // $this->db->from('unidades');
        // $this->db->join('departamentos', 'departamentos.dep_id = unidades.dep_id_departamento');
        $q = $this->db->get($this->table);
        // $lst = $q->result();
        // print_rr($lst);exit;
        $lst = $q->custom_result_object($this->class);
        return $lst;
    }
    public function get_obj(ent_proceso_actividad $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->pac_id);
        $this->db->join('tbl_procesos_etapa', 'tbl_procesos_etapa.pet_id = '.$this->table.'.pet_id_procesos_etapa');
        $this->db->join('tbl_procesos', 'tbl_procesos.pro_id = tbl_procesos_etapa.pro_id_proceso');
        $this->db->join('dependencia d', 'd.idDepend = tbl_procesos.uni_id_unidad');
        $q = $this->db->get($this->table);
        return $q->custom_row_object(0, $this->class);
    }

    public function eliminar($id){
        $this->db->where($this->id, $id);
        $this->db->delete($this->table);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

    public function actualizar(ent_proceso_actividad $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->pac_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }




}