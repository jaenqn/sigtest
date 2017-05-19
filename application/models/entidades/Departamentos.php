<?php

    class Departamentos{

        public $dep_id;
        public $dep_nombre;
        // public $dep_estado;
        public $dep_fecha_registro;

        public $get_estado;

        public $tipoEstado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
            );


        public function getEstado($val = false){
            if($val)
                $this->dep_estado = $val;
            foreach ($this->tipoEstado as $key => $value) {
                if($value['id'] == $this->dep_estado)
                    return $value['nombre'];
            }
            return null;
        }
        public function __set($name, $value)
        {
            if($name == 'dep_estado'){
                $this->get_estado = $this->getEstado($value);
            }

            $this->$name = $value;
            // if (property_exists($this,$name)){
            //     $this->$name = $value;
            // }
        }
        public function __get($name)
        {
                if (isset($this->$name))
                {
                        return $this->$name;
                }


        }


    }
?>