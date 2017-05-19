<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Documento extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function actualizar($values, $iddoc){
        $this->db->set($values);
        $this->db->where('idDoc', $iddoc);
        $this->db->update('documento');
        return $this->db->affected_rows() > 0 ? true : false;
    }
    public function getdata($id_doc){
        $this->db->select();
        $this->db->where('idDoc', $id_doc);
        return $this->db->get('documento')->row();
    }
    public function insert_doc($values){
        $this->db->set($values);
        $this->db->set('fechaDoc','now()',false);
        $this->db->insert('documento');
        // $this->db->insert_id();
    }
    public function listarImgPortal(){
        $q = $this->db->query("SELECT desDoc, nombreDoc, rutaDoc
            FROM documento, carpeta
            WHERE desCarpeta = 'ImgPortal'
            AND idCarpetaDoc = idCarpeta
            AND idDoc = (
            SELECT MAX( idDoc )
            FROM documento, carpeta
            WHERE desCarpeta = 'ImgPortal'
            AND idCarpetaDoc = idCarpeta )
            ORDER BY desDoc ASC");
        return $q->row();

    }
    public function listarDocumentoByCarpeta($idCarpeta, $orderBy = false){
        $this->db->select();
        $this->db->where('idCarpetaDoc', $idCarpeta);
        if($orderBy)
            $this->db->order_by("$orderBy", 'asc');
        $q = $this->db->get('documento');
        return $q->result();
    }

    public function listar_documento_by_categoria(){

    }

    public function listar_documento_by_carpeta($id_carpeta, $order = false, $visible = false){


        // print_rr($hijos);
        $this->db->select();
        $this->db->where('idCarpetaDoc', $id_carpeta);
        if($visible)
            $this->db->where('estadoDoc', $visible);
        if($order)
            $this->db->order_by($order[0], $order[1]);
        $q = $this->db->get('documento');
        $d = $q->result_object();

        // $d->carpetas = $hijos;
        foreach ($d as $key => $value) {
            $value->nameFile = get_ico_files($value->nombreDoc);
            $value->nameFileTwo = get_ico_name_files($value->nombreDoc);
             $t = get_ico_file($value->rutaDoc);
            $h = explode('/', $value->rutaDoc);
            if(trim(end($h)) == '')
                $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;

            // if($t[0] == 'rare')
            //     $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
        }

        return $d;
    }
    public function listar_documento_by_carpeta_descripcion($id_carpeta,$descripcion, $order = false,$visible = false){
        $this->db->select();
        $this->db->where('idCarpetaDoc', $id_carpeta);
        if($visible)
            $this->db->where('estadoDoc', $visible);
        $this->db->like('desDoc', $descripcion);
        if($order)
            $this->db->order_by($order[0], $order[1]);
        $q = $this->db->get('documento');
        $d = $q->result();
        foreach ($d as $key => $value) {
            $value->nameFile = get_ico_files($value->nombreDoc);
            $t = get_ico_file($value->rutaDoc);
            $h = explode('/', $value->rutaDoc);
            if(trim(end($h)) == '')
                $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
            // if($t[0] == 'rare')
            //     $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
        }
        return $d;
    }
    public function listar_documento_by_categoria_and_descripcion($id_carpetas,$descripcion,$limit = false, $order = false){
        $this->db->select();
        $this->db->group_start();
        foreach ($id_carpetas as $key => $value) {
            // echo $value;
            $this->db->or_where('idCarpetaDoc', $value);
        }
        $this->db->group_end();
        if($descripcion && trim($descripcion) != '')
            $this->db->like('desDoc', $descripcion);
        if($limit){
            $this->db->where('fechaDoc < now()');
            $this->db->limit(10);
        }
        if($order)
            $this->db->order_by($order[0], $order[1]);
        $q = $this->db->get('documento');
        $d = $q->result();
        // echo $this->db->last_query();
        foreach ($d as $key => $value) {
            $value->nameFile = get_ico_files($value->nombreDoc);
            $value->nameFileTwo = get_ico_name_files($value->nombreDoc);
            $t = get_ico_file($value->rutaDoc);

            // if($t[0] == 'rare')
            //     $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
              $h = explode('/', $value->rutaDoc);
            if(trim(end($h)) == '')
                $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
        }
        return $d;
    }
    public function listar_by_search($query, $limit = 10, $page = 1){
        //0 inicio
        $this->db->select();
        $this->db->where('estadoDoc', 1);
        if($query && trim($query) != ''){
            $this->db->group_start();
            $this->db->or_like('desDoc', $query);
            $this->db->or_like('nombreDoc', $query);
            $this->db->group_end();
        }
        $this->db->order_by('desDoc', 'asc');
        $d['lst'] = $this->db->get('documento',$limit,$limit*($page - 1) + ($page > 1 ? 1 : 0))->result();

        $this->db->select('idDoc');
        $this->db->where('estadoDoc', 1);
        if($query && trim($query) != ''){
            $this->db->group_start();
            $this->db->or_like('desDoc', $query);
            $this->db->or_like('nombreDoc', $query);
            $this->db->group_end();
        }
        $this->db->order_by('desDoc', 'asc');
        $dd = $this->db->get('documento')->result();
        $nropaginas = floor(count($dd)/$limit) + (count($dd)%$limit > 0 ? 1 : 0);

        $d['nro_pages'] = $nropaginas;


        // echo $this->db->last_query();exit;
        foreach ($d['lst'] as $key => $value) {
            $value->nameFile = get_ico_files($value->nombreDoc);
            $value->nameFileTwo = get_ico_name_files($value->nombreDoc);
            $t = get_ico_file($value->rutaDoc);
            if($value->fecAprobacionArchivo == '0000-00-00 00:00:00' || $value->fecAprobacionArchivo == '')
                $value->fecAprobacionArchivo = '-- -- --';
            else $value->fecAprobacionArchivo = 'Aprobado : '.DateTime::createFromFormat('Y-m-d H:i:s', $value->fecAprobacionArchivo)->format('d-m-Y');
            if(trim($value->versionDoc) == '')
                $value->versionDoc = '--';
            // if($t[0] == 'rare')
            //     $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
              $h = explode('/', $value->rutaDoc);
            if(trim(end($h)) == '')
                $value->rutaDoc = $value->rutaDoc.$value->nombreDoc;
        }
        // echo DateTime::createFromFormat('Y-m-d', '1999-10-10')->format('Y-m-d');
        // print_rr($d['lst']);
        // exit;
        return $d;

    }


}