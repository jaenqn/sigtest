<?php

    class ent_boleta{

        public $bol_id;
        public $bol_correlativo;
        public $bol_tipo;
        public $bol_uni_remitente;
        public $bol_uni_receptor;
        public $bol_observacion;
        public $bol_corregir;
        public $bol_estado;
        public $bol_plazo_accion;
        public $bol_fecha_generado;
        public $bol_expire;

        public $tipo_estado = array(
            'elaborado' => 1,
            'aprobado' => 2,
            'procesado' => 3,
            'respondido' => 4,
            'rechazado' => 5,
            'cerrado' => 6,
            'sacp' => 7
            );
        public static $tipo_estado_dos = array(
            'elaborado' => 1,
            'aprobado' => 2,
            'procesado' => 3,
            'respondido' => 4,
            'rechazado' => 5,
            'cerrado' => 6,
            'sacp' => 7,
            'rechaza_elaborado' => 8,
            'rechaza_proceso' => 9,
            'seguimiento' => 10,
            'seguimiento_fin' => 11
            );
        public static $tipo_involucrados = array(
            'elaborador' => 1,
            'aprobador' => 2,
            'supervisor' => 3,
            'fizcalizador' => 4,
            'supervisor_inmediato' => 5

            );
        public static function lstEstados($format = false){
            $f = array();
            foreach (self::$tipo_estado_dos as $key => $value) {
                if(!$format){
                    if(!($value == 8 || $value == 9 || $value == 10 || $value == 11)){
                        $f[] = array(
                            'name' => $key,
                            'value' => $value
                        );
                    }
                }else{
                    $f[] = array(
                        'name' => $key,
                        'value' => $value
                    );

                }


            }
            return $f;
        }

        private static $time_file_expire = 7200;//dos horas
        public static function getTimExpireFiles(){
            return self::$time_file_expire;
        }
        public static  function getEstado($estado){
            return array_key_exists($estado, self::$tipo_estado_dos) ? self::$tipo_estado_dos[$estado] : 0;
        }
        public static function inEstado($target, $estados){
            if(is_array($estados)){
                foreach ($estados as $key => $value) {
                    if(self::getEstado($value) == $target) return true;
                }
                return false;
            }else if(self::getEstado($estados) == $target) return true;
            return false;
        }
        public static  function getInvolucrado($invo){
            return array_key_exists($invo, self::$tipo_involucrados) ? self::$tipo_involucrados[$invo] : 0;
        }
        private static $time_expire = 7200;//2horas
        // public static $time_expire = 120;//2min
        public static function getTiempoRespuesta($mode = false){
            if($mode){
                switch($mode){
                    case 'interval':
                        return new DateInterval('PT'.self::$time_expire.'S');
                        break;
                    default:
                        return self::$time_expire;
                        break;
                }
            }else return self::$time_expire;
        }
        public static function seguridad(){
            return 16;
        }
        public static function ambiental(){
            return 17;
        }
        public static function receptor($tipo){
            if($tipo == 2)
                return self::seguridad();
            return self::ambiental();
        }
        public static function getResponsable($tipo){
            switch (+$tipo) {
                case 1://ambiental
                    return self::ambiental();
                    break;
                case 2://seguridad
                    return self::seguridad();
                    break;
                default: return false;break;
            }
        }

        public static function getTipoBoleta($tipo){
            switch ($tipo) {
                case 'seguridad':
                    return 2;
                    break;
                case 'ambiental':
                    return 1;
                    break;
                default:
                    return 0;
                    break;
            }
            // echo Smarty::PHP_PASSTHRU;
        }




    }
?>