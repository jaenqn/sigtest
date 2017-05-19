<?php
    class AppSession{
        function __construct(){
            $this->initVisita();
            //$this->verificarNotificaciones();
            date_default_timezone_set('America/Lima');
        }
        public function verificarNotificaciones(){
                $CI =& get_instance();
                $CI->load->model('Model_Boleta', 'bol');
                $unidad = self::get('id_unidad');
                // echo $unidad;
                $lstBoletas = $CI->bol->por_responder($unidad);
                // print_rr($lstBoletas);
                foreach ($lstBoletas as $key => $value) {
                    $f = new DateTime($value->bol_fecha_procesado);
                    $now = new DateTime();
                    $dif = $now->getTimestamp() - $f->getTimestamp();
                    // echo $dif;
                    if(+$dif >= ent_boleta::getTiempoRespuesta()){
                        $min = floor($dif/60);
                        if((+$min%(2)) == 0){
                            $opciones = array(
                                'default' => true,
                                'boleta_correlativo' => $value->bol_correlativo,
                                'ref_url' => 'boletasig/respuesta/'.$value->bol_id
                                );
                            // enviar_notificacion_sistema_custom_dos($unidad, $unidad, 8, $opciones);

                        }
                    }


                }
        }
        public function initVisita(){
            // echo get_cookie('ci_session');
             // print_rr($_SERVER);
            // echo 'es una visita';
            $CI =& get_instance();
            if(!$CI->input->is_ajax_request()){

                $CI->load->model('Model_Usuarios','usuario');
                // print_rr($_SERVER);
                $url = $_SERVER['REQUEST_URI'];
                $temp = explode('/',$url);
                $path = parse_url(base_url());
                $first = 0;
                if(!isset($_SERVER['PATH_INFO'])) $first = 1;
                if(procesos_sig::not_url($url, array('set_online','comprar_notificaciones_custom','listar_online'))){
                    $CI->usuario->insertar_visita(array(
                    'vis_url' => $url,
                    'id_usuario' => self::get('user_id') == false ? 0: self::get('user_id'),
                    'ci_session' => get_cookie('ci_session') ? get_cookie('ci_session') : 'none',
                    'is_first' => $first
                    // 'vis_date' => 'now()'
                    ));
                }
                // if($path['path'] == $_SERVER['PATH_INFO'])
                //     $first = 1;
                // if(procesos_sig::not_url($url, array('set_online'))){
                //     $vaL_visita = array(
                //         'vis_url' => $url,
                //         'ci_session' => get_cookie('ci_session'),
                //         'is_first' => 1
                //         );
                //     $this->insertar_visita($vaL_visita);

                // }

            }

            // echo $url;
            // exit;


        }
        public static function destroy($clave = false){
            if($clave){
                if(is_array($clave)){
                    for ($i=0; $i < count($clave) ; $i++) {
                        if(isset($_SESSION[$clave[$i]])){
                            unset($_SESSION[$clave[$i]]);
                        }
                    }
                }else{
                    if(isset($_SESSION[$clave])){
                            unset($_SESSION[$clave]);
                        }
                }
            }else{
                foreach ($_SESSION as $key => $value) {
                    unset($_SESSION[$key]);
                }
                session_destroy();
            }
        }
        public static function usuario_logueado($redirect = false){
             if(!AppSession::get('usuario_logueado')){
                return false;
             }
             return true;

        }
        public static function logueado($redirect = true){
            if(!AppSession::get('usuario_logueado')){
                if($_SERVER['REQUEST_URI'] != '/'){
                        $_SESSION['prev_url'] = $_SERVER['REQUEST_URI'];
                        //considerar que no capture ciertas urls

                        // $_SESSION['retornar'] = true;
                        if($redirect){
                             redirect('');
                             exit;
                        }
                }

                // print_rr($_SERVER);
                // redirect('');
                // header('Location: ');
                // redirect('','refresh');
                // header('location:'.BASE_URL.'error/access/5050');
                return false;
            }
            // if($_SESSION['usuario_recordar'] == false && !AppSession::get('usuario_logueado')){
            //     self::destroy();
            //     redirect('');
            // }
            return true;
        }
        public static function set($clave,$valor){
            if(!empty($clave))
                $_SESSION[$clave] = $valor;
        }
        public static  function get($clave){
            if(isset($_SESSION[$clave]))
                return $_SESSION[$clave];
            else return false;
        }
        // public static  function getName($clave){
        //     if(isset($_SESSION[$clave]))
        //         return $_SESSION[$clave];
        //     else return false;
        // }
        public static function acceso($level){
            if(!AppSession::get('usuario_logueado')){
                redirect('');
                // header('location:'.BASE_URL.'error/access/5050');
                return false;
                exit;
            }
            // Session::tiempo();
            // if(Session::getLevel($level)>Session::get(Session::get('level'))){
            if(Session::getLevel($level)>Session::get('level')){
                //[level] es la variable del nivel de usuario
                // header('location:'.BASE_URL.'error/access/5050');
                return false;
                exit;
            }
            return true;
        }
        public static function accesoView($level){
            if(!AppSession::get('usuario_logueado')){
                return false;
            }
            if(is_array($level)){
                foreach ($level as $key => $value) {
                    if(+AppSession::getLevel($value) == AppSession::get('tipo_usuario')){
                        //[level] es la variable del nivel de usuario
                        return true;
                    }
                }
            }else{
                if($level == 'all'){
                    return true;
                }else if(+AppSession::getLevel($level) ==AppSession::get('tipo_usuario')){
                    //[level] es la variable del nivel de usuario
                    return true;
                }
            }
            return false;
        }
        public static function getLevelName($level){
            $role['admin'] = 2;
            $role['empleado'] = 1;
            $name = '';
            foreach ($role as $key => $value) {
                if($value == $level){
                    $name = $key;
                }
            }
            // echo $name;exit;
            return $name;
        }
        public static function getLevel($level){
            // echo $level.br();
            $role = ent_usuarios::$tipo_usuario_session;
            // print_rr($role);
            // echo 'asdasd';
            // var_dump($level);
            // $role['admin'] = 2;
            // $role['empleado'] = 1;
            // $role['usuario'] = 1;
            // print_r($role);
            // echo $role[$level].'br';

            if(!array_key_exists($level, $role)){
                return false;
                // echo 'error';
                // throw new Exception('Error de acceso');
            }else{
                // echo 'normal';
                return $role[$level];
            }

        }
        public static function accesoEstricto(array $level, $noAdmin = false){
            if(!AppSession::get('usuario_logueado')){
                 header('location:'.BASE_URL.'error/access/5050');
                exit;
            }

            if($noAdmin == false){
                if(Session::get('level') == 'admin'){
                    return;
                }
            }

            if(count($level)){
                if(in_array(Session::get('level'), $level)){
                    return;
                }
            }

            header('location:'.BASE_URL.'error/access/5050');

        }
        public static function accesoViewStricto(array $level, $noAdmin = false){
             if(!AppSession::get('usuario_logueado')){
               return false;
            }
            // Session::tiempo();
            if($noAdmin == false){
                if(Session::get('level') == 'admin'){
                    return true;
                }
            }

            if(count($level)){
                if(in_array(Session::get('level'), $level)){
                    return true;
                }
            }

           return false;
        }
        public static function tiempo(){
            if(!AppSession::get('tiempo') || !defined('SESSION_TIME')){
                throw new Exception('No se ha definido el timepo de sesion');
            }
            if(SESSION_TIME == 0){
                return;
            }

            if((time() - Session::get('tiempo')) > (SESSION_TIME * 60)){
                Session::destroy();
                header('location:'.BASE_URL.'error/access/8080');
            }else{
                Session::set('tiempo',time());
            }
        }
    }
?>