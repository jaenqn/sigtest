<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Sacp extends CI_Controller {

    function __construct() {
        parent::__construct();
		AppSession::logueado();

    }

    public function generar_sacp()
    {
    	$datos = array(
            'titulo_header' => 'Generar SACP'
            );

		  $tipo_usuario =  $this->session->userdata('tipo_usuario');
          $id_unidad    =	$this->session->userdata('id_unidad');

		 if ($tipo_usuario == 4 and $id_unidad == 17) {
		 	 //Listado de Unidades
			$this->load->model('Model_Unidad');
		    $lstUnidades = $this->Model_Unidad->listar();
		    $datos['lstUnidades'] = $lstUnidades;

			// Fecha de Reporte
		    date_default_timezone_set('America/Lima'); //establece la fecha para -5
			$fecha = new DateTime();
			$fecha->add(new DateInterval('P1D'));   //aumenta un día a la fecha
			$fecha_mas_dia = $fecha->format('Y-m-d');
			$datos['fecha'] = $fecha_mas_dia;



			 //Numero de sacp
			 $ano =  $fecha->format('Y');
			 $this->load->model('Model_Sacp');
			 $num_sacp = $this->Model_Sacp->obtener_numero_sacp($ano);
			 $datos['num_sacp'] = $num_sacp;


			$_SESSION['evitar_reload_generar_sacp'] = 0 ;


			$datos['ar_pages'] = array('<a href="listar">Listar </a>');
	        $this->smartys->assign($datos);
	        $this->smartys->render('generar_sacp');

		 }else {
		 	redirect('sacp/listar');
		 }


    }

	public  function generar_sacp_procesa ()
	{
		//is_ajax();$_SESSION['evitar_reload_generar_sacp']

		 $tipo_usuario =  $this->session->userdata('tipo_usuario');
         $id_unidad    =	$this->session->userdata('id_unidad');

		$datos = array(
            'titulo_header' => ' '
            );

		//evitar reload
		if( $_SESSION['evitar_reload_generar_sacp'] == 0 and $tipo_usuario == 4 and $id_unidad == 17 )  {

		$post = $this->input->post();


		//*******2 sede*******
		$selUnidad		= $post['selUnidad'];
		$fecha_sacp		= $post['fecha_sacp'];


		//*******1 Clasificacion*******
		$clasificacion	= $post['clasificacion'];  //1=No conformidad, 2=Observacion, 3=Oportunidad


		//*******2. Origen*******

				//para comprobar si se envia boton,hallazgo_tipo
				/*
				0 = CUANDO NO ESTA SELECCIONADO NINGUNO
				1 = Auditoría Interna
				2 =  Incumplimiento Legal
				3 =  Actividades Relacionadas al SGC / SGSST
				4 = Reporte de Incidencias/ Accidentes / Emergencias
				5 =  Auditoría Externa
				6 = Comunicaciones
				7 = Monitoreo Ambiental / SST
				8 = Quejas
				*/
		if( isset($post['hallazgo_tipo'])) {
			$hallazgo_tipo = 	$post['hallazgo_tipo'];
		} else{
			$hallazgo_tipo = 0;
		}

		if( (strlen($post['otro_hallazgo'])) != 0   ) {
			$otro_hallazgo = 	$post['otro_hallazgo']	;
		} else{
			$otro_hallazgo = null;
		}



		//*******3. Descripción*******

		$norma 		= $post['norma'];
		$requisito 	= $post['requisito'];
		$hallazgo   = $post['hallazgo'];
		$revisador_firma    = $post['revisador_firma'];
		$reportador_firma    = $post['reportador_firma'];

		//************FIN VARIABLES POST ***********

		 //Numero de sacp
		 date_default_timezone_set('America/Lima'); //establece la fecha para -5
		 $fecha = new DateTime();
		 $ano =  $fecha->format('Y');
		 $this->load->model('Model_Sacp');
		 $num_sacp = $this->Model_Sacp->obtener_numero_sacp($ano);


		$id_sacp = $this->Model_Sacp->insertar_sacp_generado($num_sacp,$selUnidad,$fecha_sacp,$clasificacion,$hallazgo_tipo,$otro_hallazgo,$norma,$requisito,$hallazgo,$revisador_firma, $reportador_firma);




	    if ($id_sacp != false) {
	    		//evitar reload
			  	$_SESSION['evitar_reload_generar_sacp'] = 1;

				//envia la notificacion del administrador (DESO) , a la dependencia de la sacp
				$id_unidad = $this->session->userdata('id_unidad'); //UNIDAD LOGEADA EN EL SISTEMA, DESO (ID_UNIDAD = 17)
				enviar_notificacion_sistema($selUnidad , $id_unidad , 10); //RECEPTORA, EMISORA, TIPO

				$datos['num_sacp'] = $num_sacp;
			  	$datos['estado'] = 'correcto';
				$datos['ar_pages'] = array('<a href="listar">Listar </a>');
		        $this->smartys->assign($datos);
		        $this->smartys->render('generar_sacp_exito');
	    }else {

				$datos['estado'] = 'malo';
				$datos['ar_pages'] = array('<a href="listar">Listar </a>');
		        $this->smartys->assign($datos);
		        $this->smartys->render('generar_sacp_exito');

	    }
	}//fin comprueba reload
  else {
  	   redirect('sacp/listar');

   }
 }


	//vista listar
	public function listar()  {
       $datos = array(
            'titulo_header' => 'Listado de SACP\'s'
            );

		$this->load->model('Model_Departamento','departamento');
		$datos['lstDepartamento'] = $this->departamento->listar();


        $this->smartys->assign($datos);
        $this->smartys->render('listar');
    }

		//para el datatable
	public function listar_sacp_general()   {

		$this->load->model('Model_Sacp');
	    $lstSacp= $this->Model_Sacp->listar_sacp();

		$output = array (
				'data' => $lstSacp
		);
		echo json_encode($output);

    }


	// =============== Revisar SACP ================================00

	 public function revisar_sacp($id_sacp = null)
    {
       $tipo_usuario =  $this->session->userdata('tipo_usuario');
       $id_unidad    =	$this->session->userdata('id_unidad');

    	if ($id_sacp != null )
		{
			$this->load->helper('form');

	        $datos = array(
	            'titulo_header' => 'Revisar SACP'
	            );

			$this->load->model('Model_Sacp');
			$sacp = $this->Model_Sacp->obtener_sacp_detalle($id_sacp);
			$datos['sacp'] = $sacp;
			//print_rr($sacp);exit;

			 //para capturar la fecha y hora
			date_default_timezone_set('America/Lima'); //establece la fecha para -5
			$fecha = new DateTime();
			$datos['fecha_actual'] = $fecha->format('Y-m-d');


			//==========Customización de elementos del formulario =======0

			 //Para imprimir la Unidad
			 $this->load->model('Model_Unidad');
			 $unidad = $this->Model_Unidad->get_departamento($sacp->idDepend);
			 $datos['unidad'] = $unidad->desDepend;



			//1 . Clasificacion
			if($sacp->sacp_1_clasificacion == 1) {
				$clasificacion_sacp = 'No conformidad';
			 }else if ($sacp->sacp_1_clasificacion == 2) {
				$clasificacion_sacp = 'Observación (Potencial No conformidad)';
			} else if ($sacp->sacp_1_clasificacion == 3) {
				$clasificacion_sacp = 'Oportunidad de Mejora';
			}else {
				$clasificacion_sacp = 'Sin ASIGNAR';
			}
			$datos['clasificacion_sacp'] = $clasificacion_sacp ;


			//2.Origen
			if ($sacp->sacp_2_hallazgo_texto != '') {

				$datos['origen_sacp'] = $sacp->sacp_2_hallazgo_texto ;
			}else {

					if($sacp->sacp_2_hallazgo_tipo == 1) {
						$tipo_hallazgo_sacp = 'Auditoría Interna';
					}
					else if ($sacp->sacp_2_hallazgo_tipo == 2) {
						$tipo_hallazgo_sacp = 'Incumplimiento Legal';
					}
					else if ($sacp->sacp_2_hallazgo_tipo == 3) {
						$tipo_hallazgo_sacp = 'Actividades Relacionadas al SGC / SGSST';
					}
					else if ($sacp->sacp_2_hallazgo_tipo == 4) {
						$tipo_hallazgo_sacp = 'Reporte de Incidencias/ Accidentes / Emergencias';
					}
					else if ($sacp->sacp_2_hallazgo_tipo == 5) {
						$tipo_hallazgo_sacp = 'Auditoría Externa';
					}
					else if ($sacp->sacp_2_hallazgo_tipo == 6) {
						$tipo_hallazgo_sacp = 'Comunicaciones';
					}
					else if ($sacp->sacp_2_hallazgo_tipo == 7) {
						$tipo_hallazgo_sacp = 'Monitoreo Ambiental / SST';
					}
					else if ($sacp->sacp_2_hallazgo_tipo == 8) {
						$tipo_hallazgo_sacp = 'Quejas';
					}

				$datos['origen_sacp'] = $tipo_hallazgo_sacp;
			}



			$datos['tipo_usuario'] = $tipo_usuario;
			$datos['id_unidad'] = $id_unidad;
			$this->smartys->assign($datos);
        	$this->smartys->render('revisar_sacp');


        }
		else {
			redirect('sacp/listar');
		}

    }//fin de función revisar sacp


	public function agregar_causa_ishikawa()  {

	  	$post = $this->input->post();

		$id_sacp= $post['id_sacp'];
		$tipo = $post['tipo'];
		$causa = $post['texto'];

		$this->load->model('Model_Sacp');
	    $res = $this->Model_Sacp->agregar_causa_ishikawa($id_sacp, $tipo,$causa);

		return $res;

    }

	public function agregar_causa_cinco_porque()  {

	  	$post = $this->input->post();

		$id_sacp= $post['id_sacp'];

		$tipo = 0;

		$preg_1 = $post['preg_1'];
		$resp_1 = $post['resp_1'];

		$preg_2 = $post['preg_2'];
		$resp_2 = $post['resp_2'];

		$preg_3 = $post['preg_3'];
		$resp_3 = $post['resp_3'];

		$preg_4 = $post['preg_4'];
		$resp_4 = $post['resp_4'];

		$preg_5 = $post['preg_5'];
		$resp_5 = $post['resp_5'];

		$causa_raiz = $post['causa_raiz'];


		//mando defrente el array al modelo
		$arrayDatos =  array (
		   'sacishi_tipo' => 0,//0 = sin tipo, para el tipo de 5 por qué
		   'sacishi_causa' => $causa_raiz,

		    'sacau_preg1' => $preg_1,
		    'sacau_resp1' => $resp_1,

			'sacau_preg2' => $preg_2,
		    'sacau_resp2' => $resp_2,

			'sacau_preg3' => $preg_3,
		    'sacau_resp3' => $resp_3,

			'sacau_preg4' => $preg_4,
		    'sacau_resp4' => $resp_4,

			'sacau_preg5' => $preg_5,
		    'sacau_resp5' => $resp_5,

		   'sacp_id' => $id_sacp


		);



		$this->load->model('Model_Sacp');
	    $res = $this->Model_Sacp->agregar_causa_cinco_porque($arrayDatos);

		return $res;

    }


	public function agregar_seguimiento_individual()  {

	  	$post = $this->input->post();

		$id_sacp= $post['id_sacp'];
		$accion = $post['accion'];
		$comentario =  trim($post['comentario']);

	    //para capturar la fecha y hora
		date_default_timezone_set('America/Lima'); //establece la fecha para -5
		$fecha = new DateTime();
		$fecha = $fecha->format('Y-m-d H:i');


		$this->load->model('Model_Sacp');
	    $res = $this->Model_Sacp->agregar_seguimiento($id_sacp, $accion,$comentario, $fecha);

		return $res;

    }


	 //lista las causas (ishikawa), de acuerdo a una sacp
	 public function listado_ishikawa_xSacp()
    {

		$post = $this->input->post();

		//asignaciones de variables
		$id_sacp= $post['id_sacp'];

		//$id_sacp = 1;

		$this->load->model('Model_Sacp');
		$lst_causas = $this->Model_Sacp->listado_ishikawa_xSacp($id_sacp);

		// print_rr($lst_causas);;
		 $lst_causas_nuevo = $lst_causas;

		 $i=0;
		 foreach ($lst_causas as $key => $value) {

			// print_rr($value);

			 if ($value['sacishi_tipo'] == 1 ) {
			 	$tipo_texto = 'Material';
			 }else if ($value['sacishi_tipo'] == 2 ) {
			 	$tipo_texto = 'Método';
			 }else if ($value['sacishi_tipo'] == 3 ) {
			 	$tipo_texto = 'Materiales';
			 } else if ($value['sacishi_tipo'] == 4 ) {
			 	$tipo_texto = 'Mano de Obra';
			 }else if ($value['sacishi_tipo'] == 5 ) {
			 	$tipo_texto = 'Ambiente';
			 }else  {
			 	$tipo_texto = 'Sin asignar';
			 }

			 $lst_causas_nuevo[$i]['tipo_texto'] =  $tipo_texto ;
			 $i++;

		 }

		echo json_encode($lst_causas_nuevo);

    }

 	public function listado_cinco_porque_xSacp()
    {

		$post = $this->input->post();

		//asignaciones de variables
		$id_sacp= $post['id_sacp'];

		//$id_sacp = 1;

		$this->load->model('Model_Sacp');
		$lst_causas = $this->Model_Sacp->listado_cinco_porque_xSacp($id_sacp);

		// print_rr($lst_causas);;
		 $lst_causas_nuevo = $lst_causas;


		echo json_encode($lst_causas_nuevo);

    }

	//lista todas las causas, tanto ishi como 5porque
	public function listado_causas_xSacp()
    {

		$post = $this->input->post();

		//asignaciones de variables
		$id_sacp= $post['id_sacp'];

		//$id_sacp = 1;

		$this->load->model('Model_Sacp');
		$lst_causas = $this->Model_Sacp->listado_causas_xSacp($id_sacp);

		// print_rr($lst_causas);;
		 //$lst_causas_nuevo = $lst_causas;


		echo json_encode($lst_causas);

    }





		public function listado_seguimiento_xSacp()
    {

		$post = $this->input->post();

		//asignaciones de variables
		$id_sacp= $post['id_sacp'];

		//$id_sacp = 1;

		$this->load->model('Model_Sacp');
		$lst_causas = $this->Model_Sacp->listado_seguimiento_xSacp($id_sacp);
		$lst_causas_nuevo = $lst_causas;


		foreach ($lst_causas as $key => $value) {

			$lst_causas_nuevo[$key]['sacseg_coment'] = $this->cortar_string ($lst_causas[$key]['sacseg_coment'], 16)." ...";

		}

		 //print_rr($lst_causas_nuevo);


		echo json_encode($lst_causas_nuevo);

    }


			//usada por fnc listado_seguimiento_xSacp, para recortar el comentario
			public function cortar_string ($string, $largo)
		    {


				 $marca = "<!--corte-->";

				   if (strlen($string) > $largo) {

				       $string = wordwrap($string, $largo, $marca);
				       $string = explode($marca, $string);
				       $string = $string[0];
				   }
				   return $string;

		    }

	//obtiene , detalles de una una causa (tipo cinco-porqué)
	public function obtener_cinco_porque()
    {

		$post = $this->input->post();

		//asignaciones de variables
		$id_sacishi= $post['id'];

		//$id_sacishi = 34;

		$this->load->model('Model_Sacp');
		$registro = $this->Model_Sacp->obtener_cinco_porque_especifico($id_sacishi);



		echo json_encode($registro);

    }

	//obtiene , detalles de un seguimiento
	public function obtener_seguimiento()
    {

		$post = $this->input->post();

		//asignaciones de variables
		$id_sacseg= $post['id_sacseg'];

		//$id_sacishi = 34;

		$this->load->model('Model_Sacp');
		$registro = $this->Model_Sacp->obtener_seguimiento_especifico($id_sacseg);



		echo json_encode($registro);

    }


	public function generar_diagrama_ishikawa_xSacp($id_sacp)
    {

		//$id_sacp = 1;
		 $datos = array(
	            'titulo_header' => 'Revisar SACP'
	            );

		$this->load->model('Model_Sacp');
		$lst_causas = $this->Model_Sacp->listado_ishikawa_xSacp($id_sacp);

		// print_rr($lst_causas);;
		 $lst_causas_nuevo = $lst_causas;

		// print_rr($lst_causas);exit;
		 $array_principal = array();


		  $array_principal['name'] = 'Efecto' ;


		  $array_principal['children'][0]['name'] = 'Materiales';
		  $array_principal['children'][1]['name'] = 'Ambiente';
		  $array_principal['children'][2]['name'] = 'Método';
		  $array_principal['children'][3]['name'] = 'Mano de Obra';
		  $array_principal['children'][4]['name'] = 'Material';

		  $indice_mats = 0;
		  $indice_amb = 0;
		  $indice_met = 0;
		  $indice_man = 0;
		  $indice_mat = 0;

		  for($i=0 ; $i < count($lst_causas) ; $i++) {


				//1 = material
				if ( ($lst_causas[$i]['sacishi_tipo']) == 1  ) {

					 $array_principal['children'][4]['children'][$indice_mat]['name'] = $lst_causas[$i]['sacishi_causa'] ;
					 $indice_mat++;

				}
				//2 = Metodo
				else if ( ($lst_causas[$i]['sacishi_tipo']) == 2 ) {

					 $array_principal['children'][2]['children'][$indice_met]['name'] = $lst_causas[$i]['sacishi_causa'] ;
					 $indice_met++;

				}//3 = Materiales
				else if ( ($lst_causas[$i]['sacishi_tipo']) == 3 ) {

					 $array_principal['children'][0]['children'][$indice_mats]['name'] = $lst_causas[$i]['sacishi_causa'] ;
					 $indice_mats++;


				}//4 = Mano de Obra
				else if ( ($lst_causas[$i]['sacishi_tipo']) == 4 ) {

					 $array_principal['children'][3]['children'][$indice_man]['name'] = $lst_causas[$i]['sacishi_causa'] ;
					 $indice_man++;

				}//Ambiente
				else if ( ($lst_causas[$i]['sacishi_tipo']) == 5 ) {

					 $array_principal['children'][1]['children'][$indice_amb]['name'] = $lst_causas[$i]['sacishi_causa'] ;
					 $indice_amb++;


				}else {
					//sin asignar
				}


		  }//fin for

		 $datos['datos_json'] =  json_encode( $array_principal )  ;


		$this->smartys->assign($datos);
        $this->smartys->render('diagrama_ishikawa_conagua');


    }

	//eliminar causa de la tabla de Ishikawa
	public function eliminar_causa_ishikawa () {

		$post = $this->input->post();
		$id 	= $post['id'];

		$this->load->model('Model_Sacp');
		$resultado = $this->Model_Sacp->eliminar_causa_ishikawa($id);
		return $resultado;

	}

	//eliminar causa de la tabla seguimiento
	public function eliminar_seguimiento () {

		$post = $this->input->post();
		$id 	= $post['id'];

		$this->load->model('Model_Sacp');
		$resultado = $this->Model_Sacp->eliminar_seguimiento($id);
		return $resultado;

	}


	//agrega todas las causas a una sacp, tanto
	//ishikawa como sacp
	public function agregar_causas_todas () {

		$post = $this->input->post();
		$id_sacp 	= $post['id_sacp'];

		$this->load->model('Model_Sacp');
		$resultado = $this->Model_Sacp->agregar_causas_todas($id_sacp);
		return $resultado;

	}


	public function respuesta()  {
       $datos = array(
            'titulo_header' => 'Listado de SACP\'s'
            );


        $this->smartys->assign($datos);
        $this->smartys->render('respuesta');
    }



	public function cerrar_sacp () {

		$post = $this->input->post();
		$id 	= $post['id'];

		$this->load->model('Model_Sacp');
		$resultado = $this->Model_Sacp->cerrar_sacp_individual($id);
		return $resultado;

	}


	// =============== SUBIDA DE ARCHIVOS DINAMICAMENTE  para las ================================00

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





	//esto será para aprobar incidencias
	 public function aprobar_rechazar_incidente()
    {
       $datos = array(
            'titulo_header' => 'Listado de Incidencias'
            );
		$this->load->model('Model_Incidencias');
		$post = $this->input->post();
		$id_incidente = $post['id_incidente'];
		$nom_aprobador = $post['aprobador_firma'];

			//print_rr($post);

		//acciones si el usuario aprueba
		if ( isset($post['aprobar_btn'])) {
			//echo "voy a aprobar";

			 $estado =  $this->Model_Incidencias->aprobar_rechazar_incidente($id_incidente,$nom_aprobador , 2 );

			 if($estado) {
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




       // $this->smartys->assign($datos);
        //$this->smartys->render('listar');
    }


















}