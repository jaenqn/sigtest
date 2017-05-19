<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Instalacion extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Instalacion');
    }

    public function index(){ is_ajax(); }

    public function verificaabbr(){
        $p = $this->input->post();

        // $p['txtAbbr'] = 'U';
        $res['respuesta'] = false;
        if(isset($p['txtAbbr'])){
            if(isset($p['txtId']) && $p['txtId'] != '')
                $res['respuesta'] = $this->Model_Instalacion->verificar_abbr(strtoupper($p['txtAbbr']), $p['txtId']);
            else $res['respuesta'] = $this->Model_Instalacion->verificar_abbr(strtoupper($p['txtAbbr']));

        }
        echo_json($res);
    }
    private function set_values($post){
        $obj = new Instalaciones();
        $obj->ins_id = $post['id'];
        $obj->ins_nombre = $post['txtNombre'];
        $obj->ins_razon_social = $post['txtRazonSocial'];
        $obj->ins_rz_siglas = $post['txtSiglas'];
        $obj->ins_ruc = $post['txtRuc'];
        $obj->ins_email = $post['txtEmail'];
        $obj->ins_telefono = $post['txtTelefono'];
        $obj->ins_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
        $obj->ins_attr_direccion = $post['txtPreDireccion'];
        $obj->ins_direccion = $post['txtDireccion'];
        $obj->ins_urb_localidad = $post['txtUrbLocalidad'];
        $obj->dis_id_distrito = $post['txtDistrito'];
        $obj->pro_id_provincia = $post['txtProvincia'];
        $obj->dep_id_departamento = $post['txtDepartamento'];
        $obj->ins_cod_postal = $post['txtCodPostal'];
        $obj->ins_representante = $post['txtRepresentante'];
        $obj->ins_dni_representante = $post['txtDniRepre'];
        $obj->ins_ing_responsable = $post['txtResponsable'];
        $obj->ins_cip_responsable = $post['txtCipResp'];
        $obj->ins_dir_num = $post['txtDirNum'];
        $obj->ins_abbr = $post['txtAbbr'];
        return $obj;
    }
    public function get_data($id){
        $d = $this->Model_Instalacion->getdata($id);
        echo json_encode($d);

    }
    public function insertar(){
        // is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );

        $post = $this->input->post();
        // print_rr($post);exit;
        // if(!$post) exit;
        $obj = new Instalaciones();

        $obj->ins_nombre = $post['txtNombre'];
        $obj->ins_razon_social = $post['txtRazonSocial'];
        $obj->ins_rz_siglas = $post['txtSiglas'];
        $obj->ins_ruc = $post['txtRuc'];
        $obj->ins_email = $post['txtEmail'];
        $obj->ins_telefono = $post['txtTelefono'];
        $obj->ins_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
        $obj->ins_attr_direccion = $post['txtPreDireccion'];
        $obj->ins_direccion = $post['txtDireccion'];
        $obj->ins_urb_localidad = $post['txtUrbLocalidad'];
        $obj->dis_id_distrito = $post['txtDistrito'];
        $obj->pro_id_provincia = $post['txtProvincia'];
        $obj->dep_id_departamento = $post['txtDepartamento'];
        $obj->ins_cod_postal = $post['txtCodPostal'];
        $obj->ins_representante = $post['txtRepresentante'];
        $obj->ins_dni_representante = $post['txtDniRepre'];
        $obj->ins_ing_responsable = $post['txtResponsable'];
        $obj->ins_cip_responsable = $post['txtCipResp'];
        $obj->ins_dir_num = $post['txtDirNum'];
        // print_rr($obj);
        // echo 'a';
        // exit;
        $res['resultado'] = $this->Model_Instalacion->insertar($obj);

        if($res['resultado'])
            $res['objRes'] = $obj;
        // echo 'asda';
        echo json_encode($res);
    }

    public function eliminar($id){
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['resultado'] = $this->Model_Instalacion->eliminar($id);

        echo json_encode($res);
    }
    public function actualizar(){

        $res = array(
                'resultado' => false,
                'objRes' => null
                );

        $post = $this->input->post();
        // print_rr($post);exit;
        $obj = $this->set_values($post);

        // print_rr($obj);exit;
        $res['resultado'] = $this->Model_Instalacion->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $obj = new Instalaciones();
        $obj->ins_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->Model_Instalacion->get_obj($obj);
        // print_rr($res);exit;
        if($res['objRes']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );

        if(isset($_POST['order'])){

            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                case 'ins_direccion':
                    $order = array('dir_total' => $_POST['order']['0']['dir']);
                    break;
                case 'ins_razon_social':
                    $order = array('rz_total' => $_POST['order']['0']['dir']);
                    break;
                case 'get_estado':
                    $order = array('ins_estado' => $_POST['order']['0']['dir']);
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
                    case 'ins_nombre':
                    case 'ins_razon_social':
                    case 'ins_ruc':
                        $likes[] = $p[$i];
                        break;
                    case 'ins_estado':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;

        $datas = $this->Model_Datatables->get_datatables('instalaciones','Instalaciones',$likes, $filter,$selects, $order,array(),$_POST['length'],$_POST['start']);
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