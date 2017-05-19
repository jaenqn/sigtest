
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Categorias extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function listarCategorias(){
        // $sql="SELECT * FROM archivo ORDER BY nomArchivo ASC";
        $this->db->select();
        $this->db->order_by('nomArchivo','ASC');
        $q = $this->db->get('archivo');
        return $q->result();
    }

    public function insert($values){
        $this->db->set($values);
        $this->db->set('fechaArchivo','now()',false);
        $q = $this->db->insert('archivo');
        return $q;
        return false;
    }

    public function delete($id){
        $this->db->where('idArchivo', $id);
        $q = $this->db->delete('archivo');
        return $q;
    }

    public function update($values){
        $this->db->set($values);
        $this->db->where('idArchivo', $values['idArchivo']);
        $q = $this->db->update('archivo');
        return $q;
    }
    public function get_object($id){
        $this->db->select();
        $this->db->where('idArchivo', $id);
        return $this->db->get('archivo')->row();

    }
}