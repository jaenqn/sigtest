<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Prueba extends CI_Controller {

    /**
     * Index Page for this controller.
     *
     * Maps to the following URL
     *      http://example.com/index.php/welcome
     *  - or -
     *      http://example.com/index.php/welcome/index
     *  - or -
     * Since this controller is set as the default controller in
     * config/routes.php, it's displayed at http://example.com/
     *
     * So any other public methods not prefixed with an underscore will
     * map to /index.php/welcome/<method_name>
     * @see https://codeigniter.com/user_guide/general/urls.html
     */
    function __construct() {
        parent::__construct();
    }
    public function index()
    {

        // var_dump($this->load->view('prueba/index'));
        // $this->load->library('milibreria');
        // $this->milibreria->hola();
        // $this->load->view('prueba/index');


        $this->smartys->assign("title","Testing Smarty");
        $this->smartys->assign("description","This is the testing page for integrating Smarty and CodeIgniter.");
        // $this->smartys->view('test');
        // $this->smartys->assign('_template','mytemplate.tpl');
        // $this->smartys->render(APPPATH.'views/prueba/index.tpl');
        // $this->smartys->render('index');
        $this->smartys->render('registro');

    }
    public function test()
    {

        // var_dump($this->load->view('prueba/index'));
        // $this->load->library('milibreria');
        // $this->milibreria->hola();
        // $this->load->view('prueba/index');


        $this->smartys->assign("title","Testing Smarty");
        $this->smartys->assign("description","This is the testing page for integrating Smarty and CodeIgniter.");
        // $this->smartys->view('test');
        // $this->smartys->assign('_template','mytemplate.tpl');
        $this->smartys->render(APPPATH.'views/prueba/index.tpl');

    }
    public function registro($aaa,$tt){

        echo 'es un registro';
        echo $aaa;
        echo $tt;
    }
}
