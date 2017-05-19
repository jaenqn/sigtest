<?php

    class Instalaciones{

        public $ins_id;
        public $ins_nombre;
        public $ins_razon_social;
        public $ins_rz_siglas;
        public $ins_ruc;
        public $ins_email;
        public $ins_telefono;
        // public $ins_estado;
        public $ins_attr_direccion;
        public $ins_direccion;
        public $ins_urb_localidad;
        public $dis_id_distrito;
        public $pro_id_provincia;
        public $dep_id_departamento;
        public $ins_cod_postal;
        public $ins_representante;
        public $ins_dni_representante;
        public $ins_ing_responsable;
        public $ins_cip_responsable;
        public $ins_abbr;

        public $get_estado;

        public $tipoEstado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );
        public function getEstado(){
            foreach ($this->tipoEstado as $key => $value) {
                if($value['id'] == $this->ins_estado)
                    return $value['nombre'];
            }
            return null;
        }
        public function __set($name, $value)
        {
            // echo 'yess';
            $this->$name = $value;

            if($name == 'ins_estado'){
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