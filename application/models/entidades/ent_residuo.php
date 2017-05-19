<?php

    class ent_residuo{

        public $res_id;
        public $res_nombre;
        public $res_peligro;
        // public $res_estado;
        public $res_organico;
        public $res_es_otro;

        public $get_estado;
        //org = 1 ino = 0
        public $tipo_estado = array(
            array('id' => 1,'nombre' => 'Sólido'),
            array('id' => 2,'nombre' => 'Líquido')
        );

        public function getEstado(){
            foreach ($this->tipo_estado as $key => $value) {
                if($value['id'] == $this->res_estado)
                    return $value['nombre'];
            }
            return null;
        }
        public function __set($name, $value)
        {
            $this->$name = $value;
            if($name == 'res_estado'){
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