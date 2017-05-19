<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Correlativo extends CI_Model {
    private $precor_bola = 'BA-';
    private $precor_bols = 'BS-';
    private $precor_res = 'SIR-';


    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }

    public function listar(){
        $this->db->select();
        $q = $this->db->get('tbl_correlativo');

        return $q->result_object();
    }
    public function obtener_correlativo($tipo,$opc,$update = true){
        $lst = array();
        switch ($tipo) {
            case 'boleta':
                $lst = $this->listar_by_tipo(1,$opc);
                $lst = $lst[0];
                if($opc == 2)
                    $lst->correlativo = $this->precor_bols.str_pad($lst->cor_val,4,'0',STR_PAD_LEFT).'-'.date('Y');
                else
                    $lst->correlativo = $this->precor_bola.str_pad($lst->cor_val,4,'0',STR_PAD_LEFT).'-'.date('Y');
                // $value = +$lst->cor_val + 1;
                if($update)
                    $this->a_boleta(1,$opc,+$lst->cor_val + 1);
                break;
            case 'residuo':
                $lst = $this->listar_by_tipo(4,1)[0];
                $lst->correlativo = $this->precor_res.str_pad($lst->cor_val,4,'0',STR_PAD_LEFT).'-'.date('Y');
                 if($update)
                    $this->a_boleta(4,$opc,+$lst->cor_val + 1);
                break;

            default:
                # code...
                break;
        }
        return $lst;
    }
    public function listar_by_tipo($tipo,$opc,$create = false){
        $this->db->select();
        $this->db->where('cor_tip', $tipo);
        $this->db->where('cor_opc', $opc);
        $q = $this->db->get('tbl_correlativo');
        $lst = $q->result_object();
        if($create){
            if(count($lst) == 0){
                $values = array(
                    'cor_tip' => 3,
                    'cor_des' => 'RINC',
                    'cor_opc' => $opc,
                    'cor_val' => 1
                    );
                $this->db->insert('tbl_correlativo', $values);
                $idt = $this->db->insert_id();
                $this->db->select();
                $this->db->where('cor_id', $idt);
                $q = $this->db->get('tbl_correlativo');
                $lst = $q->result_object();
            }
        }

        return $lst;

    }
    public function listar_partes(){
        $this->db->select();
        $this->db->or_where('cor_tip', 2);
        $this->db->or_where('cor_tip', 4);
        $q = $this->db->get('tbl_correlativo');
        return $q->result_object();
    }

    public function a_boleta($tipo, $opc, $val){
        // br();
        // echo 't-'.$tipo;
        // br();
        // echo 'o-'.$opc;
        // br();
        // echo 'v-'.$val;
        // br();
        $object = array(
            'cor_val' => $val
            );
        $this->db->where('cor_tip', $tipo);
        $this->db->where('cor_opc', $opc);
        $this->db->update('tbl_correlativo', $object);
        // echo 'entrado';
        // echo $this->db->affected_rows().'ss';
    }
    // public function a_sacp($opc, $val){
    //     $object = array(
    //         'cor_val' => $val
    //         );
    //     $this->db->where('cor_tip', 2);
    //     $this->db->where('cor_opc', $opc);
    //     $this->db->update('tbl_correlativo', $object);
    // }
    // public function a_reporte(){
    //     $object = array(
    //         'cor_val' => $val
    //         );
    //     $this->db->where('cor_tip', 3);
    //     $this->db->where('cor_opc', $opc);
    //     $this->db->update('tbl_correlativo', $object);
    // }
    // public function a_autorizacion(){
    //     $object = array(
    //         'cor_val' => $val
    //         );
    //     $this->db->where('cor_tip', 4);
    //     $this->db->where('cor_opc', $opc);
    //     $this->db->update('tbl_correlativo', $object);
    // }

}