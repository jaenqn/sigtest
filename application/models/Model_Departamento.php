
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Departamento extends CI_Model {
    private $table = 'departamentos';
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }

    public function listar($order = 'idDepend',$type = 'asc', $activo = false){

        $this->db->select("dependencia.*");
        $this->db->select("dependencia.desDepend as dep_nombre");
        $this->db->select("dependencia.idDepend as dep_id");
        $this->db->where('nivelDepend', 1);
        if($activo && $activo == 'activo')
            $this->db->where('estadoDepend', 1);
        if($activo && $activo == 'inactivo')
            $this->db->where('estadoDepend', 0);
        $this->db->where('reportaDpend', ent_dependencia::$ID_GERENCIA);
        $this->db->order_by($order, $type);
        $q = $this->db->get('dependencia');
        $lst = $q->custom_result_object('ent_dependencia');
        return $lst;
    }
    // public function listar($order = 'dep_id',$type = 'asc'){
    //     $this->db->select();
    //     $this->db->order_by($order, $type);
    //     $q = $this->db->get($this->table);
    //     $lst = $q->custom_result_object('Departamentos');
    //     return $lst;
    // }
    // public function insertar(Departamentos $obj){
    //     $objA = array(
    //         'dep_nombre' => $obj->dep_nombre,
    //         'dep_estado' => $obj->dep_estado
    //         );
    //     $this->db->insert($this->table, $objA);
    //     if($this->db->affected_rows() == 1){
    //         $obj->dep_id = $this->db->insert_id();
    //         return true;
    //     }
    //     return false;
    // }
    public function insertar(ent_dependencia $obj){
        // print_rr($obj);
        $objA = array(
            'nivelDepend' => 1,
            'reportaDpend' => ent_dependencia::$ID_GERENCIA,
            'desDepend' => $obj->desDepend,
            'estadoDepend' => $obj->estadoDepend
        );
        $this->db->set('fechaDepend','now()',false);
        $this->db->insert('dependencia', $objA);

        if($this->db->affected_rows() == 1){
            $obj->idDepend = $this->db->insert_id();
            //crear carpeta del departamento
            $this->load->model('Model_Carpeta','carpeta');
            $nameDoc = 'Documentos'.strtoupper(substr($obj->desDepend,0,4));

            $values['idDepenCarpeta'] = $obj->idDepend;
            $values['nivelCarpeta'] = Ficheros::getCarpetaSubRaiz();
            $values['estadoCarpeta'] = 1;
            $values['descripcionCarpeta'] = '';
            $values['idArchivoCarpeta'] = 1;
            $values['desCarpeta'] = $nameDoc;

            $this->carpeta->crearCarpetaDocDep($values);


            // while($this->carpeta->existeCarpeta($nameDoc, Ficheros::getCarpetaSubRaiz())){
            //     $nameDoc .= '0';

            // }
            // mkdir(DOCSPATH.$nameDoc, 0700);
            //fincrearcarpeta
            return true;
        }
        return false;
    }
    public function get_obj(ent_dependencia $obj){
        $this->db->select();
        $this->db->where('idDepend', $obj->idDepend);
        $q = $this->db->get('dependencia');
        return $q->custom_row_object(0, 'ent_dependencia');
    }
    public function get_obj_by_unidad( $id_unidad){
        $this->db->select(array(
            'dependencia.*',
            'dd.idDepend as dep_id',
            'dd.desDepend as dep_nombre',
            ));
        $this->db->join('dependencia dd', 'dd.idDepend = dependencia.reportaDpend');
        $this->db->where('dependencia.idDepend', $id_unidad);
        return $this->db->get('dependencia')->row();
    }
    // public function get_obj(Departamentos $obj){
    //     $this->db->select();
    //     $this->db->where('dep_id', $obj->dep_id);
    //     $q = $this->db->get($this->table);
    //     return $q->custom_row_object(0, 'Departamentos');
    // }

    public function eliminar($id){
        $this->db->select();
        $this->db->where('reportaDpend', $id);
        $q = $this->db->get('dependencia');
        $q =$q->num_rows();
        if($q>0)
            return false;

        $this->db->where('idDepend', $id);
        $this->db->delete('dependencia');


        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    // public function eliminar($id){
    //     $this->db->where('dep_id', $id);
    //     $this->db->delete($this->table);

    //     if($this->db->affected_rows() >= 1){
    //         return true;
    //     }
    //     return false;
    // }

    public function actualizar(ent_dependencia $obj){
        $values = $this->db->fields_filter($obj, 'dependencia', true);
        // print_rr($values);
        $this->db->where('idDepend', $obj->idDepend);
        $this->db->update('dependencia', $values);

        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }
    // public function actualizar(Departamentos $obj){
    //     $values = $this->db->fields_filter($obj, $this->table, true);

    //     $this->db->where('dep_id', $obj->dep_id);
    //     $this->db->update($this->table, $values);

    //     if($this->db->affected_rows() >= 1){
    //         return true;
    //     }
    //     return false;
    // }

}