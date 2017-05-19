<?php

    class ent_medida_control{

        public $tipo_estado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );
        public $tipo_jerarquia = array(
            array('id' => 1,'nombre' => 'Eliminar'),
            array('id' => 2,'nombre' => 'Sustituir'),
            array('id' => 3,'nombre' => 'Controles de Ingeniería'),
            array('id' => 4,'nombre' => 'Controles Administrativos'),
            array('id' => 5,'nombre' => 'Equipos de Protección Personal')
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