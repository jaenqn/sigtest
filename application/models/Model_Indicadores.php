<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Indicadores extends CI_Model {
	
	  function __construct() {
        parent::__construct();
		$this->load->database();
    }
	  
	 public function agregar_UnidadesMedidas($nombre){
		
			$arrayDatos =  array (
		   'med_nombre' => $nombre		  
		  	);		
		 
	    $res = $this->db->insert('tbl_medidas_indicadores',$arrayDatos );  	
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else 
		{
			$num_id = $this->db->insert_id();		
			
		  	return $num_id;	
		}
 		
   }
	  


	public function listarUnidadesMedidas(){
		
		$res =   $this->db->query("SELECT * FROM `tbl_medidas_indicadores` order by med_id asc");
		$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
       return $array;      
    }
	
	

	public function listarUnidades(){
		
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
	
	public function listarUnidades_seleccionadas($id){
		
		$res =   $this->db->query("SELECT * FROM `rel_indicadores_unidades` where ind_id = $id ");
		$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
       return $array;      
    }
	

	 
	 
	
	public function agregar_indicador($indicador,$tipo,$unidad_medida,$formula,$nivel,$evidencia,$estado){
    	
		$arrayDatos =  array (
		   'ind_indicador'	=> $indicador,
		   'ind_tipo' 		=> $tipo,
		   'med_id' 		=> $unidad_medida,	
		   'ind_formula' 	=> $formula,	
		   'ind_nivel' 		=> $nivel,	
		   'ind_evidencia'	=> $evidencia,	
		   'ind_estado' 	=> $estado		
		);
		
		 
	    $res = $this->db->insert('tbl_indicadores',$arrayDatos );  		
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
					 'estado' => $res
					);		
		}
	 
       return $resultado;
      
    }
	
	public function agregar_rel_uni_ind($id_indicador,$id_depend){
    	
		$arrayDatos =  array (
		   'ind_id'	=> $id_indicador,
		   'idDepend'	=> $id_depend		   
		);
		
		 
	    $res = $this->db->insert('rel_indicadores_unidades',$arrayDatos );  		
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
	
	public function conseguir_indicador($id_indicador){
		
		 
	    $res = $this->db->query("SELECT * FROM `tbl_indicadores` WHERE ind_id =  $id_indicador ");  	
		$array = $res->result_array();		 
		 
			
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}else 
		{
			//$_SESSION['verifica_agregarContingencia'] == '1' ;
		   
			$res =  $this->db->affected_rows() == 1 ?  true : false;		
	
		}
	 
       return $array;
      
    }
	
	
	public function editar_indicador_general($id,$indicador,$tipo,$unidad_medida,$formula,$nivel,$evidencia,$estado){
    	
		$arrayDatos =  array (
		   'ind_indicador'	=> $indicador,
		   'ind_tipo' 		=> $tipo,
		   'med_id' 		=> $unidad_medida,	
		   'ind_formula' 	=> $formula,	
		   'ind_nivel' 		=> $nivel,	
		   'ind_evidencia'	=> $evidencia,	
		   'ind_estado' 	=> $estado		
		);
		
		 
		$this->db->where('ind_id', $id);
		$res = $this->db->update('tbl_indicadores', $arrayDatos);
		 
		
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
					 'estado' => $res
					);		
		}
	 
       return $resultado;
      
    }
	
	 public function eliminar_relaciones_indicadores($ind_id){
			
		//se borra el id de la tabla-relacion de Notificaciones-Unidades
		$this->db->where('ind_id', $ind_id);		 
		 
	    $res = $this->db->delete('rel_indicadores_unidades');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}			
	 
       return true;      
    }


	// para el listado de gestionar indicadores 
	 public function listarIndicadores(){
		
		$res =   $this->db->query("SELECT * FROM `tbl_indicadores` 
									inner join tbl_medidas_indicadores 
									on tbl_indicadores.med_id = tbl_medidas_indicadores.med_id ");		 
	    if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$array_indicadores = $res->result_array();			
		$nuevo_incidadores = $array_indicadores;
		
		for ($i=0; $i < count($array_indicadores) ; $i++) { 		
			$unidades = $this->listar_unidades_xIndicadores($array_indicadores[$i]['ind_id']);
			//$unidades_xIndicadores =array("unidades"=> $unidades );			
			array_push($nuevo_incidadores[$i], $nuevo['unidades']= $unidades);			
		}			
	 
       return $nuevo_incidadores;      
    }	 
	
     //funcion utilizada por listarIndicadores()
     public function listar_unidades_xIndicadores($ind_id){
		
		$res =   $this->db->query("SELECT dependencia.desDepend FROM `rel_indicadores_unidades`  INNER JOIN dependencia
									on rel_indicadores_unidades.idDepend= dependencia.idDepend
									WHERE `ind_id` = $ind_id");
		$array = $res->result_array();			
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$unidades = array();
		foreach ($array as $key => $value) {
			array_push($unidades , $value['desDepend']);
		}	 
       return $unidades;      
    }
	 
	 
	  public function listarIndicadores_filtrados($indicador, $id_unidad_medida, $id_estado, $tipo, $id_unidad){	
		
		//para nombre de indicador
		if($indicador == '_todas_') {
			$sql_indicador =  "ind_indicador like '%%'";
		}else {
			$sql_indicador =  "ind_indicador like '%$indicador%'";
		}
		
		//para tipo de unidad de medida
		if($id_unidad_medida == '_todas_') {
			$sql_medida =  " ";
		}else {
			$sql_medida =  "and tbl_indicadores.med_id  = $id_unidad_medida";
		} 
		
		//para estado, habilitado, inhabilitado
		if($id_estado == '_todas_') {
			$sql_estado =  " ";
		}else {
			$sql_estado =  "and ind_estado  = $id_estado";
		} 
		
		//para tipo
		if($tipo == '_todas_') {
			$sql_tipo =  " ";
		}else if ($tipo == 'SGA')  {
			$sql_tipo =  "and ind_tipo  = 'SGA'";
		} else if ($tipo == 'SGC')  {
			$sql_tipo =  "and ind_tipo  = 'SGC'";
		} else if ($tipo == 'SGSST')  {
			$sql_tipo =  "and ind_tipo  = 'SGSST'";
		} 
		
		
		if ($id_unidad == '_todas_') {
			$res =   $this->db->query("SELECT * FROM `tbl_indicadores` 
									inner join tbl_medidas_indicadores 
									on tbl_indicadores.med_id = tbl_medidas_indicadores.med_id 
									where $sql_indicador $sql_medida $sql_estado $sql_tipo");	
		}else {
			$res =   $this->db->query("SELECT * FROM `tbl_indicadores` inner join tbl_medidas_indicadores 
					on tbl_indicadores.med_id = tbl_medidas_indicadores.med_id 
					INNER join rel_indicadores_unidades 
					on rel_indicadores_unidades.ind_id = tbl_indicadores.ind_id
					where $sql_indicador $sql_medida $sql_estado $sql_tipo 
					and rel_indicadores_unidades.idDepend = $id_unidad");				
			
		}	
		
		
		 
	    if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$array_indicadores = $res->result_array();			
		$nuevo_incidacores = $array_indicadores;
		
		for ($i=0; $i < count($array_indicadores) ; $i++) {			
			
				$unidades = $this->listar_unidades_xIndicadores($array_indicadores[$i]['ind_id']);
				//$unidades_xIndicadores =array("unidades"=> $unidades );			
				array_push($nuevo_incidacores[$i], $nuevo['unidades']= $unidades);	
					
		}			
	 
       return $nuevo_incidacores;      
    }
    
	 public function eliminar_indicador_general($ind_id){
	 		 		
	 	//primero borro las relaciones
		$res = $this->eliminar_relaciones_indicadores($ind_id)  ;
		
		if ($res == false )	{
			return false;
		}else {
				
			//se el indicador general
			$this->db->where('ind_id', $ind_id);		 
			 
		    $res = $this->db->delete('tbl_indicadores');
			if (!$res)
			{
			  $error = $this->db->error(); // Has keys 'code' and 'message'
			  echo "$error[message]";
			  return false;
			}			
		 
	       return true;    
	   
		}	   
    }
	 
// ============= listado para la tabla de unidades de medida del modal =========================
	public function listarUnidadesMedidas_modal(){
		
		$res =   $this->db->query("SELECT * FROM `tbl_medidas_indicadores` order by med_id asc");
        // print_rr($lst);       			 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}
		//$lst = $res->result_object();				
		$array_medidas = $res->result_array();		
		$nuevo_medidas = $array_medidas;
		
		for ($i=0; $i < count($array_medidas) ; $i++) {
			//comprueba si la unidad de medida esta en uso, en la tabla indicadores 		
			$uso = $this->comprobar_uso_unidadMedida($array_medidas[$i]['med_id']);
			//$unidades_xIndicadores =array("unidades"=> $unidades );			
			$nuevo_medidas[$i]['uso']= $uso;			
		}
				 
        return $nuevo_medidas;      
    }
	
	 //funcion utilizada por listarIndicadores()
     public function comprobar_uso_unidadMedida($med_id){
     			
		$res =   $this->db->query("SELECT * FROM `tbl_indicadores` WHERE `med_id` = $med_id  group by `med_id`");			
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}
				
		$cantidad_uso = $res->num_rows();
		
		//retorna 1: SI esta en uso
		//retorna 0: NO esta en uso		
		return $cantidad_uso;		    
    }
	 
	public function actualizar_unidad_medida($id , $medida) {
				
		$arrayDatos =  array (
	   'med_nombre'	=> $medida		 	
		);
					 
		$this->db->where('med_id', $id);
		$res = $this->db->update('tbl_medidas_indicadores', $arrayDatos);
		 
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  	return false;
		}else 
		{
			return true; 
		}       
	}
	
	 public function eliminar_unidad_medida($med_id){
			
		//se borra el id de la tabla-relacion de Notificaciones-Unidades
		$this->db->where('med_id', $med_id);		 
		 
	    $res = $this->db->delete('tbl_medidas_indicadores');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}			
	 
       return true;      
    }
	 
	
	// ===== para el ingreso de indicadores ============================================================
	
	//Para comprobar los indicadores, Disponibles de acuerdo a la unidad
	 public function listar_indicadores_xUnidad_disponibles($id_unidad){
		
		$res =   $this->db->query("SELECT * FROM `rel_indicadores_unidades` where idDepend = $id_unidad ");
		$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		 
       return $array;        
    }
	 
	  //comprueba si ya se creó , el registro del indicador por unidad, de acuerdo a la fecha
	  public function comprobar_indicadores_xFecha($id_unidad,$ind_id,$fecha_creacion){
		
		$res =   $this->db->query("SELECT * FROM `tbl_indicadores_unidad` where 
								idDepend = $id_unidad and  ind_id = $ind_id and 
								induni_fch_creacion = '$fecha_creacion'");
		//$array = $res->result_array();				 
	   
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	
		
		$cantidad= $res->num_rows();
		
		if ($cantidad == 1 ) {
			return true;			
		}else {
			//se crea en el registro en la tabla = tbl_indicadores_unidad		
				
			$arrayDatos =  array (
		   		'ind_id' => $ind_id	,
		   		'idDepend' => $id_unidad	,
		   		'induni_fch_creacion' => "$fecha_creacion"	,		   		
		   		'induni_estado' => 0   //0 = Pendiente , 1 = Ingresado		   			  
		  	);		
		 
	    	$res = $this->db->insert('tbl_indicadores_unidad',$arrayDatos );  	
			return true;			
		}	 
       
    }	
	
	
	//funcion utilizada listar indicadores por unidad y fecha(dataTable)
     public function listar_indicadores_xUnidad($id_unidad,$fecha_creacion){
		
		$res =   $this->db->query("SELECT * FROM `tbl_indicadores_unidad` INNER JOIN tbl_indicadores
									on tbl_indicadores_unidad.ind_id = tbl_indicadores.ind_id 
									where tbl_indicadores_unidad.idDepend = $id_unidad
									and tbl_indicadores_unidad.induni_fch_creacion = '$fecha_creacion'
									and tbl_indicadores.ind_estado = 1 ");
		//$array = $res->result_array();
	
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		
		
		$array = $res->result_array();
		return $array;      
    }
	

	public function obtener_indicador_especifico($induni_id){
		
		$res =   $this->db->query("SELECT * FROM `tbl_indicadores_unidad` INNER JOIN tbl_indicadores 
								on tbl_indicadores_unidad.ind_id = tbl_indicadores.ind_id 
								INNER JOIN tbl_medidas_indicadores 
								ON tbl_indicadores.med_id = tbl_medidas_indicadores.med_id 
								where tbl_indicadores_unidad.induni_id = $induni_id ");
		//$array = $res->result_array();
	
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}		
		
		$obj = $res->result_object();
		//$obj = $res->row();
		return $obj;      
    }
    
    public function  insertar_indicador_procesa ($id,$consumo,$nom_fichero= null) {
    		
    	date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
		$fecha = $fecha->format('Y-m-d');		
    		
    	
    	$arrayDatos =  array (
		   'induni_consumo'		=> $consumo,
		   'induni_fch_ingreso' => $fecha,
		   'induni_estado' 		=> 1  , //0 =  pendiente ,1=Ingresado
		   'induni_nom_fichero'	=> $nom_fichero  , //0 =  pendiente ,1=Ingresado
		     );
		 
		$this->db->where('induni_id', $id);
		$res = $this->db->update('tbl_indicadores_unidad', $arrayDatos);
		 
		
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else 
		{
			//$_SESSION['verifica_agregarContingencia'] == '1' ;
		   
			$res =  $this->db->affected_rows() == 1 ?  true : false;
			return true;
		}
	     	
    }
	
	
	//============PARA LOS REPORTES ================00000
      
      //obtiene solo los años donde hay datos , para hacer el reporte
      public function  obtener_anos () {
    		
    	$res =   $this->db->query("SELECT year(`induni_fch_creacion`) as ano FROM 
									`tbl_indicadores_unidad` 
									where `induni_estado` = 1 
									GROUP by year(induni_fch_creacion)");		
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
	  
	 public function  reporte_trimestres ($id_unidad, $mes, $ano , $tipo) {
	 	
		if($tipo == '_todas_') {
			$sql_tipo = '';
		}else {
			$sql_tipo = "AND ind_tipo = '$tipo'" ;
		}		
    		
    	$res1 =   $this->db->query("SELECT * , sum(tbl_indicadores_unidad.induni_consumo) as consumo_total
    						      FROM `tbl_indicadores_unidad` inner join tbl_indicadores 
    						      ON tbl_indicadores.ind_id = tbl_indicadores_unidad.ind_id inner 
    						      JOIN tbl_medidas_indicadores 
    						      ON tbl_indicadores.med_id = tbl_medidas_indicadores.med_id 
    						      where YEAR(`induni_fch_creacion`) = '$ano' and `induni_fch_creacion` 
    						      BETWEEN '2016-01-00' AND '2016-03-30' and `ind_estado` = 1 
    						      and `idDepend` = $id_unidad     $sql_tipo
    						      group by tbl_indicadores.ind_id     						       
    						      ");
								  
	    $res2 =   $this->db->query("SELECT * , sum(tbl_indicadores_unidad.induni_consumo) as consumo_total
    						      FROM `tbl_indicadores_unidad` inner join tbl_indicadores 
    						      ON tbl_indicadores.ind_id = tbl_indicadores_unidad.ind_id inner 
    						      JOIN tbl_medidas_indicadores 
    						      ON tbl_indicadores.med_id = tbl_medidas_indicadores.med_id 
    						      where YEAR(`induni_fch_creacion`) = '$ano' and `induni_fch_creacion` 
    						      BETWEEN '2016-04-00' AND '2016-06-30' and `ind_estado` = 1 
    						      and `idDepend` = $id_unidad     $sql_tipo
    						      group by tbl_indicadores.ind_id     						       
    						      ");
    						      
    	  $res3 =   $this->db->query("SELECT * , sum(tbl_indicadores_unidad.induni_consumo) as consumo_total
    						      FROM `tbl_indicadores_unidad` inner join tbl_indicadores 
    						      ON tbl_indicadores.ind_id = tbl_indicadores_unidad.ind_id inner 
    						      JOIN tbl_medidas_indicadores 
    						      ON tbl_indicadores.med_id = tbl_medidas_indicadores.med_id 
    						      where YEAR(`induni_fch_creacion`) = '$ano' and `induni_fch_creacion` 
    						      BETWEEN '2016-07-00' AND '2016-09-30' and `ind_estado` = 1 
    						      and `idDepend` = $id_unidad     $sql_tipo
    						      group by tbl_indicadores.ind_id     						       
    						      ");
    						      
    	 $res4 =   $this->db->query("SELECT * , sum(tbl_indicadores_unidad.induni_consumo) as consumo_total
    						      FROM `tbl_indicadores_unidad` inner join tbl_indicadores 
    						      ON tbl_indicadores.ind_id = tbl_indicadores_unidad.ind_id inner 
    						      JOIN tbl_medidas_indicadores 
    						      ON tbl_indicadores.med_id = tbl_medidas_indicadores.med_id 
    						      where YEAR(`induni_fch_creacion`) = '$ano' and `induni_fch_creacion` 
    						      BETWEEN '2016-10-00' AND '2016-12-30' and `ind_estado` = 1 
    						      and `idDepend` = $id_unidad     $sql_tipo
    						      group by tbl_indicadores.ind_id     						       
    						      ");				    
		
		
				
		if (!$res1  || !$res2 || !$res3 || !$res4  )
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else 
		{
					   
			$array1 = $res1->result_array();	
			$array2 = $res2->result_array();	
			$array3 = $res3->result_array();	
			$array4 = $res4->result_array();
			
			$trimestres = array();
			
			array_push($trimestres, $array1,$array2,$array3,$array4 );
			
			return $trimestres;
		}
	     	
    }
	 
	  public function  reporte_meses ($id_unidad, $mes, $ano , $tipo) {
	 	
		if($tipo == '_todas_') {
			$sql_tipo = '';
		}else {
			$sql_tipo = "AND ind_tipo = '$tipo'" ;
		}
		
    		
    	$res =   $this->db->query("SELECT *  FROM 
							`tbl_indicadores_unidad` inner join tbl_indicadores ON
							tbl_indicadores.ind_id = tbl_indicadores_unidad.ind_id
							inner JOIN tbl_medidas_indicadores ON
							tbl_indicadores.med_id = tbl_medidas_indicadores.med_id
							where  YEAR(`induni_fch_creacion`) =  '$ano' and 
							MONTH(`induni_fch_creacion`) =  '$mes' AND 
							`induni_estado` = 1  and `ind_estado`   and							 
							`idDepend` = $id_unidad
							$sql_tipo ");		
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
	 
	 
	   	
	
	
}