<?php
   function is_ajax($redi = true){

        // var_dump($_SERVER);
        if (!(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest')) {

            if($redi)
                redirect();
            else return false;
        }

        return true;
    }

    function print_rr($value){
        echo '<pre>';
        print_r($value);
        echo '</pre>';
    }
    function br(){
        echo '</br>';
    }
    function echo_json($array){
        header('Content-Type: application/json');
        echo json_encode($array);
    }
    function array_to_name_value($array){
        $f = array();
        foreach ($array as $key => $value) {
            if($value != 8){
                $f[] = array(
                    'name' => $key,
                    'value' => $value
                );
            }

        }
        return $f;
    }
    function get_ico_files($nameDoc){
        // echo $nameDoc;
        $arrayExplode = explode(".",$nameDoc);
        $extendDoc = end($arrayExplode);
        $ico = '';
        if($extendDoc){
            switch ($extendDoc) {
                case 'jpg': $ico='image.png'; break;
                case 'jpeg': $ico='image.png'; break;
                case 'gif': $ico='image.png'; break;
                case 'png': $ico='image.png'; break;
                case 'pdf':  $ico='pdf.png'; break;
                case 'doc':  $ico='word.png'; break;
                case 'docx':  $ico='word.png'; break;
                case 'ppt':  $ico='powerpoint.png';break;
                case 'pptx':  $ico='powerpoint.png'; break;
                case 'xls': $ico='excel.png'; break;
                case 'xlsx': $ico='excel.png'; break;
                default: $ico = 'text.png'; break;
            }
        }


        return $ico;
    }
    function get_list_ico_files(){
        return array(
            array('jpg', 'image.png', 'Imagen'),
            array('jpeg', 'image.png', 'Imagen'),
            array('gif', 'image.png', 'Imagen'),
            array('png', 'image.png', 'Imagen'),
            array('pdf', 'pdf.png', 'PDF'),
            array('doc', 'word.png', 'Word'),
            array('docx', 'word.png', 'Word'),
            array('ppt', 'powerpoint.png', 'Power Point'),
            array('pptx', 'powerpoint.png', 'Power Point'),
            array('xls', 'excel.png', 'Excel'),
            array('xlsx', 'excel.png', 'Excel')
            );
    }
    function get_ico_file($nameDoc){
        $arrayExplode = explode(".",$nameDoc);
        $extendDoc = end($arrayExplode);
        foreach (get_list_ico_files() as $key => $value) {
            if($value[0] == $extendDoc)
                return $value;
        }
        return array('rare','rare.png','Rare');
    }
    function get_ico_name_files($nameDoc){
        // echo $nameDoc;
        $arrayExplode = explode(".",$nameDoc);
        $extendDoc = end($arrayExplode);
        $ico = '';
        if($extendDoc){
            switch ($extendDoc) {
                case 'jpg': $ico='Imagen'; break;
                case 'jpeg': $ico='Imagen'; break;
                case 'gif': $ico='Imagen'; break;
                case 'png': $ico='Imagen'; break;
                case 'pdf':  $ico='PDF'; break;
                case 'doc':  $ico='Word'; break;
                case 'docx':  $ico='Word'; break;
                case 'ppt':  $ico='Power Point';break;
                case 'pptx':  $ico='Power Point'; break;
                case 'xls': $ico='Excel'; break;
                case 'xlsx': $ico='Excel'; break;
                default: $ico = 'Otro Fichero'; break;
            }
        }


        return $ico;
    }
    function get_ico_doc($nameDoc){
        // echo $nameDoc;
        $arrayExplode = explode(".",$nameDoc);
        $extendDoc = end($arrayExplode);
        $ico = '';
        if($extendDoc){
            // switch ($extendDoc) {
            //     case 'jpg': $ico='img/jpg-icono-4736-32.png'; break;
            //     case 'jpeg': $ico='img/jpg-icono-4736-32.png'; break;
            //     case 'gif': $ico='img/jpg-icono-4736-32.png'; break;
            //     case 'png': $ico='img/jpg-icono-4736-32.png'; break;
            //     case 'pdf':  $ico='img/archivo-pdf-icono-3871-32.png'; break;
            //     case 'doc':  $ico='img/microsoft-office-word-2003-icono-8261-32.png'; break;
            //     case 'docx':  $ico='img/microsoft-office-word-2003-icono-8261-32.png'; break;
            //     case 'ppt':  $ico='img/microsoft-office-powerpoint-2003-icono-4740-32.png';break;
            //     case 'pptx':  $ico='img/microsoft-office-powerpoint-2003-icono-4740-32.png'; break;
            //     case 'xls': $ico='img/microsoft-office-powerpoint-2003-icono-3696-32.png'; break;
            //     case 'xlsx': $ico='img/microsoft-office-powerpoint-2003-icono-3696-32.png'; break;
            // }
            switch ($extendDoc) {
                case 'jpg': $ico='fa-file-image-o'; break;
                case 'jpeg': $ico='fa-file-image-o'; break;
                case 'gif': $ico='fa-file-image-o'; break;
                case 'png': $ico='fa-file-image-o'; break;
                case 'pdf':  $ico='fa-file-pdf-o'; break;
                case 'doc':  $ico='fa-file-word-o'; break;
                case 'docx':  $ico='fa-file-word-o'; break;
                case 'ppt':  $ico='fa-file-powerpoint-o';break;
                case 'pptx':  $ico='fa-file-powerpoint-o'; break;
                case 'xls': $ico='fa-file-excel-o'; break;
                case 'xlsx': $ico='fa-file-excel-o'; break;
                default: $ico = 'fa-file-o'; break;
            }
        }


        return $ico;
    }

    function object_to_array($obj){
        $r = array();

    }

    //Funciones para errores
    function fnErrorCarpetaUtilziada($errno, $errstr, $errfile, $errline)
    {
        /* Según el típo de error, lo procesamos */
        switch ($errno) {
            case E_WARNING:
                    echo 'La carpeta está siendo utilizada';
                    /* No ejecutar el gestor de errores interno de PHP, hacemos que lo pueda procesar un try catch */

                    break;
            case E_NOTICE:
                echo "Hay un NOTICE:<br />\n";
                /* No ejecutar el gestor de errores interno de PHP, hacemos que lo pueda procesar un try catch */
                return true;
                break;

                default:
                    /* Ejecuta el gestor de errores interno de PHP */
                    // return false;
                    break;
                }
        return true;
    }
    function enviar_notificacion_sistema($receptora , $emisora,  $tipo )
    {
        /*
          $receptora    = id de unidad receptora
          $emisora      = id de unidad emisora
          $tipo         = id del tipo de notificacion, ya establecido en la BD
         */

        $ci =& get_instance();
        $ci->load->model('Model_Notificaciones');


        //obtiene los datos de la notificacion establecidos por defecto
        $tipo_notificacion = $ci->Model_Notificaciones->conseguir_notificacion($tipo);
        // print_rr($tipo_notificacion);
        foreach ($tipo_notificacion as $item) {
            $asunto = $item['not_asunto'];
            $mensaje = $item['not_mensaje'];
        }


         //guardo la nueva notificacion
         $res = $ci->Model_Notificaciones->agregar_notificacion($receptora, $emisora ,$asunto,$mensaje);

         if ($res)  {
            return true;
         } else {
            return false;
         }

    }
    function enviar_notificacion_sistema_custom($receptora , $emisora,  $tipo, $opciones )
    {
        /*
          $receptora    = id de unidad receptora
          $emisora      = id de unidad emisora
          $tipo         = id del tipo de notificacion, ya establecido en la BD
         */

        $ci =& get_instance();
        $ci->load->model('Model_Notificaciones');

        if(isset($opciones['default']) && $opciones['default']){
        //         obtiene los datos de la notificacion establecidos por defecto
            $tipo_notificacion = $ci->Model_Notificaciones->conseguir_notificacion($tipo);
            // print_rr($tipo_notificacion);
            // foreach ($tipo_notificacion as $item) {
            //     $asunto = $item['not_asunto'];
            //     $mensaje = $item['not_mensaje'];
            // }
            $nn = $tipo_notificacion[0];
        }else{
            $nn = ent_notificaciones::boletasig($tipo, $opciones);
        }
         //guardo la nueva notificacion
         $res = $ci->Model_Notificaciones->agregar_notificacion($receptora, $emisora ,$nn['not_asunto'],$nn['not_mensaje'],null,$opciones['ref_url']);

         if ($res)  {
            return true;
         } else {
            return false;
         }

    }
    function enviar_notificacion_sistema_custom_dos($receptora , $emisora,  $tipo, $opciones )
    {
        /*
          $receptora    = id de unidad receptora
          $emisora      = id de unidad emisora
          $tipo         = id del tipo de notificacion, ya establecido en la BD
         */

        $ci =& get_instance();
        $ci->load->model('Model_Notificaciones');

        if(isset($opciones['default']) && $opciones['default']){
        //         obtiene los datos de la notificacion establecidos por defecto
            $tipo_notificacion = $ci->Model_Notificaciones->conseguir_notificacion($tipo);
            // print_rr($tipo_notificacion);
            // foreach ($tipo_notificacion as $item) {
            //     $asunto = $item['not_asunto'];
            //     $mensaje = $item['not_mensaje'];
            // }
            $nn = $tipo_notificacion[0];
        }else{
            if(isset($opciones['tipo'])){
                //seleccionar uno de ls processos
                switch ($opciones['tipo']) {
                    case 'boleta':
                        $nn = ent_notificaciones::boletasig($tipo, $opciones);
                        break;

                    default:
                        $nn = ent_notificaciones::boletasig($tipo, $opciones);
                        break;
                }
            }else
                $nn = ent_notificaciones::boletasig($tipo, $opciones);
        }
        //reemplazar datos is es que existe uno de ellos
        $variables = ent_notificaciones::getVariables();

        $var_send = array_fill_keys($variables, '');
        // foreach ($variables as $key => $value) {
        //     $var_send[$value] = '';
        // }

        $temp_opc = $opciones;
        foreach ($temp_opc as $key => $value) {
            if(!in_array($key, $variables)){
                unset($temp_opc[$key]);
                //$temp_opc[$key] = 'no_definido';
            }else{
                if(is_null($value))
                    $temp_opc[$key] = '';
                // if($c)
                //  unset($array[$key]);
            }



        }
        $temp_opc = $temp_opc + $var_send;
        $seg_opc = array_keys($temp_opc);
        foreach ($seg_opc as $key => $value) {
            $seg_opc[$key] = '{{'.$value.'}}';
        }
        // print_rr($seg_opc);
        $nn['not_mensaje'] = str_replace($seg_opc,array_values($temp_opc), $nn['not_mensaje']);


         //guardo la nueva notificacion
         $res = $ci->Model_Notificaciones->agregar_notificacion($receptora, $emisora ,$nn['not_asunto'],$nn['not_mensaje'],null,isset($opciones['ref_url']) ? $opciones['ref_url'] : '');

         if ($res)  {
            return true;
         } else {
            return false;
         }

    }

    function enviar_observacion_reutilizable($id_unidad_receptora = null, $opciones = false)
    {
        $datos = array(
            'titulo_header' => 'Enviar Observación'
            );

        //$id_unidad_receptora = 1 ;
        $ci =& get_instance();

        //si se envia  el parametro, entonces se le enviarÃ¡  los datos de la unidad a la vista
        //caso contrario el usuario tendrÃ¡ que seleccionar manualmente la unidad
        if($id_unidad_receptora != null) {

                $ci->load->model('Model_Notificaciones');
                $ci->load->model('Model_Unidad','unidad');
                $ojUni = $ci->unidad->get_departamento($id_unidad_receptora);
             //$fila = $ci->Model_Notificaciones->conseguir_unidad($id_unidad_receptora);
             $datos['fila'] = $ojUni;
             if($opciones){
                $datos['asunto'] = $opciones['asunto'];
             }

        } else {
             $datos['fila'] = '';
        }

        //imprimir los departamentos
        //$ci->load->model('Model_Reutilizables');
        //$datos['lstDepartamentos'] = $ci->Model_Reutilizables->listar_departamentos();

         $ci->load->model('Model_Departamento','departamento');
         $datos['lstDepartamento'] = $ci->departamento->listar();



        $ci->session->set_userdata('verifica_obervacion_enviada', 0);

        $datos['ar_pages'] = array('<a href="enviar_observacion_formulario">Enviar Observación</a>');
        $ci->smartys->assign($datos);

        $ci->smartys->render('notificaciones/enviar_observacion');
    }

    function delete_folder($ruta_carpeta){
        foreach(glob($ruta_carpeta . DS."*") as $archivos_carpeta)
        {
            // echo $archivos_carpeta;
            if (is_dir($archivos_carpeta))
                delete_folder($archivos_carpeta);
            else
                unlink($archivos_carpeta);
        }
        if(file_exists($ruta_carpeta))
            return rmdir($ruta_carpeta);
    }
    function verificar_carpeta_procesos(){

        $f = DOCSPATH.'__procesoss'.DS;
        // rmdir($f);
        // exit;
        // mkdir(DOCSPATH.'jaen'.DS,0700);
        if(!file_exists($f))
            mkdir($f,0700);

        //boletasig
        $b = $f.'_boletasig'.DS;
        if(!file_exists($b))
            mkdir($b,0700);
        $s = $b.'_seguridad'.DS;
        if(!file_exists($s))
            mkdir($s,0700);

        $a = $b.'_ambiental'.DS;
        if(!file_exists($a))
            mkdir($a,0700);

        $t = $b.'_temp'.DS;
        if(!file_exists($t))
            mkdir($t,0700);
        $t = $b.'_temp_res'.DS;
        if(!file_exists($t))
            mkdir($t,0700);
        $t = $b.'_temp_seg'.DS;
        if(!file_exists($t))
            mkdir($t,0700);

        //resiudos
        $res = $f.'_residuos'.DS;
        if(!file_exists($res))
            mkdir($res,0700);


        $aut = $res.'_autorizaciones'.DS;
        if(!file_exists($aut))
            mkdir($aut,0700);
        $repg = $res.'_repgenres'.DS;
        if(!file_exists($repg))
            mkdir($repg,0700);






    }
    function create_rute_folder_docs(){

    }
    function FechaLegible($fecha) {

        if ($fecha == null)
            return 'Sin Asignar';

         $mi_fecha = new DateTime("$fecha");
         $dia_semana =  $mi_fecha->format('w');
         $dia_fecha =  $mi_fecha->format('d');
         $mes_numero =  $mi_fecha->format('n');
         $anyo = $mi_fecha->format('Y');
         $horas_minutos = $mi_fecha->format('H:i');

        // echo "hoy es Mie $dia del $mes del $año $horas_minutos";

        $dias = array("Dom","Lun","Mar","Mie","Jue","Vie","Sáb");
        $meses = array("Ener","Febr","Marz","Abri","Mayo","Juni","Juli","Ago","Sept","Octu","Novi","Dici");

        $fecha_legible = $dias[$dia_semana]." ".$dia_fecha." ".$meses[($mes_numero-1)]. " $anyo - $horas_minutos" ;
        return $fecha_legible;

    }

    /**
     * [removes_space Eliminar espacios en blanco ]
     * @param  [type] $text [description]
     * @return [bool]       [description]
     */
    function removes_space($text){
        $t = preg_replace('/\s/', '', $text);
        if($t) return $t;
        return false;
    }
    function error_app($title, $message){
        $ci =& get_instance();
        $datos['part_title'] = $datos['titulo_header'] = $title;
        $datos['message'] = $message;
        $ci->smartys->assign($datos);
        $ci->smartys->render('errors/app/custom');
    }


 ?>