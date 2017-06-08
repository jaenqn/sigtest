<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Indicadores extends CI_Controller {

    function __construct() {
        parent::__construct();
	   $this->load->library('session');
	  // AppSession::logueado();
    }	
	
	public function index()
    {
		redirect('indicadores/gestionar');
    }
	

    public function agregar()
    {
    	
        $datos = array(
            'titulo_header' => 'Agregar Indicador de Desempeño'
            );
			
		//para evitar el reload
		$this->session->set_userdata('verifica_indicador_general', 0);				
    	
		$this->load->model('Model_Indicadores');
		$datos['lstUnidadesMedida'] = $this->Model_Indicadores->listarUnidadesMedidas();//para las de medidas 
		
		$this->load->model('Model_Unidad');		
	    $datos['lstUnidades'] = $this->Model_Unidad->listar();		
		
		//$datos['lstUnidades'] = $this->Model_Indicadores->listarUnidades();		         //para las de departamentos
		
		//para el Modal
		$this->load->model('Model_Indicadores');
		$datos['lstUnidadesMedida_modal'] = $this->Model_Indicadores->listarUnidadesMedidas_modal();//para las de medidas 
		
		//print_rr($datos['lstUnidadesMedida_modal']);
		
		$datos['ar_pages'] = array('<a href="gestionar">Gestionar </a> / <a href="agregar"> Agregar</a>');
        $this->smartys->assign($datos);
        $this->smartys->render('agregar');
    }
		
	
	 //
	 public function resumen()
    {
        $datos = array(
            'titulo_header' => 'Resumen de Incidentes'
            );
			
		$datos['ttu'] = 'resumen dato 1 ';
        $this->smartys->assign($datos);
        $this->smartys->render('resumen');
    }
	
	 
	 public function revisar($id = 0)
    {
        $datos = array(
            'titulo_header' => 'Revisar Reporte de Incidencia'
            );
			
		$datos['ttu'] = 'resumen dato 1 ';
        $this->smartys->assign($datos);
        $this->smartys->render('revisar');
    }

	//vista listar
	 public function gestionar()
    {
        $datos = array(
            'titulo_header' => 'Gestionar Indicadores'
            );	
			
		//cargar las unidades		
	   /* $this->load->model('Model_Reutilizables');
		$lstUnidades = $this->Model_Reutilizables->listar_unidadades_simple();*/
		
		$this->load->model('Model_Unidad');		
	    $lstUnidades = $this->Model_Unidad->listar();
		
		//print_r($lstUnidades);exit;
		//echo json_encode($lstUnidades);exit;
		
		 //cargar las unidades		
	    $this->load->model('Model_Indicadores');
		$lstUnidades_medidas = $this->Model_Indicadores->listarUnidadesMedidas(); 
		
		//$this->load->model('Model_Indicadores');		
	    //$lstUnidades = $this->Model_Indicadores->listarIndicadores_filtrados($indicador, $id_unidad_medida, $id_estado, $tipo, $id_unidad ); 		
		
		$datos['lstUnidades'] = $lstUnidades;
		$datos['lstUnidades_medidas'] = $lstUnidades_medidas;
		
		$datos['ar_pages'] = array('<a href="gestionar">Gestionar </a>');
        $this->smartys->assign($datos);
        $this->smartys->render('listar');
    }


	//para obtener los datos del formulario 
	public  function registrar_indicador ()
	{
		//is_ajax();
		
		 $datos = array(
            'titulo_header' => 'Listar Reportes de Incidencias'
            );
		
		$this->load->model('Model_Indicadores');	
		
		
		$post = $this->input->post();				
		//asignaciones de variables
		$indicador		= $post['indicador'];
		$tipo			= $post['tipo'];
		$unidad_medida	= $post['unidad_medida'];		
		$formula		= $post['formula'];
		$nivel			= $post['nivel'];
		$evidencia		= $post['evidencia'];
		$estado			= $post['estado_oculto'];				
		
	    $verifica_indicador_general = $this->session->userdata('verifica_indicador_general');		
		
		if ($verifica_indicador_general == 0 ) {
				
				$resultado = $this->Model_Indicadores->agregar_indicador($indicador,$tipo,$unidad_medida,$formula,$nivel,$evidencia,$estado); 
				$resultado['estado'] = true;	
		
				if (!$resultado['estado'])  {
					return false;
					echo "no se pudo registrar Indicador";
				}else{
					$id = $resultado['num_id'];			
					$responsables =   $post['responsables'];			
						
				
					 for ($i=0; $i < count($responsables) ; $i++) {
				 	
						$resultado = $this->Model_Indicadores->agregar_rel_uni_ind($id,$responsables[$i]); 		 	
					//echo $responsables[$i];			 
					 } 
				
					if ($resultado ){
						//todo se registro correctamente				
						
			     		$verifica_indicador_general = $this->session->set_userdata('verifica_indicador_general', 1);						
						//echo $verifica_indicador_general;
						
						 $datos = array(
				            'titulo_header' => 'Registro exitoso'
				            );			
						
						
						 $datos['ar_pages'] = array('<a href="gestionar">Gestionar </a> / <a href="agregar"> Agregar</a>');		
				         $this->smartys->assign($datos);						
		        		 $this->smartys->render('agregar_exito');		
						
					}
				}
			
		} else {
			//redireccionar para evitar el reload
			redirect('indicadores/agregar');
		}
	}

	//imprime el formulario con los datos correspondientes al indicador
    public function editar_formulario($id=null)
    {
    	 $datos = array(
            'titulo_header' => 'Listar Reportes de Incidencias'
            );		
		
    	if($id != null) {
    		
			//para evitar el reload
			$this->session->set_userdata('verifica_indicador_actualizado', 0);		
			
			$this->load->helper('form');
    		
			$this->load->model('Model_Indicadores');		
		    $indicador = $this->Model_Indicadores->conseguir_indicador($id); 		
			$datos['indicador'] = $indicador;
			
			//para el select de unidades
			$this->load->model('Model_Indicadores');
			$datos['lstUnidadesMedida'] = $this->Model_Indicadores->listarUnidadesMedidas();//para las de medidas 
			
			$this->load->model('Model_Unidad');		
	   		$datos['lstUnidades'] = $this->Model_Unidad->listar();		//para las de departamentos			
			
			//$datos['lstUnidades'] = $this->Model_Indicadores->listarUnidades();		         //para las de departamentos			
			
			//obtengo los valores del indicador seleccionado
			foreach ($indicador  as $key ) {				
				$id_indicador 	= $key['ind_id'];
				$tipo_indicador = $key['ind_tipo'];
				$med_id			= $key['med_id'];
				$ind_evidencia	= $key['ind_evidencia'];
				$ind_estado		= $key['ind_estado'];
			}	
			
			//para que cree el array de id y nombre del select = unidades de medida
			foreach ($datos['lstUnidadesMedida'] as $item) {
				$lista[$item['med_id']] = $item['med_nombre'];
			}			
			
			//string del select customizado 
			$dropdown = form_dropdown('unidad_medida', $lista, $med_id,"class='form-control' id='select_unidades'" );
			
			/* ========================================================== */
			
			//para que cree el array de id y nombre del select = Unidades/ de departamentos
			foreach ($datos['lstUnidades'] as $obj) {
				$lista_multiple[$obj->idDepend] = $obj->desDepend;
			}
			
			//print_r($lista_multiple); exit;
      		
			//obtiene en array  de las unidades / de departamentos seleccionadas
			$resultado_seleccionados = $this->Model_Indicadores->listarUnidades_seleccionadas($id_indicador);	
			
			
			
			//print_r($resultado_seleccionados); exit;
			
			$unidades_seleccionadas = array();
			foreach ($resultado_seleccionados  as $key ) {				
				array_push($unidades_seleccionadas, $key['idDepend']);				
			}
			
			//print_r($unidades_seleccionadas); exit;
			
			//	string del select multiple customizado
			$multiselect= form_dropdown('responsables[]', $lista_multiple, $unidades_seleccionadas , 'class="select2_multiple form-control" multiple="multiple"'  );
					
			
			//echo $multiselect;exit;
			
			//para los radios TIPO
			if($tipo_indicador == 'SGC') {
				$radio_tipo= form_radio('tipo', 'SGC', TRUE , 'class="flat"') . " SGC &nbsp;&nbsp;";
				$radio_tipo .= form_radio('tipo', 'SGA', FALSE , 'class="flat"') . " SGA &nbsp;&nbsp;";
				$radio_tipo .= form_radio('tipo', 'SGSST', FALSE , 'class="flat"') . " SGSST &nbsp;&nbsp;";
				
			} else if ($tipo_indicador == 'SGA') {
				$radio_tipo= form_radio('tipo', 'SGC', FALSE , 'class="flat"') . " SGC &nbsp;&nbsp;";
				$radio_tipo .= form_radio('tipo', 'SGA', TRUE , 'class="flat"') . " SGA &nbsp;&nbsp;";
				$radio_tipo .= form_radio('tipo', 'SGSST', FALSE , 'class="flat"') . " SGSST";
				
			} else {
				$radio_tipo= form_radio('tipo', 'SGC', FALSE , 'class="flat"') . " SGC &nbsp;&nbsp;";
				$radio_tipo .= form_radio('tipo', 'SGA', FALSE , 'class="flat"') . " SGA &nbsp;&nbsp;";
				$radio_tipo .= form_radio('tipo', 'SGSST', TRUE , 'class="flat"') . " SGSST";
			}
			
			
		 	//para los radios EVIDENCIA
			if($ind_evidencia == 0) {
				$radio_evidencia = form_radio('evidencia', '0', TRUE , 'class="flat"') . " No &nbsp;&nbsp;";
				$radio_evidencia .= form_radio('evidencia', '1', FALSE , 'class="flat"') . " Si &nbsp;&nbsp;";				
				
			 }else {
				$radio_evidencia = form_radio('evidencia', '0', FALSE , 'class="flat"') . " No &nbsp;&nbsp;";
				$radio_evidencia .= form_radio('evidencia', '1', TRUE , 'class="flat"') . " Si &nbsp;&nbsp;";				
			}
			
					
			if($ind_estado == 0) {
				$checkbox_estado = form_checkbox('estado', '1', FALSE , 'class="flat"') . " Activo &nbsp;&nbsp;";					
				
			 }else {
				$checkbox_estado = form_checkbox('estado', '1', TRUE , 'class="flat"') . " Activo &nbsp;&nbsp;";							
			}
			
			
			//echo $dropdown;exit;
			//echo $checkbox_estado;exit;
			
			//para el modal
			$datos['lstUnidadesMedida_modal'] = $this->Model_Indicadores->listarUnidadesMedidas_modal();
			
			$datos['dropdown'] = $dropdown;
			$datos['multiselect'] = $multiselect;
			$datos['radio_tipo'] = $radio_tipo;
			$datos['radio_evidencia'] = $radio_evidencia;
			$datos['checkbox_estado'] = $checkbox_estado;
			$datos['ar_pages'] = array("<a href='../gestionar'>Gestionar </a> / <a href='../editar_formulario/$id'> Editar</a>");	
			
			
			 $this->smartys->assign($datos);
		     $this->smartys->render('editar_formulario');	    		
    		
    	} else {
    		redirect('indicadores/listar');
    	}
    	
   
    }

 //obtienes los datos el formulario del indicador para registrar en la BD
 public  function editar_indicador_general ()
	{
		//is_ajax();
		
		 $datos = array(
            'titulo_header' => 'Listar Reportes de Incidencias'
            );
		
		$this->load->model('Model_Indicadores');	
		
		
		$post = $this->input->post();				
		//asignaciones de variables
		$id 			= $post['id_indicador'];
		$indicador		= $post['indicador'];
		$tipo			= $post['tipo'];
		$unidad_medida	= $post['unidad_medida'];		
		$formula		= $post['formula'];
		$nivel			= $post['nivel'];
		$evidencia		= $post['evidencia'];
	
		//para el checkbox del estado
		if (@$post['estado']) {
			$estado = 1;
		}else {
			$estado = 0;
		}		
		
	    $verifica_indicador_actualizado = $this->session->userdata('verifica_indicador_actualizado');	
		
		//$verifica_indicador_actualizado;
		
		if ($verifica_indicador_actualizado == 0 ) {
				
				$resultado = $this->Model_Indicadores->editar_indicador_general($id , $indicador,$tipo,$unidad_medida,$formula,$nivel,$evidencia,$estado); 
				$resultado['estado'] = true;	
		
				if (!$resultado['estado'])  {
					echo "no se pudo Actualizar Indicador";	
					return false;					
				}else{
					
					//eliminar todos las relaciones del indicador y unidades, se pasa id de indicador
					$resultado = $this->Model_Indicadores->eliminar_relaciones_indicadores($id); 		 
					if ($resultado) {				
							
						$responsables =   $post['responsables'];							
					
						 for ($i=0; $i < count($responsables) ; $i++) {
					 	
							$resultado = $this->Model_Indicadores->agregar_rel_uni_ind($id,$responsables[$i]); 		 	
						//echo $responsables[$i];			 
						 } 
					
						if ($resultado ){
							//todo se registro correctamente
							$this->session->set_userdata('verifica_indicador_actualizado', 1);
							
							 $datos = array(
					            'titulo_header' => 'Edición exitosa'
					            );			
							
							 $datos['ar_pages'] = array("<a href='gestionar'>Gestionar </a>");	
											
					         $this->smartys->assign($datos);
			        		 $this->smartys->render('editar_general_exito');		
							
						}
					}else {
						echo "no se pudo eliminar relaciones";
					}
				}
			
		} else {
			//redireccionar para evitar el reload
			redirect('indicadores/agregar');
		}
	}
 
 
 // ============= INGRESO DE INDICADORES   ESPECIFICOS=========================================================== 
     public function ingresar_indicador($id=null)
    {
		$datos = array(
		    'titulo_header' => 'Ingresar Indicadores'
		    );
			
		$this->load->helper('form');
			
   //==== para la unidad  =====	
		//$id_unidad = 2;	//************ cambiar por variable de session  
		$id_unidad = $this->session->userdata('id_unidad');	
		$this->load->model('Model_Unidad');	
	    $unidad = $this->Model_Unidad->get_departamento($id_unidad);
		 
  //==== para las fechas  =====	
  		date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
		$ano = $fecha->format('Y');			
		$mes = $fecha->format('m');	
		
		
		$ano_inicio = $ano  - 2 ; // 2 años menos 
		$ano_fin = $ano  + 1 ;   // 1 años más
		
		
		//crea el array de años
		$lst_anos = array();
		$anos = array();
		for ($i= $ano_inicio; $i <= $ano_fin; $i++) { 			
			$lst_anos[$i] = $i;			
			$ano_inicio++;	
		}		
		//cuando, mes actual es Enero, selecciona el año anterior automaticamente		
		if($mes == '01') {
			$ano  = $ano - 1 ;
		}
		$atributos_ano = "class='select-minimum form-control'  id='ano' ";		
		$select_anos = form_dropdown('ano', $lst_anos, $ano,$atributos_ano);
		
		
		//Para el array meses
		$lst_meses = array(
					'01' => 'Enero',
					'02' => 'Febrero',
					'03' => 'Marzo',
					'04' => 'Abril',
					'05' => 'Mayo',
					'06' => 'Junio',
					'07' => 'Julio',
					'08' => 'Agosto',
					'09' => 'Septiembre',
					'10' => 'Obtubre',
					'11' => 'Noviembre',
					'12' => 'Diciembre'					
 					);
					
		//cuando, mes actual es Enero, selecciona el mes anterior automaticamente		
		if($mes == '01') {
			$mes = '12';
		}else {
			//sino, restamos un mes			
			$fecha->sub(new DateInterval('P1M'));
   		    $mes =  $fecha->format('m');			
		}
		
		$atributos_mes = "class='select-minimum form-control'  id='mes' ";
		$select_meses = form_dropdown('mes', $lst_meses, $mes, $atributos_mes);	
		
		$datos['unidad'] = $unidad;
		$datos['select_anos'] = $select_anos;
		$datos['select_meses'] = $select_meses;
		$datos['ar_pages'] = array("<a href='ingresar_indicador'>Ingresar Indicador'</a>");
		$this->smartys->assign($datos);
		$this->smartys->render('ingresar_indicador');	  		

		
    }
	
	//para generar la tabla dínamica , para el (dataTable)
	public function listar_indicadores_xUnidad($ano, $mes) {		
		
		//ano y mes para comprobar si ya se creo, el regristro correspondiente
	 	$fecha_creacion = "$ano-$mes-00";	 
		 
		$id_unidad = $this->session->userdata('id_unidad');		
				
		$this->load->model('Model_Indicadores');			
	    $lstIndicadores = $this->Model_Indicadores->listar_indicadores_xUnidad_disponibles($id_unidad); 	
		
		//comprueba si existe el indicador de acuerdo al id_indicado,  id_unidad y  fecha_creacion
		//si no existe, se crea
		foreach ($lstIndicadores as $key => $value) {
			//print_rr($value);
			$id_indicador = $value['ind_id'];
			$this->Model_Indicadores->comprobar_indicadores_xFecha($id_unidad, $id_indicador, $fecha_creacion); 
		}

		//listado de indicadores por unidad de acuerdo a la fecha
		$lstIndicadores_fecha = $this->Model_Indicadores->listar_indicadores_xUnidad($id_unidad,$fecha_creacion); 
		
		 $output = array(                  
	                "data" =>  $lstIndicadores_fecha
	                ); 
		echo json_encode($output);			
	}

	
  public function ingreso_indicador_formulario($induni_id )
{
	 $datos = array(
        'titulo_header' => 'Ingresar Indicador'
        );
		
		date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
		$fecha = $fecha->format('Y-m-d');			
	
	
	  //Obtener datos
	  $this->load->model('Model_Indicadores'); 
	  $dtsIndicador = $this->Model_Indicadores->obtener_indicador_especifico($induni_id);
	  
	//maximo tamaño en bytes permitido en el servidor
	$max_post_length = (int)(str_replace('M', '', ini_get('post_max_size')) * 1024 * 1024);	
	$maximo_megas = round($max_post_length / (1024*1024), 2);

	

	 $datos['maximo_megas'] = $maximo_megas;	 
	 $datos['fecha']		= $fecha; 		  
	 $datos['dtsIndicador']	= $dtsIndicador;
	 //$datos['ruta_ficheros'] = DOCSPATH; //para la ruta de ficheros
	 $this->smartys->assign($datos);
	 $this->smartys->render('ingreso_indicador_especifico');	   		
		
}

  //para el indicador especifico	
  public function edicion_indicador_formulario($induni_id )
{
	 $datos = array(
        'titulo_header' => 'Editar Indicador'
        );
		
		date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
		$fecha = $fecha->format('Y-m-d');			
	
	
	  //Obtener datos
	  $this->load->model('Model_Indicadores'); 
	  $dtsIndicador = $this->Model_Indicadores->obtener_indicador_especifico($induni_id);	  
	  $copia_dtsIndicador =  $dtsIndicador;
	  
	//maximo tamaño en bytes permitido en el servidor
	$max_post_length = (int)(str_replace('M', '', ini_get('post_max_size')) * 1024 * 1024);	
	$maximo_megas = round($max_post_length / (1024*1024), 2);
	
	//nombre decoficicado
	foreach ($dtsIndicador as $key => $value) {		
		$nom_fichero =  urldecode($value->induni_nom_fichero);
	}
	
	 $datos['nom_fichero']  = $nom_fichero;
	 $datos['maximo_megas'] = $maximo_megas;	 
	 $datos['fecha']		= $fecha; 		  
	 $datos['dtsIndicador']	= $dtsIndicador;
	 //$datos['ruta_ficheros'] = DOCSPATH; //para la ruta de ficheros
	 $datos['ar_pages'] = array("<a href='../ingresar_indicador'>Ingresar Indicador</a> / <a href='../edicion_indicador_formulario/$induni_id'> Editar </a>");
	 $this->smartys->assign($datos);
	 $this->smartys->render('edicion_indicador_especifico');	   		
	
}

  public function ingreso_indicador_procesa()
{
	 $datos = array(
        'titulo_header' => 'Ingresar Indicador'
        );
			
	$post  = $this->input->post();
	$id      = 	$post['induni_id'];
	$consumo = $post['consumo'];	
	
	if (!is_numeric($consumo)) {
		echo $consumo; 
		echo " no es número"; exit;	
	}
	
	if(@$_FILES['userfile']['name']) {
	//Cuando el formulario tiene archivo;
		//ruta:
		$ruta = DOCSPATH . 'evidencia_indicadores' ;	
		$config['upload_path'] = $ruta;
		
		$config['allowed_types'] = '*';
		
		//tamaño:
		//maximo tamaño en bytes permitido en el servidor
		$max_post_length = (int)(str_replace('M', '', ini_get('post_max_size')) * 1024 * 1024);	
		$config['max_size'] = $max_post_length;
		
		//nombre
		//concateno nombre del fichero más el id del indicador especifico
		$newFileName = $_FILES['userfile']['name'];
				
			//devuelve la posición del último punto, número
			$pos_punto = strrpos($newFileName,'.');
			
			//devuelve solo nombre y  la extensión
			$nombre   =  substr($newFileName, 0 , $pos_punto);
			$extesion = substr($newFileName, $pos_punto);
		
		$nombre_fichero = $nombre ."_" . $id . $extesion ; //esto se guardará en la BD
		
		$nombre_fichero =  urlencode($nombre_fichero); //codifico para guardar en la BD
		
		
		$config['file_name'] = $nombre_fichero ;
		
		//sobreescritura
		$config['overwrite'] = true;
	
		$this->load->library('upload', $config);
		$this->config->set_item('language', 'spanish');
		
		//No se  subio correctamente el archivo
		if ( ! $this->upload->do_upload())
		{					
			$datos['error'] = $this->upload->display_errors();		
			$this->smartys->assign($datos);		
			$this->smartys->render("subida_error");
		}		
		
	}else {
		//echo "não tenho";
		$nombre_fichero = null;
	}	
	
	$this->load->model('Model_Indicadores');
	$res = $this->Model_Indicadores->insertar_indicador_procesa($id, $consumo,$nombre_fichero );
	
	$datos['ar_pages'] = array('<a href="ingresar_indicador">Ingresar Indicador </a>');
	$datos['tipo']	= "guardar"; //para mensaje de exito
	$this->smartys->assign($datos);
	$this->smartys->render('ingreso_indicador_exito');			
}


  public function edicion_indicador_procesa()
{
	 $datos = array(
        'titulo_header' => 'Edicion de  Indicador'
        );
			
	$post  = $this->input->post();
	$id      = 	$post['induni_id'];
	$consumo = $post['consumo'];	
	
	if (!is_numeric($consumo)) {
		echo $consumo; 
		echo " no es número"; exit;	
	}
	
	if(@$_FILES['userfile']['name']) {
	//Cuando el formulario tiene archivo;
		//ruta:
		$ruta = DOCSPATH . 'evidencia_indicadores' ;	
		$config['upload_path'] = $ruta;
		
		$config['allowed_types'] = '*';
		
		//tamaño:
		//maximo tamaño en bytes permitido en el servidor
		$max_post_length = (int)(str_replace('M', '', ini_get('post_max_size')) * 1024 * 1024);	
		$config['max_size'] = $max_post_length;
		
		//nombre
		//concateno nombre del fichero más el id del indicador especifico
		$newFileName = $_FILES['userfile']['name'];
				
			//devuelve la posición del último punto, número
			$pos_punto = strrpos($newFileName,'.');
			
			//devuelve solo nombre y  la extensión
			$nombre   =  substr($newFileName, 0 , $pos_punto);
			$extesion = substr($newFileName, $pos_punto);
		
		$nombre_fichero = $nombre ."_" . $id . $extesion ; //esto se guardará en la BD
		
		$nombre_fichero =  urlencode($nombre_fichero); //codifico para guardar en la BD
		
		
		$config['file_name'] = $nombre_fichero ;
		
		//sobreescritura
		$config['overwrite'] = true;
	
		$this->load->library('upload', $config);
		$this->config->set_item('language', 'spanish');
		
		//No se  subio correctamente el archivo
		if ( ! $this->upload->do_upload())
		{
			$datos['ar_pages'] = array('<a href="ingresar_indicador">Ingresar Indicador </a>');					
			$datos['error'] = $this->upload->display_errors();		
			$this->smartys->assign($datos);		
			$this->smartys->render("subida_error");
		}		
		
	}else {
		//no se subio fichero, entonces se asume el anterior
		//solo si, está permitido la subida de ficheros
		if(@$post['nom_fichero_antiguo']){
			$nombre_fichero = $post['nom_fichero_antiguo'];
		}else {
			$nombre_fichero  = null;			
		}
		
		
	}	
	
	$this->load->model('Model_Indicadores');
	$res = $this->Model_Indicadores->insertar_indicador_procesa($id, $consumo,$nombre_fichero );
	
	$datos['ar_pages'] = array('<a href="ingresar_indicador">Ingresar Indicador </a>');
	$datos['tipo']	= "guardar"; //para mensaje de exito
	$this->smartys->assign($datos);
	$this->smartys->render('ingreso_indicador_exito');			
}
	
	
	
	  public function reporte($id=null)
	{
		 $datos = array(
	        'titulo_header' => 'Reporte de Indicadores'
	        );
		$this->load->helper('form');
			
	    $this->load->model('Model_Unidad');		
		$datos['lstUnidades'] = $this->Model_Unidad->listar();	
		
		
		//==== para las fechas  =====	
  		date_default_timezone_set('America/Lima'); //establece la fecha para -5			
		$fecha = new DateTime();
		$ano = $fecha->format('Y');			
		$mes = $fecha->format('m');
		
		
		//crea el array de años, 
		//solo de registros disponibles en la BD
		$this->load->model('Model_Indicadores');
		$array_anos = $this->Model_Indicadores->obtener_anos();//devuelve array con los años		
			
		$lst_anos = array();
		for ($i= 0; $i < count($array_anos); $i++) { 			
			$ano_actual = $array_anos[$i]['ano'];
			$lst_anos[$ano_actual] = $ano_actual;
		}
		
				
		//cuando, mes actual es Enero, selecciona el año anterior automaticamente		
		if($mes == '01') {
			$ano  = $ano - 1 ;
		}
		$atributos_ano = "class='select-minimum form-control'  id='ano' ";		
		$select_anos = form_dropdown('ano', $lst_anos, $ano,$atributos_ano);
		$datos['select_anos'] =  $select_anos;		
				
		
		//Para el array meses
		$lst_meses = array(
					'01' => 'Enero',
					'02' => 'Febrero',
					'03' => 'Marzo',
					'04' => 'Abril',
					'05' => 'Mayo',
					'06' => 'Junio',
					'07' => 'Julio',
					'08' => 'Agosto',
					'09' => 'Septiembre',
					'10' => 'Obtubre',
					'11' => 'Noviembre',
					'12' => 'Diciembre'					
 					);
					
		//cuando, mes actual es Enero, selecciona el mes anterior automaticamente		
		if($mes == '01') {
			$mes = '12';
		}else {
			//sino, restamos un mes			
			$fecha->sub(new DateInterval('P1M'));
   		    $mes =  $fecha->format('m');			
		}
		
		$atributos_mes = "class='select-minimum form-control'  id='mes' ";
		$select_meses = form_dropdown('mes', $lst_meses, $mes, $atributos_mes);	
		
		//$datos['unidad'] = $unidad;
		$datos['select_meses'] = $select_meses;
		
		
			
		//obtiene los indicadores de acuerdo a la unidad
		  
				
		 $this->smartys->assign($datos);
		 $this->smartys->render('reporte');	   		
			
	}


  //lista los indicadores generales, personalizado para el dataTable	
		public function listado_indicadores_generales()
    {
    	$this->load->model('Model_Indicadores');		
	    $lstIndicadores = $this->Model_Indicadores->listarIndicadores(); 		
		$datos['lstIndicadores'] = $lstIndicadores;
		
		 $output = array(                  
	                "data" =>  $datos['lstIndicadores']
	                ); 
		echo json_encode($output);				
    }
	
	//http://usaii.atwebpages.com/index.php/reportes/reportes/json_obtener_cantidades_partidas
	
	
	//lista todas las unidades de acuerdo al id del indicador (para el datatable)
	public function filtros_tabla_gestionar($indicador='_todas_' , $tipo="_todas_" ,  $id_unidad='_todas_', $id_unidad_medida="_todas_", $id_estado='_todas_')
    {
    	$post 			  = $this->input->post();	
		
		
		if ($indicador == '_todas_') {
			$indicador='_todas_';
		}else {
			$indicador = urldecode($indicador);
		}
		
    		
    	$this->load->model('Model_Indicadores');		
	    $lstUnidades = $this->Model_Indicadores->listarIndicadores_filtrados($indicador, $id_unidad_medida, $id_estado, $tipo, $id_unidad ); 		
		
		
		
		 $output = array(                  
	                "data" =>  $lstUnidades
	                ); 
		echo json_encode($output);
	   
    }

	public function eliminar_indicador_general($id_indicador = null) {
		
		if ($id_indicador == null) {
			return false;
		}else {
			
			$this->load->model('Model_Indicadores');
			$resultado = $this->Model_Indicadores->eliminar_indicador_general($id_indicador);
			return $resultado;
		}
		
	}
	
	//======== para el MODAL ================================
	
	public function actualizar_unidad_medida () {
	
		$post = $this->input->post();
		$id 	= $post['id'];	
		$medida = $post['medida'];
				
		$this->load->model('Model_Indicadores');
		$resultado = $this->Model_Indicadores->actualizar_unidad_medida($id , $medida);
		return $resultado;
		
	}
   
   public function listar_unidades_medidas() {
   	   	
	$this->load->model('Model_Indicadores');
	$datos['lstUnidadesMedida'] = $this->Model_Indicadores->listarUnidadesMedidas();//para las de medidas 		
	//print_rr($datos['lstUnidadesMedida']); exit;	
	echo json_encode($datos['lstUnidadesMedida']);	
   }
   
   //agrega una nueva unidad de medida Dinamicamente
	public function agregar_unidadMedida() {
		
		$post = $this->input->post();
		$nombre = $post['unidad_nueva'];			
	
		$this->load->model('Model_Indicadores');
		$id_nueva_unidad = $this->Model_Indicadores->agregar_UnidadesMedidas($nombre);
		
		//echo $id_nueva_unidad;exit;		
		if($id_nueva_unidad) {
			 echo $id_nueva_unidad;
		} else {
			return false;
			//return $id_nueva_unidad;
		}		
		
	}
	
	public function eliminar_unidad_medida () {

		$post = $this->input->post();
		$id 	= $post['id'];			
				
		$this->load->model('Model_Indicadores');
		$resultado = $this->Model_Indicadores->eliminar_unidad_medida($id);
		return $resultado;
		
	}
	
  // ======================= PARA LOS REPORTES =========================== 
  
   
	public function reporte_meses () {

		$post = $this->input->post();
		
		$id_unidad	= $post['id_unidad'];
		$mes	= $post['mes'];
		$ano	= $post['ano'];	
		$tipo	= $post['tipo'];	
		
		//$id_unidad=13;$mes=12;$ano=2016;
		
		$this->load->model('Model_Indicadores');
		$resultado = $this->Model_Indicadores->reporte_meses($id_unidad, $mes, $ano, $tipo);
		
		echo json_encode($resultado);
		
	}
	
	public function reporte_trimestres () {

		$post = $this->input->post();
		
		$id_unidad	= $post['id_unidad'];
		$mes	= $post['mes'];
		$ano	= $post['ano'];	
		$tipo	= $post['tipo'];	
		
		//$id_unidad=13;$mes=12;$ano=2016;$tipo='_todas_';
		
		$this->load->model('Model_Indicadores');
		$resultado = $this->Model_Indicadores->reporte_trimestres($id_unidad, $mes, $ano, $tipo);
		
		echo json_encode($resultado);
		
	}
	
	
	
	
	//exporta a excel
	public function excel_reporte_meses ( $id_unidad,$mes, $ano , $tipo='_todas_', $nombre_mes) {

       $this->load->library('excel');

		//$id_unidad=13;$mes=12;$ano=2016; $tipo = '_todas_'; $nombre_mes='Diciembre';
		
		//obtiene nombre de unidad
		$this->load->model('Model_Unidad');
		$resultado = $this->Model_Unidad->get_departamento($id_unidad);
		$nombre_unidad = $resultado->desDepend;
		
	    //obtiene nombre para fecha reporte
	    $nombre_fecha = "Reporte de $nombre_mes del $ano";
		 
		//obtiene los datos de la BD
		$this->load->model('Model_Indicadores');
		$resultado = $this->Model_Indicadores->reporte_meses($id_unidad, $mes, $ano, $tipo);
		
	
	  //array , que será escrito en el excel
	  $dataArray = array () ;
	   
	   
	   foreach ($resultado as $fila) {       
	     
		$datafila= array("$fila[ind_indicador]",
						  "$fila[ind_tipo]",
						  "$fila[med_nombre]" ,
						  "$fila[ind_formula]" ,
						  "$fila[ind_nivel]" ,
						  FechaLegible($fila['induni_fch_ingreso']) ,  
						   $fila['induni_consumo'] 
						 );
						   
		  array_push($dataArray, $datafila);
	   } 
		 
	
	// Crea un nuevo objeto PHPExcel
	$objPHPExcel = new PHPExcel();
	
	// Leemos un archivo Excel 2007
	$objReader = PHPExcel_IOFactory::createReader('Excel2007');
	$objPHPExcel = $objReader->load("public/views/indicadores/plantillas/plantilla_meses.xlsx");
	// Indicamos que se pare en la hoja uno del libro
	
	// Agregar Informacion
	 $objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('B1', $nombre_fecha)
	->setCellValue('B2', $nombre_unidad);
	/*->setCellValue('C2', 'Estado');*/
	
	$objPHPExcel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');
	
	
	// Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
	$objPHPExcel->setActiveSheetIndex(0);	
	
	// Se modifican los encabezados del HTTP para indicar que se envia un archivo de Excel.
	header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
	header('Content-Disposition: attachment;filename="Reporte Mensual.xlsx"');
	header('Cache-Control: max-age=0');
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	$objWriter->save('php://output');
	exit;
}

//exporta a pdf
	public function pdf_reporte_meses ( $id_unidad = null,$mes=null, $ano=null , $tipo='_todas_', $nombre_mes=null) {

       $this->load->library('excel');
	   
	   //estable la libreria para pdf
	   $rendererName = PHPExcel_Settings::PDF_RENDERER_TCPDF;
	   $base_url = base_url();
	   $rendererLibraryPath = 'application/third_party/tcpdf/';
	   
	   //$id_unidad=13;$mes=12;$ano=2016; $tipo = '_todas_'; $nombre_mes='Diciembre';
		
		//obtiene nombre de unidad
		$this->load->model('Model_Unidad');
		$resultado = $this->Model_Unidad->get_departamento($id_unidad);
		$nombre_unidad = $resultado->desDepend;
		
	    //obtiene nombre para fecha reporte
	    $nombre_fecha = "Reporte de $nombre_mes del $ano";
		 
		//obtiene los datos de la BD
		$this->load->model('Model_Indicadores');
		$resultado = $this->Model_Indicadores->reporte_meses($id_unidad, $mes, $ano, $tipo);
		
	
	  //array , que será escrito en el excel
	  $dataArray = array () ;
	   foreach ($resultado as $fila) {       
	     
		$datafila= array("$fila[ind_indicador]",
						  "$fila[ind_tipo]",
						  "$fila[med_nombre]" ,
						  "$fila[ind_formula]" ,
						  "$fila[ind_nivel]" ,
						  FechaLegible($fila['induni_fch_ingreso']) ,  
						   $fila['induni_consumo'] 
						 );
						   
		  array_push($dataArray, $datafila);
	   } 
		 
	
	// Crea un nuevo objeto PHPExcel
	$objPHPExcel = new PHPExcel();
		
	// Leemos un archivo Excel 2007
	$objReader = PHPExcel_IOFactory::createReader('Excel2007');
	$objPHPExcel = $objReader->load("public/views/indicadores/plantillas/plantilla_meses_pdf_copia.xlsx");
	// Indicamos que se pare en la hoja uno del libro
	
	// Agregar Informacion
	 $objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('B1', $nombre_fecha)
	->setCellValue('B2', $nombre_unidad);
	/*->setCellValue('C2', 'Estado');*/
	
	$objPHPExcel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');	
	
	// Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
	$objPHPExcel->setActiveSheetIndex(0);	
	
	//$objPHPExcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
	
	$objPHPExcel->getActiveSheet()->getPageSetup()->setOrientation('landscape');
	
	if (!PHPExcel_Settings::setPdfRenderer(
		$rendererName,
		$rendererLibraryPath
	)) {
	die(
		'NOTICE: Please set the $rendererName and $rendererLibraryPath values' .
		'<br />' .
		'at the top of this script as appropriate for your directory structure'
	);
}
	
	 PHPExcel_Writer_PDF_Core::setOrientation('landscape');
	
	
	
    // Redirect output to a clientâ€™s web browser (PDF)
	header('Content-Type: application/pdf');
	header('Content-Disposition: attachment;filename="Reporte Mensual.pdf"');
	header('Cache-Control: max-age=0');	
	
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'PDF');
	$objWriter->save('php://output');
	
	
}



	
	
   	public function prueba_excel_reporte_meses () {

        $this->load->library('excel');

		/*$post = $this->input->post();
		
		$id_unidad	= $post['id_unidad'];
		$mes	= $post['mes'];
		$ano	= $post['ano'];	
		$tipo	= $post['tipo'];	*/
		
		$nombre_mes = "Diciembre";
		
		$id_unidad=13;$mes=12;$ano=2016; $tipo = '_todas_';
		
		//obtiene nombre de unidad
		$this->load->model('Model_Unidad');
		$resultado = $this->Model_Unidad->get_departamento(14);
		$nombre_unidad = $resultado->desDepend;
		
	    //obtiene nombre para fecha reporte
	    $nombre_fecha = "Reporte de $nombre_mes del $ano";		
		
		$this->load->model('Model_Indicadores');
		$resultado = $this->Model_Indicadores->reporte_meses($id_unidad, $mes, $ano, $tipo);
		
		
		
	
	//admin_consultas_obtenerFechaLegible($fila['fecha_ejecucion'])
	
	  //MANDAR A IMPRIMIR		
	  $dataArray = array () ;
	   
	   
	   foreach ($resultado as $fila) {       
	       //echo "$fila[id_estado] - $fila[descripcion] <br>";
		$datafila= array("$fila[ind_indicador]",
						  "$fila[ind_tipo]",
						  "$fila[med_nombre]" ,
						  "$fila[ind_formula]" ,
						  "$fila[ind_nivel]" ,
						  FechaLegible($fila['induni_fch_ingreso']) ,  
						   $fila['induni_consumo'] );
		  array_push($dataArray, $datafila);
	   } 
		 
		// print_rr($dataArray);
		// exit;
	
	
	// Crea un nuevo objeto PHPExcel
	$objPHPExcel = new PHPExcel();
	
	// Leemos un archivo Excel 2007
	$objReader = PHPExcel_IOFactory::createReader('Excel2007');
	$objPHPExcel = $objReader->load("public/views/indicadores/plantillas/plantilla_meses.xlsx");
	// Indicamos que se pare en la hoja uno del libro
	
	// Agregar Informacion
	 $objPHPExcel->setActiveSheetIndex(0)
	->setCellValue('B1', $nombre_fecha)
	->setCellValue('B2', $nombre_unidad);
	/*->setCellValue('C2', 'Estado');*/
	
	$objPHPExcel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');
	
	// Renombrar Hoja
	$objPHPExcel->getActiveSheet()->setTitle('OT Correctivas');
	
	// Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
	$objPHPExcel->setActiveSheetIndex(0);
	
	
	
	
	// Se modifican los encabezados del HTTP para indicar que se envia un archivo de Excel.
	header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
	header('Content-Disposition: attachment;filename="Reporte Mensual.xlsx"');
	header('Cache-Control: max-age=0');
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	$objWriter->save('php://output');
	exit;
		
		
		
	}




}