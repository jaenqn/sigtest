<?php

    class ent_dependencia{

        public  $idDepend;
        public  $nivelDepend;
        public  $reportaDpend;
        public  $desDepend;
        public  $fechaDepend;
        public static $ID_GERENCIA = 1;
        public $id_instlacion;
        // public  $estadoDepend;

         public $get_estado;

        public $tipoEstado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
            );


        public function getEstado($val = false){
            if($val)
                $this->estadoDepend = $val;
            foreach ($this->tipoEstado as $key => $value) {
                if($value['id'] == $this->estadoDepend)
                    return $value['nombre'];
            }
            return null;
        }

        public function __set($name, $value)
        {
            if($name == 'estadoDepend'){
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