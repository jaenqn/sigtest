
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Riesgo extends CI_Model {

    private $table = 'tbl_riesgos';
    private $class = 'ent_riesgo';
    private $id = 'rie_id';

    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }



    public function insertar(ent_riesgo &$obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        if($this->db->insert($this->table, $values))
            $obj->rie_id = $this->db->insert_id();
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
    public function listar_by_peligro($idpel, $estado = false){
        $this->db->select();
        $this->db->where('pel_id_peligros', $idpel);
        if($estado)
            $this->db->where('rie_estado', +$estado);
        return  $this->db->get($this->table)->result_object();
    }
    public function get_obj(ent_riesgo $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->rie_id);
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
        return true;
    }

    public function actualizar(ent_riesgo $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->rie_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

}