<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Unidad extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Unidad','unidad');
    }

    public function index(){ is_ajax(); }

    // private function set_values($post)
    // {
    //     // print_rr($post);
    //     // $post['id'] = 'sadadsdasdasd';
    //     $obj = new Unidades();
    //     $obj->uni_id = isset($post['id'])?$post['id']:null;
    //     $obj->uni_nombre = $post['txtNombre'];
    //     $obj->dep_id_departamento = $post['txtIdDepartamento'];
    //     // $obj->uni_fecha_registro = $post['txtSiglas'];
    //     $obj->uni_id_instalacion = $post['txtIdInstalacion'];
    //     $obj->uni_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;

    //     return $obj;
    // }
    public function verificaabbr(){
        $p = $this->input->post();
        // $p['txtAbbr'] = 'U';
        $res['respuesta'] = false;
        if(isset($p['txtAbbr'])){
            if(isset($p['txtId']))
                $res['respuesta'] = $this->unidad->verificar_abbr(strtoupper($p['txtAbbr']), $p['txtId']);
            else $res['respuesta'] = $this->unidad->verificar_abbr(strtoupper($p['txtAbbr']));
        }
        echo json_encode($res);
    }
    private function set_values($post)
    {
        // print_rr($post);
        // $post['id'] = 'sadadsdasdasd';
        $obj = new ent_dependencia();
        $obj->idDepend = isset($post['id'])?$post['id']:null;
        $obj->desDepend = $post['txtNombre'];
        $obj->reportaDpend = $post['txtIdDepartamento'];
        $obj->nivelDepend = 2;
        $obj->fechaDepend = date('Y-m-d H:i:s');
        // $obj->uni_fecha_registro = $post['txtSiglas'];
        $obj->id_instlacion = $post['txtIdInstalacion'];
        $obj->abbr = strtoupper($post['txtAbbr']);
        $obj->estadoDepend = strtolower($post['txtEstado']) == 'true' ? 1 : 0;

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
        // print_rr($post);exit;
        $obj = $this->set_values($post);
        $res['resultado'] = $this->unidad->insertar($obj);
        if($res['resultado'])
            $res['objRes'] = $obj;
        echo json_encode($res);
    }
    // public function insertar()
    // {
    //     is_ajax();
    //     $res = array(
    //             'resultado' => false,
    //             'objRes' => null
    //             );
    //     $post = $this->input->post();
    //     $obj = $this->set_values($post);
    //     $res['resultado'] = $this->unidad->insertar($obj);

    //     if($res['resultado'])
    //         $res['objRes'] = $obj;
    //     echo json_encode($res);
    // }

    public function eliminar($id)
    {
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['resultado'] = $this->unidad->eliminar($id);

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
        $res['resultado'] = $this->unidad->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $obj = new ent_dependencia();
        $obj->idDepend = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->unidad->get_obj($obj);
        if($res['objRes']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            'instalaciones.ins_id'
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){

            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                case 'get_estado':
                    $order = array('estadoDepend' => $_POST['order']['0']['dir']);
                    break;

            }

        }
        $filter = array();
        $filter[] = array(
            'column' => 'nivelDepend',
            'filter' => 2
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
                    case 'reportaDpend':
                    case 'estadoDepend':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                array('rel_unidades_instalacion','rel_unidades_instalacion.uni_id_unidad = dependencia.idDepend','left'),
                array('instalaciones','instalaciones.ins_id = rel_unidades_instalacion.ins_id_instalacion','left')
            );
        $datas = $this->Model_Datatables->get_datatables('dependencia','ent_dependencia',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
        // $list = get_object_vars($list);
        $data = array();
        $no = $_POST['start'];
        $lst = $this->unidad->listar();
        $this->load->model('Model_Departamento','dep');
        $lstDep = $this->dep->listar();

        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => count($lst),
                        "recordsFiltered" => $datas['count_filtered'],
                        "data" => $datas['list'],
                        "post" => $_POST,
                        'lstDepartamentos' => $lstDep
                );
        //output to json format
        echo json_encode($output);
    }

    public function listar_by_dep($id, $opcion = false)
    {
        if($opcion)
            $lst =  $this->unidad->listar_by_dep($id, $opcion);
        else $lst =  $this->unidad->listar_by_dep($id);
       echo json_encode($lst);
    }




}