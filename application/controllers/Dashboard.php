<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard extends CI_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index()
    {
        AppSession::logueado();
        // echo 'is dash';
        $datos['part_title'] = 'Dashboard';
        $datos['titulo_header'] = 'Dashboard';
        $this->smartys->assign($datos);
        $this->smartys->render('home/dashboard');
    }

}