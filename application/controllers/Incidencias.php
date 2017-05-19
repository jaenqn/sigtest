<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Incidencias extends CI_Controller {

    function __construct() {
        parent::__construct();
		AppSession::logueado();
		$this->load->library('session');
    }

    public function reportar()
    {
    	$datos = array(
            'titulo_header' => 'Reporte de Incidente'
            );		
		 
		 //Listado de Departamentos
		 $this->load->model('Model_Departamento','departamento');
		 $datos['lstDepartamento'] = $this->departamento->listar();			 
		 //print_rr( $datos['lstDepartamento']);exit;
		 
		// Fecha de Reporte
	    date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
		$fecha_reporte = $fecha->format('Y-m-d'); 
		
				
		 //Numero de Incidente
		 $ano =  $fecha->format('Y'); 
		 $this->load->model('Model_Incidencias');
		 $num_incidencia = $this->Model_Incidencias->obtener_numero_incidencia($ano);	
		 
		 
		 //Listado de Causas inmediatas (Actos inseguros por defecto)
		 $this->load->model('Model_Incidencias');
		 $datos['lstCausas'] = $this->Model_Incidencias->listar_causas_inmediatas(1);			 
		 //print_rr( $datos['lstCausas']);exit;
		 //hacer el select
		 
		 //genera un id aletario
		$identificador_reporte  =   uniqid() ;
		
		//maximo tamaño en bytes permitido en el servidor
		$max_post_length = (int)(str_replace('M', '', ini_get('post_max_size')) * 1024 * 1024);		
		$maximo_megas = round($max_post_length / (1024*1024), 2);
		$datos['maximo_megas'] = $maximo_megas;
		
	
		
		
		$_SESSION['evitar_reload_incidencias'] = 0;	
		
		$datos['identificador_reporte'] =  $identificador_reporte;	
       
		$datos['num_incidencia'] = $num_incidencia;	
		$datos['fecha_reporte'] = $fecha_reporte;
		$datos['ar_pages'] = array('<a href="reportar">Reportar </a>');
        $this->smartys->assign($datos);
        $this->smartys->render('reportar_con_datos');
    }


	 //para listar dínamicamente las causas en el select multiple (AJAX)
	 //de acuerdo al tipo de sub-estandar
	 public function listar_sub_estandar()
    {
    	$post = $this->input->post();
		$id_sub_estandar = $post['id_sub_estandar'];
		
        $this->load->model('Model_Incidencias');
		$datos['lstCausas'] = $this->Model_Incidencias->listar_causas_inmediatas($id_sub_estandar);
		
		echo json_encode($datos['lstCausas']);
		 	
    }
	
	// =============== SUBIDA DE ARCHIVOS DINAMICAMENTE ================================00

	 public function evidencia_mostrar_archivos()
    {
    	   
		$post = $this->input->post();						
	
		//asignaciones de variables
		$id_reporte = $post['identificador'];
		$tipo = $post['tipo'];
		$this->load->model('Model_Incidencias');
		$lst_arhivos = $this->Model_Incidencias->listar_evidencia($id_reporte,$tipo);
		 
    	/*$directorio_escaneado = scandir('docs/evidencia_incidencias');
		$archivos = array();
		foreach ($directorio_escaneado as $item) {
		    if ($item != '.' and $item != '..') {
		        $archivos[] = $item;
		    }
		}*/
		echo json_encode($lst_arhivos);
		 	
    }

  public function evidencia_subir_archivo()
    {
    	//echo PATHINFO_EXTENSION;exit;
		
	    if(isset($_FILES['archivo'])) {
	    		    	
			$archivo = $_FILES['archivo'];
			
			$config['upload_path'] = 'docs/evidencia_incidencias/';
			$config['allowed_types'] = '*';
			$config['max_size'] = '20000';

			//concateno nombre de archivo + time + extension
					
			$time = time();
			$solo_nombre = pathinfo($archivo['name'], PATHINFO_FILENAME);
			$solo_nombre = url_title($solo_nombre, '_'); //separo por '_' los espacios en blancos
		    $extension = pathinfo($archivo['name'], PATHINFO_EXTENSION);
			
			
		    $nombre = "$solo_nombre" . "_" . "$time.$extension";
			$config['file_name'] = $nombre;

			$this->load->library('upload', $config);
			$this->config->set_item('language', 'spanish');
		
		//No se  subio correctamente el archivo
		if ( ! $this->upload->do_upload('archivo'))
		{					
			$error = $this->upload->display_errors();			
			echo $error ;			
		}
		else {
			//se subio fichero, ENTONCES SE REGISTRA EN LA BD
			
			
			$post = $this->input->post();						
		
			//asignaciones de variables
			$id_reporte = $post['identificador'];
			$nom_fichero = $nombre; //asignado arriba, al guardar el fichero
			$descripcion = $post['descripcion'];
			$tipo = $post['tipo'];
			//$tipo = 1 ; //para evidencia adicional , 2 para evidencia de respuesta
			
					
			$this->load->model('Model_Incidencias');
		    $id_evidencia = $this->Model_Incidencias->insertar_evidencia($id_reporte, $nom_fichero, $descripcion,$tipo);
			
			echo 1;
		}		
		
	}else {
		//echo "não tenho";
		echo 0 ;
	}
		 	
  }
    
      public function evidencia_subir_archivo_respuesta()
    {
    	//echo PATHINFO_EXTENSION;exit;
		
	    if(isset($_FILES['archivo_respuesta'])) {
	    		    	
			$archivo = $_FILES['archivo_respuesta'];
			
			$config['upload_path'] = 'docs/evidencia_incidencias/';
			$config['allowed_types'] = '*';
			$config['max_size'] = '20000';

			//concateno nombre de archivo + time + extension
					
			$time = time();
			$solo_nombre = pathinfo($archivo['name'], PATHINFO_FILENAME);
			$solo_nombre = url_title($solo_nombre, '_'); //separo por '_' los espacios en blancos
		    $extension = pathinfo($archivo['name'], PATHINFO_EXTENSION);
			
			
		    $nombre = "$solo_nombre" . "_" . "$time.$extension";
			$config['file_name'] = $nombre;

			$this->load->library('upload', $config);
			$this->config->set_item('language', 'spanish');
		
		//No se  subio correctamente el archivoa
		if ( ! $this->upload->do_upload('archivo_respuesta'))
		{					
			$error = $this->upload->display_errors();			
			echo $error ;			
		}
		else {
			//se subio fichero, ENTONCES SE REGISTRA EN LA BD
			
			
			$post = $this->input->post();						
		
			//asignaciones de variables
			$id_reporte = $post['identificador'];
			$nom_fichero = $nombre; //asignado arriba, al guardar el fichero
			$descripcion = $post['descripcion'];
			$tipo = $post['tipo'];
			//$tipo = 1 ; //para evidencia adicional , 2 para evidencia de respuesta
			
					
			$this->load->model('Model_Incidencias');
		    $id_evidencia = $this->Model_Incidencias->insertar_evidencia($id_reporte, $nom_fichero, $descripcion,$tipo);
			
			echo 1;
		}		
		
	}else {
		//echo "não tenho";
		echo 0 ;
	}
		 	
    }
    
			
	
	
	 public function evidencia_eliminar_archivo()
    {    	
				
	   if(isset($_POST['archivo'])) {
		    $archivo = $_POST['archivo'];
			    if (file_exists("docs/evidencia_incidencias/$archivo")) {
			        unlink("docs/evidencia_incidencias/$archivo");
					 $this->load->model('Model_Incidencias');
					//se elimina el registro de la BD 					  
		    		 $res = $this->Model_Incidencias->eliminar_evidencia($archivo);
					
					if ( $res == true) {
						 echo 1;						
					} else {
						echo 0;
					}				        
			    } else {
			        echo  0;
			    }
			}
	   return 2 ;
	   
	}
	
	
	 //
	 public function resumen()
    {
        $datos = array(
            'titulo_header' => 'Resumen de Incidentes'
            );
			
		$this->load->model('Model_Departamento','departamento');
		$lstDepartamento = $this->departamento->listar();
		
		//obtener los años donde existen datos 
		$this->load->model('Model_Incidencias');
		$lstAnos = $this->Model_Incidencias->obtener_anos();
		
				
		$datos['lstAnos'] =  $lstAnos;
		$datos['lstDepartamento'] =  $lstDepartamento;
        $this->smartys->assign($datos);
        $this->smartys->render('resumen');
    }
	
	 
	 public function revisar_incidente($id_incidente = null)
    {
    	if ($id_incidente != null) 
		{		
			$this->load->helper('form');
			
	        $datos = array(
	            'titulo_header' => 'Revisar Incidente'
	            );	
			
			$this->load->model('Model_Incidencias');
			$incidente = $this->Model_Incidencias->obtener_incidente($id_incidente);			
			$datos['incidente'] = $incidente;
			
			//obtengo los valores del indicador seleccionado
			foreach ($incidente  as $key ) {				
				$inc_tipo 	= $key['inc_tipo'];
				$inc_estado	= $key['inc_estado'];
				
				$id_selDepartamento	= $key['inc_selDepartamento'];
				$id_selUnidad= $key['inc_selUnidad'];
				
				$tipo_incidente= $key['inc_tipo_incidente'];
				
				$tipo_causa  = $key['inc_causa_inmediata_incidente'];
				
				$id_experiencia  = $key['inc_experiencia_involucrado'];
				
				
				$estado_incidente  = $key['inc_estado'];
				$estado_guardada  = $key['inc_estado_guardada'];
				
			}	
			
			//==========Customización de elementos del formulario =======0
			
			$datos['id_incidente'] = $id_incidente;
			
			
			//para los radios EVIDENCIA
			if($inc_tipo == 0) {
				$tipo_reporte = 'Incidente';
				
			 }else {
				$tipo_reporte = 'Accidente';
			}
			$datos['tipo_reporte'] = $tipo_reporte;
			
			
			//para el estado del incidente
			if($inc_estado == 1) {
				$estado = 'Pendiente';				
			 }else if ($inc_estado == 2){
				$estado = 'Aprobado';
			 }else if ($inc_estado == 3){
				$estado = 'Rechazado';
			}
			$datos['estado'] = $estado;
			
			 
			 //Para imprimir el Departament
			 $this->load->model('Model_Departamento','departamento');
			 $lstDepartamento = $this->departamento->listar();
			 foreach ($lstDepartamento as $key => $obj) {				
				if($obj->idDepend == $id_selDepartamento) {
					$departamento = $obj->desDepend;
					 break;
				}					
			 }		
			 $datos['departamento'] = $departamento;			 
			 
			 //Para imprimir la Unidad
			 $this->load->model('Model_Dependencia');
			 $lstUnidades = $this->Model_Dependencia->listarDependenciaUni($id_selDepartamento);
			 foreach ($lstUnidades as $key => $obj) {			 	
					if($obj->idDepend == $id_selUnidad) {
					$unidad = $obj->desDepend;
					 break;
				}					
			 }		
			 $datos['unidad'] = $unidad;
			
			 
			//para el tipo de Incidente
			if($tipo_incidente == 1) {
				$tipo_incidente = 'Seguridad';				
			 }else if ($tipo_incidente == 2){
				$tipo_incidente = 'Salud';
			 }else if ($tipo_incidente == 3){
				$tipo_incidente = 'Ambiental';
			 }else if ($tipo_incidente == 4){
				$tipo_incidente = 'Social';
			 }else {
			 	$tipo_incidente = 'Sin Asignar';
			 }
			
			$datos['tipo_incidente'] = $tipo_incidente;
			
			
			 
			//para el tipo de causa
			if($tipo_causa == 1) {
				$causa = 'Actos Inseguros';				 
			 }else if ($tipo_causa == 2){
				$causa = 'Condiciones Inseguras';
			 }else {
			 	$causa = 'Sin Asignar';
			 }
			
			$datos['causa'] = $causa;
			
			
			//Para el listado de causas
			 $this->load->model('Model_Incidencias');	
			 $datos['lstCausas'] = $this->Model_Incidencias->listar_causas_xIncidente($id_incidente);
			
			//para el tipo de Incidente
			if($id_experiencia == 1) {
				$experiencia = ' Menos de 6 Meses';				
			 }else if ($id_experiencia == 2){
				$experiencia = ' 6 Meses - 1 Año';
			 }else if ($id_experiencia == 3){
				$experiencia = ' 1 Año - 5 Años';
			 }else if ($id_experiencia == 4){
				$experiencia = ' Más de 5 Años ';
			 }else {
			 	$experiencia = 'Sin Asignar';
			 }
			 
			$datos['experiencia'] = $experiencia;
			
			
			//Para el listado de  testigos
			 $this->load->model('Model_Incidencias');	
			 $datos['lstTestigos'] = $this->Model_Incidencias->listar_testigos_xIncidente($id_incidente);
			 
			 //Para tabla de archivos de detalles adicionales
			 $this->load->model('Model_Incidencias');	
			 $datos['lstEvidencia_adicionales'] = $this->Model_Incidencias->listar_evidencias_xIncidente_adicionales($id_incidente);
			 
			  //Para tabla de archivos de detalles adicionales
			 $this->load->model('Model_Incidencias');	
			 $datos['lstEvidencia_adicionales'] = $this->Model_Incidencias->listar_evidencias_xIncidente_adicionales($id_incidente);
			 
			   //Para tabla de archivos de respuesta
			 $this->load->model('Model_Incidencias');	
			 $datos['lstEvidencia_respuesta'] = $this->Model_Incidencias->listar_evidencias_xIncidente_respuesta($id_incidente);
			
			
			
			 //Para imprimir input de  la firma , si esta pendiente 
		  	$inc_estado_firma_aprobador = $inc_estado;
			$datos['inc_estado_firma_aprobador'] = $inc_estado_firma_aprobador;
			
			
			$_SESSION['evitar_reload_incidencias'] = 0 ;			
		
	     	
			//para filtrar el tipo de usuario y ver si solamente está guardada 
			$tipo_usuario = $this->session->userdata('tipo_usuario');
			
			$datos['id_unidad_receptora'] = $id_selUnidad;
			$datos['inc_tipo'] = 	$inc_tipo ;
			$datos['tipo_usuario'] = $tipo_usuario;
			$datos['estado_guardada'] = $estado_guardada;
			
			if ($estado_guardada == 0  && $estado_incidente == 1  ) {
				//mostrar el revisar para poder enviar a las unidades respectivas deso o seguridad
				$this->smartys->assign($datos);
	       		$this->smartys->render('revisar_enviar');				
			}else if ($estado_guardada == 1  && $estado_incidente == 1  ) {
				//estado pendiente , esperando aprobacion o rechazo
				$this->smartys->assign($datos);
	       		$this->smartys->render('revisar');
				
			}else if ( $estado_incidente == 2 || $estado_incidente == 3 ) {
				//estado pendiente , esperando aprobacion o rechazo
				$this->smartys->assign($datos);
	       		$this->smartys->render('revisar');
				
			}
				
			
					
			//$datos['ar_pages'] = array('<a href="../listar">Listar </a>');
	        //$this->smartys->assign($datos);
	        //$this->smartys->render('revisar');
        }
		else {			
			redirect('incidencias/listar');			
		}
    }

	
	 //envia el incidente, para su aprobación o rechazo a deso o seguridad
	 public function enviar_incidente()
    {
       $datos = array(
            'titulo_header' => 'Listado de Incidencias'
            );
		$this->load->model('Model_Incidencias');	
		$post = $this->input->post();
		$id_incidente = $post['id_incidente'];
		$estado = $post['estado'];		
		$nom_revisador = $post['revisador_firma'];
		
		$inc_tipo = $post['inc_tipo'];
		
		
		$id_unidad = $this->session->userdata('id_unidad'); 
		
		//echo $id_unidad;
		
	    //print_rr($post); exit;
					
		//acciones si el usuario aprueba
		if ($id_incidente != null and $estado == 1 ) {		   
			//echo "voy a aprobar";	
			 																					//1 =Pendiente
			 $estado =  $this->Model_Incidencias->enviar_incidente($id_incidente,$nom_revisador , 1 );
			 
			 if($estado) {
			 		
					if ($inc_tipo == 0 ) {
						//notifica a DESO
						enviar_notificacion_sistema(17 , $id_unidad , 19);						
					}else if ($inc_tipo == 1) {
						//notifica a Seguridad
						enviar_notificacion_sistema(16 , $id_unidad ,  19);
						
					}
				
				
			 		$datos['estado'] = 'enviado';
			 		$datos['ar_pages'] = array('<a href="../listar">Listar </a>');
				    $this->smartys->assign($datos);		
        			$this->smartys->render('incidente_enviado_exito');
			 }
			
						
							
		}else {
			
			redirect('incidencias/listar');
		}
		
	
    }
	


	
	//vista listar
	 public function aprobar_rechazar_incidente()
    {
       $datos = array(
            'titulo_header' => 'Listado de Incidencias'
            );
		$this->load->model('Model_Incidencias');	
		$post = $this->input->post();
		$id_incidente = $post['id_incidente'];
		$nom_aprobador = $post['aprobador_firma'];
		
		$id_unidad_receptora = $post['id_unidad_receptora'];
		
		//print_rr($post);exit;
		
		
					
		//acciones si el usuario aprueba
		if ( isset($post['aprobar_btn'])) {		   
			//echo "voy a aprobar";	
			 	
			 $estado =  $this->Model_Incidencias->aprobar_rechazar_incidente($id_incidente,$nom_aprobador , 2 );
			 
			 if($estado) {
			 		
					//enviar notificacion de aprobacion a la unidad 
					enviar_notificacion_sistema($id_unidad_receptora , 17 , 20);
				
				
			 		$datos['estado'] = 'aprobado';
			 		$datos['ar_pages'] = array('<a href="../listar">Listar </a>');
				    $this->smartys->assign($datos);		
        			$this->smartys->render('incidente_exito');
			 }
			
						
		} else if (isset($post['rechazar_btn'])) {
							
			//echo "voy a rechazar";	
			 	
			 $estado =  $this->Model_Incidencias->aprobar_rechazar_incidente($id_incidente,$nom_aprobador , 3 );
			 
			 if($estado) {
			 		$datos['estado'] = 'rechazado';
			 		$datos['ar_pages'] = array('<a href="../listar">Listar </a>');
				    $this->smartys->assign($datos);		
        			$this->smartys->render('incidente_exito');
        			}
					
		}else {
			
			//redirect('incidencias/listar');
		}
		
	
    }
	


	//vista listar
	 public function listar()
    {
       $datos = array(
            'titulo_header' => 'Listado de Incidencias'
            );
			
		$this->load->model('Model_Departamento','departamento');
		$datos['lstDepartamento'] = $this->departamento->listar();			
	   
	
        $this->smartys->assign($datos);		
        $this->smartys->render('listar');
    }

	
	public  function registrar_reporte ()
	{
		//is_ajax();$_SESSION['evitar_reload_incidencias']
	
	if( $_SESSION['evitar_reload_incidencias'] == 0 )  {
		
				
		$this->load->model('Model_Incidencias');
		
		$num_incidencia = $this->Model_Incidencias->obtener_numero_incidencia(2017); 
		//echo $num_incidencia;
		
		
		$post = $this->input->post();			
		//print_rr($post);
		
		$causa_subEstandar		= $post['causas_subEstandar'];	
				
		
		//*******Metadatos del Reporte*******		
		$tipo_reporte		= $post['tipo_reporte']; //0 = Incidente , 1 =Accidente
		$numero_incidente	= $post['numero_incidente'];
		$estado				= $post['estado'];  //1=pendiente, 2=Aprobado, 3=Rechazado
		$identificador_reporte = $post['identificador_reporte']; //de las imagenes
		
		//*******Datos de la Persona que Reporta*******
		$apellidos_reporte	= $post['apellidos_reporta']; 
		$empresa_reporta 	= $post['empresa_reporta'];
		$ocupacion_reporta 	= $post['ocupacion_reporta'];
		$selDepartamento   	= $post['selDepartamento'];
		$selUnidad		    = $post['selUnidad'];
		
		//Fecha Reporte Para que el usuario no cambie del input, readonly
	    date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
 	    $fecha_reporte = $fecha->format('Y-m-d'); //--->Esto irá a la BD
		
		$fichaDni_reporta	= $post['fichaDni_reporta'];		
		$edad_reporta 		= $post['edad_reporta'];
		
		
		//*******Detalles del Incidente*******
		
		$fechaHora_incidente	= $post['fechaHora_incidente'];
		$locacion_incidente		= $post['locacion_incidente'];
		$area_incidente			= $post['area_incidente'];
		$tipo_incidente			= $post['tipo_incidente'];//1=Seguridad, 2=Salud, 3=Ambiente, 4=Social
		$causa					= $post['causas'];  //tipo de causa inmmediata, 1=actos , 2=condiciones
		
		//array, del select multiple
		//llamar a una función, para el ingreso múltiple
		$causa_subEstandar		= $post['causas_subEstandar'];		
		
		
		//*******Personas involucradas del Incidente*******
		$apellidos_involucrado	= $post['apellidos_involucrado'];
		$fichaDni_involucrado	= $post['fichaDni_involucrado'];
		$edad_involucrado 		= $post['edad_involucrado'];
		$empresa_involucrado 	= $post['empresa_involucrado'];
		$ocupacion_involucrado  = $post['ocupacion_involucrado'];		
		$departamento_involucrado = $post['departamento_involucrado'];
		$experiencia_involucrado = $post['experiencia_involucrado']; //1=Menos de 6 Meses,
																	 //2=6 Meses - 1 Año,
																	 //3= 1 Año - 5 Años
																	 //4= más de 5años
		//Para la lista de testigos
		$testigo			= $post['testigo']; //guardado más abajo		
		
		
		//*******Descripción del Incidente*******
		$dondeComo = $post['dondeComo'];
		$queHaciendo = $post['queHaciendo'];
		$queSucedio = $post['queSucedio'];
		$adicionales = $post['adicionales'];
		
		//*******Respueta del Incidente*******
		$respuesta = $post['respuesta'];
		
		
		//*******Firmas del Incidente*******
		$reportador_firma = $post['reportador_firma'];
		$revisador_firma = $post['revisador_firma'];
		//$Obj_inc->inc_revisador_firma = $post['revisador_firma'];
		//$Obj_inc->inc_aprobador_firma = $post['aprobador_firma'];
		
		//************FIN VARIABLES POST ***********
		
		//Obtener Numero de  Reporte
		$ano = $fecha->format('Y');
		$inc_numero = $this->Model_Incidencias->obtener_numero_incidencia($ano); 
		
		
		$arrayDatos =  array (
		   'inc_tipo' => $tipo_reporte,
		   'inc_numero' => $inc_numero,		
		      
		   'inc_apellidos_reporta'	=> $apellidos_reporte,
		   'inc_empresa_reporta'	=> $empresa_reporta,
		   'inc_ocupacion_reporta'	=> $ocupacion_reporta,
		   'inc_selDepartamento'	=> $selDepartamento,
		   'inc_selUnidad'			=> $selUnidad,
		   'inc_fch_reporte'		=> $fecha_reporte,
		   'inc_fichaDni_reporta'	=> $fichaDni_reporta,
		   'inc_edad_reporta'		=> $edad_reporta,
		   
		   'inc_fechaHora_incidente'=> $fechaHora_incidente,
		   'inc_locacion_incidente' => $locacion_incidente,
		   'inc_area_incidente'		=> $area_incidente,
		   'inc_tipo_incidente'		=> $tipo_incidente,
		   'inc_causa_inmediata_incidente'	=> $causa,
		   
		   'inc_apellidos_involucrado'	=> $apellidos_involucrado,
		   'inc_fichaDni_involucrado'	=> $fichaDni_involucrado,
		   'inc_edad_involucrado'		=> $edad_involucrado,
		   'inc_empresa_involucrado'	=> $empresa_involucrado,
		   'inc_ocupacion_involucrado'	=> $ocupacion_involucrado,
		   'inc_departamento_involucrado'	=> $departamento_involucrado,
		   'inc_experiencia_involucrado'	=> $experiencia_involucrado,
		   
		   'inc_dondeComo'			=> $dondeComo,
		   'inc_queHaciendo'		=> $queHaciendo,
		   'inc_queSucedio'			=> $queSucedio,
		   'inc_adicionales'		=> $adicionales,
		   'inc_respuesta'			=> $respuesta,
		   
		   'inc_reportador_firma'	=> $reportador_firma,
		   //'inc_revisador_firma'	=> $revisador_firma,
		  		     
		);
		
		//evitar reload
		$_SESSION['evitar_reload_incidencias'] = 1;			  			 	
		$id_incidente = $this->Model_Incidencias->insertar_reporte($arrayDatos); 
		$inc_numero ; //numero del incidente
		
		
		//Para la lista de testigos, guardado en tbl_incidencias_testigos
		$testigo  = $post['testigo'];
		
		//insertado de los testigos, solo si el input tiene datos		
		for ($i=1; $i < count($testigo) ; $i++) { 			
			if ( $testigo[$i] != ''){								   
				   $res = $this->Model_Incidencias->insertar_testigo($id_incidente , $testigo[$i]);
			} 
		}
		
		//insertado de las evidencias(ficheros), en la tabla relacional
		//con el id,generado para las imagenes y el id, del incidente insertado
		 $estado_ficheros = $this->Model_Incidencias->insertar_evidencia_relacion($id_incidente , $identificador_reporte);
		 
		 //insertado de las causas, subestandares
		//con el id,generado para las imagenes y el id, del incidente insertado
		 $estado_causas = $this->Model_Incidencias->insertar_causas_relacion($id_incidente , $causa_subEstandar);		
		
		 $datos = array(
            'titulo_header' => ' '
            );
		
	    if ($id_incidente && $estado_ficheros==true &&  $estado_causas==true) {
			  		
				$datos['inc_numero'] = $inc_numero; 	  
			  	$datos['estado'] = 'correcto';
				$datos['ar_pages'] = array('<a href="reportar">Reportar </a>');
		        $this->smartys->assign($datos);
		        $this->smartys->render('reportar_exito');			
	    }else {
	    	
				$datos['estado'] = 'malo';
				$datos['ar_pages'] = array('<a href="reportar">Reportar </a>');
		        $this->smartys->assign($datos);
		        $this->smartys->render('reportar_exito');
			
	    }
	}//fin comprueba reload
  else {
  	   redirect('Incidencias/reportar');
	
   } 	
 }
	
	//para el datatable
	public function listar_incidencias_general()   {      
			
		$this->load->model('Model_Incidencias');		
	    $lstIncidencias = $this->Model_Incidencias->listar_incidencias(); 
		
		$output = array (
				'data' => $lstIncidencias
		);		
		echo json_encode($output);
	
    }	
	
	
	public function eliminar_incidencia_general($id_incidente= null) {
		
		
		if ($id_incidente == null) {
			return false;
		}else {
			
				$tipo_usuario = $this->session->userdata('tipo_usuario'); 
			   
			   if ($tipo_usuario == 1  ) {
			   		
					echo 'no_permiso';
					return ;
				
			   } else {
			   	
					$this->load->model('Model_Incidencias');
					$resultado = $this->Model_Incidencias->eliminar_incidencia_general($id_incidente);
					echo 'Si tiene permiso';
					return $resultado;
			   }			
		}
		
	}
	
	
	
	public function ver_incidente()   {      
			
		$this->load->model('Model_Incidencias');		
	    $lstIncidencias = $this->Model_Incidencias->listar_incidencias(); 
		
		$output = array (
				'data' => $lstIncidencias
		);		
		echo json_encode($output);	
    }
	
	
	
	public function filtros_tabla_incidencias($num_incidente ='_todas_' , $fecha_reporte="_todas_" ,  $fecha_incidente='_todas_', $tipo_reporte="_todas_", $tipo_incidente='_todas_',  $causa='_todas_', $selDepartamento='_todas_', $selUnidad='_todas_', $estado='_todas_')
    {
    	$post 			  = $this->input->post();	
    		
    	$this->load->model('Model_Incidencias');		
	    $lstIncidencias = $this->Model_Incidencias->listar_incidencias_filtrados($num_incidente, $fecha_reporte, $fecha_incidente, $tipo_reporte, $tipo_incidente,$causa, $selDepartamento, $selUnidad, $estado ); 		
		
		
		
		 $output = array(                  
	                "data" =>  $lstIncidencias
	                ); 
					
		echo json_encode($output);
	   
    }
	
		

	public function obtener_numero_reporte() {
	
	
	echo "hola";
	}


	public function resumen_general()
    {
    	$post 			  = $this->input->post();	
		
		$ano 	 = 	$post['ano'];
		$id_depa = 	$post['id_departamento'];
		$id_uni  = 	$post['id_unidad'];
		
		//$ano='_todas_' ; $id_depa = '_todas_'; $id_uni='_todas_';
    		
    	$this->load->model('Model_Incidencias');		
	    $lstIncidencias = $this->Model_Incidencias->resumen_general($ano, $id_depa, $id_uni ); 			
					
		echo json_encode($lstIncidencias);
	   
    }
  
  
   //para el reporte Excel, accidentes, incidentes
   public function excel_reporte_accid_incid ($ano="_todas_", $id_depa ='_todas_', $id_uni ='_todas_' , $titulo_resumen) {
	//public function excel_reporte_accid_incid ( ) {
       $this->load->library('excel');

		$titulo_resumen = urldecode($titulo_resumen);

		//$ano='_todas_'; $id_depa= '_todas_' ;  $id_uni = '_todas_'; 
		
		//para la impresion  de años 
		if ($ano == '_todas_') {
			$ano_texto = 'General';
		}else {
			$ano_texto = $ano;
		}
		
		//obtiene nombre de unidad
		$this->load->model('Model_Incidencias');		
	    $lstIncidencias = $this->Model_Incidencias->resumen_general($ano, $id_depa, $id_uni ); 
		
		//print_rr($lstIncidencias);
		
		//$enero = $lstIncidencias['lstPendientes_incid'][0]['enero'];exit;
		
		//echo "soy enero $enero"; exit;
				  
	// Crea un nuevo objeto PHPExcel
	$objPHPExcel = new PHPExcel();
	
	// Leemos un archivo Excel 2007
	$objReader = PHPExcel_IOFactory::createReader('Excel2007');
	$objPHPExcel = $objReader->load("public/views/incidencias/plantillas/plantilla_resumen2.xlsx");
	
	// Agregar Informacion para el título
	 $objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('C1', $titulo_resumen)
	->setCellValue('E2', $ano_texto)
	->setCellValue('B6', $ano_texto);
	
	
	// PARA INCIDENTES- PENDIENTES
	$objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('D6', $lstIncidencias['lstPendientes_incid'][0]['enero'])
	->setCellValue('D7', $lstIncidencias['lstPendientes_incid'][0]['febrero'])
	->setCellValue('D8', $lstIncidencias['lstPendientes_incid'][0]['marzo'])
	->setCellValue('D9', $lstIncidencias['lstPendientes_incid'][0]['abril'])
	->setCellValue('D10', $lstIncidencias['lstPendientes_incid'][0]['mayo'])
	->setCellValue('D11', $lstIncidencias['lstPendientes_incid'][0]['junio'])
	->setCellValue('D12', $lstIncidencias['lstPendientes_incid'][0]['julio'])
	->setCellValue('D13', $lstIncidencias['lstPendientes_incid'][0]['agosto'])
	->setCellValue('D14', $lstIncidencias['lstPendientes_incid'][0]['septiembre'])
	->setCellValue('D15', $lstIncidencias['lstPendientes_incid'][0]['octubre'])
	->setCellValue('D16', $lstIncidencias['lstPendientes_incid'][0]['noviembre'])
	->setCellValue('D17', $lstIncidencias['lstPendientes_incid'][0]['diciembre'])
	->setCellValue('D18', $lstIncidencias['lstTotal_incid'][0]['pendiente']);
	
	// PARA INCIDENTES - APROBADOS
	$objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('E6', $lstIncidencias['lstAprobados_incid'][0]['enero'])
	->setCellValue('E7', $lstIncidencias['lstAprobados_incid'][0]['febrero'])
	->setCellValue('E8', $lstIncidencias['lstAprobados_incid'][0]['marzo'])
	->setCellValue('E9', $lstIncidencias['lstAprobados_incid'][0]['abril'])
	->setCellValue('E10', $lstIncidencias['lstAprobados_incid'][0]['mayo'])
	->setCellValue('E11', $lstIncidencias['lstAprobados_incid'][0]['junio'])
	->setCellValue('E12', $lstIncidencias['lstAprobados_incid'][0]['julio'])
	->setCellValue('E13', $lstIncidencias['lstAprobados_incid'][0]['agosto'])
	->setCellValue('E14', $lstIncidencias['lstAprobados_incid'][0]['septiembre'])
	->setCellValue('E15', $lstIncidencias['lstAprobados_incid'][0]['octubre'])
	->setCellValue('E16', $lstIncidencias['lstAprobados_incid'][0]['noviembre'])
	->setCellValue('E17', $lstIncidencias['lstAprobados_incid'][0]['diciembre'])
	->setCellValue('E18', $lstIncidencias['lstTotal_incid'][0]['aprobado']);
	
	// PARA INCIDENTES - RECHAZADOS
	$objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('F6', $lstIncidencias['lstRechazados_incid'][0]['enero'])
	->setCellValue('F7', $lstIncidencias['lstRechazados_incid'][0]['febrero'])
	->setCellValue('F8', $lstIncidencias['lstRechazados_incid'][0]['marzo'])
	->setCellValue('F9', $lstIncidencias['lstRechazados_incid'][0]['abril'])
	->setCellValue('F10', $lstIncidencias['lstRechazados_incid'][0]['mayo'])
	->setCellValue('F11', $lstIncidencias['lstRechazados_incid'][0]['junio'])
	->setCellValue('F12', $lstIncidencias['lstRechazados_incid'][0]['julio'])
	->setCellValue('F13', $lstIncidencias['lstRechazados_incid'][0]['agosto'])
	->setCellValue('F14', $lstIncidencias['lstRechazados_incid'][0]['septiembre'])
	->setCellValue('F15', $lstIncidencias['lstRechazados_incid'][0]['octubre'])
	->setCellValue('F16', $lstIncidencias['lstRechazados_incid'][0]['noviembre'])
	->setCellValue('F17', $lstIncidencias['lstRechazados_incid'][0]['diciembre'])
	->setCellValue('F18', $lstIncidencias['lstTotal_incid'][0]['rechazado']);
	
	
	// ========================================================
	
		// PARA ACCIDENTES - PENDIENTES
	$objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('G6', $lstIncidencias['lstPendientes_accid'][0]['enero'])
	->setCellValue('G7', $lstIncidencias['lstPendientes_accid'][0]['febrero'])
	->setCellValue('G8', $lstIncidencias['lstPendientes_accid'][0]['marzo'])
	->setCellValue('G9', $lstIncidencias['lstPendientes_accid'][0]['abril'])
	->setCellValue('G10', $lstIncidencias['lstPendientes_accid'][0]['mayo'])
	->setCellValue('G11', $lstIncidencias['lstPendientes_accid'][0]['junio'])
	->setCellValue('G12', $lstIncidencias['lstPendientes_accid'][0]['julio'])
	->setCellValue('G13', $lstIncidencias['lstPendientes_accid'][0]['agosto'])
	->setCellValue('G14', $lstIncidencias['lstPendientes_accid'][0]['septiembre'])
	->setCellValue('G15', $lstIncidencias['lstPendientes_accid'][0]['octubre'])
	->setCellValue('G16', $lstIncidencias['lstPendientes_accid'][0]['noviembre'])
	->setCellValue('G17', $lstIncidencias['lstPendientes_accid'][0]['diciembre'])
	->setCellValue('G18', $lstIncidencias['lstTotal_accid'][0]['pendiente']);
	
	
		// PARA accidentes- APROBADOS
	$objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('H6', $lstIncidencias['lstAprobados_accid'][0]['enero'])
	->setCellValue('H7', $lstIncidencias['lstAprobados_accid'][0]['febrero'])
	->setCellValue('H8', $lstIncidencias['lstAprobados_accid'][0]['marzo'])
	->setCellValue('H9', $lstIncidencias['lstAprobados_accid'][0]['abril'])
	->setCellValue('H10', $lstIncidencias['lstAprobados_accid'][0]['mayo'])
	->setCellValue('H11', $lstIncidencias['lstAprobados_accid'][0]['junio'])
	->setCellValue('H12', $lstIncidencias['lstAprobados_accid'][0]['julio'])
	->setCellValue('H13', $lstIncidencias['lstAprobados_accid'][0]['agosto'])
	->setCellValue('H14', $lstIncidencias['lstAprobados_accid'][0]['septiembre'])
	->setCellValue('H15', $lstIncidencias['lstAprobados_accid'][0]['octubre'])
	->setCellValue('H16', $lstIncidencias['lstAprobados_accid'][0]['noviembre'])
	->setCellValue('H17', $lstIncidencias['lstAprobados_accid'][0]['diciembre'])
	->setCellValue('H18', $lstIncidencias['lstTotal_accid'][0]['aprobado']);
	
	
	// PARA accidentes - RECHAZADOS
	$objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('I6', $lstIncidencias['lstRechazados_accid'][0]['enero'])
	->setCellValue('I7', $lstIncidencias['lstRechazados_accid'][0]['febrero'])
	->setCellValue('I8', $lstIncidencias['lstRechazados_accid'][0]['marzo'])
	->setCellValue('I9', $lstIncidencias['lstRechazados_accid'][0]['abril'])
	->setCellValue('I10', $lstIncidencias['lstRechazados_accid'][0]['mayo'])
	->setCellValue('I11', $lstIncidencias['lstRechazados_accid'][0]['junio'])
	->setCellValue('I12', $lstIncidencias['lstRechazados_accid'][0]['julio'])
	->setCellValue('I13', $lstIncidencias['lstRechazados_accid'][0]['agosto'])
	->setCellValue('I14', $lstIncidencias['lstRechazados_accid'][0]['septiembre'])
	->setCellValue('I15', $lstIncidencias['lstRechazados_accid'][0]['octubre'])
	->setCellValue('I16', $lstIncidencias['lstRechazados_accid'][0]['noviembre'])
	->setCellValue('I17', $lstIncidencias['lstRechazados_accid'][0]['diciembre'])
	->setCellValue('I18', $lstIncidencias['lstTotal_accid'][0]['rechazado']);
	
	
	
	//$objPHPExcel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');
	
	
	// Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
	$objPHPExcel->setActiveSheetIndex(0);	
	
	// Se modifican los encabezados del HTTP para indicar que se envia un archivo de Excel.
	header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
	header('Content-Disposition: attachment;filename="Resumen Incidentes.xlsx"');
	header('Cache-Control: max-age=0');
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	$objWriter->save('php://output');
	exit;
}
 

	

   

}