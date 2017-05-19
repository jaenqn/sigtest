<?php

    class ent_riesgo{

        // public $pel_id;
        // public $pel_nombre;
        // public $cat_id_categoria;
        // public $pel_estado;

        public $tipo_estado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );
        public function __set($name, $value)
        {
                $this->$name = $value;
        }

        public function __get($name)
        {
                if (isset($this->$name)) return $this->$name;

        }


    }
?>