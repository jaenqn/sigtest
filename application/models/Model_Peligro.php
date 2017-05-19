
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Peligro extends CI_Model {
    private $table = 'tbl_peligros';
    private $class = 'ent_peligro';
    private $id = 'pel_id';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }



    public function insertar(ent_peligro &$obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        if($this->db->insert($this->table, $values))
            $obj->pel_id = $this->db->insert_id();
        return $this->db->affected_rows() == 1 ? true : false;

    }

    public function listar(){
        $this->db->select();
        $q = $this->db->get($this->table);
        $lst = $q->custom_result_object($this->class);
        return $lst;
    }
    public function listar_con_categoria(){
        $this->load->model('Model_PeligroCategoria','cate');
        $lstCate = $this->cate->listar_peligro(1);
        $final = array();
        foreach ($lstCate as $key => $value) {
            $this->db->select();
            $this->db->where('cat_id_categoria', $value->cat_id);
            $lstE = $this->db->get('tbl_peligros')->result_object();

            $final[] = array(
                'categoria' => $value->cat_nombre,
                'elementos' => $lstE
                );
        }
        return $final;

    }
    public function get_obj(ent_peligro $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->pel_id);
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

    public function actualizar(ent_peligro $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->pel_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

}