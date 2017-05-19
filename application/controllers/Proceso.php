<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Proceso extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Procesos','proceso');
    }

    public function index(){ is_ajax(); }
    private function set_values($post)
    {
        // print_rr($post);
        // $post['id'] = 'sadadsdasdasd';
        $obj = new ent_proceso();

        $obj->pro_id = isset($post['id'])?$post['id']:null;
        $obj->pro_nombre = $post['txtNombre'];
        $obj->uni_id_unidad = $post['txtIdUnidad'];
        $obj->pro_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
        // $obj->pro_fecha_creacion = $post[''];
        // $obj->pro_fecha_modificacion = $post[''];
        return $obj;
    }
    public function listar_uni_by_dep($iddep){
        $lst = $this->proceso->listar_deps(2, $iddep);
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
        $res['resultado'] = $this->proceso->insertar($obj);

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
        $res['resultado'] = $this->proceso->eliminar($id);

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
        $res['resultado'] = $this->proceso->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $obj = new ent_proceso();
        $obj->pro_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->proceso->get_obj($obj);


        if($res['objRes']!=null){
            $res['resultado'] = true;
            $res['arrayRes'] = array_values(get_object_vars($res['objRes']));
            $res['resObj'] = $res['objRes'];
        }
        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            "d.idDepend as uni_id",
            "d.desDepend as uni_nombre",
            "dd.idDepend as dep_id",
            "dd.desDepend as dep_nombre",
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
                    case 'pro_nombre':
                        if(trim($value['filter']) != '')
                            $likes[] = $p[$i];
                        break;
                    case 'dep_id_departamento':
                        if(+$value['filter'] != -1)
                            $filter[] = array(
                                'column' => 'd.reportaDpend',
                                'filter' => $value['filter']
                                );
                        break;
                    case 'uni_id_unidad':
                        if(+$value['filter'] != -1)
                            $filter[] = array(
                                'column' => 'tbl_procesos.uni_id_unidad',
                                'filter' => $value['filter']
                            );
                        break;
                    case 'pro_estado':
                        if(+$value['filter'] != -1)
                            $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                array('dependencia d','d.idDepend = tbl_procesos.uni_id_unidad'),
                array('dependencia dd','dd.idDepend = d.reportaDpend')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_procesos','ent_proceso',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
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
    public function listar_by_dep($iddep){
        $lst =  $this->proceso->listar_by_departamento($iddep);
        echo json_encode($lst);
    }
    public function listar_by_unidad($id)
    {

       $lst =  $this->proceso->listar_by_unidad($id);
       echo json_encode($lst);
    }

    public function listar_todo()
    {

       $lst =  $this->proceso->listar();

       echo json_encode($lst);
    }
    public function listar_by_departamento($id)
    {

       $lst =  $this->proceso->listar_by_departamento($id);

       echo json_encode($lst);
    }




}