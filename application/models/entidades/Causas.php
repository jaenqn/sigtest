<?php

    class Causas{

        public $cau_id;
        // public $cau_tipo;
        // public $cau_sub_estandar;
        public $cau_nombre;

        public $cau_get_tipo;
        public $cau_get_sub_estandar;

        public $tipos = array(
            array('id' => 1,'nombre' => 'Inmediata'),
            array('id' => 2,'nombre' => 'Básica')
            );
        public $sub_estandar = array(
            array('id' => 1,'nombre' => 'Actos'),
            array('id' => 2,'nombre' => 'Condiciones')
            );
        public function getTipo(){

            foreach ($this->tipos as $key => $value) {
                if($value['id'] == $this->cau_tipo)
                    return $value['nombre'];
            }
            return null;
        }

        public function getSubEstandar(){
            foreach ($this->sub_estandar as $key => $value) {
                if($value['id'] == $this->cau_sub_estandar)
                    return $value['nombre'];
            }
            return null;
        }
        public function __set($name, $value)
        {
            $this->$name = $value;
            switch ($name) {
                case 'cau_tipo':
                    $this->cau_get_tipo = $this->getTipo();
                    break;
                case 'cau_sub_estandar':
                    $this->cau_get_sub_estandar = $this->getSubEstandar();
                    break;
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