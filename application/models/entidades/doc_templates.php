<?php

    class doc_templates{


        public static function getWord($opcion){
            $out = '';
            switch ($opcion) {
                case 'rep_autorizacion':
                    $out = TPLSPATH.'tpl_res_autorizacion_ingreso.docx';
                    break;
                case 'rep_declaracion':
                    $out = TPLSPATH.'tpl_res_declaracion_dosb.zip';
                    break;
            }
            return $out;

        }

        public static function getExcel($opcion){
            $out = '';
            switch ($opcion) {
                case 'rep_gen_sol':
                    $out = TPLSPATH.'tpl_res_rep_gen_solidos.xlsx';
                    break;
                case 'rep_gen':
                    $out = TPLSPATH.'tpl_res_rep_gen.xlsx';
                    break;
                case 'apr_rep_matriz':
                    $out = TPLSPATH.'tpl_apr_rep_matriz_dos.xlsx';
                    break;SPATH.'tpl_res_rep_gen.xlsx';
                    break;
                case 'test':
                    $out = TPLSPATH.'tpl_apr_rep_matriz_tres.xlsx';
                    break;
            }
            return $out;
        }
    }
?>