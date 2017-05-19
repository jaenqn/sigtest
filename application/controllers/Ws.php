<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Ws extends CI_Controller {

    function __construct() {

        parent::__construct();
        is_ajax();

    }

    public function index()
    {

        echo 'adada';
        // $datos = array();


        // $this->smartys->assign();
        // $this->smartys->render('index');
    }
    private function carpetas_listar(){
        $this->load->model('Model_Dependencia');
    }
    private function listar_dependencia(){
        $this->load->model('Model_Dependencia');
        $lst = $this->Model_Dependencia->listarDependencia();
        return $lst;
        // print_r($lst);
    }
    public function listar($option = false){
        if($option){
            switch ($option) {
                case 'dependencia':
                    echo json_encode($this->listar_dependencia());
                    break;

                default:
                    # code...
                    break;
            }
        }
    }

    public function listar_datos_carpeta(){

        $res = array();
        $post = $this->input->post();
        $idDependencia = 1;
        $idCarpeta = 306;
        // idDependencia,idCarpeta
        $this->load->model('Model_Documento');
        $this->load->model('Model_Carpeta');

        $lstCarpetas = $this->Model_Carpeta->listarCarpetas($idDependencia,$idCarpeta);
        $lstDocumentos = $this->Model_Documento->listarDocumentoByCarpeta($idCarpeta);

        // if($lstCarpetas){
        //     foreach ($lstCarpetas as $key => $value) {

        //         }
        // }

        // if($lstDocumentos){
        //     foreach ($lstDocumentos as $key => $value) {
        //         print_rr($value);
        //         break;
        //     }
        // }

        $res['lstCarpetas'] = array(
            'datas' => $lstCarpetas,
            'tipoArchivo' => 1
            );
        $res['lstDocumentos'] = array(
            'datas' => $lstDocumentos,
            'tipoArchivo' => 2
            );

        echo json_encode($res);

        // print_rr($lstCarpetas);
        // print_rr($lstDocumentos);


    }



}