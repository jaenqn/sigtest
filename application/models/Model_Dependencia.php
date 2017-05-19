
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Dependencia extends CI_Model {

    public $variable;
    private $table = 'dependencia';

    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function listarDependencia(){

        $this->db->select();
        $this->db->where('nivelDepend', 1);
        $q = $this->db->get($this->table);
        return $q->result();
    }
    public function listarDependenciaDep(){

        $this->db->select();
        $this->db->where('nivelDepend', 1);
        $this->db->where('reportaDpend', 1);
        $q = $this->db->get($this->table);

        return $q->result();
    }
    public function listarDependenciaUni($id_departamento = false){

        if($id_departamento){
            $this->db->select();
            $this->db->where('nivelDepend', 2);
            if($id_departamento)
                $this->db->where('reportaDpend', $id_departamento);
            $q = $this->db->get($this->table);
            return $q->result();
        }else{
            // listar todos los unidades
        }

    }


}

/* End of file Model_Dependencia.php */
/* Location: ./application/models/Model_Dependencia.php */