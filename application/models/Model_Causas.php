<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Causas extends CI_Model {
    private $table = 'causas';
    private $class = 'Causas';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

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
    public function get_obj(Causas $obj)
    {
        $this->db->select();
        $this->db->where('cau_id', $obj->cau_id);
        $q = $this->db->get($this->table);
        return $q->custom_row_object(0, $this->class);
    }

    public function eliminar($id){
        $this->db->where('cau_id', $id);
        $this->db->delete($this->table);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

    public function actualizar(Causas $obj){
        $values = $this->db->fields_filter($obj,$this->table);
        $this->db->where('cau_id', $obj->cau_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function insertar(Causas $obj){
        $values = $this->db->fields_filter($obj,$this->table);
        $this->db->insert($this->table, $values);
        return $this->db->affected_rows() == 1 ? true : false;

    }
    // public function insertar_causa(Causas $objC){

    //     $this->db->insert('causas', $objC);
    //     return $this->db->affected_rows() == 1 ? true : false;
    // }

}