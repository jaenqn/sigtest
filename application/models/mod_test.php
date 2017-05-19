<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class mod_test extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function where(){
        $this->db->select();
        $this->db->where('uni_id_unidad = 15 or uni_id_unidad = 10');
        return $this->db->get('tbl_usuarios')->result_object();

    }

}