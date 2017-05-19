<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Boleta extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function finaliza_seguimiento($p){

        $this->db->where('bol_id', $p['id_boleta']);
        return $this->db->update('tbl_boletasig', array(
            'bol_fin_seg' => 1,
            'bol_fecha_fin_seg' => date('Y-m-d H:i:s')
            ));
    }
    public function por_responder($unidad_observada){
        $this->db->select();
        $this->db->where('bol_estado', ent_boleta::getEstado('procesado'));
        $this->db->where('bol_uni_receptor', $unidad_observada);
        return $this->db->get('tbl_boletasig')->result_object();

    }
    public function getBitacora($idb){
        $this->db->select();
        $this->db->where('bol_id_boleta', $idb);
        $this->db->join('tbl_usuarios u', 'u.usu_id = rel_boletasig_bitacora.usu_usuario_id', 'left');
        return $this->db->get('rel_boletasig_bitacora')->result_object();
    }
    public function cerrar_boleta(){
        $p = $this->input->post();
        // [radTipoPeligro] => 1
        // [selSacp] =>
        // [txtNombreFiscaliza] => asdas
        // [txtIdBoleta] => asdas

        $this->insertar_involucrado(array(
            'bol_id_boleta' => $p['txtIdBoleta'],
            'ibo_tipo_invo' => 4,
            'ibo_nombre' => $p['txtNombreFiscaliza'],
            'ibo_ficha' => '',
            'ibo_dni' => ''

            ));

        $this->db->set('bol_fecha_respondido','now()',false);
        $this->db->set('bol_fecha_cerrado','now()',false);
        if($p['selSacp']){
            $this->db->set('bol_estado',6);
        }
        $this->db->set('bol_estado',6);
        $this->db->where('bol_id',$p['txtIdBoleta']);
        $this->db->update('tbl_boletasig');


    }
    public function rechazar_boleta($id_boleta, $estado = 3, $total = true){
        date_default_timezone_set('America/Lima');
        $this->db->set('bol_estado', $estado);
        // if($total)
            $this->db->set('bol_rechazado', 1);
        $this->db->set('bol_fecha_rechazado', 'now()', false);
        $this->db->where('bol_id',$id_boleta);




        if($this->db->update('tbl_boletasig')){
            $this->load->model('Model_Unidad', 'uni');
            $ojUnidad = $this->uni->getsimpledata(AppSession::get('id_unidad'));
             $valbit = array(
                'bbi_fecha' => date('Y-m-d H:i:s'),
                'bol_id_boleta' => $id_boleta,
                'usu_usuario_id' => AppSession::get('user_id'),
                'bbi_descripcion' => 'Boleta SIG rechazada  en '.$ojUnidad->desDepend,
                'bbi_proceso' => 1,
                'bbi_titulo' => 'Boleta SIG rechazada'
                );
            $this->insertar_bitacora($valbit);
        }
        return $this->db->affected_rows() > 0 ? true : false;
    }
    public function insertar_seguimiento($p){
        $obj = $this->getsimpledata($p['txtidbolseg']);
        if($obj){

            $fechatarget = new DateTime();
            //insertar observacion de seguimiento
            $valuesseg['bos_observacion'] = $p['txtObseSeg'];
            $valuesseg['bol_id_boleta'] = $obj->bol_id;
            $valuesseg['usu_id_usuario'] = AppSession::get('user_id');
            $valuesseg['bos_fecha'] = $fechatarget->format('Y-m-d H:i:s');
            $this->db->insert('rel_boleta_seguimiento', $valuesseg);
            $idseg = $this->db->insert_id();


            $valfilebitseg = array(
                    'bol_id_boleta' => $obj->bol_id,
                    'bbi_fecha' => $fechatarget->format('Y-m-d H:i:s'),
                    'usu_usuario_id' => AppSession::get('user_id'),
                    'bbi_proceso' => 5,
                    'bbi_descripcion' => 'Observación : '.$valuesseg['bos_observacion'],
                    'bbi_titulo' => 'Observación de Seguimiento'
                    );
                // print_rr($valfilebitseg);
                $this->insertar_bitacora($valfilebitseg);
            //mover ficheros temporales
            // $cis = $this->session->ref_session_boleta;
            $cis = md5($obj->bol_id.$obj->bol_correlativo);

            //obtener los ficheros que están en mddo temporal
            $this->db->select(array('abo_id','abo_nombre_fichero','abo_fecha_subida'));
            $this->db->where('abo_user_temp', $cis);
            $this->db->where('abo_tipo', 3);
            $this->db->where('abo_estado', 0);
            $this->db->where('abo_expire > 0');
            $la = $this->db->get('rel_boleta_archivos')->result_object();//lista ficheros temporales boleta
            // print_rr($la);
            // exit;
                    //mover los ficheros temproales
            verificar_carpeta_procesos();
            $prob = DOCSPATH.'__procesoss'.DS.'_boletasig'.DS;
            $probt = $prob.'_temp_seg'.DS;
            if($obj->bol_tipo == 2) $prob .= '_seguridad'.DS;
            else $prob .= '_ambiental'.DS;

            // if(!file_exists($prop))
            //         mkdir($prop,0700);

            if(!file_exists($prob.$obj->bol_correlativo.DS))
                mkdir($prob.$obj->bol_correlativo.DS,0700);
            if(!file_exists($prob.$obj->bol_correlativo.DS.'_evidencia_seg'.DS))
                mkdir($prob.$obj->bol_correlativo.DS.'_evidencia_seg'.DS,0700);


            foreach ($la as $key => $value) {
                //verificar si aún existe en el temp
                if(file_exists($probt.$cis.DS.$value->abo_nombre_fichero)){
                    if(rename($probt.$cis.DS.$value->abo_nombre_fichero,$prob.$obj->bol_correlativo.DS.'_evidencia_seg'.DS.$value->abo_nombre_fichero)){
                        //exito = registrar en bitacora
                        $valfilebit = array(
                            'bol_id_boleta' => $obj->bol_id,
                            'bbi_fecha' => $value->abo_fecha_subida,
                            'usu_usuario_id' => AppSession::get('user_id'),
                            'bbi_proceso' => 4,
                            'bbi_descripcion' => 'Fichero : '.$value->abo_nombre_fichero,
                            'bbi_titulo' => 'Evidencia de Seguimiento'
                            );
                        // print_rr($valfilebit);
                        $this->insertar_bitacora($valfilebit);
                    }

                }else{
                    $this->db->where('abo_id', $value->abo_id);
                    $this->db->delete('rel_boleta_archivos');
                }


                $val_update['bol_id_boleta'] = $obj->bol_id;

                $val_update['abo_user_temp'] = '';
                $val_update['abo_expire'] = 0;
                $val_update['abo_estado'] = 1;
                $val_update['bos_id_seguimiento'] = $idseg;

                $this->db->set($val_update);
                $this->db->where('abo_id', $value->abo_id);
                $this->db->update('rel_boleta_archivos');


            }

            $return['fecha_registro'] = $fechatarget->format('Y-m-d H:i:s');
            $return['datos_usuario'] = $this->simpledatausuario(AppSession::get('user_id'));
            $return['observacion'] = $valuesseg['bos_observacion'];
            $return['ficheros'] = $this->get_ficheros_seguimiento(array(
                'id_boleta' => $obj->bol_id,
                'tipo_boleta' => $obj->bol_tipo,
                'correlativo' => $obj->bol_correlativo,
                'tipo_fichero' => 3,
                'estado' => 1,
                'id_seguimiento' => $idseg
                ));
            return $return;
        }else return false;
    }
    public function simpledatausuario($id){
        $this->db->select(array('usu_nombre','usu_apellidos'));
        $this->db->where('usu_id', $id);
        return $this->db->get('tbl_usuarios')->row();
    }
    public function get_ficheros_seguimiento($values){
        $this->db->select();
        $this->db->where('bol_id_boleta', $values['id_boleta']);
        $this->db->where('abo_tipo', $values['tipo_fichero']);
        $this->db->where('abo_estado', $values['estado']);
        $this->db->where('bos_id_seguimiento', $values['id_seguimiento']);
        $qqq =  $this->db->get('rel_boleta_archivos')->result_object();


        foreach ($qqq as $key => $valuef) {

            $valuef->ico_img = get_ico_file($valuef->abo_nombre_fichero);
            if($values['tipo_boleta'] == 2)
                $valuef->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_seguridad/'.$values['correlativo'].'/_evidencia_seg/'.$valuef->abo_nombre_fichero;
            else $valuef->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_ambiental/'.$values['correlativo'].'/_evidencia_seg/'.$valuef->abo_nombre_fichero;
        }
        return $qqq;

    }
    public function responder_boleta($p){
        // print_rr($this->boleta);exit;
        // print_rr($p);
        // exit;
        $obj = $this->getsimpledata($p['txtId']);
        $amerita = !in_array(9, $p['txtAccPost']);
        if($obj->bol_rechazado == 0){
            //determinar camps nulos antes de agregar
            if(removes_space($p['txtAccionInmediataOtro'])){
                 $id_acciinm = $this->insertar_accion(array(
                    'aci_des' => $p['txtAccionInmediataOtro'],
                    'aci_tipo' => 1,
                    'aci_otro' => 1
                    ));
                if($id_acciinm)
                    $p['txtAccInme'][] = $id_acciinm;
            }

            if($amerita){
                if(removes_space($p['txtAccionPosteriorOtro'])){
                    $id_accipos = $this->insertar_accion(array(
                        'aci_des' => $p['txtAccionPosteriorOtro'],
                        'aci_tipo' => 2,
                        'aci_otro' => 1
                        ));
                    if($id_accipos)
                        $p['txtAccPost'][] = $id_accipos;
                }
            }
        }else{
            //actualiza la acción que fue registrada antes de ser rechazada
            if(isset($p['txtIdResAccInm'])){
                $this->actualizar_accion($p['txtIdResAccInm'], array(
                    'aci_des' => $p['txtAccionInmediataOtro']
                    ));
                $p['txtAccInme'][] = +$p['txtIdResAccInm'];
            }
            if(isset($p['txtIdResAccPost'])){
                $this->actualizar_accion($p['txtIdResAccPost'], array(
                    'aci_des' => $p['txtAccionPosteriorOtro']
                    ));
                $p['txtAccPost'][] = +$p['txtIdResAccPost'];
            }

            //eliminar todas las acciones de la boleta y reemplazarla con las nuevas
            $this->db->where('bol_id_boleta', +$obj->bol_id);
            $this->db->delete('rel_boleta_respuestas');
            //actualizar las id otros
        }

        //insertar todas las acciones inmeditas
        if(isset($p['txtAccInme'])){

            foreach ($p['txtAccInme'] as $key => $value) {
                $this->db->set(array(
                    'bol_id_boleta' => $p['txtId'],
                    'aci_id_accion_inmedita' => $value
                    ));
                $this->db->insert('rel_boleta_respuestas');
            }
        }
        if($amerita){
            //inserta ttodas las accione sposteriores
            if(isset($p['txtAccPost'])){
                foreach ($p['txtAccPost'] as $key => $value) {
                    $this->db->set(array(
                        'bol_id_boleta' => $p['txtId'],
                        'aci_id_accion_posterior' => $value
                        ));
                    $this->db->insert('rel_boleta_respuestas');
                }
            }
        }








        //actualizar mes y año de boleta
        // $this->update_fechames(+$p['txtId'], $p['selMes'], $p['selYear']);
        // exit;

        //ingresar involucrado super

        if($obj->bol_rechazado == 0){
            $this->insertar_involucrado(array(
            'bol_id_boleta' => +$p['txtId'],
            'ibo_tipo_invo' => ent_boleta::getInvolucrado('supervisor'),//supervisor
            'usu_id_usuario' => AppSession::get('user_id')
            ));
        }else{
            $this->db->set(array(
                'usu_id_usuario' => AppSession::get('user_id')
                ));
            $this->db->where('ibo_id', +$p['txtIdInvolucrado']);
            $this->db->update('rel_boleta_involucrados');
        }

        //insertar observaciones
        if($obj->bol_rechazado == 0)
            $this->db->set(array(
                'bol_observacion_respuesta' => $p['txtObservaciones'],
                'bol_estado' => $amerita ? ent_boleta::getEstado('seguimiento') : ent_boleta::getEstado('respondido'),
                ));
        else $this->db->set(array(
                'bol_observacion_respuesta' => $p['txtObservaciones'],
                'bol_estado' => ent_boleta::getEstado('respondido'),
                'bol_rechazado' => 0
                ));

        date_default_timezone_set('America/Lima');
        $fechares = new DateTime();

        $valbolupdate['bol_fecha_respondido'] = $fechares->format('Y-m-d H:i:s');

        if($amerita){
            $valbolupdate['bol_fecha_plazo_ini'] = '';$valbolupdate['bol_fecha_plazo_fin']='';

            if(isset($p['txtfecha_ini']))
                $valbolupdate['bol_fecha_plazo_ini'] = $p['txtfecha_ini'];
            else
                unset($valbolupdate['bol_fecha_plazo_ini']);

            if(isset($p['txtfecha_fin']))
                $valbolupdate['bol_fecha_plazo_fin'] = $p['txtfecha_fin'];
            else
                unset($valbolupdate['bol_fecha_plazo_fin']);
            if(isset($p['conplazo'])) $valbolupdate['bol_plazo_establecido'] = 1;
        }


        $this->db->set($valbolupdate);
        $this->db->where('bol_id',$p['txtId']);
        $this->db->update('tbl_boletasig');

        $valbit = array(
            'bol_id_boleta' => $obj->bol_id,
            'bbi_fecha' => $fechares->format('Y-m-d H:i:s'),
            'usu_usuario_id' => AppSession::get('user_id'),
            'bbi_proceso' => 1,
            'bbi_descripcion' => 'Se respondió a la Boleta SIG',
            'bbi_titulo' => 'Boleta respondida'
            );
        $this->insertar_bitacora($valbit);


        //mover ficheros temporales
        // $cis = $this->session->ref_session_boleta;
        $cis = md5($obj->bol_id.$obj->bol_correlativo);

        //obtener los ficheros que están en mddo temporal
        $this->db->select(array('abo_id','abo_nombre_fichero','abo_fecha_subida'));
        $this->db->where('abo_user_temp', $cis);
        $this->db->where('abo_tipo', 2);
        $this->db->where('abo_estado', 0);
        $this->db->where('abo_expire > 0');
        $la = $this->db->get('rel_boleta_archivos')->result_object();//lista ficheros temporales boleta
        // print_rr($la);
        // exit;

        //mover los ficheros temproales
        verificar_carpeta_procesos();
        $prob = DOCSPATH.'__procesoss'.DS.'_boletasig'.DS;
        $probt = $prob.'_temp_res'.DS;
        if($obj->bol_tipo == 2) $prob .= '_seguridad'.DS;
        else $prob .= '_ambiental'.DS;

        // if(!file_exists($prop))
        //         mkdir($prop,0700);

        if(!file_exists($prob.$obj->bol_correlativo.DS))
            mkdir($prob.$obj->bol_correlativo.DS,0700);
        if(!file_exists($prob.$obj->bol_correlativo.DS.'_evidencia_res'.DS))
            mkdir($prob.$obj->bol_correlativo.DS.'_evidencia_res'.DS,0700);


        foreach ($la as $key => $value) {
            //verificar si aún existe en el temp
            if(file_exists($probt.$cis.DS.$value->abo_nombre_fichero)){
                if(rename($probt.$cis.DS.$value->abo_nombre_fichero,$prob.$obj->bol_correlativo.DS.'_evidencia_res'.DS.$value->abo_nombre_fichero)){
                    //exito = registrar en bitacora
                    $valfilebit = array(
                        'bol_id_boleta' => $obj->bol_id,
                        'bbi_fecha' => $value->abo_fecha_subida,
                        'usu_usuario_id' => AppSession::get('user_id'),
                        'bbi_proceso' => 3,
                        'bbi_descripcion' => 'Fichero : '.$value->abo_nombre_fichero,
                        'bbi_titulo' => 'Evidencia de Respuesta'
                        );
                    // print_rr($valfilebit);
                    $this->insertar_bitacora($valfilebit);
                }

            }else{
                $this->db->where('abo_id', $value->abo_id);
                $this->db->delete('rel_boleta_archivos');
            }


            $val_update['bol_id_boleta'] = $obj->bol_id;

            $val_update['abo_user_temp'] = '';
            $val_update['abo_expire'] = 0;
            $val_update['abo_estado'] = 1;
            $this->db->set($val_update);
            $this->db->where('abo_id', $value->abo_id);
            $this->db->update('rel_boleta_archivos');
        }

        // $this->session->unset_userdata('ref_session_boleta');

        $opcs = array(
            'default' => true,
            'boleta_correlativo' => $obj->bol_correlativo,
            'unidad_remite' => AppSession::get('id_unidad')
            );
        //notificar generador de boleta
        enviar_notificacion_sistema_custom_dos($obj->bol_uni_remitente, AppSession::get('id_unidad') ,5,$opcs);
        //notificar area responsable de boleta Seg o Deso
        enviar_notificacion_sistema_custom_dos(ent_boleta::getResponsable($obj->bol_tipo), AppSession::get('id_unidad'),5, $opcs);


    }
    public function insertar_accion($values){
        $this->db->set($values);
        $this->db->insert('tbl_acciones_boleta');
        return $this->db->insert_id();
    }
    public function actualizar_accion($id, $values){
        $this->db->set($values);
        $this->db->where('aci_id', $id);
        return $this->db->update('tbl_acciones_boleta');

    }
    public function listar_acciones($tipo){
        $this->db->select();
        $this->db->where('aci_tipo', $tipo);
        $this->db->where('aci_otro', 0);
        $q = $this->db->get('tbl_acciones_boleta')->result_object();
        return $q;
    }
    public function procesar_boleta($id_boleta){
        date_default_timezone_set('America/Lima');
        $this->db->set(array(
            'bol_estado' => 3
            ));
        $fecha_proce = new DateTime();
        $fecha_bita = new DateTime($fecha_proce->format('Y-m-d H:i:s'));
        $this->db->set('bol_fecha_procesado', $fecha_proce->format('Y-m-d H:i:s'));
        $this->db->set('bol_expire', $fecha_proce->add(ent_boleta::getTiempoRespuesta('interval'))->format('Y-m-d H:i:s'));
        $this->db->where('bol_id', $id_boleta);
        if($this->db->update('tbl_boletasig')){
             $this->load->model('Model_Unidad', 'uni');
            $ojUnidad = $this->uni->getsimpledata(AppSession::get('id_unidad'));
            $valbit = array(
                'bbi_fecha' => $fecha_bita->format('Y-m-d H:i:s'),
                'bol_id_boleta' => $id_boleta,
                'usu_usuario_id' => AppSession::get('user_id'),
                'bbi_descripcion' => 'Boleta SIG procesada en  '.$ojUnidad->desDepend,
                'bbi_proceso' => 1,
                'bbi_titulo' => 'Boleta SIG procesada'
                );
            $this->insertar_bitacora($valbit);
            return true;
        }
        // if($this->db->affected_rows() >= 1){

        // }
        return false;
    }
    public function insertar_fichero($values){
        $this->db->set($values);
        $fecha = new DateTime();
        $this->db->set('abo_fecha_subida', $fecha->format('Y-m-d H:i:s'));
        $this->db->insert('rel_boleta_archivos');
        return $this->db->insert_id();
    }
    public function update_fechames($id, $m, $y){
        $this->db->set(array(
            'bol_mes' => $m,
            'bol_year' => $y
            ));
        $this->db->where('bol_id', $id);
        $this->db->update('tbl_boletasig');
    }
    public function aprobar_boleta(&$values){
        // exit;
        date_default_timezone_set('America/Lima');
        $values->bol_fecha_aprobado = date('Y-m-d H:i:s');
        $valuesf = $this->db->fields_filter($values, 'tbl_boletasig', true);
        // print_rr($values);
        // exit;
        $this->db->set($valuesf);

        // $this->db->set('bol_fecha_aprobado','now()',false);
        $this->db->where('bol_id', $values->bol_id);
        $this->db->where('bol_estado', 1);
        $this->db->update('tbl_boletasig');

        $this->load->model('Model_Unidad','uni');
        $objB = $this->getsimpledata($values->bol_id);
        $ojUnidad = $this->uni->getsimpledata($objB->bol_uni_receptor);
        // print_rr($ojUnidad);
        $valbit = array(
            'bbi_fecha' => $values->bol_fecha_aprobado,
            'bol_id_boleta' => $values->bol_id,
            'usu_usuario_id' => AppSession::get('user_id'),
            'bbi_descripcion' => 'Boleta SIG para '.$ojUnidad->desDepend.' ha sido aprobada',
            'bbi_proceso' => 1,
            'bbi_titulo' => 'Boleta SIG aprobada'
            );
        $this->insertar_bitacora($valbit);

        $this->insertar_involucrado(array(
            'bol_id_boleta' => $values->bol_id,
            'ibo_tipo_invo' => ent_boleta::getInvolucrado('aprobador'),
            'usu_id_usuario' => AppSession::get('user_id')
            ));
            //fin insertat invlucrado
        $values = $objB;
        return true;

    }
    public function insertar_involucrado($values){
        $this->db->set($values);
        return $this->db->insert('rel_boleta_involucrados');
    }
    public function insertar_respuesta(){

    }
    public function getdatafilesimple($id_fichero){
        $this->db->select();
        $this->db->where('abo_id', $id_fichero);
        $this->db->join('tbl_boletasig bs', 'bs.bol_id = rel_boleta_archivos.bol_id_boleta');
        return $this->db->get('rel_boleta_archivos')->row();
    }
    public function eliminar_file_temp($id_file){
        echo $id_file;
        $this->db->where('abo_id', $id_file);
        $this->db->delete('rel_boleta_archivos');
        return $this->db->affected_rows() == 0 ? false : true;
    }
    public function eliminar_file_alojado($id_file){
        //eliminar includo de la carpeta en la que está alojado el fichero
        $objF = $this->getdatafilesimple($id_file);
        // print_rr($objF);exit;
        $tipo_bol = '';
        if(+$objF->bol_tipo == 2) $tipo_bol = '_seguridad';
        else $tipo_bol = '_ambiental';
        $tipo_abo = '';
        if($objF->abo_tipo == 1) $tipo_abo = '_evidencia';
        else $tipo_abo = '_evidencia_res';


        $ruta = DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.$tipo_bol.DS.$objF->bol_correlativo.DS.$tipo_abo.DS.$objF->abo_nombre_fichero;
        if(is_file($ruta))
            unlink($ruta);

        $this->db->where('abo_id', $id_file);
        $this->db->delete('rel_boleta_archivos');
        return $this->db->affected_rows() == 0 ? false : true;
    }
    public function eliminar_file_expire($temp){

        //elimina ficheros de las carpetas temproales
        // $this->db->where('abo_id', $id_file);
        $this->db->select('abo_user_temp');
        $this->db->where('abo_expire < '.time());
        $this->db->where('abo_expire > 0');
        $this->db->group_by('abo_user_temp');
        $l = $this->db->get('rel_boleta_archivos')->result_object();
        foreach ($l as $key => $value) {
            switch ($temp) {
                case '_temp':
                    delete_folder(DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp'.DS.$value->abo_user_temp.DS);
                    break;
                case '_temp_res':
                    delete_folder(DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp_res'.DS.$value->abo_user_temp.DS);
                    break;
                case '_temp_seg':
                    delete_folder(DOCSPATH.'__procesoss'.DS.'_boletasig'.DS.'_temp_seg'.DS.$value->abo_user_temp.DS);
                    break;
            }
        }



        $this->db->where('abo_expire < '.time());
        $this->db->where('abo_expire > 0');
        $this->db->delete('rel_boleta_archivos');
        return $this->db->affected_rows() == 0 ? false : true;
    }
    public function insertar_bitacora($values){
        $this->db->set($values);
        return $this->db->insert('rel_boletasig_bitacora');
    }
    public function insertar($obj){
        date_default_timezone_set('America/Lima');
        $obj->bol_fecha_generado = date('Y-m-d H:i:s');
        // print_rr($obj);
        // exit;
        $values = $this->db->fields_filter($obj, 'tbl_boletasig', true);
        $this->db->set($values);
        if($this->db->insert('tbl_boletasig')){
            $idb = $this->db->insert_id();
            $obj->bol_id = $idb;
            //insertar el dato del primer involucrado (elaborador)
            $this->db->set(array(
                'bol_id_boleta' => $idb,
                'ibo_tipo_invo' => 1,
                'usu_id_usuario' => AppSession::get('user_id')
                ));
            $this->db->insert('rel_boleta_involucrados');

            // $this->db->set(array(
            //     'bbi_fecha' => $obj->bol_fecha_generado,
            //     'bol_id_boleta' => $idb,
            //     'usu_usuario_id' => AppSession::get('user_id'),
            //     'bbi_descripcion' => 'asdasd'

            //     ));
            $this->load->model('Model_Unidad','uni');
            $ojUnidad = $this->uni->getsimpledata($obj->bol_uni_receptor);

            $valbit = array(
                'bbi_fecha' => $obj->bol_fecha_generado,
                'bol_id_boleta' => $idb,
                'usu_usuario_id' => AppSession::get('user_id'),
                'bbi_descripcion' => 'Boleta SIG para '.$ojUnidad->desDepend,
                'bbi_proceso' => 1,
                'bbi_titulo' => 'Boleta SIG elaborada'
                );
            $this->insertar_bitacora($valbit);


            //mover los ficheros en estado temporal a la carpeta correspondiente al correlativo
            //optener fohceros
            $cis = $this->session->ref_session_boleta;

            $this->db->select();
            $this->db->where('abo_user_temp', $cis);
            $this->db->where('abo_tipo', 1);//evidencia_obs
            $this->db->where('abo_expire > 0');
            $la = $this->db->get('rel_boleta_archivos')->result_object();//lista ficheros temporales boleta
            // print_rr($la);
            // exit;

            //mover los ficheros temproales
            verificar_carpeta_procesos();
            $prob = DOCSPATH.'__procesoss'.DS.'_boletasig'.DS;
            $probt = $prob.'_temp'.DS;
            if($obj->bol_tipo == 2) $prob .= '_seguridad'.DS;
            else $prob .= '_ambiental'.DS;

            // if(!file_exists($prop))
            //         mkdir($prop,0700);

            mkdir($prob.$obj->bol_correlativo.DS,0700);
            mkdir($prob.$obj->bol_correlativo.DS.'_evidencia'.DS,0700);


            foreach ($la as $key => $value) {
                if(file_exists($probt.$cis.DS.$value->abo_nombre_fichero)){
                    if(rename($probt.$cis.DS.$value->abo_nombre_fichero, $prob.$obj->bol_correlativo.DS.'_evidencia'.DS.$value->abo_nombre_fichero)){
                          $valfilebit = array(
                            'bol_id_boleta' => $obj->bol_id,
                            'bbi_fecha' => $value->abo_fecha_subida,
                            'usu_usuario_id' => AppSession::get('user_id'),
                            'bbi_proceso' => 2,
                            'bbi_descripcion' => 'Fichero : '.$value->abo_nombre_fichero,
                            'bbi_titulo' => 'Evidencia de Elaboración'
                            );

                        $this->insertar_bitacora($valfilebit);
                    }
                }else{
                    $this->db->where('abo_id', $value->abo_id);
                    $this->db->delete('rel_boleta_archivos');
                }


                $val_update['bol_id_boleta'] = $idb;
                $val_update['abo_estado'] = 1;
                $val_update['abo_user_temp'] = '';
                $val_update['abo_expire'] = 0;
                $this->db->set($val_update);
                $this->db->where('abo_id', $value->abo_id);
                $this->db->update('rel_boleta_archivos');
            }
        }

        $this->session->unset_userdata('ref_session_boleta');
        return $idb;
        return $this->db->affected_rows() == 1 ? true : false;
    }
    public function listar_respuestas($id_boleta, $tipo){

        $this->db->select();
        $this->db->where('bol_id_boleta', $id_boleta);
        if($tipo == 'inm'){
            $this->db->join('tbl_acciones_boleta ab', 'ab.aci_id = rel_boleta_respuestas.aci_id_accion_inmedita', 'left');
            $this->db->where('(aci_id_accion_posterior = 0 or isnull(aci_id_accion_posterior))');
        }
        if($tipo == 'post'){
            $this->db->join('tbl_acciones_boleta abp', 'abp.aci_id = rel_boleta_respuestas.aci_id_accion_posterior', 'left');
            $this->db->where('(aci_id_accion_inmedita=0 or isnull(aci_id_accion_inmedita))');
        }

        return  $this->db->get('rel_boleta_respuestas')->result_object();
        // echo $this->db->last_query();
        // return $q;
    }
    public function getsimpledata($id_boleta){
        $this->db->select();
        $this->db->where('bol_id', $id_boleta);
        return $this->db->get('tbl_boletasig')->row();
    }
    public function existe_id($id){
        $this->db->select('bol_id');
        $this->db->where('bol_id', $id);
        return $this->db->get('tbl_boletasig')->row() ? true : false;
    }
    public function getdata($id_boleta){
        $this->db->select('tbl_boletasig.*');
        $this->db->select('da.desDepend as nom_area');
        $this->db->select('du.desDepend as nom_unidad');
        $this->db->select('dra.desDepend as nom_area_receptor');
        $this->db->select('dru.desDepend as nom_unidad_receptor');

        $this->db->join('dependencia du', 'du.idDepend = tbl_boletasig.bol_uni_remitente', 'left');
        $this->db->join('dependencia da', 'da.idDepend = du.reportaDpend', 'left');
        $this->db->join('dependencia dru', 'dru.idDepend = tbl_boletasig.bol_uni_receptor', 'left');
        $this->db->join('dependencia dra', 'dra.idDepend = du.reportaDpend', 'left');

        $this->db->where('bol_id', $id_boleta);
        $q = $this->db->get('tbl_boletasig')->row();

        if($q){

            //Listar los involucrados
            $this->db->select();
            $this->db->where('bol_id_boleta', $q->bol_id);
            $this->db->join('tbl_usuarios u', 'u.usu_id = rel_boleta_involucrados.usu_id_usuario', 'left');
            $qq = $this->db->get('rel_boleta_involucrados')->result_object();
            foreach ($qq as $key => $value) {
                switch (+$value->ibo_tipo_invo) {
                    case 1://Elaborador
                        $q->involucrados['elaborador'] = $qq[$key];
                        break;
                    case 2://aprobador
                        $q->involucrados['aprobador'] = $qq[$key];
                        break;
                    case 3://supervisor
                        $q->involucrados['supervisor'] = $qq[$key];
                        break;
                    case 4://fizcalizador
                        $q->involucrados['fizcalizador'] = $qq[$key];
                        break;
                }
            }
            //fin_lista involucrados
            //
            //listar respuestas
            $q->respuestas['posteriores'] = $this->listar_respuestas($id_boleta,'post');
            $q->respuestas['inmediatas'] = $this->listar_respuestas($id_boleta,'inm');
            //fin respuestas
            //
            //Listar_ficheros tipo 1
            $this->db->select();
            $this->db->where('bol_id_boleta', $q->bol_id);
            $this->db->where('abo_tipo', 1);// 1 de evidencias
            $this->db->where('abo_expire', 0);
            $this->db->where('abo_estado', 1);
            $qqq = $this->db->get('rel_boleta_archivos')->result_object();

            foreach ($qqq as $key => $value) {

                $value->ico_img = get_ico_file($value->abo_nombre_fichero);
                if($q->bol_tipo == 2)
                    $value->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_seguridad/'.$q->bol_correlativo.'/_evidencia/'.$value->abo_nombre_fichero;
                else $value->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_ambiental/'.$q->bol_correlativo.'/_evidencia/'.$value->abo_nombre_fichero;
            }

            $q->ficheros_evidencia = $qqq;

            //fin_lista_ficheros tipo 2//
            //Listar_ficheros
            $this->db->select();
            $this->db->where('bol_id_boleta', $q->bol_id);
            $this->db->where('abo_tipo', 2);// 2 de evidencias
            $this->db->where('abo_estado', 1);
            $this->db->where('abo_expire', 0);
            $qqq = $this->db->get('rel_boleta_archivos')->result_object();

            foreach ($qqq as $key => $value) {

                $value->ico_img = get_ico_file($value->abo_nombre_fichero);
                if($q->bol_tipo == 2)
                    $value->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_seguridad/'.$q->bol_correlativo.'/_evidencia_res/'.$value->abo_nombre_fichero;
                else $value->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_ambiental/'.$q->bol_correlativo.'/_evidencia_res/'.$value->abo_nombre_fichero;
            }
            //seguimiento en caso exista
            $this->db->select();
            $this->db->where('bol_id_boleta', $q->bol_id);
            $this->db->join('tbl_usuarios u', 'u.usu_id = rel_boleta_seguimiento.usu_id_usuario');
            $lstseg = $this->db->get('rel_boleta_seguimiento')->result_object();
            $fechasseg = array();
            if($lstseg){

                usort($lstseg, function($a,$b){
                    $aa = strtotime($a->bos_fecha);
                    $bb = strtotime($b->bos_fecha);

                    if ($aa == $bb) {
                        return 0;
                    }
                    return ($aa > $bb) ? -1 : 1;
                });
                foreach ($lstseg as $key => $value) {
                    $fechasseg[] = date('d/m/Y', strtotime($value->bos_fecha));
                    $value->bos_fecha_format = date('d/m/Y', strtotime($value->bos_fecha));
                    $this->db->select();
                    $this->db->where('bol_id_boleta', $q->bol_id);
                    $this->db->where('abo_tipo', 3);// 2 de seguimiento
                    $this->db->where('abo_estado', 1);
                    $this->db->where('abo_expire', 0);
                    $this->db->where('bos_id_seguimiento', $value->bos_id);
                    $qqq = $this->db->get('rel_boleta_archivos')->result_object();


                    foreach ($qqq as $key => $valuef) {

                        $valuef->ico_img = get_ico_file($valuef->abo_nombre_fichero);
                        if($q->bol_tipo == 2)
                            $valuef->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_seguridad/'.$q->bol_correlativo.'/_evidencia_seg/'.$valuef->abo_nombre_fichero;
                        else $valuef->ruta_archivo = NAMEDOC.'/__procesoss/_boletasig/_ambiental/'.$q->bol_correlativo.'/_evidencia_seg/'.$valuef->abo_nombre_fichero;
                    }
                    $value->ficheros = $qqq;
                }
            }
            //fin_lista_ficheros tipo 3//
            //Listar_ficheros

            $q->fechas_seguimiento = array_unique($fechasseg);
            $q->seguimiento = $lstseg;
        }


        //fin_lista_ficheros

        return $q;

    }

}