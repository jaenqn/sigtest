<?php

    class ent_proceso{

        public $pro_id;
        public $pro_nombre;
        public $uni_id_unidad;
        public $pro_estado;
        public $pro_fecha_creacion;
        public $pro_fecha_modificacion;

        public $tipo_estado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );

        // public function __set($name, $value)
        // {
        //     $this->$name = $value;
        //     // if($name == 'uni_estado'){
        //     //     $this->get_estado = $this->getEstado();
        //     // }
        // }
        // public function __get($name)
        // {
        //         if (isset($this->$name))
        //         {
        //                 return $this->$name;
        //         }

        // }



    }
?>