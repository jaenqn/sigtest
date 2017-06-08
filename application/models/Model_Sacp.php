
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Sacp extends CI_Model {

    

    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function insertar_sacp_generado($num_sacp,$selUnidad,$fecha_sacp,$clasificacion,$hallazgo_tipo,$otro_hallazgo,$norma,$requisito,$hallazgo,$revisador_firma, $reportador_firma){         
		
			$arrayDatos =  array (
		   'idDepend' => $selUnidad,
		   
		   'sacp_estado' => 1, //1 = abierto,2 = cerrada, 3=Genera SACP
		  
		      
		   'sacp_1_fecha'	=> $fecha_sacp,
		   'sacp_1_clasificacion'	=> $clasificacion,
		   
		   'sacp_2_numero'			=> $num_sacp,
		   'sacp_2_hallazgo_tipo'	=> $hallazgo_tipo,
		   'sacp_2_hallazgo_texto'	=> $otro_hallazgo,
		   
		   'sacp_3_norma'			=> $norma,
		   'sacp_3_requisito'		=> $requisito,
		   'sacp_3_descripcion'		=> $hallazgo,
		   'sacp_3_lider'			=> $revisador_firma ,
		   'sacp_3_emisor'			=> $reportador_firma   
		   
		  		     
		);
		
		 
	    $res = $this->db->insert('tbl_sacp',$arrayDatos );  
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
	 	
		$id = $this->db->insert_id();			
	  	return $id;	        
    }
	
	    
		
		//comprueba si el número de Sacp ya existe!!
	  	public function comprobar_numero_sacp($num_sacp){
		
		$res =   $this->db->query("SELECT sacp_2_numero  FROM `tbl_sacp` 
								   WHERE `sacp_2_numero`   = '$num_sacp'");						 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
		
		//verifico si encontró un número incidencia 
	    $numero_registros = $res->num_rows();
		
		if($numero_registros > 0) {
			return true;
		}		
		else{
			return false;
		}
		      
    }
	  	  
	
	 public function obtener_numero_sacp($ano){
		
		//$res =   $this->db->query("SELECT COUNT(YEAR(`inc_fch_reporte`)) AS cantidad FROM `tbl_incidencias` 
		//						  WHERE YEAR(`inc_fch_reporte`) = '$ano'");	
								  
		$res =   $this->db->query("SELECT `sacp_2_numero` FROM `tbl_sacp`
									WHERE YEAR(`sacp_1_fecha`) = '$ano'
									order by `sacp_id` desc LIMIT 0 ,1 ");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
		
		if ($res->num_rows()  == 0 ) {			
			$num_sacp = 1 ;
		}else {			
			//Obtengo el numero(en int) del numero de sacp	
			$registro = $res->row();		 
	        $string_sacp = $registro->sacp_2_numero ;
			
			$array_codigo = explode('-', $string_sacp);	
			$num_sacp = ((int)$array_codigo[1]) + 1;  //sumo uno al numero de sacp actual
		}
				 		 
		 if ($num_sacp < 10) {
		 	$num_modificado =  "00$num_sacp";
		 }else if ($num_sacp < 100){
		 	$num_modificado =  "0$num_sacp";
		 }else {
		 	$num_modificado = $num_sacp;
		 }
		 		 
		 $num = "SACP-$num_modificado-$ano-RSEL";
		 
		 $bandera = false;
		 //comprobar si ya se registro ese Numero de SACP
		  while ( $this->comprobar_numero_sacp($num)  ) {
		  		 			  			
		  		 $num_sacp++ ;
				if ($num_sacp < 10) {
				 	$num_modificado =  "00$num_sacp";
				 }else if ($num_incidente < 100){
				 	$num_modificado =  "0$num_sacp";
				 }else {
				 	$num_modificado = $num_sacp;
				 }
				 		 
				  $num = "SACP-$num_modificado-$ano-RSEL";		  
		  	
		  }		 
		 
		 return $num ;	      
    }

	public function listar_sacp(){
		
		$res =   $this->db->query("SELECT * FROM `tbl_sacp`  ORDER by `sacp_id` desc");						 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return $error;
		}	
		
		$array_incidencias = $res->result_array();
       return $array_incidencias;
      
    }
	
	public function listar_sacp_xDependencia($idDepend){
		
		$res =   $this->db->query("SELECT * FROM `tbl_sacp` where `idDepend` =  $idDepend  
									 ORDER by `sacp_id` desc");						 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return $error;
		}	
		
		$array_incidencias = $res->result_array();
        return $array_incidencias;
      
    }
	
		 
	 public function obtener_sacp_detalle($id_sacp){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp`
									WHERE `sacp_id` =  $id_sacp");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$registro = $res->row();
		return $registro;
		
    }

	public function agregar_causa_ishikawa ($id_sacp, $tipo,$causa) {
		
		$arrayDatos =  array (
		   'sacishi_tipo' => $tipo,//1 = Material,2 = Metodo, 3=Materiales,4=Mano de obra, 5=Ambiente
		   'sacishi_causa' => $causa,
		   'sacp_id' => $id_sacp 	  
		   
		  		     
		);		
		 
	    $res = $this->db->insert('tbl_sacp_5causas',$arrayDatos );  
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
	 	
		$id = $this->db->insert_id();			
	  	return $id;	        	
		
	}
	
	
	public function agregar_causa_cinco_porque ($arrayDatos) {
		
	
		 
	    $res = $this->db->insert('tbl_sacp_5causas',$arrayDatos );  
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
	 	
		$id = $this->db->insert_id();			
	  	return $id;	        	
		
	}
	
	public function agregar_seguimiento ($id_sacp,$accion,$comentario, $fecha) {		
				
		$arrayDatos =  array (
		   'sacseg_accion' => $accion,//
		   'sacseg_fecha' => $fecha,
		   'sacseg_coment' => $comentario,
		   'sacp_id'	=>  $id_sacp	  		   
		  		     
		);		
		 
	    $res = $this->db->insert('tbl_sacp_seguimiento',$arrayDatos );  
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
	 	
		$id = $this->db->insert_id();			
	  	return $id;	        	
		
	}
	
	
	 public function listado_ishikawa_xSacp($id_sacp){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp_5causas`
									WHERE `sacp_id` =  $id_sacp 
									and `sacishi_tipo` != 0 
									order by sacishi_tipo asc");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$lst = $res->result_array();
		return $lst ;		
		
    }
	 
	  public function listado_cinco_porque_xSacp($id_sacp){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp_5causas`
									WHERE `sacp_id` =  $id_sacp 
									and `sacishi_tipo` = 0 
									order by sacishi_tipo asc");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$lst = $res->result_array();
		return $lst ;		
		
    }
	  
	 public function listado_causas_xSacp($id_sacp){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp_5causas`
									WHERE `sacp_id` =  $id_sacp 
									 and `sacau_estado_guardada` = 1 
									order by sacishi_tipo asc");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$lst = $res->result_array();
		return $lst ;		
		
    }
	  
	  
	  
	 public function listado_seguimiento_xSacp($id_sacp){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp_seguimiento`
									WHERE `sacp_id` =  $id_sacp 									
									order by sacseg_id asc");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$lst = $res->result_array();
		return $lst ;		
		
    }
	  
	 public function obtener_cinco_porque_especifico($id_sacishi){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp_5causas`
									WHERE `sacishi_id` =  $id_sacishi 
									and `sacishi_tipo` = 0 ");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$registro = $res->row();
		return $registro ;		
		
    }
	 
	 
	  public function obtener_seguimiento_especifico($id_sacsig){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp_seguimiento`
									WHERE `sacseg_id` =  $id_sacsig ");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$registro = $res->row();
		return $registro ;		
		
    }
	 
	 
	 public function generar_diagrama_ishikawa_xSacp($id_sacp){
	
								  
		$res =   $this->db->query("SELECT * FROM `tbl_sacp_5causas`
									WHERE `sacp_id` =  $id_sacp
									order by sacishi_tipo asc");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$lst = $res->result_array();
		return $lst ;		
		
    }
    
     public function eliminar_causa_ishikawa($id_ishikawa){
			
		//se borra el id de la tabla-relacion de Notificaciones-Unidades
		$this->db->where('sacishi_id', $id_ishikawa);		 
		 
	    $res = $this->db->delete('tbl_sacp_5causas');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}			
	 
       return true;      
    }
	 
	  public function eliminar_seguimiento($id_sacseg){
			
		//se borra el id de la tabla-relacion de Notificaciones-Unidades
		$this->db->where('sacseg_id', $id_sacseg);		 
		 
	    $res = $this->db->delete('tbl_sacp_seguimiento');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}			
	 
       return true;      
    }
	 
	 

	public function agregar_causas_todas($id_sacp){
    	
		$arrayDatos =  array (
		   'sacau_estado_guardada'		=> 1		    
		);				   
		
		$this->db->where('sacp_id', $id_sacp);
		$res = $this->db->update('tbl_sacp_5causas', $arrayDatos);		
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}else 
		{
			//$_SESSION['verifica_agregarContingencia'] == '1' ;		   
			$res =  $this->db->affected_rows() == 1 ?  true : false;		   	    	
		}
	 
       return $res;
      
    }
    
    // para el insertado de evidencias 
    public function insertar_evidencia($id_incidente,$identificador_reporte){         
    
       
                
         //obtengo los id
        $res1 =   $this->db->query("SELECT incevi_id FROM `tbl_incidencias_evidencias` 
                                    where `incevi_id_reporte` = '$identificador_reporte'");
        
        $array = $res1->result_array();
        
        
        
        if (!$res1)
        {
          $error = $this->db->error(); // Has keys 'code' and 'message'
          echo "$error[message]";
          return false;
        }else {
                
                foreach ($array as $key => $incevi_id) {                
                    
                    $arrayDatos =  array (
                       'inc_id'     =>$id_incidente,
                       'incevi_id' => $incevi_id['incevi_id'],        
                    );  
                    
                    
             
                    $res2 = $this->db->insert('rel_incidencias_ficheros',$arrayDatos );  
                }
                
                                
                
            }
            
        return true;     
     } 
    
    
    
    
    
	
	
	public function cerrar_sacp_individual($id_sacp){
    	
		$arrayDatos =  array (
		   'not_asunto'		=> $asunto,
		   'not_mensaje' 	=> $mensaje		 
		);				   
		
		$this->db->where('not_id', $id);
		$res = $this->db->update('tbl_notificaciones', $arrayDatos);		
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}else 
		{
			//$_SESSION['verifica_agregarContingencia'] == '1' ;		   
			$res =  $this->db->affected_rows() == 1 ?  true : false;
		    $this->session->set_userdata('verifica_notificacion', 1);		    	
		}
	 
       return $res;
      
    }
    
    
    
    
			

}	
