<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Impacto_Ambiental extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_ImpactoAmbiental','impacto');
    }

    public function index(){ is_ajax(); }

    private function set_values($post)
    {
        $obj = new ent_impacto_ambiental();
        $obj->imp_id = isset($post['id'])?$post['id']:null;
        $obj->imp_nombre = $post['txtNombre'];
        $obj->asp_id_aspecto_ambiental = +$post['txtIdAspecto'];
        $obj->imp_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
        return $obj;
    }

    public function listar_by_aspecto($idasp){
        $lst = $this->impacto->listar_by_aspecto($idasp, 1);
        echo_json($lst);
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
        $res['resultado'] = $this->impacto->insertar($obj);

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
        $res['resultado'] = $this->impacto->eliminar($id);

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
        $res['resultado'] = $this->impacto->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $obj = new ent_impacto_ambiental();
        $obj->imp_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->impacto->get_obj($obj);
        if($res['objRes']!=null){
            $res['resultado'] = true;
            $res['arrayRes'] = array_values(get_object_vars($res['objRes']));
        }
        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            'tbl_aspecto_ambiental.*'
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
                    case 'imp_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'asp_id_aspecto_ambiental':
                    case 'imp_estado':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                array('tbl_aspecto_ambiental', 'tbl_aspecto_ambiental.asp_id = tbl_impacto_ambiental.asp_id_aspecto_ambiental')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_impacto_ambiental','ent_impacto_ambiental',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);

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