<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Unidad extends CI_Model {
    public $table = 'unidades';
    private $class = 'Unidades';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function verificar_abbr($abbr, $id = false){
        $this->db->select('count(abbr) as nrAbbr');
        $this->db->where('abbr', $abbr);
        // $this->db->where('nivelDepend', 2);
        if($id){
            $this->db->where_not_in('idDepend',array($id));
        }
        $q = $this->db->get('dependencia')->row();
        // print_rr($q);
        if(+$q->nrAbbr == 0) return true;
        return false;
    }

    public function insertar(ent_dependencia $objU){

        $values = $this->db->fields_filter($objU,'dependencia');
        // print_rr($objU);
        $this->db->insert('dependencia', $values);
        $r = $this->db->last_query();
        $idDepend = $this->db->insert_id();
        $valIns = array(
                'uni_id_unidad' => $idDepend,
                'ins_id_instalacion' => $objU->id_instlacion,
                );
        $this->db->insert('rel_unidades_instalacion', $valIns);
        return $this->db->affected_rows() == 1 ? true : false;

    }

    public function listar(){
        $this->db->select('d.*');
        $this->db->select('dd.idDepend as id_depa');
        $this->db->select('dd.desDepend as nom_depa');
        $this->db->where('d.nivelDepend', 2);
        $this->db->join('dependencia dd', 'dd.idDepend = d.reportaDpend');
        // $this->db->join('instalaciones i', 'i.ins_id = d.id_instalacion','left');
        $this->db->from('dependencia d');
        // $this->db->join('departamentos', 'departamentos.dep_id = unidades.dep_id_departamento');
        $q = $this->db->get();
        // $lst = $q->result();
        // print_rr($lst);exit;
        $lst = $q->custom_result_object('ent_dependencia');
        // print_rr($lst);
        return $lst;
    }
    public function get_obj(ent_dependencia $obj)
    {
        $this->db->select();
        $this->db->where('idDepend', $obj->idDepend);
        $this->db->join('rel_unidades_instalacion','rel_unidades_instalacion.uni_id_unidad = dependencia.idDepend','left');
        $this->db->join('instalaciones','instalaciones.ins_id = rel_unidades_instalacion.ins_id_instalacion','left');
        $q = $this->db->get('dependencia');
        return $q->custom_row_object(0, 'ent_dependencia');
    }
    public function getsimpledata($id){
        $this->db->select();
        $this->db->where('idDepend', $id);
        return $this->db->get('dependencia')->row();
    }
    public function eliminar($id){
        $this->db->where('idDepend', $id);
        $this->db->delete('dependencia');
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    private function existeUniEnInstalacion($idinst){
        $this->db->select();
        $this->db->where('uni_id_unidad', $idinst);
        $this->db->get('rel_unidades_instalacion');
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    public function actualizar(ent_dependencia $obj){
        // print_rr($obj);exit;
        $values = $this->db->fields_filter($obj,'dependencia');

        $this->db->where('idDepend', $obj->idDepend);
        $this->db->update('dependencia', $values);
        $final = false;
        if($this->db->affected_rows() >= 1){
            $final =  true;
        }

        if($this->existeUniEnInstalacion($obj->idDepend)){
            $valIns = array('ins_id_instalacion' => $obj->id_instlacion);
            $this->db->where('uni_id_unidad', $obj->idDepend);
            $this->db->update('rel_unidades_instalacion', $valIns);

            if($this->db->affected_rows() >= 1){
                $final =  true;
            }
        }else{
            $valIns = array(
                'uni_id_unidad' => $obj->idDepend,
                'ins_id_instalacion' => $obj->id_instlacion,
                );
            $this->db->insert('rel_unidades_instalacion', $valIns);
        }


        return $final;
    }
    public function listar_by_instalacion($idinstlacion){
        $this->db->select('dependencia.*');
        $this->db->where('ins_id_instalacion', $idinstlacion);
        $this->db->join('dependencia', 'dependencia.idDepend = rel_unidades_instalacion.uni_id_unidad');
        $q = $this->db->get('rel_unidades_instalacion')->result_object();
        return $q;
    }
    public function listar_by_dep($id_departamento, $activo = false)
    {
        $this->db->select('dependencia.*');
        $this->db->select('dependencia.idDepend as uni_id');
        $this->db->select('dependencia.desDepend as uni_nombre');

        if($activo && $activo == 'activo')
            $this->db->where('estadoDepend', 1);
        if($activo && $activo == 'inactivo')
            $this->db->where('estadoDepend', 0);

        $this->db->where('reportaDpend', $id_departamento);
        $this->db->where('nivelDepend', 2);
        $q = $this->db->get('dependencia');
        return $q->custom_result_object('ent_dependencia');

    }

    public function get_departamento($id_unidad){
        $this->db->select('d.*');
        $this->db->select('dd.idDepend as id_depa');
        $this->db->select('dd.desDepend as nom_depa');
        $this->db->where('d.nivelDepend', 2);
        $this->db->where('d.idDepend', $id_unidad);
        $this->db->join('dependencia dd', 'dd.idDepend = d.reportaDpend');
        // $this->db->join('instalaciones i', 'i.ins_id = d.id_instalacion','left');
        $this->db->from('dependencia d');

        // $this->db->select();

        // $this->db->join('departamentos', 'departamentos.dep_id = unidades.dep_id_departamento');
        $q = $this->db->get();
        return $q->custom_row_object(0, 'ent_dependencia');
    }

}