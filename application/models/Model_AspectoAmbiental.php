<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_AspectoAmbiental extends CI_Model {
    private $table = 'tbl_aspecto_ambiental';
    private $class = 'ent_aspecto_ambiental';
    private $id = 'asp_id';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }



    public function insertar(ent_aspecto_ambiental $obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        $this->db->insert($this->table, $values);
        return $this->db->affected_rows() == 1 ? true : false;

    }

    public function listar(){
        $this->db->select();
        $q = $this->db->get($this->table);
        $lst = $q->custom_result_object($this->class);
        return $lst;
    }
    public function get_obj(ent_aspecto_ambiental $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->asp_id);
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

    public function actualizar(ent_aspecto_ambiental $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->asp_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

}