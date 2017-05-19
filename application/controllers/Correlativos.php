<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Correlativos extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Correlativo','corre');
    }

    public function index()
    {
        $datos = array();


        $this->smartys->assign($datos);
        $this->smartys->render('index');
    }
    public function solicitar_correlativo($tipo, $opcion = 1){
        $lst = $this->corre->obtener_correlativo($tipo,$opcion,false);
        echo json_encode($lst);
    }
    public function solicitar_cboleta($opc){
        $lst = $this->corre->obtener_correlativo('boleta',$opc,false);
        // $post = $this->input->post();
        // $lst = $this->corre->listar_by_tipo(1, $opc);
        // $lst = $lst[0];
        // // str_pad($input, 10, "-=", STR_PAD_LEFT);
        // if($opc == 2)
        //     $lst->correlativo = 'BNS-'.str_pad($lst->cor_val,4,'0',STR_PAD_LEFT).'-'.date('Y');
        // else
        //     $lst->correlativo = 'BNA-'.str_pad($lst->cor_val,4,'0',STR_PAD_LEFT).'-'.date('Y');
        // print_rr($lst);

        echo json_encode($lst);

    }
    public function solicitar_cresiduo($opc){
        $lst = $this->corre->obtener_correlativo('residuo',$opc,false);

        echo json_encode($lst);

    }
    public function get_correlativo_sig($tipo = 1,$opc = 1){
        is_ajax();
        $lst = $this->corre->listar_by_tipo($tipo, $opc);
        echo json_encode($lst);

    }
    public function get_correlativo_inc($tipo = 3,$opc = 1){
        is_ajax();
        $lst = $this->corre->listar_by_tipo($tipo, $opc, true);
        echo json_encode($lst);

    }

    public function actualizar(){
        $post = $this->input->post();
        // print_rr($post);

        foreach ($post as $key => $value) {
            switch ($key) {
                case 'boleta':
                    if($post['boleta']['opc'])
                        $this->corre->a_boleta(1,$value['opc'], $value['value']);
                    break;
                case 'sacp':
                    $this->corre->a_boleta(2,1, $value['value']);

                    break;
                case 'reporte':
                if($post['reporte']['opc'])
                    $this->corre->a_boleta(3,$value['opc'], $value['value']);
                    break;
                case 'autorizacion':
                    $this->corre->a_boleta(4,1, $value['value']);
                    break;
            }
        }

        echo json_encode(array('respuesta' => true));

    }




}