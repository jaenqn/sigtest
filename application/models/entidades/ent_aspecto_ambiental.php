<?php

    class ent_aspecto_ambiental{

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