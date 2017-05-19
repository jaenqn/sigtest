<?php

    class ent_categorias{

        public $cat_id;
        public $cat_nombre;
        public $cat_tipo_peligro;
        public $cat_estado;


        public $tipo_categoria = array(
            array('id' => 1,'nombre' => 'Peligro'),
            array('id' => 2,'nombre' => 'Aspecto Ambiental')
        );
        public $tipo_estado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );
    }
?>