<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_AnalisiProceso extends CI_Model {
    private $table = 'tbl_analisis_proceso';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function getestados_analisis(){
        return array(
            array('id' => 1, 'nombre' => 'Actualizable'),
            array('id' => 2, 'nombre' => 'Elaborado'),
            array('id' => 3, 'nombre' => 'Revisado'),
            array('id' => 4, 'nombre' => 'Aprobado'),
            array('id' => 5, 'nombre' => 'Finalizado')
            );
    }
    /**
     Estados de Análisis
     1 Actualizable
     2 Elaborado
     3 Revisado
     4 Aprobado
     5 Finalizado
     */
    public function insertar($values){

        $valF = $this->db->fields_filter($values, $this->table, true);
        $this->db->insert($this->table, $valF);
        return $this->db->affected_rows() == 1 ? true : false;
    }
    public function actualizar($value){

        $values = $this->db->fields_filter($value, $this->table);
        $this->db->where('apr_id', $value['apr_id']);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function getdata($idapr){
        $this->db->select(array(
            'ap.*',
            'uni.idDepend as uni_id',
            'uni.desDepend as uni_nombre',
            'dep.idDepend as dep_id',
            'dep.desDepend as dep_nombre',
            'p.*'
            ));
        $this->db->join('tbl_procesos p', 'p.pro_id = ap.pro_id_proceso');
        $this->db->join('dependencia uni', 'uni.idDepend = p.uni_id_unidad');
        $this->db->join('dependencia dep', 'dep.idDepend = uni.reportaDpend');
        $this->db->where('apr_id', $idapr);

        return $this->db->get('tbl_analisis_proceso ap')->row();


    }
    public function getcompletedata($idapr){
        $this->db->select(array(
            'ap.*',
            'uni.idDepend as uni_id',
            'uni.desDepend as uni_nombre',
            'dep.idDepend as dep_id',
            'dep.desDepend as dep_nombre',
            'p.*'
            ));
        $this->db->join('tbl_procesos p', 'p.pro_id = ap.pro_id_proceso');
        $this->db->join('dependencia uni', 'uni.idDepend = p.uni_id_unidad');
        $this->db->join('dependencia dep', 'dep.idDepend = uni.reportaDpend');
        $this->db->where('apr_id', $idapr);

        $objPro = $this->db->get('tbl_analisis_proceso ap')->row();
        if($objPro){
            //etapas proceso
            $this->db->select();
            $this->db->where('pro_id_proceso', $objPro->pro_id_proceso);
            $lstEta = $this->db->get('tbL_procesos_etapa')->result_object();

            //ordenar etapas
            usort($lstEta, function($a, $b){
                 if (+$a->pet_orden == +$b->pet_orden) return 0;
                 return (+$a->pet_orden < +$b->pet_orden) ? -1 : 1;
            });
            foreach ($lstEta as $key => $value) {
                $this->db->select();
                $this->db->where('pet_id_procesos_etapa', $value->pet_id);
                $value->lst_actividades = $this->db->get('tbL_procesos_actividad')->result_object();


                usort($value->lst_actividades, function($a, $b){
                     if (+$a->pac_orden == +$b->pac_orden) return 0;
                     return (+$a->pac_orden < +$b->pac_orden) ? -1 : 1;
                });

                foreach ($value->lst_actividades as $kAc => $valAc) {
                    $this->db->select();
                    $this->db->where('pac_id_actividad', $valAc->pac_id);
                    $this->db->join('tbl_peligros p', 'p.pel_id = abp.pel_id_peligro');
                    $valAc->lst_blan_peligros = $this->db->get('rel_actividad_blanco_peligro abp')->result_object();




                    foreach ($valAc->lst_blan_peligros as $kb => $valB) {
                        $idmed = explode(',', $valB->acb_medidas_control);
                        $this->db->select();
                        $this->db->where_in('mco_id', $idmed);
                        $this->db->join('tbl_jerarquia_mc j', 'j.jmc_id = tbl_medidas_control.mco_jerarquia');
                        $valB->lst_medidas = $this->db->get('tbl_medidas_control')->result_object();


                        $idrie = explode(',', $valB->rie_id_riesgo);
                        $this->db->select();
                        $this->db->where_in('rie_id', $idrie);
                        $valB->lst_riesgos = $this->db->get('tbl_riesgos')->result_object();
                        $valB->acb_vfp_pr = 0;
                        $sumpr = (+$valB->acb_vfp_ie) + (+$valB->acb_vfp_if) + (+$valB->acb_vfp_ip) + (+$valB->acb_vfp_ic);
                        // =SI(R10<=7;"1";SI(Y(R10>7;R10<=10);"2";SI(Y(R10>10;R10<=13);"3";SI(Y(R10>13;R10<=16);"4";SI(Y(R10>16;R10<=20);"5")))))

                        if($sumpr <= 7)
                            $valB->acb_vfp_pr = 1;
                        else if($sumpr > 7 && $sumpr <=10)
                            $valB->acb_vfp_pr = 2;
                        else if($sumpr > 10 && $sumpr <=13)
                            $valB->acb_vfp_pr = 3;
                        else if($sumpr > 13 && $sumpr <=16)
                            $valB->acb_vfp_pr = 4;
                        else if($sumpr > 16 && $sumpr <=20)
                            $valB->acb_vfp_pr = 5;

                        $valB->acb_vfp_prxse = $valB->acb_vfp_pr * (+$valB->acb_sev);
                        $valB->acb_vfp_nivrieimp = '';
                        if(+$valB->acb_vfp_prxse > 16){
                            $valB->acb_vfp_nivrieimp = 'IN';
                        }else if(+$valB->acb_vfp_prxse > 9){
                            $valB->acb_vfp_nivrieimp = 'IM';
                        }else if(+$valB->acb_vfp_prxse > 3){
                               $valB->acb_vfp_nivrieimp = 'TO';
                        }else if(+$valB->acb_vfp_prxse > 0){
                            $valB->acb_vfp_nivrieimp = 'AC';
                        }
                        $valB->acb_vfp_riimpsig = '';

                        if(+$valB->acb_vfp_prxse >= 10)
                            $valB->acb_vfp_riimpsig = 'SI';
                        else $valB->acb_vfp_riimpsig = 'NO';



                    }

                }

                foreach ($value->lst_actividades as $kAc => $valAc) {
                    $this->db->select();
                    $this->db->where('pac_id_actividad', $valAc->pac_id);
                    $this->db->join('tbl_aspecto_ambiental aa', 'aa.asp_id = aba.asp_id_ambiental');




                    $valAc->lst_blan_ambiental = $this->db->get('rel_actividad_blanco_aspamb aba')->result_object();
                    foreach ($valAc->lst_blan_ambiental as $kb => $valB) {
                        $idmed = explode(',', $valB->aba_medidas_control);
                        $this->db->select();
                        $this->db->where_in('mco_id', $idmed);
                        $this->db->join('tbl_jerarquia_mc j', 'j.jmc_id = tbl_medidas_control.mco_jerarquia');
                        $valB->lst_medidas = $this->db->get('tbl_medidas_control')->result_object();

                        $idimp = explode(',', $valB->imp_id_impacto);
                        $this->db->select();
                        $this->db->where_in('imp_id', $idimp);
                        $valB->lst_impactos = $this->db->get('tbl_impacto_ambiental')->result_object();

                        $valB->aba_vfp_prxse = (+$valB->aba_vfp_pr) * (+$valB->aba_vfp_sev);


                        $valB->aba_vfp_nivrieimp = '';
                        if(+$valB->aba_vfp_prxse > 16){
                            $valB->aba_vfp_nivrieimp = 'IN';
                        }else if(+$valB->aba_vfp_prxse > 9){
                            $valB->aba_vfp_nivrieimp = 'IM';
                        }else if(+$valB->aba_vfp_prxse > 3){
                               $valB->aba_vfp_nivrieimp = 'TO';
                        }else if(+$valB->aba_vfp_prxse > 0){
                            $valB->aba_vfp_nivrieimp = 'AC';
                        }
                        $valB->aba_vfp_riimpsig = '';

                        if(+$valB->aba_vfp_prxse >= 10)
                            $valB->aba_vfp_riimpsig = 'SI';
                        else $valB->aba_vfp_riimpsig = 'NO';

                    }

                }

                foreach ($value->lst_actividades as $kAc => $valAc) {
                    if(count($valAc->lst_blan_peligros) == 0 && count($valAc->lst_blan_ambiental) == 0)
                        unset($value->lst_actividades[$kAc]);
                }

            }
            $objPro->lst_etapas = $lstEta;
        }
        return $objPro;
        // print_rr($objPro);




    }
    public function actualizar_blapeligro($values){
        $id = $values['acb_id'];
        unset($values['acb_id']);
        $this->db->set($values);
        $this->db->where('acb_id', $id);
        return $this->db->update('rel_actividad_blanco_peligro');
    }
    public function actualizar_blaambiente($values){
        $id = $values['aba_id'];
        unset($values['aba_id']);
        $this->db->set($values);
        $this->db->where('aba_id', $id);
        return $this->db->update('rel_actividad_blanco_aspamb');
    }
    public function insertar_peligro($values){
        $this->db->set($values);
        return $this->db->insert('rel_actividad_blanco_peligro');
    }
    public function insertar_ambiente($values){
        $this->db->set($values);
        return $this->db->insert('rel_actividad_blanco_aspamb');
    }
    public function getdataactividadpeligro($idapel){

        $this->db->select();
        $this->db->where('acb_id', $idapel);
        $obj =  $this->db->get('rel_actividad_blanco_peligro')->row();


            $ids = explode(',', $obj->acb_medidas_control);

            $this->db->select();
            $this->db->where_in('mco_id', $ids);
            $this->db->join('tbl_jerarquia_mc j', 'j.jmc_id = tbl_medidas_control.mco_jerarquia');
            $obj->medidas_control = array();
            $obj->medidas_control = $this->db->get('tbl_medidas_control')->result_object();
            usort($obj->medidas_control, function($a,$b){
                return (+$a->jmc_nivel < +$b->jmc_nivel) ? -1 : 1;
            });
            // print_rr($obj);
        return $obj;
    }
    public function getdataactividadambiental($idaamb){

        $this->db->select();
        $this->db->where('aba_id', $idaamb);
        $obj =  $this->db->get('rel_actividad_blanco_aspamb')->row();


            $ids = explode(',', $obj->aba_medidas_control);

            $this->db->select();
            $this->db->where_in('mco_id', $ids);
            $this->db->join('tbl_jerarquia_mc j', 'j.jmc_id = tbl_medidas_control.mco_jerarquia');
            $obj->medidas_control = array();
            $obj->medidas_control = $this->db->get('tbl_medidas_control')->result_object();
            usort($obj->medidas_control, function($a,$b){
                return (+$a->jmc_nivel < +$b->jmc_nivel) ? -1 : 1;
            });
            // print_rr($obj);
        return $obj;
    }

    public function eliminar_peligro($id){
        $this->db->where('acb_id', $id);
        return  $this->db->delete('rel_actividad_blanco_peligro');
    }
    public function eliminar_ambiental($id){
        $this->db->where('aba_id', $id);
        return  $this->db->delete('rel_actividad_blanco_aspamb');
    }

}