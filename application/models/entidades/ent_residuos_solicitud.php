<?php

    class ent_residuos_solicitud{
        public $rss_id;
        public $res_id_residuo;
        public $rss_peso;
        public $rss_volumen;
        public $rss_volumen_tipo;
        public $rss_unidades;
        public $rso_id_origen;
        public $alm_id_almacenamiento;
        public $empc_id_empresa;
        public $rss_epp;
        public $rss_observaciones;
        public $rss_autorizado;
        public $uni_id_unidad_remitente;
        public $rss_fecha_solicitud;
        public $rss_fecha_autorizado;

        public static $tipos_volumen = array(
            array('lt',1),
            array('m3',2),
            array('gal',3),
            );

        public static function receptor($idopc){
            // retorna los ids de la tabla dependencia
            switch($idopc){
                case 'tic':
                    return 15;
                    break;
            }
        }

    }
?>