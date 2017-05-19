<?php

    class ent_proceso_actividad{

        public $pac_id;
        public $pac_nombre;
        public $pac_estado;
        public $pac_orden;
        public $pet_id_procesos_etapa;
        public $pac_puesto_trabajo;
        public $pac_situacion;
        public $pac_ubicacion;
        public $pac_tipo_personal;


        public $tipo_estado = array(
            array('id' => 1,'nombre' => 'Activo'),
            array('id' => 0,'nombre' => 'Inactivo')
        );

        public $tipo_situacion = array(
            array('id' => 1,'nombre' => 'Rutinario'),
            array('id' => 2,'nombre' => 'No Rutinario'),
            array('id' => 3,'nombre' => 'Emergencia')
        );
        public $tipo_ubicacion = array(
            array('id' => 1,'nombre' => 'Dentro del Lugar'),
            array('id' => 2,'nombre' => 'Fuera del Lugar')
        );
        public $tipo_personal = array(
            array('id' => 1,'nombre' => 'Propio', 'ref' => 'PP'),
            array('id' => 2,'nombre' => 'Contratado', 'ref' => 'PC'),
            array('id' => 3,'nombre' => 'Visita', 'ref' => 'V')
        );


    }
?>