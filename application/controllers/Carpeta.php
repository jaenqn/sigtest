<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * En la tabla "archivos" de la base de datos en realidad son las categorías, en ella el número 1 no existe, pero en la tabla de Carpetas, existe el número 1
 */
class Carpeta extends CI_Controller {

    function __construct() {
        parent::__construct();
    }
    public function eliminar_categoria($id_categoria){
        $this->load->model('Model_Categorias','cate');
        $res['resultado'] = $this->cate->delete($id_categoria);
        echo json_encode($res);
    }
    public function data_categoria($id_categoria){
        $this->load->model('Model_Categorias','cate');
        $res['obj'] = $this->cate->get_object($id_categoria);
        echo json_encode($res);

    }
    public function insertar_categoria(){
        $this->load->model('Model_Categorias','cate');
        $post = $this->input->post();
        $values['nomArchivo'] = $post['txtNombre'];
        $values['url'] = $post['txtUrl'];
        $values['estadoArchivo'] = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
        $res['resultado'] = $this->cate->insert($values);


        echo json_encode($res);
    }
    public function actualizar_categoria(){
        $this->load->model('Model_Categorias','cate');
        $post = $this->input->post();
        $values['nomArchivo'] = $post['txtNombre'];
        $values['idArchivo'] = $post['id'];
        $values['url'] = $post['txtUrl'];
        $values['estadoArchivo'] = strtolower($post['txtEstado']) == 'true' ? 1 : 0;
        $res['resultado'] = $this->cate->update($values);
        echo json_encode($res);

    }
    public function datatables_categorias(){
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){
            // switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
            //     case 'get_estado':
            //         $order = array('uni_estado' => $_POST['order']['0']['dir']);
            //         break;

            // }
        }
        $filter = array();
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'nomArchivo':
                        $likes[] = $p[$i];
                        break;
                    case 'estadoArchivo':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $joins = array();
        $datas = $this->Model_Datatables->get_datatables(
            'archivo',
            'object',
            $likes,
            $filter,
            $selects,
            $order,
            $joins,$_POST['length'],$_POST['start']);
        // $list = get_object_vars($list);

        $output = array(
            'recordsTotal' => $datas['count_all'],
            "recordsFiltered" => $datas['count_filtered'],
            "data" => $datas['list'],
            "post" => $_POST,
            );

