
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Almacen extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }

    public function insertar(AlmacenResiduos &$obj){
        $this->db->insert('almacen_residuos', $obj);
        if($this->db->affected_rows() == 1){
            $obj->empc_id = $this->db->insert_id();
            return true;
        }
        return false;
        // return  ? true : false;

    }
    public function listar(){
        $this->db->select();
        return $this->db->get('almacen_residuos')->result_object();
    }
    public function get_obj(AlmacenResiduos $obj){
        $this->db->select();
        $this->db->where('alm_id', $obj->alm_id);
        $q = $this->db->get('almacen_residuos');
        return $q->custom_row_object(0, 'AlmacenResiduos');
    }

    public function eliminar($id){
        $this->db->where('alm_id', $id);
        $this->db->delete('almacen_residuos');

        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function actualizar(AlmacenResiduos $obj){
        $this->db->where('alm_id', $obj->alm_id);
        $this->db->update('almacen_residuos', $obj);

        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

}