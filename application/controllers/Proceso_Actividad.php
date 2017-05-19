<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Proceso_Actividad extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_ProcesosActividad','proceso');
    }

    public function index(){ is_ajax(); }
    public function peligros_actividad($idact, $idpel = false){
        //Lista de peligros que se pueden agregar a la actividad
        if($idpel)
            $lst = $this->proceso->listar_peligros_categoria_to_blancos($idact, $idpel);
        else $lst = $this->proceso->listar_peligros_categoria_to_blancos($idact);
        echo_json($lst);
    }
    public function ambiental_actividad($idact, $idamb = false){
        //Lista de aspectos ambientales que se pueden agregar a la actividad
        if($idamb)
            $lst = $this->proceso->listar_ambiental_categoria_to_blancos($idact, $idamb);
        else $lst = $this->proceso->listar_ambiental_categoria_to_blancos($idact);
        echo_json($lst);
    }
    public function get_blancos($idact){
        $lst = array();
        if(is_numeric($idact)){
            $lst['lstPeligros'] = $this->proceso->getpeligros($idact);
            $lst['lstAspectos'] = $this->proceso->getaspectos($idact);
        }
        echo_json($lst);
    }
    public function listar_by_etapa($idpet){
        $lst = $this->proceso->listar_by_etapa($idpet);
        echo_json($lst);
    }
    private function set_values($post)
    {


        $obj = new ent_proceso_actividad();
        $obj->pac_id = isset($post['id'])?$post['id']:null;
        $obj->pac_nombre = $_POST['txtNombre'];
        $obj->pac_orden = +$post['txtOrden'];
        $obj->pac_estado = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
        $obj->pet_id_procesos_etapa = +$post['txtIdEtapaActividad'];
        $obj->pac_puesto_trabajo = $post['txtPuesto'];
        $obj->pac_situacion = +$post['txtSituacion'];
        $obj->pac_ubicacion = +$post['txtUbicacion'];
        $obj->pac_tipo_personal = +$post['txtTipoPersonal'];

        return $obj;
    }
    private function set_values_dos($post)
    {


        $obj = new ent_proceso_actividad();
        $obj->pac_id = null;
        $obj->pac_nombre = $_POST['txtNomActiNew'];
        $obj->pac_orden = +$post['txtOrdenActiNew'];
        $obj->pac_estado = 1;
        $obj->pet_id_procesos_etapa = +$post['selEtapas'];
        $obj->pac_puesto_trabajo = $post['txtPuestoActiNew'];
        $obj->pac_situacion = +$post['radSituacionActividad'];
        $obj->pac_ubicacion = +$post['radUbicacionActividad'];
        $obj->pac_tipo_personal = +$post['radTipoPersonalActividad'];

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
        // print_rr($_POST);
        // set_error_handler('_custom_errors');
        if(isset($post['insert_tipo']) && +$post['insert_tipo'] == 2)
            $obj = $this->set_values_dos($post);
        else $obj = $this->set_values($post);




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
        // print_rr($obj);
        $res['resultado'] = $this->proceso->actualizar($obj);
        echo json_encode($res);
    }
    public function data($id)
    {

        $obj = new ent_proceso_actividad();
        $obj->pac_id = $id;
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

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            'tbl_procesos.*',
            'tbl_procesos_etapa.*'
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
                    case 'pac_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'pro_id_proceso':
                    case 'pac_estado':
                    case 'pet_id_procesos_etapa':
                        if(+$value['filter'] != -1)
                            $filter[] = $p[$i];
                        break;
                    case 'dep_id':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'd.reportaDpend', 'filter' => $value['filter']);
                        break;
                    case 'uni_id':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'd.idDepend', 'filter' => $value['filter']);
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                array('tbl_procesos_etapa', 'tbl_procesos_etapa.pet_id = tbl_procesos_actividad.pet_id_procesos_etapa'),
                array('tbl_procesos', 'tbl_procesos.pro_id = tbl_procesos_etapa.pro_id_proceso'),
                array('dependencia d', 'd.idDepend = tbl_procesos.uni_id_unidad')
                // array('departamentos','departamentos.dep_id = unidades.dep_id_departamento')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_procesos_actividad','ent_proceso_actividad',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
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