
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Procesos extends CI_Model {
    private $table = 'tbl_procesos';
    private $class = 'ent_proceso';
    private $id = 'pro_id';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }



    public function insertar(ent_proceso $obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        $this->db->insert($this->table, $values);
        $this->load->model('Model_AnalisiProceso','ana');
        $idpro = $this->db->insert_id();
        $values_analisi = array(
            'pro_id_proceso' => $idpro,
            'apr_estado' => 1

            );
        $this->ana->insertar($values_analisi);

        return $this->db->affected_rows() == 1 ? true : false;

    }
    public function listar_deps($option, $iddep = false){
        switch($option){
            case 1:
                //departamentos que tienen proceso
                $this->db->select('dd.*');
                $this->db->join('dependencia d', 'd.idDepend = p.uni_id_unidad');
                $this->db->join('dependencia dd', 'dd.idDepend = d.reportaDpend');
                $this->db->group_by('d.reportaDpend');
                return $this->db->get('tbl_procesos p')->result_object();
                break;
            case 2:
                //unidades que tienen proceso
                $this->db->select('d.*');
                $this->db->join('dependencia d', 'd.idDepend = p.uni_id_unidad');
                $this->db->join('dependencia dd', 'dd.idDepend = d.reportaDpend');
                $this->db->where('d.reportaDpend', $iddep);
                $this->db->group_by('p.uni_id_unidad');
                return $this->db->get('tbl_procesos p')->result_object();
                break;
        }
        return array();
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
    public function get_obj(ent_proceso $obj)
    {
        $this->db->select();
        $this->db->where($this->id, $obj->pro_id);
        $this->db->join('dependencia d', 'd.idDepend = '.$this->table.'.uni_id_unidad');
        $q = $this->db->get($this->table);
        return $q->custom_row_object(0, $this->class);
    }

    public function eliminar($id){
        $this->db->where($this->id, $id);
        $this->db->delete($this->table);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

    public function actualizar(ent_proceso $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        $this->db->where($this->id, $obj->pro_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function listar_by_unidad($id_unidad)
    {
        $this->db->select();
        $this->db->where('uni_id_unidad', $id_unidad);
        $q = $this->db->get($this->table);
        return $q->custom_result_object($this->class);

    }
    public function listar_by_departamento($id_dep)
    {
        $this->db->select();
        $this->db->join('dependencia d', 'd.idDepend = '.$this->table.'.uni_id_unidad');
        $this->db->where('d.reportaDpend', $id_dep);
        $q = $this->db->get($this->table);
        return $q->custom_result_object($this->class);

    }

}