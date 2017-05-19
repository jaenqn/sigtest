<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Noticias extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Noticias','noticias');
    }
    public function eliminar($idnoticia){
        if(is_ajax(false)){
            $res['resultado'] = $this->noticias->delete($idnoticia);
            echo_json($res);
        }else show_404();

    }
    public function publicar($idnoticia){
        $res['resultado'] = $this->noticias->change_public($idnoticia,1);
        echo_json($res);
    }
    public function ocultar($idnoticia){
        $res['resultado'] = $this->noticias->change_public($idnoticia,0);
        echo_json($res);
    }
    public function setportada($idfile){
        if($this->noticias->existefile($idfile)){
            $res['resultado'] = $this->noticias->setportada($idfile);
            echo_json($res);
        }
    }
    public function deletefile($idfile){
        $res['resultado'] = $this->noticias->deletefile($idfile);
        echo_json($res);
    }
    public function generar()
    {
        if(!is_ajax(false))
            redirect('gestor/noticias');
        $res = $this->noticias->generar();
        echo json_encode($res);
    }
    public function savecontent($id){
        $p = $this->input->post();
        switch(+$p['tiposave']){
            case 1:

                // $res['resultado'] = $this->noticias->actualizarnoticia($idnot, $values);
                // break;
            // case 2:
                // $idnot = $p['txtIdNoticia'];
                // $values['not_contenido'] = $p['editor1'];
                // $res['resultado'] = $this->noticias->actualizarnoticia($idnot, $values);
                // break;
        }
            $idnot = $p['txtIdNoticia'];
            $values['not_titulo'] = $p['txtTituloNot'];
            $values['not_autor'] = $p['txtAutorNot'];
            $values['not_intro'] = $p['txtIntroPortada'];
            $values['not_contenido'] = $p['editor1'];
            $res['resultado'] = $this->noticias->actualizarnoticia($idnot, $values);
        echo_json($res);
        // var_dump($_POST);

    }
    public function uploadfiles($id){
        if($this->noticias->existe_noticia($id)){
            // verificar_carpeta_procesos();
            $params = array(
                'upload_dir' => DOCSPATH.'_noticias'.DS.$id.DS,
                'upload_url' => NAMEDOC.'/_noticias/'.$id.'/'
                );
            // $up = new UploadHandler($params);


            ob_start();
            $qq = $this->load->library('UploadHandler',$params);
            $salida2 = ob_get_contents();
            ob_end_clean();
            $pre_salida = json_decode($salida2);

            $this->uploadhandler->response['files'][0]->casa = 'adasdsd';

            $targetFile = $this->uploadhandler->response['files'][0];
            // print_rr($targetFile);
            $values['dno_nombre_fichero'] = $targetFile->name;
            $values['dno_nombre_public'] = $targetFile->name;
            $values['not_id_noticia'] = $id;//evidencia_obs_respuesta


            $ref_files = $this->noticias->insertfile($values);
            $pre_salida->files[0]->id_fichero = $ref_files;
            $pre_salida->files[0]->id_noticia = $id;
            // $pre_salida->files[0]->id_fichero = 100;
            echo json_encode($pre_salida);
        }
        // echo $id;
        // $cis = $this->session->ref_session_boleta;
    }
    public function datatables(){
         $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
                 // "urm.desDepend as uni_rem_nombre",
                 // "urc.desDepend as uni_rec_nombre",
                // "dd.desDepend as dep_nombre",
                // "dd.idDepend as dep_id_departamento"
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){

            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                // case 'get_estado':
                //     $order = array('uni_estado' => $_POST['order']['0']['dir']);
                //     break;

            }

        }
        $filter = array();
        //filtro por defecto para mostrar solo las boletas de cada unidad remitente

        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                // switch ($value['column']) {
                //     case 'usu_nombre':
                //         $likes[] = $p[$i];
                //         break;
                //     case 'dep_id_departamento':
                //         $filter[] = array('column' => 'dd.idDepend', 'filter' => $value['filter']);
                //         break;
                //     case 'uni_id_unidad':
                //         $filter[] = $p[$i];
                //         break;
                //     case 'usu_estado':
                //     case 'usu_tipo_usuario':
                //         $filter[] = $p[$i];
                //         break;
                // }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                // array('dependencia urm','urm.idDepend = tbl_boletasig.bol_uni_remitente'),
                // array('dependencia urc','urc.idDepend = tbl_boletasig.bol_uni_receptor')
                // array('dependencia dd','dd.idDepend = d.reportaDpend')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_noticias','object',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
        // $list = get_object_vars($list);
        $data = array();
        $no = $_POST['start'];


        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => $datas['count_all'],
                        "recordsFiltered" => $datas['count_filtered'],
                        "data" => $datas['list'],
                        "post" => $_POST
                );
        //output to json format
        echo json_encode($output);
    }

}