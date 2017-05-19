<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Departamento extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Departamento','departamento');
    }

    public function index()
    {
        $datos = array();


        $this->smartys->assign($datos);
        $this->smartys->render('index');
    }

    public function insertar(){
        // is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );

        $post = $this->input->post();

        $obj = new ent_dependencia();
        $obj->abbr = isset($post['txtAbbr']) ? strtoupper($post['txtAbbr']) : '';
        $obj->desDepend = $post['txtNombre'];
        $obj->estadoDepend = strtolower($post['txtEstado']) == 'true' ? 1 : 0;



        $res['resultado'] = $this->departamento->insertar($obj);

        if($res['resultado'])
            $res['objRes'] = $obj;
        echo json_encode($res);
    }
    // public function insertar(){
    //     // is_ajax();
    //     $res = array(
    //             'resultado' => false,
    //             'objRes' => null
    //             );

    //     $post = $this->input->post();

    //     $obj = new Departamentos();

    //     $obj->dep_nombre = $post['txtNombre'];
    //     $obj->dep_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;



    //     $res['resultado'] = $this->departamento->insertar($obj);
    //     if($res['resultado'])
    //         $res['objRes'] = $obj;
    //     echo json_encode($res);
    // }

    public function eliminar($id){
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['resultado'] = $this->departamento->eliminar($id);

        echo json_encode($res);
    }
    public function actualizar(){
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $obj = new ent_dependencia();
        $post = $this->input->post();

        $obj->idDepend = $post['id'];
        $obj->desDepend = $post['txtNombre'];
        $obj->abbr = strtoupper($post['txtAbbr']);
        $obj->estadoDepend = strtolower($post['txtEstado']) == 'true' ? 1 : 0;

        // print_rr($obj);exit;
        $res['resultado'] = $this->departamento->actualizar($obj);
        echo json_encode($res);
    }
    // public function actualizar(){
    //     $res = array(
    //             'resultado' => false,
    //             'objRes' => null
    //             );
    //     $obj = new Departamentos();
    //     $post = $this->input->post();

    //     $obj->dep_id = $post['id'];
    //     $obj->dep_nombre = $post['txtNombre'];
    //     $obj->dep_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;

    //     // print_rr($obj);exit;
    //     $res['resultado'] = $this->departamento->actualizar($obj);
    //     echo json_encode($res);
    // }
    public function data($id){
        $obj = new ent_dependencia();
        $obj->idDepend = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->departamento->get_obj($obj);
        if($res['objRes']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array();
        if(isset($_POST['order'])){

            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                // case 'dep_nombre':
                //     $order = array('dep_nombre' => $_POST['order']['0']['dir']);
                //     break;
                case 'get_estado':
                    $order = array('estadoDepend' => $_POST['order']['0']['dir']);
                    break;

            }

        }
        $filter = array();
        $filter[] = array(
            'column' => 'nivelDepend',
            'filter' => 1
            );
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'desDepend':
                        $likes[] = $p[$i];
                        break;
                    case 'estadoDepend':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }




        $datas = $this->Model_Datatables->get_datatables('dependencia','ent_dependencia',$likes,$filter, $selects, $order,array(),$_POST['length'],$_POST['start']);
        // $list = get_object_vars($list);
        $data = array();
        $no = $_POST['start'];

        $lst = $this->departamento->listar();

        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => count($lst),
                        "recordsFiltered" => $datas['count_filtered'],
                        "data" => $datas['list'],
                        "post" => $_POST,
                        "post2" => $filter
                );
        //output to json format
        echo json_encode($output);
    }
    // public function datatables_list()
    // {
    //     $this->load->model('Model_Datatables');
    //     $order = false;
    //     $selects = array();
    //     if(isset($_POST['order'])){

    //         switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
    //             // case 'dep_nombre':
    //             //     $order = array('dep_nombre' => $_POST['order']['0']['dir']);
    //             //     break;
    //             case 'get_estado':
    //                 $order = array('dep_estado' => $_POST['order']['0']['dir']);
    //                 break;

    //         }

    //     }
    //     $filter = array();
    //     $likes = array();
    //     if($this->input->post('filters')){
    //         $p = $this->input->post('filters');
    //         $i = 0;
    //         foreach ($p as $key => $value) {
    //             switch ($value['column']) {
    //                 case 'dep_nombre':
    //                     $likes[] = $p[$i];
    //                     break;
    //                 case 'dep_estado':
    //                     $filter[] = $p[$i];
    //                     break;
    //             }
    //             $i++;
    //         }
    //     }

    //     $datas = $this->Model_Datatables->get_datatables('departamentos','Departamentos',$likes,$filter, $selects, $order,array(),$_POST['length'],$_POST['start']);
    //     // $list = get_object_vars($list);
    //     $data = array();
    //     $no = $_POST['start'];



    //     $output = array(
    //                     "draw" => $_POST['draw'],
    //                     "recordsTotal" => $datas['count_all'],
    //                     "recordsFiltered" => $datas['count_filtered'],
    //                     "data" => $datas['list'],
    //                     "post" => $_POST
    //             );
    //     //output to json format
    //     echo json_encode($output);
    // }

    public function listar()
    {
        is_ajax();
        $lst = $this->departamento->listar();
        echo json_encode($lst);
    }

    public function listar_activos(){
        is_ajax();
        $lst = $this->departamento->listar('desDepend','asc', 'activo');
        echo json_encode($lst);
    }




}