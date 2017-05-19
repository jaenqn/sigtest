
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Reutilizables extends CI_Model {
	
 public function __construct()
{
    parent::__construct();
    $this->load->database();

}


public function listar_departamentos(){
		
		$res =   $this->db->query("SELECT * FROM `departamentos` where dep_estado = 1 ");
		$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
       return $array;      
    }
	
	public function listar_unidadades(){
		
		$res =   $this->db->query("SELECT * FROM `unidades` where uni_estado = 1 ");
		$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
       return $array;      
    }
	
	//devuelve id y nombre
	public function listar_unidadades_simple(){
		
		$res =   $this->db->query("SELECT uni_id,uni_nombre FROM `unidades` where uni_estado = 1 ");
		$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
       return $array;      
    }
	
	
	//lista las unidades, correspondientes al id de un departamento	
	public function listar_unidadades_xDepartamento($dep_id){
		
		$res =   $this->db->query("SELECT * FROM `dependencia` where estadoDepend = 1 and reportaDpend= $dep_id ");
		$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
       return $array;      
    }		
 
 
}
