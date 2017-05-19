
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_EmpreContra extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }

    public function insertar(EmpresaContratista &$obj){
        $this->db->insert('empresa_contratista', $obj);
        if($this->db->affected_rows() == 1){
            $obj->empc_id = $this->db->insert_id();
            return true;
        }
        return false;
        // return  ? true : false;

    }
    public function listar($order = 'empc_id', $type = 'asc'){
        $this->db->select();
        $this->db->order_by($order, $type);
        $q = $this->db->get('empresa_contratista');
        $lst = $q->custom_result_object('EmpresaContratista');
        return $lst;
    }

    public function eliminar($idEmpresa){
        $this->db->where('empc_id', $idEmpresa);
        $this->db->delete('empresa_contratista');

        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function actualizar(EmpresaContratista $obj){
        $this->db->where('empc_id', $obj->empc_id);
        $this->db->update('empresa_contratista', $obj);

        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function get_obj(EmpresaContratista $obj){
        $this->db->select();
        $this->db->where('empc_id', $obj->empc_id);
        $q = $this->db->get('empresa_contratista');
        return $q->custom_row_object(0, 'EmpresaContratista');
    }

}