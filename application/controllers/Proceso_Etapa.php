<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Proceso_Etapa extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_ProcesosEtapa','proceso');
    }

    public function index(){ is_ajax(); }
    private function set_values($post)
    {
        $obj = new ent_proceso_etapa();
        $obj->pet_id = isset($post['id'])?$post['id']:null;
        $obj->pet_nombre = $post['txtNombre'];
        $obj->pet_orden = +$post['txtOrden'];
        $obj->pro_id_proceso = +$post['txtIdProceso'];
        $obj->pet_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
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

        $obj = new ent_proceso_etapa();
        $obj->pet_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->proceso->get_obj($obj);
        if($res['objRes']!=null){
            $res['resultado'] = true;
            $res['arrayRes'] = array_values(get_object_vars($res['objRes']));

        }
        echo json_encode($res);
    }
    public function listar_by_unidades(){

    }
    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            'p.*'
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
                    case 'dep_id':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'd.reportaDpend', 'filter' => $value['filter']);
                        break;
                    case 'uni_id':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'd.idDepend', 'filter' => $value['filter']);
                        break;
                    case 'pet_nombre':
                        if(trim($value['filter']) != '')
                            $likes[] = $p[$i];
                        break;
                    case 'pro_id_proceso':
                    case 'pet_estado':
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
                array('tbl_procesos p','p.pro_id = tbl_procesos_etapa.pro_id_proceso'),
                array('dependencia d','d.idDepend = p.uni_id_unidad')
                // array('departamentos','departamentos.dep_id = unidades.dep_id_departamento')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_procesos_etapa','object',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
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

    public function listar_by_procesos()
    {
        if(is_ajax(false)){
           $lst =  $this->proceso->listar_by_procesos($_POST['refid']);
           echo json_encode($lst);
        }else show_404();
    }

}