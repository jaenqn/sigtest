<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Gestor extends CI_Controller {

    function __construct() {
        parent::__construct();
        AppSession::logueado();
    }

    public function index()
    {
        $datos = array();


        $this->smartys->assign();
        $this->smartys->render('index');
    }
    public function noticias($opc = false, $id = false){
        if(!$opc){
            $datos['part_title'] = 'Gestor Noticias';
            $datos['ar_pages'] = array('Gestor','Noticias');
            $datos['titulo_header'] = 'Gestionar Noticias';
            $this->smartys->assign($datos);
            $this->smartys->render('ges_noticias');
        }else{
            switch ($opc) {
                case 'editar':
                    if($id && is_int(+$id) && (strlen(+$id) == strlen($id))){
                        $this->load->model('Model_Noticias','noticias');
                        $objN = $this->noticias->getdata(+$id);
                        // print_rr($objN);
                        if($objN){
                            $datos['ref_icons'] = json_encode(get_list_ico_files());
                            $datos['objN'] = $objN;
                            $datos['part_title'] = 'Editar Noticia - '.$objN->not_id;
                            $datos['ar_pages'] = array('Gestor','Noticias','Editar',$objN->not_id);
                            $datos['titulo_header'] = 'Editar  Noticia';
                            $this->smartys->assign($datos);
                            $this->smartys->render('ges_noticias_editar');


                        }
                        else show_404();
                    }else{
                        if(+$id != 0)
                            redirect('gestor/noticias/editar/'.+$id);
                        else redirect('gestor/noticias');
                    }
                    break;
                default:
                    redirect('gestor/noticias');
                    break;
            }
        }

    }
    public function correlativo(){
        $this->load->model('Model_Unidad','uni');
        $this->load->model('Model_Correlativo','corre');
        $datos['ar_pages'] = array('Gestor','Correlativos');
        $datos['titulo_header'] = 'Gestionar correlativo';
        $lstCorre = $this->corre->listar_partes();
        $datos['lstunidades'] = $this->uni->listar();

        $datos['lstCorrSacp'] = $lstCorre[0];
        $datos['lstCorrAlmacen'] = $lstCorre[1];

        // print_rr($lstCorre);
        $this->smartys->assign($datos);
        $this->smartys->render('ges_correlativo');
    }
    public function causas(){
        AppSession::logueado();
        // redirect('','refresh');
        $datos = array();
        $obj = new Causas();
        $datos['part_title'] = 'Gestor Causas';
        $datos['ar_pages'] = array('Gestor','Causas');
        $datos['titulo_header'] = 'Causas';
        $datos['lstTiposCausas'] = $obj->tipos;
        $datos['lstSubEstandarCausas'] = $obj->sub_estandar;

        $this->smartys->assign($datos);
        $this->smartys->render('ges_causas');
    }

    public function instalaciones(){

        $datos['titulo_header'] = 'Gestor de Instalaciones';
        $datos['ar_pages'] = array('Gestor','Instalaciones');

        $this->smartys->assign($datos);
        $this->smartys->render('instalacion');
    }
    public function departamentos(){
        $datos['titulo_header'] = 'Gestionar Departamentos';
        $datos['ar_pages'] = array('Gestor','Departamentos');

        $this->smartys->assign($datos);
        $this->smartys->render('departamento');

    }
    public function unidades(){
        $this->load->model('Model_Departamento','departamento');
        $this->load->model('Model_Instalacion','instalacion');
        $datos['titulo_header'] = 'Unidades';
        $datos['ar_pages'] = array('Gestor','Unidades');
        $datos['lstDepartamento'] = $this->departamento->listar();
        $datos['lstInstalacion'] = $this->instalacion->listar();
        $this->smartys->assign($datos);
        $this->smartys->render('unidad');
    }
    public function empresa_contratista(){
        $this->load->model('Model_Departamento','departamento');
        $this->load->model('Model_Instalacion','instalacion');

        $datos['titulo_header'] = 'Empresas Contratistas';
        $datos['ar_pages'] = array('Gestor','Empresas Contratistas');

        $datos['lstDepartamento'] = $this->departamento->listar();
        $datos['lstInstalacion'] = $this->instalacion->listar();

        $this->smartys->assign($datos);
        $this->smartys->render('ges_empresa');
    }
    public function almacenes(){

        $datos['titulo_header'] = 'Almacen de Residuos';
        $datos['ar_pages'] = array('Gestor','Almacen de Residuos');

        // $datos['lstDepartamento'] = $this->departamento->listar();
        // $datos['lstInstalacion'] = $this->instalacion->listar();

        $this->smartys->assign($datos);
        $this->smartys->render('ges_almacen');
    }
    public function x(){
        $this->smartys->render('asdasd');
    }
    public function origen_residuos()
    {
        $this->load->model('Model_Departamento','departamento');
        $this->load->model('Model_Instalacion','instalacion');
        $datos['titulo_header'] = 'Origen de Residuos';
        $datos['part_title'] = 'Gestor - Origen Residuos';
        $datos['ar_pages'] = array('Gestor','Residuos','Origen');
        $datos['lstDepartamento'] = $this->departamento->listar();
        $datos['lstInstalacion'] = $this->instalacion->listar();

        $this->smartys->assign($datos);
        $this->smartys->render('ges_origen_residuos');
    }

    public function residuos()
    {

        $datos['titulo_header'] = 'Gestor de Residuos';
        $datos['ar_pages'] = array('Gestor','Residuos');
        $datos['part_title'] = 'Gestor de Residuos';

        $this->smartys->assign($datos);
        $this->smartys->render('residuos');
    }

    public function usuarios()
    {

         if(!AppSession::accesoView(array('administrador','admin-sig','jefe'))){
            redirect('home/dashboard');
            exit;
        }

        $this->load->model('Model_Departamento','departamento');
        $datos['titulo_header'] = 'Usuarios';
        $datos['part_title'] = 'Gestionar Usuarios';
        $datos['ar_pages'] = array('Gestor','Usuarios');

        if(AppSession::accesoView(array('administrador','jefe'))){
            $datos['lstDepUni'] = $this->departamento->get_obj_by_unidad($this->session->id_unidad);

        }
        $datos['lstDepartamento'] = $this->departamento->listar();

        $this->smartys->assign($datos);

        $this->smartys->render('ges_usuarios');
    }

    public function procesos()
    {
        AppSession::logueado();
        $this->load->model('Model_Departamento','departamento');

        $datos['titulo_header'] = 'Gestor de Procesos';
        $datos['ar_pages'] = array('Gestor','Procesos');
        $datos['part_title'] = 'Gestor de Procesos';
        $datos['lstDepartamento'] = $this->departamento->listar();

        $this->smartys->assign($datos);

        $this->smartys->render('procesos');
    }

    public function proceso_estapas()
    {
        AppSession::logueado();
        $this->load->model('Model_Departamento','departamento');
        $this->load->model('Model_Procesos','pro');

        $datos['titulo_header'] = 'Gestor de Etapas de Proceso';
        $datos['ar_pages'] = array('Gestor','Proceso','Etapas');
        $datos['part_title'] = 'Gestor de Etapas de Proceso';

        $datos['lstDepartamento'] = $this->pro->listar_deps(1);
        $datos['lstDepartamentos'] = $this->departamento->listar(1);
        $this->smartys->assign($datos);

        $this->smartys->render('procesos_etapa');
    }
    public function proceso_actividades()
    {
        AppSession::logueado();

        $this->load->model('Model_Departamento','departamento');
        $this->load->model('Model_Procesos','pro');

        $datos['titulo_header'] = 'Gestor Actividades de Procesos';
        $datos['part_title'] = 'Gestor Actividades de Procesos';
        $datos['ar_pages'] = array('Gestor','Proceso','Actividades');

        $datos['lstDepartamento'] = $this->pro->listar_deps(1);
        // $datos['lstProcesos'] = $this->procesos->listar();

        $this->smartys->assign($datos);

        $this->smartys->render('procesos_actividades');
    }
    public function categorias()
    {
        AppSession::logueado();
         if(!AppSession::accesoView(array('administrador','admin-sig'))){
            redirect('home/dashboard');
            exit;
        }
        // $this->load->model('Model_Procesos','procesos');

        $datos['titulo_header'] = 'Gestionar Categorías Peligros y Aspectos Ambientales';
        $datos['part_title'] = 'Gestionar Categorías Pel. y Asp. Ambientales';
        $datos['ar_pages'] = array('Gestor','Categorias');


        // $datos['lstProcesos'] = $this->procesos->listar();

        $this->smartys->assign($datos);

        $this->smartys->render('categorias_peligro_aspecto');
    }
    public function peligros()
    {
        AppSession::logueado();
        $this->load->model('Model_PeligroCategoria','peligro_cate');

        $datos['titulo_header'] = 'Gestionar Peligros';
        $datos['part_title'] = 'Gestionar Peligros';
        $datos['ar_pages'] = array('Gestor','Peligros');


        $datos['lstCategoriasPeligro'] = $this->peligro_cate->listar_peligro();

        $this->smartys->assign($datos);

        $this->smartys->render('peligros');
    }
    public function riesgo()
    {
        AppSession::logueado();
        $this->load->model('Model_Peligro','peligro');

        $datos['part_title'] = 'Gestionar Riesgo';
        $datos['titulo_header'] = 'Gestionar Riesgo';
        $datos['ar_pages'] = array('Gestor','Riesgos');


        $datos['lstPeligros'] = $this->peligro->listar();

        $this->smartys->assign($datos);

        $this->smartys->render('riesgo');
    }

    public function aspecto_ambiental()
    {
        AppSession::logueado();
        $this->load->model('Model_PeligroCategoria','peligro');

        $datos['part_title'] = 'Gestionar Aspecto Ambiental';
        $datos['titulo_header'] = 'Gestionar Aspecto Ambiental';
        $datos['ar_pages'] = array('Gestor','Aspecto Ambiental');


        $datos['lstCatAmbiental'] = $this->peligro->listar_ambiental();

        $this->smartys->assign($datos);

        $this->smartys->render('aspecto_ambiental');
    }
    public function impacto_ambiental()
    {
        AppSession::logueado();
        $this->load->model('Model_AspectoAmbiental','aspecto');

        $datos['part_title'] = 'Gestionar Impacto Ambiental';
        $datos['titulo_header'] = 'Gestionar Impacto Ambiental';
        $datos['ar_pages'] = array('Gestor','Impacto Ambiental');


        $datos['lstAspectoAmbiental'] = $this->aspecto->listar();

        $this->smartys->assign($datos);

        $this->smartys->render('impacto_ambiental');
    }
    public function medidas_control()
    {

        AppSession::logueado();
        $datos['part_title'] = 'Gestionar Medidas de Control';
        $datos['titulo_header'] = 'Gestionar Medidas de Control';
        $datos['ar_pages'] = array('Gestor','Medidas de Control');




        $this->smartys->assign($datos);

        $this->smartys->render('medidas_control');
    }


}