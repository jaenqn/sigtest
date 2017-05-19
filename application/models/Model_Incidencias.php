<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Incidencias extends CI_Model {

    

    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function insertar_reporte($arraDatos){         
		 
	    $res = $this->db->insert('tbl_incidencias',$arraDatos );  
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
	 	
		$id = $this->db->insert_id();			
	  	return $id;	        
    }
	
	
	public function insertar_testigo($id_incidente , $nombre_testigo){         
		 
	  $arrayDatos =  array (
	  	   'inc_id'     =>$id_incidente,
		   'inctes_nombre' => $nombre_testigo,		  
		);		
		 
	    $res = $this->db->insert('tbl_incidencias_testigos',$arrayDatos );  		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else 
		{					   
			$res =  $this->db->affected_rows() == 1 ?  true : false;			
		    return $res; 
		}
	   
    }
	
	
	public function insertar_evidencia_relacion($id_incidente,$identificador_reporte){         
	
	   
				
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
	
	
	public function insertar_causas_relacion($id_incidente,$causa_subEstandar){         
	
	
	   foreach ($causa_subEstandar as $key => $id_subbEstandar) {
		   
		   $arrayDatos =  array (
			  	   'inc_id'     =>$id_incidente,
				   'cau_id'     => $id_subbEstandar,		  
				);	
		 
	    		$res = $this->db->insert('rel_incidencias_causas',$arrayDatos );  		   
	   }
				
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else {
				
			return true;	
			
		}			 
	  	 
	 }
	
	 //Lista todas las causas Asignados al incidente
	 public function listar_causas_xIncidente($id_incidente){
		
		$res =   $this->db->query("SELECT * FROM `rel_incidencias_causas` INNER join causas 
								on rel_incidencias_causas.cau_id = causas.cau_id 
								where rel_incidencias_causas.inc_id = $id_incidente ");
		$array_incidencias = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return $error;
		}	
		
		
       return $array_incidencias;
      
    } 
	 
	 public function listar_testigos_xIncidente($id_incidente){
		
		$res =   $this->db->query("SELECT * FROM `tbl_incidencias_testigos` 
								where inc_id = $id_incidente ");					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return $error;
		}	
		$array_testigos = $res->result_array();	
		
		
       return $array_testigos;
      
    } 
	 
	  public function listar_evidencias_xIncidente_adicionales($id_incidente){
		
		$res =   $this->db->query("SELECT * FROM `rel_incidencias_ficheros` INNER join tbl_incidencias_evidencias 
								ON rel_incidencias_ficheros.incevi_id = tbl_incidencias_evidencias.incevi_id
								WHERE tbl_incidencias_evidencias.incevi_tipo = 1 
								and  rel_incidencias_ficheros.inc_id = $id_incidente ");					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return $error;
		}	
		$array_ficheros_adicionales = $res->result_array();	
		
		
       return $array_ficheros_adicionales;
      
    } 
    
      public function listar_evidencias_xIncidente_respuesta($id_incidente){
		
		$res =   $this->db->query("SELECT * FROM `rel_incidencias_ficheros` INNER join tbl_incidencias_evidencias 
								ON rel_incidencias_ficheros.incevi_id = tbl_incidencias_evidencias.incevi_id
								WHERE tbl_incidencias_evidencias.incevi_tipo = 2 
								and  rel_incidencias_ficheros.inc_id = $id_incidente ");					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return $error;
		}	
		$array_ficheros_adicionales = $res->result_array();	
		
		
       return $array_ficheros_adicionales;
      
    } 
	
	
	
	 public function listar_incidencias(){
		
		$res =   $this->db->query("SELECT inc_id, inc_numero,inc_tipo,dependencia.desDepend, 
								inc_fch_reporte,inc_fechaHora_incidente,inc_locacion_incidente, 
								inc_tipo_incidente,inc_causa_inmediata_incidente, inc_estado, inc_estado_guardada  
								FROM `tbl_incidencias` inner join dependencia 
								on tbl_incidencias.inc_selUnidad = dependencia.idDepend 
								order by inc_id desc");
		$array_incidencias = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return $error;
		}	
		
		
       return $array_incidencias;
      
    }
	 
	  public function listarUnidades(){
		
		$res =   $this->db->query("SELECT * FROM `tbl_incidencias`");
		$array = $res->result_array();
		
		
						 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}		 
       return $array;
      
    }
	    
		
		//comprueba si el número de incidencia ya existe!!
	  	public function comprobar_numero_incidencia($num_incidente){
		
		$res =   $this->db->query("SELECT inc_numero  FROM `tbl_incidencias` 
								   WHERE `inc_numero`   = '$num_incidente'");						 
	   
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
	  	  
	
	
	 public function obtener_numero_incidencia($ano){
		
		//$res =   $this->db->query("SELECT COUNT(YEAR(`inc_fch_reporte`)) AS cantidad FROM `tbl_incidencias` 
		//						  WHERE YEAR(`inc_fch_reporte`) = '$ano'");	
								  
		$res =   $this->db->query("SELECT `inc_numero` FROM `tbl_incidencias`
									WHERE YEAR(`inc_fch_reporte`) = '$ano'
									order by `inc_id` desc LIMIT 0 ,1 ");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
		
		if ($res->num_rows()  == 0 ) {			
			$num_incidente = 1 ;
		}else {			
			//Obtengo el numero(en int) del numero de incidente		
			$registro = $res->row();		 
	        $string_incidente = $registro->inc_numero ;
			
			$array_codigo = explode('-', $string_incidente);	
			$num_incidente = ((int)$array_codigo[1]) + 1;  //sumo uno al numero de incidente
		}
				 		 
		 if ($num_incidente < 10) {
		 	$num_modificado =  "00$num_incidente";
		 }else if ($num_incidente < 100){
		 	$num_modificado =  "0$num_incidente";
		 }else {
		 	$num_modificado = $num_incidente;
		 }
		 		 
		 $num = "RI-$num_modificado-$ano";
		 
		 $bandera = false;
		 //comprobar si ya se registro ese Numero de incidence
		  while ( $this->comprobar_numero_incidencia($num)  ) {
		  		 			  			
		  		 $num_incidente++ ;
				if ($num_incidente < 10) {
				 	$num_modificado =  "00$num_incidente";
				 }else if ($num_incidente < 100){
				 	$num_modificado =  "0$num_incidente";
				 }else {
				 	$num_modificado = $num_incidente;
				 }
				 		 
				 $num = "RI-$num_modificado-$ano";			  
		  	
		  }		 
		 
		 return $num ;	      
    }

 	//VERSION ANTIGUA
	/*public function obtener_numero_incidencia($ano){
		
		//$res =   $this->db->query("SELECT COUNT(YEAR(`inc_fch_reporte`)) AS cantidad FROM `tbl_incidencias` 
		//						  WHERE YEAR(`inc_fch_reporte`) = '$ano'");	
								  
		$res =   $this->db->query("SELECT `inc_numero` FROM `tbl_incidencias`
									WHERE YEAR(`inc_fch_reporte`) = '$ano'
									order by `inc_id` desc LIMIT 0 ,1 ");						  					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
		
		//retorna la cantidad de reportes durente el año y le sumo uno
		$cantidad = $res->row();		 
        $num_incidente = $cantidad->cantidad + 1 ;	
		 		 
		 if ($num_incidente < 10) {
		 	$num_modificado =  "00$num_incidente";
		 }else if ($num_incidente < 100){
		 	$num_modificado =  "0$num_incidente";
		 }else {
		 	$num_modificado = $num_incidente;
		 }
		 		 
		 $num = "RI-$num_modificado-$ano";
		 
		 $bandera = false;
		 //comprobar si ya se registro ese Numero de incidence
		  while ( $this->comprobar_numero_incidencia($num)  ) {
		  		 			  			
		  		 $num_incidente++ ;
				if ($num_incidente < 10) {
				 	$num_modificado =  "00$num_incidente";
				 }else if ($num_incidente < 100){
				 	$num_modificado =  "0$num_incidente";
				 }else {
				 	$num_modificado = $num_incidente;
				 }
				 		 
				 $num = "RI-$num_modificado-$ano";			  
		  	
		  }		 
		 
		 return $num ;	      
    }*/

	
	 
	 public function listar_causas_inmediatas($id_sub_estandar){
		
		$res =   $this->db->query("SELECT * FROM `causas`
								 where `cau_tipo` = 1 and `cau_sub_estandar` = $id_sub_estandar");					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}	
		
		$array = $res->result_array();		 
        return $array;
      
    }
	 
	 
    public function insertar_evidencia($id_reporte, $nom_fichero, $descripcion,$tipo){
    	
		date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
		$fcha_subida = $fecha->format('Y-m-d H:i'); 
		
		$arrayDatos =  array (
		   'incevi_id_reporte' => $id_reporte,
		   'incevi_nom_fichero' => $nom_fichero,
		   'incevi_descripcion' => $descripcion,
		   'incevi_fch_subida'=> $fcha_subida,
		   'incevi_tipo'=> $tipo //1 para las evidencias adicionales
		   					     //2 para evidencias de la respuesta		     
		);
		
		 
	    $res = $this->db->insert('tbl_incidencias_evidencias',$arrayDatos );  		
		if (!$res){
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return $error;
		}
		else {
			//$_SESSION['verifica_agregarContingencia'] == '1' ;
		   
			$res =  $this->db->affected_rows() == 1 ?  true : false;
			$num_id = $this->db->insert_id();	
	        
			return $num_id; 			 
		}      
      
    }
	
	
	public function eliminar_evidencia($nom_fichero){
		
		$this->db->where('incevi_nom_fichero', $nom_fichero);		 
		 
	    $res = $this->db->delete('tbl_incidencias_evidencias');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  //echo "$error[message]";
		  return false ;
		}else  {
			$res =  $this->db->affected_rows() == 1 ?  true : false;
			return $res;		
		}       
      
    }
	
	public function listar_evidencia($id_reporte, $tipo){
		
		$res =   $this->db->query("SELECT * FROM `tbl_incidencias_evidencias`
								 where `incevi_id_reporte` = '$id_reporte' and 
								 `incevi_tipo` = $tipo");					 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}	
		
		$array = $res->result_array();		 
        return $array;      
      
    }
	
	  public function listar_incidencias_filtrados($num_incidente, $fecha_reporte, $fecha_incidente, $tipo_reporte, $tipo_incidente,$causa, $selDepartamento, $selUnidad, $estado) 
	  {	
		
		//para nombre de indicador
		if($num_incidente == '_todas_') {
			$sql_num_incidente =  "inc_numero like '%%'";
		}else {
			$sql_num_incidente =  "inc_numero like '%$num_incidente%'";
		}
		
		//para tipo de unidad de medida
		if($fecha_reporte == '_todas_') {
			$sql_fecha_reporte =  " ";
		}else {
			$sql_fecha_reporte =  "and inc_fch_reporte >= '$fecha_reporte%'";
		} 
		
		//para estado, habilitado, inhabilitado
		if($fecha_incidente == '_todas_') {
			$sql_fecha_incidente =  " ";
		}else {
			$sql_fecha_incidente =  "and `inc_fechaHora_incidente` >= '$fecha_incidente%'";
		} 
		
		//para tipo
		if($tipo_reporte == '_todas_') {
			$sql_tipo_reporte =  " ";
		}else if ($tipo_reporte == '0')  {
			$sql_tipo_reporte =  "and inc_tipo  = 0";
		} else if ($tipo_reporte == '1')  {
			$sql_tipo_reporte =  "and inc_tipo  = 1 ";
		}
		
		//para tipo
		if($tipo_incidente == '_todas_') {
			$sql_tipo_incidente =  " ";
		}else if ($tipo_incidente == '1')  {
			$sql_tipo_incidente =  "and inc_tipo_incidente  = 1";
		} else if ($tipo_incidente == '2')  {
			$sql_tipo_incidente =  "and inc_tipo_incidente  = 2 ";
		}else if ($tipo_incidente == '3')  {
			$sql_tipo_incidente =  "and inc_tipo_incidente  = 3";
		} else if ($tipo_incidente == '4')  {
			$sql_tipo_incidente =  "and inc_tipo_incidente  = 4 ";
		}
		
		//para tipo
		if($causa == '_todas_') {
			$sql_causa =  " ";
		}else if ($causa == '1')  {
			$sql_causa =  "and inc_causa_inmediata_incidente  = 1";
		} else if ($causa == '2')  {
			$sql_causa =  "and inc_causa_inmediata_incidente  = 2 ";
		}
		
		if($selDepartamento == '_todas_') {
			$sql_selDepartamento =  " ";
		}else {
			$sql_selDepartamento =  "and inc_selDepartamento = $selDepartamento";
		}
		
		if($selUnidad == '_todas_') {
			$sql_selUnidad =  " ";
		}else {
			$sql_selUnidad =  "and inc_selUnidad = $selUnidad";
		}
		
		if($estado == '_todas_') {
			$sql_estado =  " ";
		}else if ($estado == '1')  {
			$sql_estado =  "and inc_estado  = 1";
		} else if ($estado == '2')  {
			$sql_estado =  "and inc_estado  = 2 ";
		}else if ($estado == '3')  {
			$sql_estado =  "and inc_estado  = 3";
		}
		
		
		
	
			$res =   $this->db->query("SELECT inc_id, inc_numero,inc_tipo,dependencia.desDepend, 
									inc_fch_reporte,inc_fechaHora_incidente,inc_locacion_incidente, 
									inc_tipo_incidente,inc_causa_inmediata_incidente, inc_estado  
									FROM `tbl_incidencias` inner join dependencia 
									on tbl_incidencias.inc_selUnidad = dependencia.idDepend 
									 
									where $sql_num_incidente $sql_fecha_reporte $sql_fecha_incidente  $sql_tipo_reporte 									
										  $sql_tipo_incidente $sql_causa  $sql_selDepartamento  $sql_selUnidad
										  $sql_estado");	
	
		
		 
	    if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$array_incicadores = $res->result_array();			
			
	 
       return $array_incicadores;      
    }

		
	//Obtener datos de un incidente especifico
	public function obtener_incidente($id_incidente){
		
		$res =   $this->db->query("SELECT * FROM `tbl_incidencias`
									where inc_id = $id_incidente");
							 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
		$array = $res->result_array();			 
       	return $array;      

	}
	
		public function enviar_incidente($id_incidente ,$revisador_firma, $estado){
		//1 = Pendiente	    	
		//2 = aprobado
		// 3 = Rechazado		
		$arrayDatos =  array (
		   'inc_revisador_firma'	=> $revisador_firma,
		   'inc_estado'				=>   $estado, 
		   'inc_estado_guardada'				=>   1   //0= Pendiente guardada(sin revisar), 
														 // 1= Pendiente guardada(revisado) y listo para ser enviado a Deso o seguridad,   
		);			 
		
		$this->db->where('inc_id', $id_incidente);
		$res = $this->db->update('tbl_incidencias', $arrayDatos);		
		
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
	
		public function aprobar_rechazar_incidente($id_incidente ,$aprobador_firma, $estado){    	
		//2 = aprobado
		// 3 = Rechazado		
		$arrayDatos =  array (
		   'inc_aprobador_firma'	=> $aprobador_firma,
		   'inc_estado'				=>   $estado
		);			 
		
		$this->db->where('inc_id', $id_incidente);
		$res = $this->db->update('tbl_incidencias', $arrayDatos);		
		
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
		
	
	//============PARA LOS REPORTES ================00000
      
      //obtiene solo los años donde hay datos , para hacer el reporte
      public function  obtener_anos () {
    		
    	$res =   $this->db->query("SELECT year(`inc_fch_reporte`) as ano FROM 
									`tbl_incidencias` 									
									GROUP by year(inc_fch_reporte)");		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else 
		{		   
			$array = $res->result_array();	
			return $array;
		}
	     	
      } 
	  
	   //listado de reporte por año y tipo
	   public function  reporte_xAno_xEstado ($ano, $estado, $tipo, $id_departamento, $id_unidad) {
	   	
		//estado: 1=Pendiente, 2=Aprobado, 3=Rechazado
		//tipo  0=Incidente , 1=accidente
		
		if ($ano == '_todas_') {
			$sql_ano = ' ';			
		}else {
			$sql_ano = "AND year(inc_fch_reporte) = '$ano'";
		}
		
		
		
		if ($id_departamento == '_todas_') {
			$sql_depa = ' ';			
		}else {
			$sql_depa = "AND inc_selDepartamento = $id_departamento";
		}
		
		if ($id_unidad == '_todas_') {
			$sql_uni = ' ';			
		}else {
			$sql_uni = "AND inc_selUnidad = $id_unidad";
		}
		
		
		
    		
    	$res =   $this->db->query("SELECT 
								 '$ano',
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 1  THEN (`inc_id`)  END)  enero,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 2 THEN (`inc_id`)  END) febrero,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 3 THEN (`inc_id`)  END) marzo,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 4 THEN (`inc_id`) END) abril,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 5 THEN (`inc_id`)  END) mayo,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 6 THEN (`inc_id`) END) junio,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 7 THEN (`inc_id`)  END) julio,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 8 THEN (`inc_id`) END) agosto,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 9 THEN (`inc_id`)  END) septiembre,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 10 THEN (`inc_id`)  END) octubre,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 11 THEN (`inc_id`)  END) noviembre,
								COUNT(CASE WHEN MONTH(`inc_fch_reporte`) = 12 THEN (`inc_id`)  END) diciembre
								from   tbl_incidencias
								WHERE
									 inc_tipo  = $tipo  and inc_estado = $estado 
								 	$sql_ano	$sql_depa $sql_uni
								 ");		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else 
		{		   
			$array = $res->result_array();	
			return $array;
		}
	     	
      } 
      
      //para la fila de TOTAL
      public function  reporte_total_xAno_xEstado($ano,  $tipo, $id_departamento, $id_unidad) {
	   	
		//estado: 1=Pendiente, 2=Aprobado, 3=Rechazado
		//tipo  0=Incidente , 1=accidente
		
		if ($ano == '_todas_') {
			$sql_ano = ' ';			
		}else {
			$sql_ano = "AND year(inc_fch_reporte) = '$ano'";
		}
		
		
		
		if ($id_departamento == '_todas_') {
			$sql_depa = ' ';			
		}else {
			$sql_depa = "AND inc_selDepartamento = $id_departamento";
		}
		
		if ($id_unidad == '_todas_') {
			$sql_uni = ' ';			
		}else {
			$sql_uni = "AND inc_selUnidad = $id_unidad";
		}
				
    		
    	$res =   $this->db->query("SELECT 
									'$ano',
									COUNT(CASE WHEN inc_estado  = 1  THEN (`inc_id`)  END)  pendiente,
									COUNT(CASE WHEN inc_estado  = 2  THEN (`inc_id`)  END)  aprobado,
									COUNT(CASE WHEN inc_estado  = 3  THEN (`inc_id`)  END)  rechazado																	
									from   tbl_incidencias
									WHERE
									 inc_tipo  = $tipo   
								 	$sql_ano	$sql_depa $sql_uni
								 ");		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else 
		{		   
			$array = $res->result_array();	
			return $array;
		}
	     	
      } 
      
      public function resumen_general ($ano, $id_departamento, $id_unidad){
      		
      	 //para Incidente 		
      	 $lstPendientes_incid = $this->reporte_xAno_xEstado($ano,1,0, $id_departamento, $id_unidad); // recibe el año y el estado, y su tipo
      	 $lstAprobados_incid = $this->reporte_xAno_xEstado($ano,2,0, $id_departamento, $id_unidad);		
      	 $lstRechazados_incid = $this->reporte_xAno_xEstado($ano,3,0, $id_departamento, $id_unidad);	
      	 
      	 // para accidente 		
      	 $lstPendientes_accid = $this->reporte_xAno_xEstado($ano,1,1, $id_departamento, $id_unidad); // recibe el año y el estado, y su tipo
      	 $lstAprobados_accid = $this->reporte_xAno_xEstado($ano,2,1, $id_departamento, $id_unidad);		
      	 $lstRechazados_accid = $this->reporte_xAno_xEstado($ano,3,1, $id_departamento, $id_unidad);
		 
		 //para el total
		 $lstTotal_incid = $this->reporte_total_xAno_xEstado($ano,0, $id_departamento, $id_unidad);
		 $lstTotal_accid = $this->reporte_total_xAno_xEstado($ano,1, $id_departamento, $id_unidad);
		 	
      	 
      	 $resumen_general = array();
      	 
      	 $resumen_general['lstPendientes_incid'] = $lstPendientes_incid;
		 $resumen_general['lstAprobados_incid'] = $lstAprobados_incid;
		 $resumen_general['lstRechazados_incid'] = $lstRechazados_incid;
		 
		 $resumen_general['lstPendientes_accid'] = $lstPendientes_accid;
		 $resumen_general['lstAprobados_accid'] = $lstAprobados_accid;
		 $resumen_general['lstRechazados_accid'] = $lstRechazados_accid;
		 
		 $resumen_general['lstTotal_incid'] = $lstTotal_incid;
		 $resumen_general['lstTotal_accid'] = $lstTotal_accid;
		 
		 return $resumen_general;
      	 
      	
      }
	  
	  
	  public function eliminar_incidencia_general($inc_id){
	 		 		
	 	//primero borro las relaciones		
		$this->db->where('inc_id', $inc_id);			 
	    $res1 = $this->db->delete('rel_incidencias_ficheros');
		
		$this->db->where('inc_id', $inc_id);			 
	    $res2 = $this->db->delete('rel_incidencias_causas');
		
		$this->db->where('inc_id', $inc_id);			 
	    $res3 = $this->db->delete(' tbl_incidencias_testigos');
		
		//eliminar tabla centrarl
		$this->db->where('inc_id', $inc_id);			 
		$res4 = $this->db->delete('tbl_incidencias');		
			
		 if ($res == false ) {
		 	return false;
		 }
		 
	     return true;    
	   
			   
    }
	  
	  		
		
		

}	
