<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Dependencia extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Dependencia','dependencia');
    }

    public function index()
    {
        redirect('');
    }
    public function unidad_by_dep($id_departamento){
        $lstUnidad =  $this->dependencia->listarDependenciaUni($id_departamento);
        echo json_encode($lstUnidad);
    }


}