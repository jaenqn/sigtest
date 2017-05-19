<?php

    class ent_notificaciones{
        private static $n = array(
                'not_asunto' => 'nodefinido',
                'not_mensaje' => 'sinmensajedefinido'
                );
        public static $areas = array(
            'deso' => 17,
            'seguridad' => 16,
            'comunicacion' => 15,
            );
        public static function getVariables(){
            return array(
                'unidad_remite',
                'unidad_receptora',
                'departamento_remite',
                'departamento_receptor',
                'matriz_proceso',
                'boleta_correlativo'
                );
        }
        public static function boletasig($accion, $options){

            switch ($accion) {
                case 'elaborado':
                    $self->n['not_asunto'] = 'Boleta SIG elaborada';
                    $self->n['not_mensaje'] = 'Se ah elaborado una sboleta SIG para '.$options['uni_receptora'];
                    break;
                case 'bol_aprobado':
                    $self->n['not_asunto'] = 'Boleta SIG Aprobada';
                    $self->n['not_mensaje'] = 'Se ah aprobado la Boleta SIG «{{boleta_correlativo}}» para {{unidad_receptora}}';
                    break;
                case 'rechazado_uno':
                    $self->n['not_asunto'] = 'Boleta SIG Rechazada';
                    $self->n['not_mensaje'] = 'La Boleta SIG : '.$options['objbol']->bol_correlativo.' fue rechazada';
                    break;
                case 'respondido_remi':
                    $self->n['not_asunto'] = 'Boleta SIG Respondida';
                    $self->n['not_mensaje'] = $options['uni_responsable'].'ah respondido a la Boleta SIG  '.$options['objbol']->bol_correlativo;
                    break;
                case 'respondido_resp':
                    $self->n['not_asunto'] = 'Boleta SIG Respondida';
                    $self->n['not_mensaje'] = 'La Boleta SIG : '.$options['objbol']->bol_correlativo.' ah sido respondida, verificar revición y ';
                    break;
                case 'res_solicitud_generada':
                    $self->n['not_asunto'] = 'Ingreso de Residuos : '.$options['residuo'];
                    $self->n['not_mensaje'] = 'Se requiere verificar la solicitud de '.$options['unidad'];
                    break;
                case 'res_solicitud_aprobada':
                    $self->n['not_asunto'] = 'Ingreso de Residuos Aprobado';
                    $self->n['not_mensaje'] = 'La solicitud '.$options['correlativo'].' fue aprobada.';
                    break;
                case 'bol_proce_info_gen'://ncesario
                    $self->n['not_asunto'] = 'Boleta SIG procesada';
                    $self->n['not_mensaje'] = 'Se procesó la Boleta SIG {{boleta_correlativo}} para {{unidad_receptora}}';
                    break;
            }

            return $self->n;
        }
        public static function analisis_proces(){

        }


    }
?>