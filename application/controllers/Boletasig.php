<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Boletasig extends CI_Controller {
    // private $folder_boleta_temp = '';
    function __construct() {
        parent::__construct();
        // AppSession::logueado();
        $this->load->model('Model_Boleta','boleta');
    }
    public function viewdoc($correlativo){
        //enrutar los los ficheros de las boletas
    }
    public function resumen(){
        $res = $this->boleta->get_resumen();
        echo_json($res);
    }
    public function finseguimiento(){
        if($this->input->is_ajax_request()){

            $p = $this->input->post();
            // print_rr($p);exit;
            if(isset($p['id_boleta']) && is_numeric($p['id_boleta'])){
                $objres = $this->boleta->finaliza_seguimiento($p);
                $res['resultado'] = true;
                $res['objRes'] = $objres;

            }else{
                $res['resultado'] = false;
                $res['objRes'] = null;
            }
            echo json_encode($res);
        }else{
            echo_json(array('msg' => 'Sin acceso'));
        }
    }
    public function agregar_seguimiento(){
        if($this->input->is_ajax_request()){

            $p = $this->input->post();
            // if(!isset($p['txtAccPost'])){
            //     $p['txtAccPost'] = array(9);
            // }
            // if(isset($p) && $p['txtObseSeg'] != ''){
            //     // $fechas = explode('-', $p['txtplazo']);
            //     $p['txtfecha_ini'] = DateTime::createFromFormat('d/m/Y', trim($fechas[0]));
            //     if(!$p['txtfecha_ini']) unset($p['txtfecha_ini']);
            //     $p['txtfecha_fin'] = DateTime::createFromFormat('d/m/Y', trim($fechas[1]));
            //     if(!$p['txtfecha_fin']) unset($p['txtfecha_fin']);

            //     if(isset($p['txtfecha_ini']) && isset($p['txtfecha_fin'])){
            //         //con plazo
            //         $p['conplazo']  = 1;
            //         $p['txtfecha_ini'] = $p['txtfecha_ini']->format('Y-m-d H:i:s');
            //         $p['txtfecha_fin'] = $p['txtfecha_fin']->format('Y-m-d H:i:s');
            //     }
            // }else{
            //     //sin plazo establecido
            // }



            // print_rr($p);
            // exit;

            $objres = $this->boleta->insertar_seguimiento($p);

            $res['resultado'] = true;
            $res['objRes'] = $objres;
            echo json_encode($res);
        }else{
            echo_json(array('msg' => 'Sin acceso'));
        }
    }
    public function seguimiento($id_boleta){

        if(AppSession::logueado()){
            if(!AppSession::accesoView(array('elaborador','revisador'))){
                error_app('No Autorizado', 'Usted no tiene permisos para esta operación');
            }else{
                $datos['objBoleta'] = $this->boleta->getdata($id_boleta);
                array_unshift($datos['objBoleta']->fechas_seguimiento, date('d/m/Y'));
                $datos['objBoleta']->fechas_seguimiento = array_unique($datos['objBoleta']->fechas_seguimiento);
                $datos['targettoday'] = date('d/m/Y');
                // print_rr($datos['objBoleta']);exit;
                if($datos['objBoleta']){



                    // $this->session->ref_session_boleta = get_cookie('ci_session');
                    // $this->session->ref_session_boleta = $datos['objBoleta']->bol_correlativo;
                    // $this->session->ref_bol_id = $datos['objBoleta']->bol_id;
                    $name_temp_folder = md5($datos['objBoleta']->bol_id.$datos['objBoleta']->bol_correlativo);

                    verificar_carpeta_procesos();
                    delete_folder(DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp_seg'.DS.$name_temp_folder.DS);
                    //verficar si fue rechazado para así al entrar a la vista esta devuelva datos para ser utilizados
                    $this->boleta->eliminar_file_expire('_temp_seg');


                    if(+$datos['objBoleta']->bol_estado == ent_boleta::getEstado('seguimiento')){//procesado
                        // $datos['lstunidades'] = $this->uni->listar();
                        $datos['seguimiento'] = false;
                        if($datos['objBoleta']->bol_uni_receptor == AppSession::get('id_unidad')){
                            $datos['seguimiento'] = true;
                        }

                            $datos['part_title'] = 'Seguimiento Boleta '.$datos['objBoleta']->bol_correlativo;
                            // for ($i = +date('n') ; $i < 12; $i++) {

                            $datos['lstmeses'] = $this->list_meses();
                            // $datos['lstyears'] = $lst_years;

                            $datos['ref_icons'] = json_encode(get_list_ico_files());

                            $datos['lstAccInme'] = $this->boleta->listar_acciones(1);
                            $datos['lstAccPost'] = $this->boleta->listar_acciones(2);

                            $datos['ar_pages'] = array('Boletas SIG','Seguimiento ');
                            $datos['titulo_header'] = 'Boleta SIG, '.$datos['objBoleta']->bol_correlativo;

                            // $this->smartys->assign($datos);
                            // $this->smartys->render('bol_procesar');
                            $this->smartys->assign($datos);
                            $this->smartys->render('bol_respuesta');
                        // }else{
                        //     error_app('No Autorizado', 'Usted no tiene permisos para esta operación');
                        // }
                    }else{
                        error_app('Boleta SIG en otro estado', 'La Boleta SIG debe estar en estado «procesado»');
                    }
                }else{
                    error_app('Boleta SIG no encontrada', 'No existe registro de esta Boleta SIG');
                }
            }




        }
    }
    public function mostrar_respuestas(){
        return false;
    }
    public function ver($id_boleta){
        if(AppSession::logueado()){
            $objBol = $this->boleta->getdata($id_boleta);

            if($objBol){
                $opcionesver = array();
                switch (+$objBol->bol_estado) {
                    case ent_boleta::getEstado('elaborado'):
                        if(!AppSession::accesoView(array('revisador', 'jefe'))){
                            $pase = true;
                        }else{

                        }

                        break;

                    default:
                        # code...
                        break;
                }
                // if($pase){
                if(true){
                    $datos['veropc'] = $opcionesver;
                    $datos['solover'] = true;
                    $this->load->model('Model_Unidad','uni');
                    $datos['part_title'] = 'Boleta «'.$objBol->bol_correlativo.'»';
                    // $datos['lstmeses'] = $this->list_meses();
                    // $datos['lstunidades'] = $this->uni->listar();
                    // print_rr($datos['objBoleta']);exit;
                    $datos['objBoleta'] = $objBol;
                    $datos['solo_vista'] = true;
                    $datos['ref_icons'] = json_encode(get_list_ico_files());
                    $datos['lstAccInme'] = $this->boleta->listar_acciones(1);
                    $datos['lstAccPost'] = $this->boleta->listar_acciones(2);
                    $datos['ar_pages'] = array('Boletas SIG','Respuesta');
                    $datos['titulo_header'] = 'Boleta SIG, '.$objBol->bol_correlativo;
                    $this->smartys->assign($datos);
                    $this->smartys->render('bol_ver');
                    // $this->smartys->render('bol_fiscalizar');

                }
            }else{
                    error_app('Boleta SIG no encontrada', 'No existe registro de esta Boleta SIG');

            }

        }
    }
    public function bitacora($idbol){

        if($this->boleta->existe_id($idbol)){
            $objBol = $this->boleta->getdata($idbol);
            $datos['titulo_header'] = $datos['part_title'] = 'Bitacora boleta SIG «'.$objBol->bol_correlativo.'»';
            $datos['lstBitacora'] = $this->boleta->getBitacora($idbol);
            $this->smartys->assign($datos);
            $this->smartys->render('bol_bitacora');
        }else{
            error_app('Contenido no encontrado', 'Boleta SIG no existe');
        }

    }
    public function enviar_observacion($idb, $destino){
        $objB = $this->boleta->getsimpledata($idb);
        if($objB){
            if($objB->bol_estado == ent_boleta::getEstado('rechaza_elaborado') ||
                $objB->bol_estado == ent_boleta::getEstado('rechaza_proceso') ||
                $objB->bol_estado == ent_boleta::getEstado('rechazado')){
                $opciones = array(
                    'asunto' => 'Boleta SIG rechazada'
                    );
                switch($destino){
                    case 'emi':
                        enviar_observacion_reutilizable($objB->bol_uni_remitente, $opciones);
                        break;
                    case 'rec':
                        enviar_observacion_reutilizable($objB->bol_uni_receptor, $opciones);
                        break;
                    default :
                        error_app('Opción Inválida', 'No existe opción de Remitente o Receptor');
                        break;
                }
            }else{
                redirect('boletasig/listar');
            }
        }else error_app('Boleta SIG no encontrada', 'La Boleta SIG no existe');

    }
    public function rechazada($idb){
        AppSession::logueado();
            // redirect('boletasig/listar');


        $this->load->model('Model_Unidad','uni');
        $datos['objBoleta'] = $this->boleta->getdata($idb);
        if($datos['objBoleta']){
            if($datos['objBoleta']->bol_rechazado != 1){
                error_app('Boleta SIG «'.$datos['objBoleta']->bol_correlativo.'» Activa','La boleta no ha sido rechazada');
            }else{
                $datos['lstunidades'] = $this->uni->listar();
                $datos['ref_icons'] = json_encode(get_list_ico_files());
                $datos['ar_pages'] = array(
                    'Boletas SIG',
                    '<a href="'.base_url('boletasig/listar').'">Listar</a>',
                    'Rechazada');
                $datos['part_title'] = $datos['titulo_header'] = 'Boleta SIG, '.$datos['objBoleta']->bol_correlativo.' rechazada';

                $this->smartys->assign($datos);
                $this->smartys->render('bol_aprobar');
            }
        }else{
            error_app('Contenido no encontrado', 'Boleta SIG no existe');
        }


        // print_rr($datos['objBoleta']);
        // exit;


    }
    public function rechazar_elaborado($idb){
        // print_rr($idb);exit;
        $objBoleta = $this->boleta->getsimpledata($idb);
        $res['resultado'] = $this->boleta->rechazar_boleta($idb, ent_boleta::getEstado('rechaza_elaborado'));
        enviar_notificacion_sistema_custom_dos($this->session->id_unidad,$this->session->id_unidad, 32,array(
                'default' => true,
                'boleta_correlativo' => $objBoleta->bol_correlativo,
                'ref_url' => 'boletasig/rechazada/'.$idb,
                'bol_id' => $idb
        ));
        echo json_encode($res);
    }
    public function index()
    {
        $datos = array();


        $this->smartys->assign();
        $this->smartys->render('index');
    }
    public function cerrar_boleta(){
        $p = $this->input->post();
        // print_rr($p);

        $res['resultado'] = true;
        echo json_encode($res);
    }
    /**
     * [rechazar_respuesta
     * --Cambia estado de Boleta SIG a PROCESADO
     * --Envia observación a unidad generadora para ser corregido
     * ]
     * @return [string] [json]
     */
    public function rechazar_respuesta($id_b){

        $res['resultado'] = $this->boleta->rechazar_boleta($id_b);
        echo json_encode($res);
    }

    public function rechazar_proceso($idb){
        $objBol = $this->boleta->getsimpledata($idb);
        $res['resultado'] = $this->boleta->rechazar_boleta($idb, ent_boleta::getEstado('rechaza_proceso'));

        enviar_notificacion_sistema_custom_dos($objBol->bol_uni_remitente, $this->session->id_unidad, 32,array(
                'default' => true,
                'boleta_correlativo' => $objBol->bol_correlativo,
                'ref_url' => 'boletasig/rechazada/'.$idb,
                'bol_id' => $idb
        ));
        // $this->session->preunidad = $objBol->bol_uni_remitente;
        // $this->session->sigproceso = 'boletarechazada';
        // $this->session->bolcorre = $objBol->bol_correlativo;
        // $this->session->prerefresh = false;
        echo json_encode($res);
    }
    public function fiscalizar($id_boleta){
        if(AppSession::logueado()){
            if(!AppSession::accesoView(array('administrador'))){

                error_app('No Autorizado', 'Usted no tiene permisos para esta operación');
            }else{
                $objBol = $this->boleta->getdata($id_boleta);
                // print_rr($objBol);exit;
                $datos['objBoleta'] = $objBol;
                if($objBol){
                    // if($objBol->bol_estado == ent_boleta::getEstado('respondido','seguimiento_fin')){
                    if(ent_boleta::inEstado($objBol->bol_estado, array('respondido','seguimiento_fin'))){
                        $this->load->model('Model_Unidad','uni');
                        $datos['part_title'] = 'Fiscalizar Boleta «'.$objBol->bol_correlativo.'»';
                        // $datos['lstmeses'] = $this->list_meses();
                        // $datos['lstunidades'] = $this->uni->listar();
                        // print_rr($datos['objBoleta']);exit;
                        $datos['ref_icons'] = json_encode(get_list_ico_files());
                        $datos['lstAccInme'] = $this->boleta->listar_acciones(1);
                        $datos['lstAccPost'] = $this->boleta->listar_acciones(2);
                        $datos['ar_pages'] = array('Boletas SIG','Respuesta');
                        $datos['titulo_header'] = 'Boleta SIG, '.$objBol->bol_correlativo;
                        $this->smartys->assign($datos);
                        $this->smartys->render('bol_fiscalizar_dos');
                        // $this->smartys->render('bol_fiscalizar');

                    }else{
                        error_app('Boleta SIG en otro estado', 'La Boleta SIG debe estar en estado «respondido»');
                    }
                }else{
                    error_app('Boleta SIG no encontrada', 'No existe registro de esta Boleta SIG');

                }
            }
        }

    }
    private function list_meses(){
        $lst_mes = array();
          for ($i = 1 ; $i < 12; $i++) {
                $__mes = '';
                switch ($i) {
                    case 1: $__mes = 'Enero'; break;
                    case 2: $__mes = 'Febrero'; break;
                    case 3: $__mes = 'marzo'; break;
                    case 4: $__mes = 'Abril'; break;
                    case 5: $__mes = 'Mayo'; break;
                    case 6: $__mes = 'Junio'; break;
                    case 7: $__mes = 'Julio'; break;
                    case 8: $__mes = 'Agosto'; break;
                    case 9: $__mes = 'Septiembre'; break;
                    case 10: $__mes = 'Octubre'; break;
                    case 11: $__mes = 'Noviembre'; break;
                    case 12: $__mes = 'Diciembre'; break;
                }
                $lst_mes[] = array(
                    'num' => $i,
                    'mes' => $__mes
                    );
            }
        return $lst_mes;
    }
    public function respuesta($id_boleta){
        if(AppSession::logueado()){
            if(!AppSession::accesoView(array('elaborador','revisador','jefe'))){
                error_app('No Autorizado', 'Usted no tiene permisos para esta operación');

            }
            $datos['objBoleta'] = $this->boleta->getdata($id_boleta);
            if($datos['objBoleta']){

                // $this->session->ref_session_boleta = get_cookie('ci_session');
                // $this->session->ref_session_boleta = $datos['objBoleta']->bol_correlativo;
                // $this->session->ref_bol_id = $datos['objBoleta']->bol_id;
                $name_temp_folder = md5($datos['objBoleta']->bol_id.$datos['objBoleta']->bol_correlativo);

                verificar_carpeta_procesos();
                delete_folder(DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp_res'.DS.$name_temp_folder.DS);
                //verficar si fue rechazado para así al entrar a la vista esta devuelva datos para ser utilizados
                $this->boleta->eliminar_file_expire('_temp_res');


                if(+$datos['objBoleta']->bol_estado == ent_boleta::getEstado('procesado')){//procesado
                    // $datos['lstunidades'] = $this->uni->listar();
                    $datos['responde'] = false;
                    if($datos['objBoleta']->bol_uni_receptor == AppSession::get('id_unidad')){
                        $datos['responde'] = true;
                    }
                        $lst_years = array();
                // print_rr($datos['objBoleta']);exit;

                        $getdate  = date('Y');
                        for ($i=1; $i < 4 ; $i++) {
                            $lst_years[] = +$getdate++;
                        }
                        $datos['part_title'] = 'Respuesta Boleta '.$datos['objBoleta']->bol_correlativo;
                        // for ($i = +date('n') ; $i < 12; $i++) {

                        $datos['lstmeses'] = $this->list_meses();
                        $datos['lstyears'] = $lst_years;

                        $datos['ref_icons'] = json_encode(get_list_ico_files());

                        $datos['lstAccInme'] = $this->boleta->listar_acciones(1);
                        $datos['lstAccPost'] = $this->boleta->listar_acciones(2);

                        $datos['ar_pages'] = array('Boletas SIG','Respuesta');
                        $datos['titulo_header'] = 'Boleta SIG, '.$datos['objBoleta']->bol_correlativo;

                        // $this->smartys->assign($datos);
                        // $this->smartys->render('bol_procesar');
                        $this->smartys->assign($datos);
                        $this->smartys->render('bol_respuesta');
                    // }else{
                    //     error_app('No Autorizado', 'Usted no tiene permisos para esta operación');
                    // }
                }else{
                    error_app('Boleta SIG en otro estado', 'La Boleta SIG debe estar en estado «procesado»');
                }
            }else{
                error_app('Boleta SIG no encontrada', 'No existe registro de esta Boleta SIG');
            }




        }
    }
    public function eliminar_fichero(){
        $post = $this->input->post();
        $res['resultado'] = false;
        if(isset($post['id_fichero']))
            $res['resultado'] = $this->boleta->eliminar_file_temp($post['id_fichero']);
        echo json_encode($res);
    }
    public function eliminar_fichero_alojado(){
        $post = $this->input->post();
        $res['resultado'] = false;
        if(isset($post['id_fichero']))
            $res['resultado'] = $this->boleta->eliminar_file_alojado($post['id_fichero']);
        echo json_encode($res);
    }
    public function procesa($id_boleta){
        $res['respuesta'] = false;
        $res['respuesta'] = $this->boleta->procesar_boleta($id_boleta);
        $objBol = $this->boleta->getsimpledata($id_boleta);
        $this->load->model('Model_Unidad', 'uni');
        $objUniEmi = $this->uni->getsimpledata($objBol->bol_uni_remitente);
        $objUniRec = $this->uni->getsimpledata($objBol->bol_uni_receptor);
        enviar_notificacion_sistema_custom_dos($objBol->bol_uni_receptor,$this->session->id_unidad, 4,array(
                'default' => true,
                'boleta_correlativo' => $objBol->bol_correlativo,
                'unidad_remite' => $objUniEmi->desDepend,
                'ref_url' => 'boletasig/respuesta/'.$id_boleta,
                'bol_id' => $id_boleta
        ));
        enviar_notificacion_sistema_custom_dos($objBol->bol_uni_remitente,$this->session->id_unidad, 'bol_proce_info_gen',array(
                'boleta_correlativo' => $objBol->bol_correlativo,
                'unidad_receptora' => $objUniRec->desDepend,
                'ref_url' => 'boletasig/respuesta/'.$id_boleta,
                'bol_id' => $id_boleta
        ));
        echo json_encode($res);

    }
    public function responder(){
        if($this->input->is_ajax_request()){

            $p = $this->input->post();
            if(!isset($p['txtAccPost'])){
                $p['txtAccPost'] = array(9);
            }
            if(isset($p) && $p['txtplazo'] != ''){
                $fechas = explode('-', $p['txtplazo']);
                $p['txtfecha_ini'] = DateTime::createFromFormat('d/m/Y', trim($fechas[0]));
                if(!$p['txtfecha_ini']) unset($p['txtfecha_ini']);
                $p['txtfecha_fin'] = DateTime::createFromFormat('d/m/Y', trim($fechas[1]));
                if(!$p['txtfecha_fin']) unset($p['txtfecha_fin']);

                if(isset($p['txtfecha_ini']) && isset($p['txtfecha_fin'])){
                    //con plazo
                    $p['conplazo']  = 1;
                    $p['txtfecha_ini'] = $p['txtfecha_ini']->format('Y-m-d H:i:s');
                    $p['txtfecha_fin'] = $p['txtfecha_fin']->format('Y-m-d H:i:s');
                }
            }else{
                //sin plazo establecido
            }



            // print_rr($p);
            // exit;

            $this->boleta->responder_boleta($p);

            $res['resultado'] = true;
            echo json_encode($res);
        }else{
            echo_json(array('msg' => 'Sin acceso'));
        }
    }
    public function procesar($id_boleta){
        if(AppSession::logueado()){

            if(!AppSession::accesoView(array('administrador'))){
                error_app('No Autorizado', 'No tiene permisos para esta Operación');
            }else{
                if(AppSession::get('id_unidad') == procesos_sig::autoriza('boleta_ambiental') || AppSession::get('id_unidad') == procesos_sig::autoriza('boleta_seguridad')){
                    $datos['part_title'] = 'Procesar';
                    $this->load->model('Model_Unidad','uni');
                    $datos['objBoleta'] = $this->boleta->getdata($id_boleta);
                    if($datos['objBoleta']->bol_estado == ent_boleta::getEstado('aprobado')){
                        $datos['lstunidades'] = $this->uni->listar();
                        $datos['ref_icons'] = json_encode(get_list_ico_files());
                        $datos['ar_pages'] = array('Boletas SIG','Procesar');
                        $datos['part_title'] = $datos['titulo_header'] = 'Procesar boleta SIG, '.$datos['objBoleta']->bol_correlativo;

                        $this->smartys->assign($datos);
                        $this->smartys->render('bol_procesar');
                    }else
                        error_app('Boleta SIG en otro estado', 'La Boleta SIG debe estar en estado «aprobado»');
                }else error_app('No Autorizado', 'No tiene permisos para esta Operación');
            }
        }

    }
    public function aprobar($id_boleta){
        if(!AppSession::accesoView(array('jefe','revisador'))){
            error_app('No Autorizado', 'No tiene permisos para esta Operación');
        }else{
            $this->load->model('Model_Unidad','uni');
            $datos['objBoleta'] = $this->boleta->getdata($id_boleta);
            if(+$datos['objBoleta']->bol_estado == +ent_boleta::getEstado('elaborado')){
                // print_rr($datos['objBoleta']);
                // exit;
                $datos['lstunidades'] = $this->uni->listar();
                $datos['ref_icons'] = json_encode(get_list_ico_files());
                $datos['ar_pages'] = array('Boletas SIG','<a href="'.base_url('boletasig/listar').'">Listar</a>','Aprobar');
                $datos['part_title'] = $datos['titulo_header'] = 'Aprobar boleta SIG, '.$datos['objBoleta']->bol_correlativo;

                $this->smartys->assign($datos);
                $this->smartys->render('bol_aprobar');
            }else error_app('Boleta SIG en otro estado', 'La Boleta SIG debe estar en estado de elaborado');
        }


    }
    private function set_values($p, $correlativo = false){

        $obj = new ent_boleta();
        if(isset($p['txtId']))
            $obj->bol_id = $p['txtId'];
        if(!$correlativo){
            $oc = $this->corre->obtener_correlativo('boleta', +$p['txtTipo']);
            $obj->bol_correlativo = $oc->correlativo;
        }
        $obj->bol_tipo = isset($p['txtTipo']) ? $p['txtTipo'] : null;
        $obj->bol_uni_remitente = isset($p['txtUniRemi']) ? $p['txtUniRemi'] : null;
        $obj->bol_uni_receptor = isset($p['txtUniRece']) ? $p['txtUniRece'] : null;
        $obj->bol_observacion = isset($p['txtObserva']) ? $p['txtObserva'] : null;
        $obj->bol_corregir = isset($p['txtCorregir']) ? $p['txtCorregir'] : null;
        $obj->bol_estado = 1;
        // $obj->bol_plazo_accion = 10000;//tiempo en segundos palzo
        // $obj->bol_fecha_generado = date('Y-m-d H:i:s');
        // $obj->bol_expire = 10000;// tiempo expiración de boleta
        // $obj->bol_nombre_ela = $p['txtNombreEla'];
        // $obj->bol_ficha_ela = $p['txtFichaEla'];
        // $obj->bol_dni_ela = $p['txtDniEla'];
        return $obj;
    }
    public function listar(){
        if(AppSession::logueado()){
            $datos['part_title'] = 'Listar Boletas';
            $this->load->model('Model_Unidad','uni');
            $datos['lstunidades'] = $this->uni->listar();
            $datos['ar_pages'] = array('Boletas SIG','Listar');
            $datos['titulo_header'] = 'Boletas SIG';
            $datos['procesossig'] = new procesos_sig();
            // $this->smartys->registerClass('ent_boleta','ent_boleta');
            $this->smartys->assign($datos);
            $this->smartys->render('bol_listar');
        }

    }
    public function upload_ficheros_seg(){
        // echo 'asdasdasd';exit;
        // print_rr($_POST);exit;
        // $cis = $this->session->ref_session_boleta;
        $cis = md5($_POST['bol_id'].$_POST['bol_correlativo']);
        // $cis = md5()
        verificar_carpeta_procesos();
        $params = array(
            'upload_dir' => DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp_seg'.DS.$cis.DS,
            'upload_url' => NAMEDOC.'/__procesoss/_boletasig/_temp_seg/'.$cis.'/'
            );
        // $up = new UploadHandler($params);


        ob_start();
        $qq = $this->load->library('UploadHandler',$params);
        $salida2 = ob_get_contents();
        ob_end_clean();
        $pre_salida = json_decode($salida2);


        $targetFile = $this->uploadhandler->response['files'][0];
        // print_rr($targetFile);
        $values['abo_nombre_fichero'] = $targetFile->name;
        $values['abo_tipo'] = 3;//evidencia_obs_seguimiento
        $values['abo_user_temp'] = $cis;
        $values['abo_expire'] = time() + ent_boleta::getTimExpireFiles();
        $ref_files = $this->boleta->insertar_fichero($values);
        $pre_salida->files[0]->id_fichero = $ref_files;
        echo json_encode($pre_salida);

    }
    public function upload_ficheros_res(){
        // echo 'asdasdasd';exit;
        // print_rr($_POST);exit;
        // $cis = $this->session->ref_session_boleta;
        $cis = md5($_POST['bol_id'].$_POST['bol_correlativo']);
        // $cis = md5()
        verificar_carpeta_procesos();
        $params = array(
            'upload_dir' => DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp_res'.DS.$cis.DS,
            'upload_url' => NAMEDOC.'/__procesoss/_boletasig/_temp_res/'.$cis.'/'
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
        $values['abo_nombre_fichero'] = $targetFile->name;
        $values['abo_tipo'] = 2;//evidencia_obs_respuesta
        $values['abo_user_temp'] = $cis;
        $values['abo_expire'] = time() + ent_boleta::getTimExpireFiles();
        $ref_files = $this->boleta->insertar_fichero($values);
        $pre_salida->files[0]->id_fichero = $ref_files;
        echo json_encode($pre_salida);

    }

    public function upload_ficheros(){
        // echo 'asdasdasd';exit;

        $cis = $this->session->ref_session_boleta;
        verificar_carpeta_procesos();
        $params = array(
            'upload_dir' => DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp'.DS.$cis.DS,
            'upload_url' => NAMEDOC.'/__procesoss/_boletasig/_temp/'.$cis.'/'
            );
        // $up = new UploadHandler($params);
        ob_start();
        $qq = $this->load->library('UploadHandler',$params);
        $salida2 = ob_get_contents();
        ob_end_clean();
        $pre_salida = json_decode($salida2);

        // print_rr($pre_salida);

        $targetFile = $this->uploadhandler->response['files'][0];
        // print_rr($targetFile);
        $values['abo_nombre_fichero'] = $targetFile->name;
        $values['abo_tipo'] = 1;//evidencia_obs_realizada
        $values['abo_user_temp'] = $cis;
        $values['abo_expire'] = time() + ent_boleta::getTimExpireFiles();
        $ref_files = $this->boleta->insertar_fichero($values);
        $pre_salida->files[0]->id_fichero = $ref_files;
        echo json_encode($pre_salida);


    }
    public function crear(){
        if(is_ajax(false)){
            // $this->load->model('Model_Boleta','boleta');
            $this->load->model('Model_Correlativo','corre');
            $post = $this->input->post();
            $obj  = $this->set_values($post);
            $idb = $this->boleta->insertar($obj);
            $res['resultado'] = false;
            if($idb){
                if(!isset($this->uni))
                    $this->load->model('Model_Unidad','uni');
                // $objBol = $this->boleta->getsimpledata($idb);
                $ojUnidad = $this->uni->getsimpledata($obj->bol_uni_receptor);

                enviar_notificacion_sistema_custom_dos(
                    $obj->bol_uni_remitente,
                    $this->session->id_unidad,
                    31,
                    array(
                        'default' => true,
                        'boleta_correlativo' => $obj->bol_correlativo,
                        'unidad_receptora' => $ojUnidad->desDepend,
                        'ref_url' => 'boletasig/aprobar/'.$idb
                    ));
                // enviar_notificacion_sistema($obj->bol_uni_remitente,$this->session->id_unidad, 3);
                $res['resultado'] =true;

                // echo json_encode($res);
            }
            echo_json($res);
        }else{
            echo_json(array('msg'=>'No Autorizado'));
        }
    }


    public function aprobar_boleta(){
        if(is_ajax(false)){
            $p = $this->input->post();
        // print_rr($p);
            $obj  = $this->set_values($p, true);
            // print_rr($obj);
            // exit;

            unset($obj->bol_plazo_accion);
            unset($obj->bol_expire);
            $obj->bol_estado = 2;
            $this->boleta->aprobar_boleta($obj);
            // print_rr($obj);
            //quitar valores
            // exit;

            // enviar_notificacion_sistema(16,$this->session->id_unidad, 3);
            if(!isset($this->uni))
                $this->load->model('Model_Unidad','uni');
            $ojUnidadRecep = $this->uni->getsimpledata($obj->bol_uni_receptor);
            $ojUnidadRem = $this->uni->getsimpledata($obj->bol_uni_remitente);
            //informar unidad responsable desorollo|seguridad
            enviar_notificacion_sistema_custom_dos(ent_boleta::receptor($obj->bol_tipo),$this->session->id_unidad, 3,array(
                    'default' => true,
                    'unidad_receptora' => $ojUnidadRecep->desDepend,
                    'unidad_remite' => $ojUnidadRem->desDepend,
                    'ref_url' => 'boletasig/procesar/'.$obj->bol_id
            ));
            //informar a unidad de que se aprobó boleta
            enviar_notificacion_sistema_custom_dos($this->session->id_unidad,$this->session->id_unidad, 'bol_aprobado',array(
                    'default' => false,
                    'tipo' => 'boleta',
                    'unidad_receptora' => $ojUnidadRecep->desDepend,
                    'boleta_correlativo' => $obj->bol_correlativo,
                    'unidad_remite' => $ojUnidadRem->desDepend,
                    'ref_url' => 'boletasig/procesar/'.$obj->bol_id
            ));
            $res['resultado'] = true;
            echo json_encode($res);
        }else{
            echo_json(array('msg'=>'No permitido'));
        }


    }
    public function listar_boleta()
    {
    	#$this->load->model('Model_Listar_boletas');  -->


    	$datos = array();

    	$this->smartys->assign($datos);
    	$this->smartys->render('listar');

    }
    public function generar_boleta()
    {
        if(!AppSession::accesoView(array('elaborador','revisador'))){
            redirect('home/dashboard');
        }
        $datos['part_title'] = 'Generar Boleta';
        $this->session->ref_session_boleta = get_cookie('ci_session');
        verificar_carpeta_procesos();
        //eliminar fichero temp anterior misma session
        delete_folder(DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp'.DS.$this->session->ref_session_boleta.DS);
        //eliminar fichero de DB que ya expiren
        $this->boleta->eliminar_file_expire('_temp');

        // $this->session->unset_userdata('ref_session_boleta');
        // print_rr($_SESSION);
        // echo '<span>😑</span>';
        // echo '<div>'.get_cookie('ci_session').'</div>';
        $this->load->model('Model_Unidad','uni');
        $datos['lstunidades'] = $this->uni->listar();
        $datos['ar_pages'] = array('Boletas SIG','Generar');
    	$datos['titulo_header'] = 'Generar Boletas SIG';
        $datos['ref_icons'] = json_encode(get_list_ico_files());
        // print_rr($_SESSION);exit;
    	$this->smartys->assign($datos);
    	$this->smartys->render('bol_generar');
    }



    public function revision_boleta()
    {
    	 $datos = array();

    	$this->smartys->assign($datos);
    	$this->smartys->render('revision');
    }
    public function reviewdata(){
        // print_rr($_POST);
        $this->datatables();
    }
    public function datatables(){
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
                 "urm.desDepend as uni_rem_nombre",
                 "urc.desDepend as uni_rec_nombre",
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
        //['default'] Aplica al filtro del datatable y lo considera como por defecto
        if(+$this->session->tipo_usuario < ent_usuarios::getUsuario('admin-sig')){

            if(+$this->session->tipo_usuario == ent_usuarios::getUsuario('administrador')){

                switch (AppSession::get('id_unidad')) {
                    case procesos_sig::autoriza('boleta_seguridad'):
                         $filter[] = array(
                            'column' => 'bol_tipo',
                            'filter' => 2,
                            'default' => true
                            );

                        $filter[] = array(
                            'column' => '(bol_estado != '.ent_boleta::getEstado('elaborado').' and bol_estado != '.ent_boleta::getEstado('rechaza_elaborado').')  or ((bol_estado = '.ent_boleta::getEstado('elaborado').' or bol_estado = '.ent_boleta::getEstado('rechaza_elaborado').' ) and bol_uni_remitente = '.$this->session->id_unidad.')',
                            'default' => true,
                            'type' => 'custom'

                            );
                        break;
                    case procesos_sig::autoriza('boleta_ambiental'):
                         $filter[] = array(
                            'column' => 'bol_tipo',
                            'filter' => 1,
                            'default' => true
                            );

                         $filter[] = array(
                            'column' => '(bol_estado != '.ent_boleta::getEstado('elaborado').' and bol_estado != '.ent_boleta::getEstado('rechaza_elaborado').')  or ((bol_estado = '.ent_boleta::getEstado('elaborado').' or bol_estado = '.ent_boleta::getEstado('rechaza_elaborado').' ) and bol_uni_remitente = '.$this->session->id_unidad.')',
                            'default' => true,
                            'type' => 'custom'

                            );
                        break;
                    default:
                          $filter[] = array(
                            'column' => 'bol_uni_remitente',
                            'filter' => $this->session->id_unidad,
                            'default' => true
                            );
                        break;
                }
            }else{
                // $filter[] = array(
                //     'column' => 'bol_uni_remitente',
                //     'filter' => $this->session->id_unidad,
                //     'default' => true
                //     );
                $filter[] = array(
                    'column' => '(bol_uni_remitente ='.$this->session->id_unidad.' or bol_uni_receptor = '.$this->session->id_unidad.') and ((bol_uni_receptor = '.$this->session->id_unidad.' and bol_estado not in(8,9,1,2)) or (bol_uni_remitente = '.$this->session->id_unidad.' or bol_estado not in(8,9,1,2)) ) ',
                    'default' => true,
                    'type' => 'custom'
                    );
            }
        }
        // if(+$this->session->tipo_usuario == 5){
        //     if($this->session->id_unidad == procesos_sig::autoriza('boleta_seguridad')){//##CAMBIAR
        //         $filter[] = array(

        //         'column' => 'bol_tipo',
        //         'filter' => 2,
        //         'default' => true
        //         );
        //     }
        //     if($this->session->id_unidad == procesos_sig::autoriza('boleta_ambiental')){
        //         $filter[] = array(

        //         'column' => 'bol_tipo',
        //         'filter' => 1,
        //         'default' => true
        //         );
        //     }

        // }
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'usu_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'dep_id_departamento':
                        $filter[] = array('column' => 'dd.idDepend', 'filter' => $value['filter']);
                        break;
                    case 'uni_id_unidad':
                        $filter[] = $p[$i];
                        break;
                    case 'usu_estado':
                    case 'usu_tipo_usuario':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                array('dependencia urm','urm.idDepend = tbl_boletasig.bol_uni_remitente'),
                array('dependencia urc','urc.idDepend = tbl_boletasig.bol_uni_receptor')
                // array('dependencia dd','dd.idDepend = d.reportaDpend')
            );
        $datas = $this->Model_Datatables->get_datatables('tbl_boletasig','object',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);

        foreach ($datas['list'] as $key => $value) {
            $value->uni_activa = AppSession::get('id_unidad');
            $value->tipo_usuario = AppSession::get('tipo_usuario');
        }
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