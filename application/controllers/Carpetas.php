<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Carpetas extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Dependencia');
        $this->load->model('Model_Categorias');
        $this->load->model('Model_Carpeta');
        $this->load->model('Model_Documento');
    }

    public function index()
    {
        // print_r($_SESSION);
        $datos = array();
        $datos['titulo_header'] = 'Carpetas';

        $lst = $this->Model_Dependencia->listarDependencia();
        $lst2 = $this->Model_Categorias->listarCategorias();
        $lstCarpetas = $this->Model_Carpeta->listarCarpetas(1);

        $todosFicheros = array();
        foreach ($lstCarpetas as $key => $value) {
                $temp = new Ficheros();
                $temp->NombreFichero = $value->desCarpeta;
                $temp->Descripcion = $value->descripcionCarpeta;
                $temp->TipoFichero = 1;
                $temp->IdFichero = $value->idCarpeta;
                $todosFicheros[] = $temp;

        }

        $lstCategorias = $this->Model_Carpeta->listarCategorias();
        // print_rr($lstCategorias);exit;
        // foreach ($lstCategorias as $key => $value) {
        //     $value->nomArchivo =substr($value->nomArchivo,2);
        // }
        $datos['lstCarpetas'] = $todosFicheros;
        $datos['lstCategorias'] = $lstCategorias;

        // echo '<pre>';
        // print_r($lstCarpetas);
        // echo '</pre>';


        $this->smartys->assign($datos);
        $this->smartys->render('index');
    }
    public function ws($tipo = false){

    }
    private function fnObtenerRutaCarpeta($idCarpeta){
        $carpetas = array();
        do{
            $temp = $this->Model_Carpeta->getPadreCarpeta($idCarpeta);
            // print_rr($temp);
            $idCarpeta = +$temp->nivelCarpeta;
            $carpetas[] = $temp;

        }while($idCarpeta!=Ficheros::getCarpetaRaiz() && $idCarpeta!=Ficheros::getCarpetaSubRaiz());

        $carpetas = array_reverse($carpetas);
        return $carpetas;
        // print_rr($carpetas);
    }
    public function f($carpetas = false){
        //muestra el contenido de la carpetas que no es raiz
        //esto incluye documentos y carpetas

        if($carpetas){
            $datos = array();
            $datos['lstRutaCarpetas'] = $this->fnObtenerRutaCarpeta($carpetas);
            $datos['titulo_header'] = 'Carpetas';
            $lst = $this->Model_Dependencia->listarDependencia();
            $lst2 = $this->Model_Categorias->listarCategorias();

            $lstCarpetas = $this->Model_Carpeta->listarCarpetas($carpetas);
            $lstDocumentos = $this->Model_Documento->listarDocumentoByCarpeta($carpetas);

            $todosFicheros = array();
            foreach ($lstCarpetas as $key => $value) {
                $temp = new Ficheros();
                $temp->NombreFichero = $value->desCarpeta;
                $temp->TipoFichero = 1;
                $todosFicheros[] = $temp;

            }
            foreach ($lstDocumentos as $key => $value) {
                $temp = new Ficheros();
                $temp->NombreFichero = $value->nombreDoc;
                $temp->TipoFichero = 2;
                $temp->FaIcono = get_ico_doc($value->nombreDoc);
                $todosFicheros[] = $temp;

            }

            // print_rr($todosFicheros);
            // exit;

            $lstContenidoCarpeta = array();
            $datos['lstCarpetas'] = $todosFicheros;

            // echo '<pre>';
            // print_r($lstCarpetas);
            // echo '</pre>';


            $this->smartys->assign($datos);
            $this->smartys->render('index');
        }else redirect('carpetas');

    }

    public function get_carpeta($idCarpeta = false){
        is_ajax();
        if($idCarpeta){
            $objCarp = $this->Model_Carpeta->getCarpeta($idCarpeta);
            if(+$objCarp->estadoCarpeta == 9)
                $objCarp->estadoCarpeta = TRUE;
            else $objCarp->estadoCarpeta = FALSE;
            if($objCarp)
                echo json_encode($objCarp);
            else echo json_encode(array(
                    'msg' => 'Id Carpeta no encontrado'
                ));
            exit;
        }


    }
    public function update_datos(){
        is_ajax();
        $post = $this->input->post();
        // print_r($post);exit;

        $objF = new Ficheros();
        $objF->IdFichero = $post['txtIdCarpeta'];
        $objF->Descripcion = $post['txtTitulo'];
        $objF->CategoriaFichero = $post['selCategoria'];
        $objF->Estado = $post['txtVisible'] == 'true' ? 9 : 1;


        $res = $this->Model_Carpeta->actualizarCarpeta($objF);
        echo json_encode(array('respuesta' => $res));


    }

}