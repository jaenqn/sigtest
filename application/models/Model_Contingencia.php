
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Contingencia extends CI_Model {

    
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
		$this->load->library('session');

    }
    public function insertarContingencia($descripcion, $fecha_aprobacion){
    	
		$arrayDatos =  array (
		   'con_descripcion' => $descripcion,
		   'con_fecha_aprobacion' => $fecha_aprobacion,
		    'con_estado'	=> 0 
		);
		
		 
	    $res = $this->db->insert('tbl_contingencia',$arrayDatos );  		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}else 
		{
			//$_SESSION['verifica_agregarContingencia'] == '1' ;
		   
			$res =  $this->db->affected_rows() == 1 ?  true : false;
			$num_id = $this->db->insert_id();	
		
		$resultado = array (
					 'num_id' => $num_id,
					 'resultado' => $res
					);		
		}
	 
       return $resultado;
      
    }
	
	  public function eliminarContingencia($num_id){
		
			   $this->db->where('con_id', $num_id);		 
		 
	    $res = $this->db->delete('tbl_contingencia');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}else 
		
		
	 
       return $res;
      
    }
	  
	 public function listarContingencia(){
		
		$res =   $this->db->query("SELECT * FROM `tbl_contingencia`");
		$array = $res->result_array();		 
		 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}	
	 
       return $array;
      
    }
    
    public function cambiar_estado_contingencia($id){    	
		// 0 = Pendiente
		// 1 = Publicado		
		$arrayDatos =  array (
		   'con_estado'		=> 1		  
		);			 
		
		$this->db->where('con_id', $id);
		$res = $this->db->update('tbl_contingencia', $arrayDatos);		
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  return false;
		}
		else 
		{				   
			$res =  $this->db->affected_rows() == 1 ?  true : false;		    
			return true;		    	
		}
    }
	  


}