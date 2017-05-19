<?php

    class procesos_sig{

        public static function path_folder($pro){
            $ruta = '';
            switch ($pro) {
                case 'res_autorizaciones':
                    $ruta = PROPATH.'_residuos'.DS.'_autorizaciones'.DS;
                    break;

                default:
                    # code...
                    break;
            }
            return $ruta;
        }
        public static function  autoriza($opc){
            switch($opc){
                case 'ingreso_residuos':
                    return 15;//unidad ti y comunicaciones
                    break;
                case 'boleta_ambiental':
                    return 17;//deso
                    break;
                case 'boleta_seguridad':
                    return 16;//seguridad
                    break;
            }
        }
        public static function tiempo_respuesta($opc){
            //tiempo basado en horas
            switch ($opc) {
                case 'boleta': return 7*24; break;
            }
            return false;
        }
        public static function not_url($uri, $target){
            $e = explode('/', $uri);
            // print_rr($e);
            if(is_array($target)){
                foreach ($target as $key => $value) {
                    if(in_array($value, $e)) return false;
                }
                return true;
            }else {
                return !(in_array($target, $e));
            }


        }
    }
?>