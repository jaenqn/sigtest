<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Usuarios','usuario');
    }
    public function search(){

    }
    public function noticia($idnoticia){
        $datos['asdasd'] ='asdasd';
        $this->load->model('Model_Carpeta','carpeta');
        $this->load->model('Model_Noticias','ntc');

        $datos['lstNoticias'] = $this->ntc->listpublic();
        if($this->ntc->existe_noticia($idnoticia) && $this->ntc->is_public($idnoticia)){
            $datos['objNot'] = $this->ntc->getdatapublic($idnoticia);
            // print_rr($datos['objNot']);exit;
            $lstCategorias = $this->carpeta->listarCategorias();
            $this->smartys->assign('documento',$lstCategorias);
            $this->smartys->assign($datos);
            $this->smartys->render('hom_noticias','template_home');
        }else{
            show_404();
        }

    }
    // public function visitas(){

    //     // print_rr($_SERVER);
    //     // print_rr(get_cookie('ci_session'));
    //     // print_rr($_SESSION);
    //     if(AppSession::usuario_logueado()){
    //         if(AppSession::get('tipo_usuario') == 4 || AppSession::get('tipo_usuario') == 5){

    //             $datos['ar_pages'] = array('Portal','Visitas');
    //             $datos['titulo_header'] = 'Visitas';
    //             //cargar información de estadísticas
    //             $datos['part_title'] = 'Visitas';
    //             $datos['data_visitas'] = $this->usuario->listar_estadisticas();
    //             $this->smartys->assign($datos);
    //             $this->smartys->render('hom_estadisticas');
    //         }else redirect('home/dashboard');
    //     }else redirect();

    // }
    public function politica_integrada(){
        $datos['part_title'] = 'Política Integrada';
        $this->smartys->assign($datos);

        $this->smartys->render('home/pages/hom_politica_integrada','template_home');
    }
    public function organizacion(){
        $this->load->model('Model_Documento','doc');
        $datos['imgPortal'] = $this->doc->listarImgPortal();
        $datos['part_title'] = 'Organización';
        $this->smartys->assign($datos);
        $this->smartys->render('home/pages/hom_organizacion','template_home');
    }
    public function alcance(){
        $datos['part_title'] = 'Alcance';
        $this->smartys->assign($datos);
        $this->smartys->render('home/pages/hom_alcance','template_home');
    }
    public function ambiente(){
        $datos['part_title'] = 'Ambiente ';
        $this->smartys->assign($datos);
        $this->smartys->render('home/pages/hom_ambiente','template_home');
    }
    public function seguridad(){
        $datos['part_title'] = 'Seguridad';
        $this->smartys->assign($datos);
        $this->smartys->render('home/pages/hom_seguridad','template_home');
    }
    public function calidad(){
        $datos['part_title'] = 'Calidad';
        $this->smartys->assign($datos);
        $this->smartys->render('home/pages/hom_calidad','template_home');
    }

    // public function dashboard()
    // {
    //     AppSession::logueado();
    //     // echo 'is dash';
    //     $datos['part_title'] = 'Dashboard';
    //     $datos['titulo_header'] = 'Dashboard';
    //     $this->smartys->assign($datos);
    //     $this->smartys->render('dashboard');
    // }
    public function document($zone = false){
        // print_rr($_GET);
        // echo $zone;
         $this->load->model('Model_Carpeta','carpeta');
            // $this->load->model('Model_Carpeta','carpeta');
            $lstCategorias = $this->carpeta->listarCategorias();

            $this->load->model('Model_Noticias','ntc');
            $lstNoticias = $this->ntc->listpublic();
            $this->smartys->assign('lstNoticias',$lstNoticias);
            // print_rr($lstCategorias);
            $idCategoria = 0;
            foreach ($lstCategorias as $key => $value) {
                if($zone == $value->url)
                    $idCategoria = $value->idArchivo;
            }
            $this->smartys->assign('documento',$lstCategorias);
        if($zone){


            switch ($zone) {
                case 'sig-generales':
                    $this->sig_generales($idCategoria);
                    break;
                case 'areas':
                    $this->areas($idCategoria);
                    break;
                case 'seg-informacion':
                    $this->seg($idCategoria);
                    break;
                case 'formatos-sig':
                    $this->formatos_sig($idCategoria);
                    break;
                case 'normativa-legal':
                    $this->normativa_legal($idCategoria);
                    break;
                case 'otros-documentos':
                    $this->otros_documentos($idCategoria);
                    break;
                case 'charlas-sig':
                    $this->charlas_sig($idCategoria);
                    break;
                default:
                    $this->formatdefault($idCategoria);
                    // redirect('');
                    break;
            }
        }else{
            $this->load->model('Model_Documento','doc');
            $npage = 0;
            $limit = 10;
            if(isset($_GET['l']))
                $limit = +$_GET['l'] == 0 ? 10 : $_GET['l'];
            if(isset($_GET['p'])){
                $lst = $this->doc->listar_by_search($_GET['s'],$limit,$_GET['p']);
                $npage = +$_GET['p'];
            }
            else{
                $lst = $this->doc->listar_by_search($_GET['s'],$limit);
                $npage = 1;
            }
            $datos['lstDocs'] = $lst['lst'];
            $datos['np'] = $lst['nro_pages'];
            if(count($lst['lst']) > 0){
                $pages = +$lst['nro_pages'];

                //los 7 espacios
                $datos['pagest'] = array();
                if($pages > 7){
                    if(($npage - 1) <= 3){
                        $modoprint = 1;
                    }else if(($pages - $npage) <= 3){
                        $modoprint = 2;
                    }else{
                        $modoprint = 3;
                    }
                    $datos['pageprev'] = 0;
                    $datos['pagesig'] = 0;
                    if($npage > 1)
                        $datos['pageprev'] = $npage -1;
                    else $datos['pageprev'] = '';

                    if($npage == $pages)
                        $datos['pagesig'] = '';
                    else $datos['pagesig'] = $npage + 1;


                    switch ($modoprint) {
                        case 1:
                            $datos['pagest'][] = 1;
                            $datos['pagest'][] = 2;
                            $datos['pagest'][] = 3;
                            $datos['pagest'][] = 4;
                            $datos['pagest'][] = 5;
                            $datos['pagest'][] = '...';
                            $datos['pagest'][] = $pages;
                            break;
                        case 2:

                            $datos['pagest'][] = 1;
                            $datos['pagest'][] = '...';
                            $datos['pagest'][] = $pages - 4;
                            $datos['pagest'][] = $pages - 3;
                            $datos['pagest'][] = $pages - 2;
                            $datos['pagest'][] = $pages - 1;
                            $datos['pagest'][] = $pages;
                            break;
                        case 3:
                            $datos['pagest'][] = 1;
                            $datos['pagest'][] = '...';
                            $datos['pagest'][] = $npage -1;
                            $datos['pagest'][] = $npage;
                            $datos['pagest'][] = $npage +1;
                            $datos['pagest'][] = '...';
                            $datos['pagest'][] = $pages;
                            break;


                    }

                }else{
                    for ($i=1; $i <= +$lst['nro_pages'] ; $i++) {
                        $datos['pagest'][] = $i;
                    }
                }
            }


            $datos['query'] = $_GET['s'];
            $datos['npage'] = $npage;
            // print_rr($lst);
            $datos['s_cadena'] = $_GET['s'];
            $this->smartys->assign($datos);
            $this->smartys->render('home/documentos/hom_resultados','template_home');
        }




    }
    private function formatdefault($categoria){
        $this->load->model('Model_Categorias','cate');
        $objCate = $this->cate->get_object($categoria);
        // print_rr($objCate);
        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        // print_rr($datos['lstCarpetasGenerales']);
        // print_rr($datos['lstCarpetasGenerales']);
        $datos['part_title'] = $objCate->nomArchivo;
        $datos['nombre_categoria'] = $objCate->nomArchivo;
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_default','template_home');
    }
    private function formatos_sig($categoria){
        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        // print_rr($datos['lstCarpetasGenerales']);
        $datos['part_title'] = 'Formatos SIG';
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_formatos','template_home');
    }
    private function normativa_legal($categoria){

        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');

        foreach ($datos['lstCarpetasGenerales'] as $key => $value) {

            $datos['jsonCarpetas'][] = +$value->idCarpeta;
        }

        // print_rr($datos['lstCarpetasGenerales']);
        $datos['categoria'] = $categoria;
        $datos['jsonCarpetas'] = json_encode($datos['jsonCarpetas']);
        $datos['part_title'] = 'Normativa legal';
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_normativa','template_home');
    }
    private function otros_documentos($categoria){
        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        // print_rr($datos['lstCarpetasGenerales']);
        $datos['part_title'] = 'Otros Documentos';
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_otros','template_home');
    }
    private function charlas_sig($categoria){
        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        $datos['part_title'] = 'Charlas SIG';
        // print_rr($datos['lstCarpetasGenerales']);
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_charla','template_home');
    }
    private function sig_generales($categoria){
        // $datos['x'] = 'adasd';
        // $this->load->model('Model_Carpeta','carpeta');
        $this->load->model('Model_Documento','documento');
        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        $datos['part_title'] = 'Documentación SIG/Generales';
        // print_rr($datos['lstCarpetasGenerales']);
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_generales','template_home');
    }
    private function areas($categoria){
        $this->load->model('Model_Dependencia','dependencia');
        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        $datos['lstDepartamentos'] = $this->dependencia->listarDependenciaDep();
        $datos['part_title'] = 'Documentación por áreas';
        // print_rr($datos['lstCarpetasGenerales']);
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_area','template_home');
    }
    private function seg($categoria){
        $datos['lstCarpetasGenerales'] = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        // print_rr($datos['lstCarpetasGenerales']);
        $datos['part_title'] = 'Formatos Seg. Información';
        $this->smartys->assign($datos);
        $this->smartys->render('home/documentos/hom_seg','template_home');
    }
    public function login(){

            $datos = array();
            $post = $this->input->post();
            // print_rr($post);
            $datos['is_log'] = false;
            $datos['prev_url'] = false;
            $obj = new ent_usuarios();
            $obj->usu_usuario = $post['txtUsuario'];
            $obj->usu_pass = $post['txtPassword'];

            // print_rr($obj);
            $obj = $this->usuario->validar_usuario($obj);
            if($obj){
                // if(+$post['txtRecordar'] == 1)
                //     $this->config->sess_expiration = 7200;
                    // $this->session->usuario_recordar = true;
                // else
                //     $this->session->usuario_recordar = false;
                $this->session->user_id = $obj->usu_id;
                $this->session->tipo_usuario = $obj->usu_tipo_usuario;
                $this->session->nombre_tipo_usuario = $obj->get_tipo_usuario;

                $this->session->nombre_usuario = $obj->usu_nombre;
                $this->session->apellido_usuario = $obj->usu_apellidos;
                $this->session->dni_usuario = $obj->usu_dni;
                $this->session->ficha_usuario = $obj->usu_ficha;

                $this->session->usuario_cuenta = $obj->usu_usuario;
                $this->session->id_unidad = $obj->uni_id_unidad;
                $this->session->usuario_logueado = true;
                $this->load->model('Model_Unidad','uni');
                setcookie('id_usuario', Hash::getHash('sha1',$obj->usu_id,HASH_KEY));
                if($obj->uni_id_unidad != 0){
                    $obj_uni = $this->uni->get_departamento($obj->uni_id_unidad);
                    $this->session->nom_dep = $obj_uni->nom_depa;
                    $this->session->nom_uni = $obj_uni->desDepend;
                }else{
                    $this->session->nom_dep = 'ADMIN';
                    $this->session->nom_uni = 'ADMIN';
                }

                if(isset($this->session->prev_url)){
                    // echo $this->session->prev_url;
                    $datos['prev_url'] = substr($this->session->prev_url,1);
                    if($datos['prev_url'] == '/notificaciones/comprar_notificaciones_custom')
                        $datos['prev_url'] = '';

                }
                $datos['is_log'] = true;
                //registrar_el_acceso del usuario
                // $this->usuario->registrar_activo(array(
                //     'id_usuario' => $obj->usu_id,
                //     'name_usuario' => $obj->usu_nombre,
                //     'tiempo' => time()
                //     ));
                // $this->session->mark_as_temp(array('user_id', 'tipo_usuario','nombre_usuario','id_unidad','usuario_logueado'), 30);d

            }else{
                $datos['lblMensaje'] = 'Usuario y/o contraseña incorrectos';

            }

            echo  json_encode($datos);

    }
    public function index()
    {
        //verificar si existen usuario, esto era para la configuración inicial del sitema, quedó en pendiente
        if($this->usuario->existen_usuarios()){
            $this->load->model('Model_Carpeta','carpeta');
            $this->load->model('Model_Noticias','ntc');
            $datos = array();
            $datos['part_title'] = 'Inicio';
            $datos['lst_documento'] = $this->carpeta->listarCategorias();
            $datos['lstNoticias'] = $this->ntc->listpublic();
            $post = $this->input->post();
            // if(isset($post['frm-level']) && $post['frm-level'] == 1){
            //     $obj = new ent_usuarios();
            //     $obj->usu_usuario = $post['txtUsuario'];
            //     $obj->usu_pass = $post['txtPassword'];
            //     // print_rr($obj);
            //     $obj = $this->usuario->validar_usuario($obj);
            //     if($obj){
            //         $this->session->user_id = $obj->usu_id;
            //         $this->session->tipo_usuario = $obj->usu_tipo_usuario;
            //         $this->session->nombre_usuario = $obj->usu_nombre;

            //         $this->session->id_unidad = $obj->uni_id_unidad;
            //         $this->session->usuario_logueado = true;
            //         if(isset($this->session->prev_url))
            //             redirect($this->session->prev_url);
            //         // $this->session->mark_as_temp(array('user_id', 'tipo_usuario','nombre_usuario','id_unidad','usuario_logueado'), 30);d

            //     }else{
            //         $datos['lblMensaje'] = 'Usuario y/o contraseña incorrectos';
            //     }
            // }
            // echo get_cookie('ci_session');
            $this->smartys->assign($datos);
            // $this->smartys->render('testuser/index','template_home');
            $this->smartys->render('hom_index','template_home');
        }else{

        }



    }
    public function register(){
        $this->smartys->render('hom_register_admin','template_home');
    }
//

}