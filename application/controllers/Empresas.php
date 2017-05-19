<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Empresas extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_EmpreContra','empresa');
    }

    public function index(){ is_ajax(); }
    private function set_values($post)
    {
        // print_rr($post);
        // $post['id'] = 'sadadsdasdasd';
        $obj = new EmpresaContratista();
        $obj->empc_id = isset($post['id'])?$post['id']:null;
        $obj->empc_nombre = $post['txtNombre'];
        $obj->empc_direccion = $post['txtDireccion'];

        $obj->empc_telefono = $post['txtTelefono'];
        // $obj->uni_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;

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
        $res['resultado'] = $this->empresa->insertar($obj);

        if($res['resultado'])
            $res['objRes'] = $obj;
        echo json_encode($res);
    }
    public function data($id){
        $obj = new EmpresaContratista();
        $obj->empc_id = $id;
        $res = array(
                'resultado' => false,
                'objEmpresa' => null
                );
        $res['objEmpresa'] = $this->empresa->get_obj($obj);
        if($res['objEmpresa']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }
    public function eliminar($id){
        $res = array(
                'resultado' => false,
                'objEmpresa' => null
                );
        $res['resultado'] = $this->empresa->eliminar($id);

        echo json_encode($res);
    }

    public function actualizar(){
        $res = array(
                'resultado' => false,
                'objEmpresa' => null
                );
        $obj = new EmpresaContratista();
        $post = $this->input->post();

        $obj->empc_id = $post['id'];
        $obj->empc_nombre = $post['txtNombre'];
        $obj->empc_direccion = $post['txtDireccion'];
        $obj->empc_telefono = $post['txtTelefono'];
        // print_rr($obj);exit;
        $res['resultado'] = $this->empresa->actualizar($obj);
        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );

        if(isset($_POST['order'])){

            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                // case 'ins_direccion':
                //     $order = array('dir_total' => $_POST['order']['0']['dir']);
                //     break;
                // case 'ins_razon_social':
                //     $order = array('rz_total' => $_POST['order']['0']['dir']);
                //     break;
                // case 'get_estado':
                //     $order = array('ins_estado' => $_POST['order']['0']['dir']);
                //     break;

            }

        }
        $filter = array();
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'empc_nombre':
                    case 'empc_direccion':
                    case 'empc_telefono':
                        $likes[] = $p[$i];
                    //     break;
                    // case 'ins_estado':
                    //     $filter[] = $p[$i];
                    //     break;
                }
                $i++;
            }
        }

        $datas = $this->Model_Datatables->get_datatables('empresa_contratista','EmpresaContratista',$likes, $filter,$selects, $order,array(),$_POST['length'],$_POST['start']);
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

}