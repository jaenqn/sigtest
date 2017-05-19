<?php

    class ent_proceso_etapa{

        public $pet_id;
        public $pet_nombre;
        public $pet_orden;
        public $pro_id_proceso;
        public $pet_estado;

        public $tipo_estado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );

    }
?>