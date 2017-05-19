<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Ejemplo extends CI_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index()
    {

        $datos = array(
            'titulo_header' => 'Ejemplo'
            );
        $this->smartys->assign($datos);
        $this->smartys->render('index');
    }

}