
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_ProcesosEtapa extends CI_Model {
    private $table = 'tbl_procesos_etapa';
    private $class = 'ent_proceso_etapa';
    private $id = 'pet_id';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }



    public function insertar(ent_proceso_etapa &$obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        if($this->db->insert($this->table, $values)){
            $obj->pet_id = $this->db->insert_id();
        }
        return $this->db->affected_rows() == 1 ? true : false;

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
    public function get_obj(ent_proceso_etapa $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->pet_id);
        $this->db->join('tbl_procesos p ', 'p.pro_id = '.$this->table.'.pro_id_proceso');
        $this->db->join('dependencia d', 'd.idDepend = p.uni_id_unidad');
        $q = $this->db->get($this->table);
        return $q->row();
    }

    public function eliminar($id){
        $this->db->where($this->id, $id);
        $this->db->delete($this->table);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

    public function actualizar(ent_proceso_etapa $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->pet_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }


    public function listar_by_procesos($refid)
    {
        if(is_array($refid) && count($refid) > 1){
            $this->db->select();
            $this->db->where_in('pro_id_proceso', $refid);
            $this->db->order_by('pro_id_proceso', 'asc');
            $this->db->order_by('pet_orden', 'asc');
            $q = $this->db->get($this->table);

            return $q->result_object();
        }else if(is_array($refid)){
            $this->db->select();
            $this->db->where('pro_id_proceso', $refid[0]);
            $this->db->order_by('pet_orden', 'asc');
            $q = $this->db->get($this->table);

            return $q->result_object();
        }else{
            $this->db->select();
            $this->db->where('pro_id_proceso', $refid);
            $this->db->order_by('pet_orden', 'asc');
            $q = $this->db->get($this->table);
            return $q->result_object();
        }


    }





}