<?php

    class ent_usuarios{

        public $usu_id;
        public $usu_nombre;
        public $usu_cargo;
        public $usu_ficha;
        public $uni_id_unidad;
        public $usu_usuario;
        public $usu_pass;
        public static $tiempo_usuario = 2;//en segundos
        // public $usu_tipo_usuario;
        // public $usu_estado;

        public $get_estado;
        public $get_tipo_usuario;

        public $tipo_estado = array(
            array( 'id' => 1, 'nombre' => 'Activo'),
            array( 'id' => 0, 'nombre' => 'Inactivo')
            );
        public $tipo_usuario = array(
            array( 'id' => 1, 'nombre' => 'Elaborador'),
            array( 'id' => 2, 'nombre' => 'Revisador'),
            array( 'id' => 3, 'nombre' => 'Jefe'),
            array( 'id' => 4, 'nombre' => 'Administrador'),
            array( 'id' => 5, 'nombre' => 'Administrador SIG')
            );
        public static $tipo_usuario_session = array(
            'elaborador' => 1,
            'revisador' => 2,
            'jefe' => 3,
            'administrador' => 4,
            'admin-sig' => 5
            );
        public static function lstUsuarios(){
            return array_to_name_value(self::$tipo_usuario_session);
        }
        public static function getUsuario($key){
            return array_key_exists($key, self::$tipo_usuario_session) ?  self::$tipo_usuario_session[$key] : false;
        }
        public function getEstado($val = false){
            if($val) $this->usu_estado = $val;
            foreach ($this->tipo_estado as $key => $value) {
                if($value['id'] == $this->usu_estado)
                    return $value['nombre'];
            }
            return null;
        }
        public static function permitir($target, $level){
            if(is_array($level)){
                foreach ($level as $key => $value) {
                    if(+self::getUsuario($value) == $target){
                        //[level] es la variable del nivel de usuario
                        return true;
                    }
                }
            }else{
                if($level == 'all'){
                    return true;
                }else if(+self::getUsuario($level) == $target){
                    return true;
                }
            }
            return false;
        }
        public function getTipoUsuario($val = false){
            if($val) $this->usu_tipo_usuario = $val;
            foreach ($this->tipo_usuario as $key => $value) {
                if($value['id'] == $this->usu_tipo_usuario)
                    return $value['nombre'];
            }
            return null;
        }
        public function __set($name, $value)
        {
            $this->$name = $value;
            if($name == 'usu_estado'){
                $this->get_estado = $this->getEstado();
            }
            if($name == 'usu_tipo_usuario')
                $this->get_tipo_usuario = $this->getTipoUsuario();

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