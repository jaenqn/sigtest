<?php

    class Ficheros{
        public  $IdFichero;
        public  $NombreFichero;
        public  $Descripcion;
        public  $TipoFichero;
        public  $FechaModificacion;
        public  $CategoriaFichero;
        public  $Estado;
        public  $Visible;

        // adicionales

        public $FaIcono;
        private static $FilRaiz = -2;
        private static $FilRaiz2 = -1;

        public static function getCarpetaRaiz(){
            return self::$FilRaiz;
        }
        public static function getCarpetaSubRaiz(){
            return self::$FilRaiz2;
        }




    }
?>