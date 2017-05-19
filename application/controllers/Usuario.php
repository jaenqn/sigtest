<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Usuario extends CI_Controller {

    function __construct() {
        parent::__construct();
        // $this->load->model('Model_Usuarios','usuario');
    }
    public function get_tipos_usuarios(){
        if($this->input->is_ajax_request()){
            echo_json(ent_usuarios::lstUsuarios());
        }else echo_json(array('msg' => 'No Found'));

    }

    public function index(){ is_ajax(); }
    public function logout(){
        $_SESSION['prev_url'] = '';
        $this->usuario->delete_online(AppSession::get('user_id'));
        AppSession::destroy();
        redirect('');


    }
    public function validar_usuario(){
        $res['resultado'] = false;
        $p = $this->input->post();
        $r = $this->usuario->existe_usuario($p['txtUsuario'],$p['txtIdUsu']);
        if($r>0)
            $res['resultado'] = true;
        echo json_encode($res);
    }
    public function lista_visita($tipo){
        switch ($tipo) {
            case 'dia':
                // print_rr($_POST);
                $data_fechas = $this->input->post('data_values');
                $output = array(
                        'data' => array()
                        );
                if(isset($data_fechas['tipo']) && $data_fechas['tipo'] == 2){
                    $fecha_dia = date('Y-m-d');
                    $lst = $this->usuario->visita_hoy($data_fechas['inicio']);
                    $output['data'] = $lst;

                }
                echo json_encode($output);

                break;
            case 'hoy':
                $fecha_dia = date('Y-m-d');
                $lst = $this->usuario->visita_hoy($fecha_dia);

                // $output = array(
                //         "draw" => $_POST['draw'],
                //         "recordsTotal" => count($lst),
                //         "recordsFiltered" => 10,
                //         "data" => $lst,
                //         "post" => $_POST
                // );
                $output = array(
                    'data' => $lst
                    );
                echo json_encode($output);
                break;
            case 'ayer':

                $fecha_dia = date('Y-m-d',time() - 24*60*60);
                // echo $fecha_dia;
                $lst = $this->usuario->visita_hoy($fecha_dia);
                $output = array(
                    'data' => $lst
                    );
                echo json_encode($output);
                break;
            case 'semana':
                // $fechas = $this->input->post('data_values');
                $dia_sem = +date('w');
                $t = $dia_sem == 0 ? 6 : ($dia_sem == 1? 0 : ($dia_sem - 1));
                $ini_sem_num = time() - ($t)*3600*24;
                $ini_sem = date('Y-m-d',$ini_sem_num);
                $fin_sem = date('Y-m-d',$ini_sem_num + 6*3600*24);
                $lst = $this->usuario->visita_rango($ini_sem, $fin_sem);
                $fecha_dia = date('Y-m-d');
                $output = array(
                    'data' => $lst
                    );
                echo json_encode($output);
                break;
            case 'rango':
            // print_rr($_POST);

                $data_fechas = $this->input->post('data_values');
                if(isset($data_fechas['tipo']) && $data_fechas['tipo'] == 1){
                    $dia_sem = +date('w');
                    $t = $dia_sem == 0 ? 6 : ($dia_sem == 1? 0 : ($dia_sem - 1));
                    $ini_sem_num = time() - ($t)*3600*24;
                    $ini_sem = date('Y-m-d',$ini_sem_num);
                    $ini_sem = $data_fechas['inicio'];
                    $fin_sem = date('Y-m-d',$ini_sem_num + 6*3600*24);
                    $fin_sem = $data_fechas['fin'];
                    $lst = $this->usuario->visita_rango($ini_sem, $fin_sem);
                    $fecha_dia = date('Y-m-d');
                    $output = array(
                        'data' => $lst
                        );
                    echo json_encode($output);
                }
                break;
            default:
                # code...
                break;
        }
    }
    public function listar_online(){
        $lst = $this->usuario->listar_onlines();
        echo json_encode($lst);

    }
    public function set_online(){
        // echo_json(array('res' => true));
        // exit;
        // [user_id] => 7
        // [tipo_usuario] => 3
        // [nombre_usuario] => Administrador
        // [id_unidad] => 0
        // [usuario_logueado] => 1
        // [verifica_plan] => 1
        $res = array();

        if($this->input->is_ajax_request()){
            if(AppSession::usuario_logueado()){
                // if(!isset($_SESSION['id_usuario'])){

                // }
                // if(Hash::getHash('sha1',$this->session->user_id,HASH_KEY) != get_cookie('id_usuario')){
                //     // $_SESSION['prev_url'] = base_url();
                //     $res['reload'] = true;
                //     //$_SESSION['prev_url'] = $_SERVER['REQUEST_URI'];
                // }
                $res = $this->usuario->registrar_activo(array(
                    'id_usuario' => $this->session->user_id,
                    'name_usuario' => $this->session->usuario_cuenta,
                    'tiempo' => time()
                    ));
                // print_rr($_SESSION);

            }else{
                $res = $this->usuario->registrar_activo(array(
                    'id_usuario' => 0,
                    'name_usuario' => get_cookie('ci_session'),
                    'tiempo' => time()
                    ));
                $res['reload'] = true;
            }
        }

        echo json_encode($res);
    }
    private function set_values($post)
    {
        $this->load->library('Hash');
        // print_rr($post);
        // $post['id'] = 'sadadsdasdasd';
        $obj = new ent_usuarios();
        $obj->usu_id = isset($post['id'])?$post['id']:null;
        $obj->usu_nombre = $post['txtNombre'];
        $obj->usu_apellidos = $post['txtApellidos'];
        $obj->usu_dni = $post['txtDNI'];
        $obj->usu_cargo = $post['txtCargo'];
        $obj->usu_ficha = $post['txtFicha'];
        $obj->uni_id_unidad = $post['txtIdUnidad'];
        $obj->usu_usuario = $post['txtUsuario'];
        $obj->usu_pass = Hash::getHash('sha1',trim($post['txtPass']),HASH_KEY);
        $obj->usu_tipo_usuario = $post['txtTipoUsuario'];
        $obj->usu_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;


        return $obj;
    }
    public function insertar()
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $post = $this->input->post();
        $obj = $this->set_values($post);
        $res['resultado'] = $this->usuario->insertar($obj);

        if($res['resultado'])
            $res['objRes'] = $obj;
        echo json_encode($res);
    }

    public function eliminar($id)
    {
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['resultado'] = $this->usuario->eliminar($id);

        echo json_encode($res);
    }
    public function actualizar()
    {
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $post = $this->input->post();
        $obj = $this->set_values($post);
        $res['resultado'] = $this->usuario->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $obj = new ent_usuarios();
        $obj->usu_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->usuario->get_obj($obj);
        if($res['objRes']!=null){

            $res['resultado'] = true;
            $res['arrayRes'] = array_values(get_object_vars($res['objRes']));
            // print_rr($res['objRes']);
            // print_rr($res['arrayRes']);
        }
        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
                 "d.desDepend as uni_nombre",
                "dd.desDepend as dep_nombre",
                // "dd.idDepend as dep_id_departamento"
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){

            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                case 'get_estado':
                    $order = array('uni_estado' => $_POST['order']['0']['dir']);
                    break;

            }

        }
        $filter = array();
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'usu_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'dep_id_departamento':
                        $filter[] = array('column' => 'dd.idDepend', 'filter' => $value['filter']);
                        break;
                    case 'uni_id_unidad':
                        $filter[] = $p[$i];
                        break;
                    case 'usu_estado':
                    case 'usu_tipo_usuario':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                array('dependencia d','d.idDepend = tbl_usuarios.uni_id_unidad'),
                array('dependencia dd','dd.idDepend = d.reportaDpend')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_usuarios','ent_usuarios',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
        // $list = get_object_vars($list);
        $data = array();
        $no = $_POST['start'];


        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => $datas['count_all'],
                        "recordsFiltered" => $datas['count_filtered'],
                        "data" => $datas['list'],
                        "post" => $_POST
                );
        //output to json format
        echo json_encode($output);
    }
    // public function datatables_list()
    // {
    //     $this->load->model('Model_Datatables');
    //     $order = false;
    //     $selects = array(
    //         // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
    //         // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
    //         );
    //     if(isset($_POST['order'])){

    //         switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
    //             case 'get_estado':
    //                 $order = array('uni_estado' => $_POST['order']['0']['dir']);
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
    //                 case 'usu_nombre':
    //                     $likes[] = $p[$i];
    //                     break;
    //                 case 'dep_id_departamento':
    //                 case 'uni_id_unidad':
    //                 case 'usu_estado':
    //                 case 'usu_tipo_usuario':
    //                     $filter[] = $p[$i];
    //                     break;
    //             }
    //             $i++;
    //         }
    //     }
    //     $_POST['f'] = $filter;
    //     $_POST['l'] = $likes;
    //     $joins = array(
    //             array('unidades','unidades.uni_id = tbl_usuarios.uni_id_unidad'),
    //             array('departamentos','departamentos.dep_id = unidades.dep_id_departamento')
    //         );
    //     $datas = $this->Model_Datatables->get_datatables('tbl_usuarios','ent_usuarios',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
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


}