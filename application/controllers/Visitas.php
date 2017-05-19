<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Visitas extends CI_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index()
    {
        if(AppSession::usuario_logueado()){
            if(AppSession::get('tipo_usuario') == 4 || AppSession::get('tipo_usuario') == 5){

                $datos['ar_pages'] = array('Portal','Visitas');
                $datos['titulo_header'] = 'Visitas';
                //cargar información de estadísticas
                $datos['part_title'] = 'Visitas';
                $datos['data_visitas'] = $this->usuario->listar_estadisticas();
                $this->smartys->assign($datos);
                $this->smartys->render('home/hom_estadisticas');
            }else redirect('dashboard');
        }else redirect();
    }

}