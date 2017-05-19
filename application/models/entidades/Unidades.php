<?php

    class Unidades{

        public $uni_id;
        public $uni_nombre;
        public $dep_id_departamento;
        // public $uni_estado;
        public $uni_fecha_registro;
        public $uni_id_instalacion;


        public $get_estado;

        public $tipoEstado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );
        public function getEstado(){
            foreach ($this->tipoEstado as $key => $value) {
                if($value['id'] == $this->uni_estado)
                    return $value['nombre'];
            }
            return null;
        }
        public function __set($name, $value)
        {
            $this->$name = $value;
            if($name == 'uni_estado'){
                $this->get_estado = $this->getEstado();
            }
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