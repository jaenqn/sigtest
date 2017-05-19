<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Causa extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Causas','causa');
    }

    public function index()
    {
        is_ajax();
    }

    private function set_values($post)
    {
        // print_rr($post);
        // $post['id'] = 'sadadsdasdasd';
        $obj = new Causas();
        $obj->cau_id = isset($post['id'])?$post['id']:null;
        $obj->cau_nombre = $post['txtNombre'];
        $obj->cau_tipo = $post['txtIdTipo'];
        $obj->cau_sub_estandar = $post['txtIdSubEstandar'];
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
        $res['resultado'] = $this->causa->insertar($obj);

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
        $res['resultado'] = $this->causa->eliminar($id);

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
        $res['resultado'] = $this->causa->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $obj = new Causas();
        $obj->cau_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->causa->get_obj($obj);
        if($res['objRes']!=null)
            $res['resultado'] = true;

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
                    case 'cau_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'cau_tipo':
                    case 'cau_sub_estandar':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                // array('departamentos','departamentos.dep_id = unidades.dep_id_departamento')
            );
        $datas = $this->Model_Datatables->get_datatables('causas','Causas',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
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