        echo json_encode($output);
    }
    public function categorias(){
        $datos['ar_pages'] = array('Carpetas','Gestor','Categorias');
        $datos['titulo_header'] = 'Categorias de carpetas';

        $this->smartys->assign($datos);
        $this->smartys->render('carpetas/car_categorias');
    }
    public function listar_by_unidad($id_unidad){
        $this->load->model('Model_Unidad','unidad');
        $this->load->model('Model_Carpeta','carpeta');

        //retorna todas las carpetas con el mismo 'idDepenCarpeta', sin verificar nivel

        if(isset($_GET['nivel'])){
            if($_GET['nivel'] == 1){
                //filtrar el nivel de retorno de las carpetas de la unidad, en este caso solo las que sean hijos directos de la carpeta contenedora del departamento, las carpetas contenedoras de los departamentos son únicas
                $idDep = $this->unidad->getsimpledata($id_unidad)->reportaDpend;
                $objCarpeta = $this->carpeta->get_folder_dep($idDep);
                //obtener las carpetas de primer nivel dela unidad solicitada
                $hd = $this->carpeta->get_folder_uni_primernivel($objCarpeta->idCarpeta, $id_unidad);
                $ids = array();
                foreach ($hd as $key => $value) {
                    $ids[] = $value->idCarpeta;
                }

                $lstCarpeta = $this->carpeta->listar_by_unidad($id_unidad, $ids);
            }
        }else{
            $lstCarpeta = $this->carpeta->listar_by_unidad($id_unidad);
        }

        echo json_encode($lstCarpeta);
    }
    public function actualizar(){
        is_ajax();
        $this->load->model('Model_Carpeta','carpeta');
        $post = $this->input->post();
        $values['idCarpeta'] = $post['txtIdCarpeta'];
        $values['estadoCarpeta'] = $post['txtVisible'] == 'true' ? 9 : 1;
        $values['descripcionCarpeta'] = $post['txtTitulo'];
        // print_rr($_POST);
        if(isset($post['txtCategoria']))
            $values['idArchivoCarpeta'] = $post['txtCategoria'];
        $res['resultado'] = $this->carpeta->actualizar($values);
        echo json_encode($res);
        // print_rr($post);
    }
    public function data($id_carpeta){
        $this->load->model('Model_Carpeta','carpeta');

        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->carpeta->get_obj($id_carpeta);
        if($res['objRes']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }
    public function delete_folder($idcarpeta){
        is_ajax();
        $this->load->model('Model_Carpeta','carpeta');
        $res = $this->carpeta->eliminar_carpeta($idcarpeta);
        echo json_encode($res);


    }
    public function delete_archivo($idarchivo){

    }
    private function fnObtenerRutaCarpeta($idCarpeta){

        $this->load->model('Model_Carpeta');
        $carpetas = array();
        if($this->Model_Carpeta->existeId($idCarpeta)){

            do{
                $temp = $this->Model_Carpeta->getPadreCarpeta($idCarpeta);
                // print_rr($temp);
                $idCarpeta = +$temp->nivelCarpeta;
                $carpetas[] = $temp;

            }while($idCarpeta!=Ficheros::getCarpetaRaiz() && $idCarpeta!=Ficheros::getCarpetaSubRaiz());

            $carpetas = array_reverse($carpetas);
        }
        return $carpetas;
        // print_rr($carpetas);
    }

    public function create_folder(){
        //las carpetas que se crean en los departamentos son carpetas de unidades, estas peudes ser de 'n' cantidades
        is_ajax();


        $this->load->model('Model_Carpeta','carpeta');

        $post = $this->input->post();

        $values = array();
        $values['idDepenCarpeta'] = 1;
        $values['nivelCarpeta'] = Ficheros::getCarpetaRaiz();
        $values['estadoCarpeta'] = $post['txtVisible'] == 'true'? 9 : 1;
        $values['descripcionCarpeta'] = $post['txtTitulo'];
        if(isset($post['txtCategoria']))
            $values['idArchivoCarpeta'] = $post['txtCategoria'];
        if($post['txtIdPadreCarpeta'] != 'folder'){
            $values['nivelCarpeta'] = $post['txtIdPadreCarpeta'];

            if(isset($post['tipocrear'])){
                if($post['tipocrear'] == 1){
                    $objCar = $this->carpeta->get_obj(+$post['txtIdPadreCarpeta']);
                    $iddepend = $objCar->idDepenCarpeta;

                    $values['idDepenCarpeta'] = +$iddepend;
                    $values['estadoCarpeta'] = 1;
                    $values['idArchivoCarpeta'] = 5;
                }
                if($post['tipocrear'] == 2){
                    $objCar = $this->carpeta->get_folder_dep($post['idDepartamento']);
                    $values['idDepenCarpeta'] = $post['idUnidad'];
                    $values['nivelCarpeta'] = $objCar->idCarpeta;
                    $values['idArchivoCarpeta'] = 1;
                    $values['estadoCarpeta'] = 1;


                }
            }
        }




        // print_rr($_POST);
        // print_rr($values);exit;

        $res = $this->carpeta->crearCarpetaGeneral($values);
        echo json_encode($res);
        // print_rr($post);

    }
    public function index()
    {
        $this->load->model('Model_Carpeta');

        $datos = array();
        $datos['titulo_header'] = 'Carpetas';
        $datos['part_title'] = 'Carpetas';
        $data_folder = array(
            'carpeta' => 'folder'
            );
        $datos['lstCategorias'] = $this->Model_Carpeta->listarCategorias();
        $datos['lstCategoriasJSON'] = json_encode($datos['lstCategorias']);
        $datos['data_carpeta'] = json_encode($data_folder);

        $this->smartys->assign($datos);
        $this->smartys->render('carpetas/car_index');
    }
    public function fdep($carpeta){

    }
    public function f($carpetas = false){

        $idcarpeta = $carpetas;
        // if($this->input->is_ajax_request()){

            $data_ref = array();

            // print_rr($_POST);
            $this->load->model('Model_Datatables');
            $total_resultados = 0;
            $total_filtrado = 0;
            $todosFicheros = array();
            $order = false;
            $orderA = false;
            $orderB = false;
            if(isset($_POST['order'])){
                $orderA = array();
                $orderB = array();
                // echo 'order';
                foreach ($_POST['order'] as $key => $value) {
                    switch ($_POST['columns'][$value['column']]['data']) {
                        case 'Descripcion':
                            $orderA['descripcionCarpeta'] =  $value['dir'];
                            $orderB['desDoc'] =  $value['dir'];
                            break;
                        case 'CategoriaFichero':
                            $orderA['nomArchivo'] =  $value['dir'];
                            break;
                        case 'Visible':
                            $orderA['estadoCarpeta'] =  $value['dir'];
                            break;
                    }
                }
            }
            // print_rr($carpetas);

            if($carpetas == 'folder'){
                // print_rr($carpetas);
                $filter = array(
                    array('column' => 'nivelCarpeta' , 'filter' => Ficheros::getCarpetaRaiz())
                    );
                $datas = $this->Model_Datatables->get_datatables(
                'carpeta',
                'object',
                false,//likes
                $filter,//filtros
                array('substr(nomArchivo,3) as "nomArchivo"'),//selects
                $orderA,
                array(
                    array('archivo','archivo.idArchivo = carpeta.idArchivoCarpeta','left')
                ),//joins
                $_POST['length'],//lenght
                $_POST['start']);//start



                $total_resultados = $datas['count_all'];
                $total_filtrado = $datas['count_filtered'];

                foreach ($datas['list'] as $key => $value) {
                    $temp = new Ficheros();
                    $temp->NombreFichero = $value->desCarpeta;
                    $temp->Descripcion = $value->descripcionCarpeta;
                    $temp->TipoFichero = 1;
                    $temp->IdFichero = $value->idCarpeta;
                    $temp->CategoriaFichero = $value->idArchivoCarpeta;
                    $temp->Visible = $value->estadoCarpeta;
                    $temp->NombreCategoria = $value->nomArchivo;
                    $todosFicheros[] = $temp;
                }
                // $todosFicheros[] = $datas['list'];

            }else if($carpetas != ''){
                    // print_rr($carpetas);
                    $length = +$_POST['length'];
                    $start = +$_POST['start'];

                    $viewdocs = true;
                    $viewruta = true;

                    $filter = array(
                        array('column' => 'nivelCarpeta' , 'filter' => $carpetas)
                        // array('column' => 'idDepend' , 'filter' => 1)
                        );

                    //documentos
                    $filter2 = array(
                        array('column' => 'idCarpetaDoc' , 'filter' => $carpetas)
                        // array('column' => 'idDepend' , 'filter' => 1)
                        );
                    if(isset($_GET['t'])){
                        switch($_GET['t']){
                            case 'dep':
                                $this->load->model('Model_Carpeta','carpeta');
                                $objCar = $this->carpeta->get_carpetadoc_dep($carpetas);
                                // $filter[0]['column'] = 'nivelCarpeta';
                                // var_dump($objCar);
                                $filter[0]['filter'] = $objCar != null ? $objCar->idCarpeta : -1;
                                // $filter[] = array('column' => 'idDepenCarpeta' , 'filter' => $carpetas);
                                $viewdocs = false;
                                $idcarpeta = $objCar != null ? $objCar->idCarpeta : -1;
                                // $viewruta = false;
                                break;
                            case 'uni':

                                break;
                        }
                    }else{

                    }


                    // print_rr($filter);
                    // $this->load->model('Model_Carpeta');
                    // $this->load->model('Model_Documento');

                    // $lstCarpetas = $this->Model_Carpeta->listarCarpetas($carpetas);
                    // $lstDocumentos = $this->Model_Documento->listarDocumentoByCarpeta($carpetas);

                    //carpetas
                    $countDep = $this->Model_Datatables->get_datatables(
                        'carpeta',
                        'object',
                        false,//likes
                        $filter,//filtros
                        array(),//selects
                        $orderA,
                        array(
                        ),//joins
                        -1,//lenght
                        0);//start

                    $countDep = $countDep['count_filtered'];

                    $countDocs = $this->Model_Datatables->get_datatables(
                    'documento',
                    'object',
                    false,//likes
                    $filter2,//filtros
                    array(),//selects
                    $orderB,
                    array(
                    ),//joins
                    -1,//length
                    0);//start

                    $countDocs = +$countDocs['count_filtered'];
                    $config = array();
                    // print_rr($countDep + $countDocs);
                    if(($countDep + $countDocs)>0){
                        $mode = 1;
                        if($countDep > 0){


                        }
                        $quiebre = 0;

                        $resDep = $countDep % $length;

                        // print_rr($resDep);

                        $pages = floor($countDep / $length);

                        $difDepDoc = 0;
                        if($resDep > 0){
                            // if($pages == 0){
                            //     $quiebre = $pages;
                            // }
                            // else
                                $quiebre = $pages;
                            if($countDocs > 0){
                                $difDepDoc = ($length - $resDep);
                                $partDoc = ($countDocs - $difDepDoc);
                            }


                            // $resDep++;
                        }else{
                            if($pages == 0){
                                $mode = 2;
                            }
                            $resDep = $length;
                            $quiebre = $pages - 1;
                            $pages--;
                            if($countDocs > 0){
                                $difDepDoc = ($length - $resDep);
                                $partDoc = ($countDocs - $difDepDoc);
                            }

                        }
                        if($countDocs > 0 && $partDoc > 0){
                            $resDoc = $partDoc % $length;


                            $pagesDocs = floor($partDoc / $length);

                            if($resDoc > 0) $pages += $pagesDocs + 1;
                            else $pages += $pagesDocs;
                        }


                        // $pages++;



                        // print_rr($countDep.'-'.$countDocs.' = '.($countDep + $countDocs));
                        // print_rr($pages);
                        // print_rr($quiebre);


                        $startF = 0;
                        for ($i=0; $i < $pages +1; $i++) {

                            if($i == $quiebre){
                                $config[] = array(($i)*$length, $resDep, 0, $difDepDoc);
                                $mode = 2;
                            }else{
                                if($mode == 1){
                                    $config[] = array(($i)*$length, $length,0,0);
                                }else if($mode == 2){
                                    $config[] = array(0, 0,$difDepDoc + ($i - ($quiebre+1))*$length ,$length);
                                }
                            }

                        }
                    }
                    // print_rr($config);
                    //determinar la página que se solicita


                    if(count($config)>0){
                        // print_rr($config);
                        $targetpage = $start/$length;
                        $targetconfig = $config[$targetpage];
                         // print_rr($targetconfig);
                        if(!($targetconfig[0] == 0 && $targetconfig[1] == 0)){
                            $datas = $this->Model_Datatables->get_datatables(
                            'carpeta',
                            'object',
                            false,//likes
                            $filter,//filtros
                            array(),//selects
                            $orderA,
                            array(
                            ),//joins
                            $targetconfig[1],//$_POST['length'],//length
                            $targetconfig[0]);//$_POST['start']//start

                            // print_rr($datas);
                            foreach ($datas['list'] as $key => $value) {
                                $temp = new Ficheros();
                                $temp->NombreFichero = $value->desCarpeta;
                                $temp->Descripcion = $value->descripcionCarpeta;
                                $temp->TipoFichero = 1;
                                $temp->IdFichero = $value->idCarpeta;
                                $temp->CategoriaFichero = $value->idArchivoCarpeta;
                                $temp->Visible = $value->estadoCarpeta;
                                $todosFicheros[] = $temp;
                            }
                            $total_resultados += $datas['count_all'];

                            $total_filtrado += $datas['count_filtered'];
                        }





                       // if(isset($_GET['t'])){
                       //      switch($_GET['t']){
                       //          case 'dep':
                       //              // $filter[0]['column'] = 'nivelCarpeta';
                       //              $filter[0]['filter'] = -1;
                       //              // $filter[] = array('column' => 'idDepenCarpeta' , 'filter' => $carpetas);
                       //              // $filter2 = false;
                       //              break;
                       //          case 'uni':

                       //              break;

                       //      }
                       //  }
                    // echo 'no es folder';
                    // echo $carpetas.'-------';
                    if($viewdocs){


                        // print_rr($countDocs);
                        if(!($targetconfig[3] == 0 && $targetconfig[2] == 0)){
                            $datas = $this->Model_Datatables->get_datatables(
                            'documento',
                            'object',
                            false,//likes
                            $filter2,//filtros
                            array(),//selects
                            $orderB,
                            array(
                            ),//joins
                            $targetconfig[3],//$_POST['length'],//lenght
                            $targetconfig[2]);//$_POST['start']//start
                            foreach ($datas['list'] as $key => $value) {
                                $temp = new Ficheros();
                                $temp->NombreFichero = $value->nombreDoc;
                                $temp->Descripcion = $value->desDoc;
                                $temp->RutaDoc = $value->rutaDoc;
                                // $t = get_ico_file($value->rutaDoc);

                                // if($t[0] == 'rare')
                                //     $temp->RutaDoc = $value->rutaDoc.$value->nombreDoc;
                                  $h = explode('/', $value->rutaDoc);
                                if(trim(end($h)) == '')
                                    $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
                                $temp->TipoFichero = 2;
                                $temp->IdFichero = $value->idDoc;
                                $temp->FaIcono = get_ico_files($value->nombreDoc);
                                $temp->nameFileTwo = get_ico_name_files($value->nombreDoc);
                                $temp->Visible = $value->estadoDoc;
                                $todosFicheros[] = $temp;

                            }
                            $total_resultados += $datas['count_filtered'];
                            $total_filtrado += $datas['count_filtered'];
                        }


                    }
                    $total_filtrado = $countDep + $countDocs;
                    }

                if($viewruta)
                    $data_ref['ruta_carpeta'] = $this->fnObtenerRutaCarpeta($idcarpeta);
                // echo json_encode($todosFicheros);
                // exit;
            }

            // $output = array(
            //         "draw" => $_POST['draw'],
            //         "recordsTotal" => $datas['count_all'],
            //         "recordsFiltered" => $datas['count_filtered'],
            //         "data" => $datas['list'],
            //         "post" => $_POST
            //     );
            $output = array(
                        "draw" => isset($_POST['draw']) ? $_POST['draw'] : 'none' ,
                        // "recordsTotal" => $total_resultados,
                        "recordsTotal" => $total_resultados,
                        "recordsFiltered" => $total_filtrado,
                        "data" => $todosFicheros,
                        "post" => $_POST,
                        "ref" => $data_ref
                );

            echo json_encode($output);
            exit;
        // }else{
        //     $data_folder = array(
        //         'carpeta' => 'folder'
        //         );

        //     $datos['data_carpeta'] = json_encode($data_folder);
        // }

        if($carpetas){
            // echo 'asdad';
            $data_folder = array(
            'carpeta' => $carpetas
            );
            $datos['data_carpeta'] = json_encode($data_folder);
            $this->smartys->assign($datos);
            $this->smartys->render('carpetas/car_index');
        }else redirect('carpetas');

    }

    private function datatables_carpeta()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){
            // switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
            //     case 'get_estado':
            //         $order = array('uni_estado' => $_POST['order']['0']['dir']);
            //         break;

            // }
        }
        $filter = array();
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'rso_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'dep_id_departamento':
                    case 'uni_id_unidad':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $joins = array();
        $datas = $this->Model_Datatables->get_datatables(
            'carpeta',
            'object',
            $likes,
            $filter,
            $selects,
            $order,
            $joins,$res_lenght,$res_start);
        // $list = get_object_vars($list);

        $output = array(
            'recordsTotal' => $datas['count_all'],
            "recordsFiltered" => $datas['count_filtered'],
            "data" => $datas['list'],
            );
        // $output = array(
        //                 "draw" => $_POST['draw'],
        //                 "recordsTotal" => $datas['count_all'],
        //                 "recordsFiltered" => $datas['count_filtered'],
        //                 "data" => $datas['list'],
        //                 "post" => $_POST
        //         );
        return $output;
        // echo json_encode($output);
    }


}