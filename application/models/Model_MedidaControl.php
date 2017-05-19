<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_MedidaControl extends CI_Model {
    private $table = 'tbl_medidas_control';
    private $id = 'mco_id';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }



    public function insertar($obj){
        $values = $this->db->fields_filter($obj, $this->table, true);

        $this->db->insert($this->table, $values);
        return $this->db->affected_rows() == 1 ? true : false;

    }
    public function listar_jerarquia_by_tipo($tipo = 0){
        $this->db->select('jm.*');
        $this->db->where('mco_tipo', $tipo);//riesgos 1, impacto 2
        $this->db->where('mco_estado', 1);
        $this->db->join('tbl_jerarquia_mc jm', 'jm.jmc_id = mc.mco_jerarquia');
        $this->db->group_by('mc.mco_jerarquia');
        return $this->db->get('tbl_medidas_control mc')->result_object();
    }
    public function listar_by_jerarquia_tipo($idj, $tipo){
        $this->db->select();
        $this->db->where('mco_jerarquia', $idj);
        $this->db->where('mco_tipo', $tipo);//riesgos 1, impacto 2
        $this->db->where('mco_estado', 1);
        return $this->db->get('tbl_medidas_control')->result_object();
    }
    public function listar(){
        $this->db->select();
        $q = $this->db->get($this->table);
        $lst = $q->result_object();
        return $lst;
    }
    public function get_obj($idmed)
    {
        $this->db->select();
        $this->db->where($this->id, $idmed);
        $this->db->join('tbl_jerarquia_mc j', 'j.jmc_id = tbl_medidas_control.mco_jerarquia');
        $q = $this->db->get($this->table);
        return $q->row();
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

    public function actualizar($obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj['mco_id']);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

}