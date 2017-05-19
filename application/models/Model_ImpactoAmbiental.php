<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_ImpactoAmbiental extends CI_Model {
    private $table = 'tbl_impacto_ambiental';
    private $class = 'ent_impacto_ambiental';
    private $id = 'imp_id';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }

    public function listar_by_aspecto($idasp, $estado = false){
        $this->db->select();
        $this->db->where('asp_id_aspecto_ambiental', $idasp);
        if($estado)
            $this->db->where('imp_estado', +$estado);
        return  $this->db->get($this->table)->result_object();
    }


    public function insertar(ent_impacto_ambiental &$obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        if($this->db->insert($this->table, $values))
            $obj->imp_id = $this->db->insert_id();
        return $this->db->affected_rows() == 1 ? true : false;

    }

    public function listar(){
        $this->db->select();
        $q = $this->db->get($this->table);
        $lst = $q->custom_result_object($this->class);
        return $lst;
    }
    public function get_obj(ent_impacto_ambiental $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->imp_id);
        // $this->db->join('unidades', 'unidades.uni_id = '.$this->table.'.uni_id_unidad');
        $q = $this->db->get($this->table);
        return $q->custom_row_object(0, $this->class);
    }

    public function eliminar($id){
        $this->db->db_debug = false;
        $this->db->where($this->id, $id);
        $is_del = $this->db->delete($this->table);
         if(!$is_del){
            return $this->db->error();
        }
        $this->db->db_debug = true;
        return true;
    }

    public function actualizar(ent_impacto_ambiental $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->imp_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

}