
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Instalacion extends CI_Model {
    private $table = 'instalaciones';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }

    public function verificar_abbr($abbr, $id = false){
        $this->db->select('count(ins_abbr) as nrAbbr');
        $this->db->where('ins_abbr', $abbr);
        // $this->db->where('nivelDepend', 2);
        if($id){
            $this->db->where_not_in('ins_id',array($id));
        }
        $q = $this->db->get('instalaciones')->row();
        // print_rr($q);
        if(+$q->nrAbbr == 0) return true;
        return false;
    }
    public function getcompletdata($id_instalacio){
        $this->db->select();
        $this->db->where('ins_id', $id_instalacio);
        // db_
    }
    public function getdata($id_instalacio = false){
        $this->db->select();
        if($id_instalacio){
            $this->db->where('ins_id', $id_instalacio);
            return $this->db->get($this->table)->row();
        }else{
            return $this->db->get($this->table)->result_object();
        }
    }
    public function listar($order = 'ins_id',$type = 'asc'){
        $this->db->select();
        $this->db->order_by($order, $type);
        $q = $this->db->get($this->table);
        $lst = $q->custom_result_object('Instalaciones');
        return $lst;
    }
    public function insertar(Instalaciones $obj){
        $values = $this->db->fields_filter($obj,$this->table);
        $this->db->insert($this->table, $values);
        if($this->db->affected_rows() == 1){
            $obj->dep_id = $this->db->insert_id();
            return true;
        }
        return false;
    }
    public function get_obj(Instalaciones $obj){
        $this->db->select();
        $this->db->where('ins_id', $obj->ins_id);

        $q = $this->db->get($this->table);
        return $q->row();
        // return $q->custom_row_object(0, 'Instalaciones');
    }

    public function eliminar($id){
        $this->db->where('ins_id', $id);
        $this->db->delete($this->table);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function actualizar(Instalaciones $obj){
        // print_rr($obj);exit;
        $values = $this->db->fields_filter($obj,$this->table);
        // print_rr($values);
        // exit;
        $this->db->where('ins_id', $obj->ins_id);

        $this->db->update($this->table, $values);

        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }


}