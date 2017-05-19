<?php
    class Test{
        private $nombre;

        public function __set($name, $value)
        {
            if (property_exists($this,$name)){
                $this->$name = $value;
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