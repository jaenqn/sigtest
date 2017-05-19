<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_PeligroCategoria extends CI_Model {

    private $table = 'tbl_categorias';
    private $class = 'ent_categorias';
    private $id = 'cat_id';

    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }



    public function insertar(ent_categorias &$obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        if($this->db->insert($this->table, $values))
            $obj->cat_id = $this->db->insert_id();

        return $this->db->affected_rows() == 1 ? true : false;

    }

    public function listar($active = false){
        $this->db->select();
        // $this->db->from('unidades');
        // $this->db->join('departamentos', 'departamentos.dep_id = unidades.dep_id_departamento');
        if($active)//1 activo, 0 inactivo
             $this->db->where('cat_estado', $activo);
        $q = $this->db->get($this->table);
        // $lst = $q->result();
        // print_rr($lst);exit;
        $lst = $q->custom_result_object($this->class);
        return $lst;
    }
    public function listar_peligro($activo = false){
        $this->db->select();
        $this->db->where('cat_tipo_peligro', 1);
        if($activo)
            $this->db->where('cat_estado', $activo);
        $q = $this->db->get($this->table);
        $lst = $q->result_object();
        return $lst;
    }
    public function listar_ambiental($activo = false){
        $this->db->select();
        $this->db->where('cat_tipo_peligro', 2);
        if($activo)
            $this->db->where('cat_estado', $activo);
        $q = $this->db->get($this->table);
        $lst = $q->result_object();
        return $lst;
    }
    public function get_obj(ent_categorias $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->cat_id);
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

    public function actualizar(ent_categorias $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->cat_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

}