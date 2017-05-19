<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Medida_Control extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_MedidaControl','mco');
    }

    public function index(){ is_ajax(); }

    private function set_values($post)
    {

        $obj['mco_id'] = isset($post['txtId']) ? $post['txtId']: null;
        $obj['mco_nombre'] = $post['txtNombreMedida'];
        $obj['mco_jerarquia'] = $post['selJerarquia'];
        $obj['mco_tipo'] = +$post['radTipo'];
        $obj['mco_estado'] = 0;
        if(isset($post['chkEstadoMedida']))
            $obj['mco_estado'] = strtolower($post['chkEstadoMedida']) == 'on' ? 1 : 0;
        return $obj;
    }
    public function listar_by_jerarquia($idj, $tipo){
        $lst = $this->mco->listar_by_jerarquia_tipo($idj, $tipo);
        echo_json($lst);
    }
    public function insertar()
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        unset($_POST['txtId']);
        $post = $this->input->post();
        $obj = $this->set_values($post);
        $res['resultado'] = $this->mco->insertar($obj);

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
        $res['resultado'] = $this->mco->eliminar($id);

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
        $res['resultado'] = $this->mco->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->mco->get_obj($id);
        if($res['objRes']!=null){
            $res['resultado'] = true;
            $res['arrayRes'] = array_values(get_object_vars($res['objRes']));
        }
        echo json_encode($res);
    }
    public function simpledata($id){
        $obj = $this->mco->get_obj($id);
        echo_json($obj);
    }
    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            'j.*'
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){

            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                // case 'get_estado':
                //     $order = array('pro_estado' => $_POST['order']['0']['dir']);
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
                    case 'mco_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'mco_jerarquia':
                    case 'mco_estado':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                array('tbl_jerarquia_mc j', 'j.jmc_id = tbl_medidas_control.mco_jerarquia')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_medidas_control','object',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);

        $data = array();
        $no = $_POST['start'];


        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => $datas['count_all'],
                        "recordsFiltered" => $datas['count_filtered'],
                        "data" => $datas['list'],
                        "post" => $_POST
                );

        echo json_encode($output);
    }

}