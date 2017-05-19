<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Almacen extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Almacen');
    }

    public function index()
    {
        is_ajax();
    }

    public function insertar(){
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );

        $post = $this->input->post();
        $obj = new AlmacenResiduos();

        $obj->alm_nombre = $post['txtNombre'];
        $obj->alm_descripcion = $post['txtDescripcion'];

        $res['resultado'] = $this->Model_Almacen->insertar($obj);
        if($res['resultado'])
            $res['objRes'] = $obj;
        echo json_encode($res);
    }

    public function eliminar($id){
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['resultado'] = $this->Model_Almacen->eliminar($id);

        echo json_encode($res);
    }
    public function actualizar(){
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $obj = new AlmacenResiduos();
        $post = $this->input->post();

        $obj->alm_id = $post['id'];
        $obj->alm_nombre = $post['txtNombre'];
        $obj->alm_descripcion = $post['txtDescripcion'];

        // print_rr($obj);exit;
        $res['resultado'] = $this->Model_Almacen->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id){
        $obj = new AlmacenResiduos();
        $obj->alm_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->Model_Almacen->get_obj($obj);
        if($res['objRes']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array();
        $filter = array();
        $likes = array();

        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'alm_nombre':
                        $likes[] = $p[$i];
                }
                $i++;
            }
        }

        $datas = $this->Model_Datatables->get_datatables('almacen_residuos','AlmacenResiduos',$likes, $filter,$selects,false,array(),$_POST['length'],$_POST['start']);
        // $list = get_object_vars($list);
        $data = array();
        $no = $_POST['start'];


        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => $datas['count_all'],
                        "recordsFiltered" => $datas['count_filtered'],
                        "data" => $datas['list']
                );
        //output to json format
        echo json_encode($output);
    }



}