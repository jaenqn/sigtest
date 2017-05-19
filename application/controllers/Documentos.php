<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Documentos extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Documento','documento');
        // $this->load->library('UploadHandler');
    }
    public function actualizar(){
        is_ajax();
        $p = $this->input->post();
        // print_rr($p);
        $values['desDoc'] = $p['txtTituloDoc'];
        if(trim($p['txtAprobacionDoc']) != ''){
            $g = DateTime::createFromFormat('d/m/Y',$p['txtAprobacionDoc']);
            $values['fecAprobacionArchivo'] = $g->format('Y-m-d');
        }
        if(trim($p['txtVerDoc']) != '')
            $values['versionDoc'] = $p['txtVerDoc'];
        if(isset($p['txtVisibleDoc']) && $p['txtVisibleDoc'] == 'on')
            $values['estadoDoc'] = 1;
        else $values['estadoDoc'] = 0;
        // $values['idDoc'] = $p['txtIdDocumento'];
        $res['resultado'] = $this->documento->actualizar($values, $p['txtIdDocumento']);
        echo json_encode($res);
    }
    public function do_uploaded()
    {
        print_rr($_POST);
        print_rr($_FILES);
        $upload_path_url = base_url().'uploads/';

        $config['upload_path'] = 'uploads/';
        $config['allowed_types'] = 'jpg';
        $config['max_size'] = '30000';
        $this->load->library('upload', $config);

        if ( ! $this->upload->do_upload()) {
            $error = array('error' => $this->upload->display_errors());
            print_rr($error);

        } else {
            $data = $this->upload->data();
            /*
                    // to re-size for thumbnail images un-comment and set path here and in json array
            $config = array(
                'source_image' => $data['full_path'],
                'new_image' => $this->$upload_path_url '/thumbs',
                'maintain_ration' => true,
                'width' => 80,
                'height' => 80
            );

            $this->load->library('image_lib', $config);
            $this->image_lib->resize();
            */
            //set the data for the json array
            $info->name = $data['file_name'];
                $info->size = $data['file_size'];
            $info->type = $data['file_type'];
                $info->url = $upload_path_url .$data['file_name'];
            // I set this to original file since I did not create thumbs.  change to thumbnail directory if you do = $upload_path_url .'/thumbs' .$data['file_name']
            $info->thumbnail_url = $upload_path_url .$data['file_name'];
                $info->delete_url = base_url().'upload/deleteImage/'.$data['file_name'];
                $info->delete_type = 'DELETE';

            //this is why we put this in the constants to pass only json data
            if (IS_AJAX) {
                echo json_encode(array($info));
                //this has to be the only data returned or you will get an error.
                //if you don't give this a json array it will give you a Empty file upload result error
                //it you set this without the if(IS_AJAX)...else... you get ERROR:TRUE (my experience anyway)

            // so that this will still work if javascript is not enabled
            } else {
                $file_data['upload_data'] = $this->upload->data();
                $this->load->view('admin/upload_success', $file_data);
            }
        }
    }
    public function upload_docs($id_carpeta = 3){
        $this->load->model('Model_Carpeta','carpeta');
        $lst = $this->carpeta->getPadreTotalCarpeta($id_carpeta);
        $path = '';
        $path_url =  '';
        foreach ($lst as $key => $value) {
            $path .= $value->desCarpeta.DS;
            $path_url .= $value->desCarpeta.'/';
        }


        // echo $path;
        // print_rr($lst);
        // echo $id_carpeta;
        // exit;

        // print_rr($_POST);


        $params = array(
            'upload_dir' => DOCSPATH.$path,
            'upload_url' => NAMEDOC.'/'.$path_url
            );
        // $up = new UploadHandler($params);
        $qq = $this->load->library('UploadHandler',$params);


        $targetFile = $this->uploadhandler->response['files'][0];
        // br();
        // print_rr($targetFile);
        // exit;
        $idDependencia = $lst[0]->idDepenCarpeta;

        $values['idDependDoc'] = $idDependencia;
        $values['desDoc'] = $targetFile->name;
        $values['nombreDoc'] = $targetFile->name;
        $values['rutaDoc'] = $targetFile->url;
        $values['idCarpetaDoc'] = $id_carpeta;
        $values['versionDoc'] = '';
        $values['estadoDOc'] = 1;
        $this->documento->insert_doc($values);
        //Insertar en la basededatos



        // $upload_handler = new UploadHandler();

    }
    public function by_carpeta($idcarpeta){
        $this->load->model('Model_Carpeta','carpeta');
        $hijos = $this->carpeta->getHijoCarpeta($idcarpeta, 9);
        // print_rr($hijos);
        $post = $this->input->post();
        $lstDocs['folders'] = $hijos;
        if(isset($post['search'])){
            $lstDocs['docs'] = $this->documento->listar_documento_by_carpeta_descripcion($idcarpeta, array('desDoc','asc'), 1);
        }else{
            $lstDocs['docs'] = $this->documento->listar_documento_by_carpeta($idcarpeta, array('desDoc','asc'), 1);
        }


        echo json_encode($lstDocs);
    }
    public function by_categoria($idCategoria){

        $post = $this->input->post();
        // print_rr($post);

        if(!isset($post['id_carpetas'])){
            $this->load->model('Model_Carpeta','carpeta');
            $carpetas = $this->carpeta->listar_by_categoria($categoria, 9, Ficheros::getCarpetaRaiz(),'asc');
        }else{
            $carpetas = $post['id_carpetas'];
        }
        $order = array('desDoc','asc');
        $limit_date = false;
        if(isset($post['search'])){
            if(isset($post['limit_date_recent']) && $post['limit_date_recent'] == 1){
                $order = array('fechaDoc','desc');
                $limit_date = $post['limit_date_recent'];
            }

            $lstDocs = $this->documento->listar_documento_by_categoria_and_descripcion($carpetas,$post['search'], $limit_date , $order);
        }else{
            // $lstDocs = $this->documento->listar_documento_by_carpeta($idcarpeta, array('desDoc','asc'));
        }


        echo json_encode($lstDocs);
    }
    public function data($id){
        $lst = $this->documento->getdata($id);
        echo json_encode($lst);
    }
    public function ver($url_doc){
        echo '<embed src="http://sig.devep-jp.com:8888/docs/ACCIDENTES/fsig015001_reporte_de_incidentes_v.2.pdf" width="500" height="375">';

        // echo '<iframe style="" src="http://sig.devep-jp.com:8888/docs/ACCIDENTES/fsig015001_reporte_de_incidentes_v.2.pdf" width="600" height="780"></iframe>';
    }



}