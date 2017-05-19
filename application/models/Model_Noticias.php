<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Noticias extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function delete($idnoticia){
        $this->db->where('not_id', $idnoticia);
        $this->db->delete('tbl_noticias');
        $res = $this->db->affected_rows() > 0 ? true : false ;

        $this->db->where('not_id_noticia', $idnoticia);
        $this->db->delete('rel_docs_noticia');
        delete_folder(DOCSPATH.'_noticias'.DS.$idnoticia.DS);
        return $res;
    }
    public function change_public($idnoticia, $estado){
        return $this->actualizarnoticia($idnoticia,array(
            'not_publico' => +$estado
            ));
    }
    public function actualizarnoticia($idnoticia, $values){
        $this->db->set($values);
        $this->db->where('not_id',$idnoticia);
        $this->db->update('tbl_noticias');
        return $this->db->affected_rows() > 0 ? true : false;
    }
    public function listpublic(){
        $this->db->select();
        $this->db->where('not_publico', 1);
        $l = $this->db->get('tbl_noticias')->result_object();
        foreach ($l as $key => $value) {
            $value->file_portada = $this->getportadanoticia($value->not_id);
        }
        return $l;
    }
    public function deletefile($idfile){
        if($this->existefile($idfile)){
            $tf = $this->getnotfile($idfile);
            $ruta = DOCSPATH.'_noticias'.DS.$tf->not_id_noticia.DS;
            foreach(glob($ruta."*") as $archivos_carpeta)
            {
                if($archivos_carpeta == $ruta.$tf->dno_nombre_fichero)
                    unlink($archivos_carpeta);
            }
        }
        $this->db->where('dno_id', $idfile);
        $this->db->delete('rel_docs_noticia');
        $afr = $this->db->affected_rows();
        return $afr > 0 ? true : false;
    }
    public function getportadanoticia($idnoticia){
        $this->db->select();
        $this->db->where('not_id_noticia', $idnoticia);
        $this->db->where('dno_portada', 1);
        return $this->db->get('rel_docs_noticia')->row();

    }
    public function generar(){

        $g = new DateTime();
        $this->db->set('not_fecha_generado',$g->format('Y-m-d H:i'));
        $res['resultado'] = $this->db->insert('tbl_noticias');
        $res['obj_id'] = $this->db->insert_id();
        return $res;
    }
    public function getsimpledata($id){
        $this->db->select();
        $this->db->where('not_id', $id);
        return $this->db->get('tbl_noticias')->row();
    }
    public function getsimplefile($idfile){
        $this->db->select();
        $this->db->where('dno_id', $idfile);
        return $this->db->get('rel_docs_noticia')->row();
    }
    public function existe_noticia($id){
        $this->db->select('not_id');
        $this->db->where('not_id', $id);
        $this->db->get('tbl_noticias');
        return $this->db->affected_rows() > 0 ? true : false;
    }
    public function is_public($id){
        $this->db->select('not_id');
        $this->db->where('not_id', $id);
        $this->db->where('not_publico', 1);
        $this->db->get('tbl_noticias');
        return $this->db->affected_rows() > 0 ? true : false;
    }
    public function existefile($id){
        $this->db->select('dno_id');
        $this->db->where('dno_id', $id);
        $this->db->get('rel_docs_noticia');
        return $this->db->affected_rows() > 0 ? true : false;
    }
    public function insertfile($values){
        //identificar el tipo de fichero que se sube
        $values['dno_tipo'] = 1;
        $this->db->set($values);
        $this->db->insert('rel_docs_noticia');
        return $this->db->insert_id();
    }
    public function getnotfile($idfile){
        $this->db->select(array('not_id_noticia','dno_nombre_fichero'));
        $this->db->where('dno_id', $idfile);
        return $this->db->get('rel_docs_noticia')->row();
    }
    public function setportada($id){
        $idnot = $this->getnotfile($id)->not_id_noticia;
        // print_rr($idnot);
        $this->db->select(array('dno_id','dno_portada'));
        $this->db->where('not_id_noticia', $idnot);
        $ldocs = $this->db->get('rel_docs_noticia')->result_object();
        $this->db->flush_cache();

        foreach ($ldocs as $key => $value) {
            $this->db->or_where('dno_id', $value->dno_id);
        }
        $this->db->update('rel_docs_noticia', array('dno_portada' => 0));
        // echo $this->db->last_query();
        $this->db->flush_cache();
        $this->db->where('dno_id', $id);
        $this->db->update('rel_docs_noticia', array('dno_portada' => 1));

        return $this->db->affected_rows() > 0 ? true : false;
    }

    public function listficheros($idnoticia){
        $this->db->select();
        $this->db->where('not_id_noticia', $idnoticia);
        $lst  = $this->db->get('rel_docs_noticia')->result_object();


        foreach ($lst as $key => $value) {

            $value->ico_img = get_ico_file($value->dno_nombre_fichero);

            $value->ruta_archivo = NAMEDOC.'/_noticias/'.$idnoticia.'/'.$value->dno_nombre_fichero;

        }

        return $lst;
    }
    public function getdata($idnoticia){


            $this->db->select();
            $this->db->where('not_id', $idnoticia);
            $obj =  $this->db->get('tbl_noticias')->row();
            $obj->lstFicheros = $this->listficheros($idnoticia);
            return $obj;


    }
    public function getdatapublic($idnoticia){
        $this->db->select();
        $this->db->where('not_id', $idnoticia);
        $obj =  $this->db->get('tbl_noticias')->row();
        $obj->portada = $this->getportadanoticia($idnoticia);
        return $obj;

    }

}