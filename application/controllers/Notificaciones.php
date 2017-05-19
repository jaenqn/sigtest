<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Notificaciones extends CI_Controller {
    private $numero_notificaciones = 5;
    function __construct() {
        parent::__construct();
		$this->load->library('session');
		AppSession::logueado();
    }

	public function index()
    {
		redirect('notificaciones/gestionar_notificaciones');
    }

	 //
	 public function listar($pro_id = null)
    {
        $datos = array(
            'titulo_header' => 'Edicion de Asuntos y Mensajes de Notificaciones'
            );
		$this->load->model('Model_Notificaciones');

		//obtiene los registros de notificaciones y lo guardo en una variable
	    $lstNotificaciones = $this->Model_Notificaciones->listar_notificaciones();
		$datos['lstNotificaciones'] =  $lstNotificaciones ;

		//obtiene los registros del proceso de notificacion y lo guardo en una variable
	    $lstProcesos = $this->Model_Notificaciones->listar_procesos_notificacion();
		$datos['lstProcesos'] =  $lstProcesos ;
		$datos['ar_pages'] = array("<a href='listar'>Edicion de Asuntos </a>");
        $this->smartys->assign($datos);
        $this->smartys->render('listar');
    }


		 //
	 public function filtrar_procesos($pro_id = null)
    {
       //	$post = $this->input->post();
    	//@$pro_id = $post['pro_id'];


		$this->load->model('Model_Notificaciones');
		//obtiene los registros de notificaciones por proceso
		if ($pro_id == 0 ) {
			 $lstNotificaciones = $this->Model_Notificaciones->listar_notificaciones();

		} 	else {
			 $lstNotificaciones = $this->Model_Notificaciones->listar_notificaciones_xProceso($pro_id);

		}


		 $output = array(
                        "data" =>  $lstNotificaciones
                        );

        //output to json format
        echo json_encode($output);

    }

	//elimina plan (archivo Pdf y registro de BD)
	 public function eliminar($id = 0)
    {
    	//primero eliminamos el fichero
    	$post = $this->input->post();
    	$id = $post['id'];

		echo "$id";

        $file = "contingencia/$id.pdf";
		$do = unlink($file);
		if($do != true){
		  echo "There was an error trying to delete the file" . $file . "<br />";
		 }
		else {
			 //eliminamos el registro
			 $this->load->model('Model_Contingencia');
			 $res = $this->Model_Contingencia->eliminarContingencia($id); 	//elimina el registro de la BD
			 return true;
		}

		return false;
    }



  public function editar_formulario($id=null)
    {
    	 $datos = array(
            'titulo_header' => 'Editar Notificacion'
            );

    	if($id != null) {

			//para evitar el reload
			$this->session->set_userdata('verifica_notificacion', 0);
			$this->load->helper('form');

			$this->load->model('Model_Notificaciones');
		    $notificacion = $this->Model_Notificaciones->conseguir_notificacion($id);
			$datos['notificacion'] = $notificacion;
			$datos['ar_pages'] = array("<a href='../listar'>Edición de Asuntos</a> / <a href='../editar_formulario/$id'> Editar </a>");
			 $this->smartys->assign($datos);
		     $this->smartys->render('editar_formulario');

    	} else {
    		redirect('indicadores/listar');
    	}

    }

  //obtienes los datos el formulario del indicador para registrar en la BD
 public  function editar_notificacion ()
	{
		//is_ajax();

		 $datos = array(
            'titulo_header' => 'Editar Notificacion'
            );

		$post = $this->input->post();
		//asignaciones de variables
		$id					= $post['id_notificacion'];
		$asunto				= $post['asunto'];
		$mensaje			= $post['mensaje'];

	    $verifica_notificacion_actualizado = $this->session->userdata('verifica_notificacion');

		if ($verifica_notificacion_actualizado == 0 ) {

		$this->load->model('Model_Notificaciones');
		$resultado = $this->Model_Notificaciones->editar_notificacion($id,$asunto,$mensaje);

			if ($resultado ){
				//todo se registro correctamente
				$this->session->set_userdata('verifica_notificacion', 1);

				 $datos = array(
		            'titulo_header' => 'Edicion exitosa'
		            );
				 $datos['ar_pages'] = array("<a href='listar'>Edición de Asuntos</a>");
		         $this->smartys->assign($datos);
        		 $this->smartys->render('editar_exito');

			}	else {
				redirect('notificaciones/listar');
			}
		} else {
			//redireccionar para evitar el reload
			redirect('notificaciones/listar');
		}
	}

   // ========================  Para Gestionar notificaciones  ==============================

    public function gestionar_notificaciones($id_unidad= null)
    {
        $datos = array(
            'titulo_header' => 'Gestionar Notificaciones'
            );
		$this->load->model('Model_Notificaciones');



		$tipo_usuario = $this->session->tipo_usuario;

		 $tipo_usuario;


		$datos['tipo_usuario'] =   $tipo_usuario;
		$datos['id_unidad'] =  		 $id_unidad ;
		$datos['ar_pages'] = array('<a href="gestionar_notificaciones">Gestionar</a>');
        $this->smartys->assign($datos);
        $this->smartys->render('gestionar_notificaciones');
        // echo json_encode(array());
    }


		//para el listado de Notificaciones recibidas , de acuerdo a la unidad
	public function listado_notificaciones_recibidas($id_unidad= null)
    {

		$this->load->model('Model_Notificaciones');

		//$id_unidad = 2 ; //acá capturaré el id_unidad por session

		//$this->session->id_unidad;
		$id_unidad = $this->session->id_unidad;

		//echo $id_unidad ; exit;



		//obtiene los registros de notificaciones y lo guardo en una variable
	    $lstNotificaciones = $this->Model_Notificaciones->listado_notificacion_xUnidad($id_unidad);
	    $datos['lstNotificaciones'] =  $lstNotificaciones ;


		 $output = array(
                        "data" =>  $lstNotificaciones
                        );

        //output to json format
        echo json_encode($output);

    }

	    public function listado_notificaciones_enviadas($id_unidad= null)
    {

		$this->load->model('Model_Notificaciones');

		//$id_unidad = 1 ; //esté será el id_del administrador

		$id_unidad = $this->session->id_unidad;

		//obtiene los registros de notificaciones y lo guardo en una variable
	    $lstNotificaciones = $this->Model_Notificaciones->notificacion_enviadas_xAdministrador($id_unidad);
	    $datos['lstNotificaciones'] =  $lstNotificaciones ;


		 $output = array(
                        "data" =>  $lstNotificaciones
                        );

        //output to json format
        echo json_encode($output);

    }

	public function listado_observaciones_recibidas($id_unidad= null)
    {

		$this->load->model('Model_Notificaciones');

		//$id_unidad = 2 ; //acá capturaré el id_unidad por session

		$id_unidad = $this->session->id_unidad;

		//obtiene los registros de notificaciones y lo guardo en una variable
	    $lstObservaciones = $this->Model_Notificaciones->listado_observaciones_xUnidad($id_unidad);
	    $datos['lstObservaciones'] =  $lstObservaciones ;


		 $output = array(
                        "data" =>  $lstObservaciones
                        );

        //output to json format
        echo json_encode($output);

    }


  			//para el listado de Notificaciones enviadas , de acuerdo a la unidad
	    public function leer_notificacion($rel_id = null)
        {
    	  $datos = array(
            'titulo_header' => '&nbsp;'
            );
        $datos['permision_delete'] = AppSession::accesoView(array('administrador','revisador','jefe'));
        $this->load->model('Model_Notificaciones');

        //obtiene los datos de la notificacion
          $notificacion = $this->Model_Notificaciones->leer_notificacion($rel_id );
            $datos['notificacion'] =  $notificacion ;
            $datos['part_title'] = $datos['notificacion'][0]['rel_asunto'];



		  //para obtener nombre de la unidad emisora
		  foreach ($notificacion as $key ) {

				if($key['uni_id_emisora'] != 0)	 {
			  		 $nombre_unidad_emisora = $this->Model_Notificaciones->conseguir_unidad_emisora($key['uni_id_emisora'] );
				}else {
					$nombre_unidad_emisora = 'Administrador General';
				}
		  }

	    $datos['unidad_emisora'] =  $nombre_unidad_emisora ;
		$datos['ar_pages'] = array('<a href="../gestionar_notificaciones">Gestionar</a>');


        $this->smartys->assign($datos);
        $this->smartys->render('leer_notificacion');
    }

	//elimina la notificacion
	 public function eliminar_notificacion($id = 0)
    {
    	$post = $this->input->post();
    	$id = $post['id'];

		 //eliminamos el registro
		 $this->load->model('Model_Notificaciones');
		 $res = $this->Model_Notificaciones->eliminar_notificacion($id); 	//elimina el registro de la BD
         if(is_ajax())
            echo json_encode($res);
		 if ($res)  {
		 	return true;
		 } else {
		 	return false;
		 }

    }

	//cambia el estado de la notificacion de Nuevo a Visto
	 public function cambiar_estado_notificacion($id = 0)
    {
    	$post = $this->input->post();
    	$id = $post['id'];

		 $this->load->model('Model_Notificaciones');
		 $res = $this->Model_Notificaciones->cambiar_estado_notificacion($id); 	//elimina el registro de la BD
         if(is_ajax())
            echo json_encode($res);
		 return $res;

    }

	 public function enviar_notificacion_formulario()
    {
        $datos = array(
            'titulo_header' => 'Enviar Notificación'
            );

		$datos['ar_pages'] = array('<a href="gestionar_notificaciones">Gestionar</a> / <a href="enviar_notificacion_formulario">Enviar Notificación</a> ');

	   // $this->load->model('Model_Reutilizables');
		//$datos['lstDepartamentos'] = $this->Model_Reutilizables->listar_departamentos();

		 $this->load->model('Model_Departamento','departamento');
		 $datos['lstDepartamento'] = $this->departamento->listar();

		 //print_rr( $datos['lstDepartamento']);exit;

		//$this->session->set_userdata('verifica_notificacion_personalizada', 0);

		$_SESSION['verifica_notificacion_personalizada'] = 0;

		//$datos['id_unidad'] =  $id_unidad ;
        $this->smartys->assign($datos);
        $this->smartys->render('enviar_notificacion');
    }

	 public function enviar_notificacion_personalizada()
    {

        $datos = array(
            'titulo_header' => ' '
            );


		$post = $this->input->post();
		//asignaciones de variables
		$uni_id_receptora  = $post['selUnidad'];
		$asunto				= $post['asunto'];
		$mensaje			= $post['mensaje'];
		//$uni_id_emisora 	=  1; //acá irá el id de la unidad Administradora

		$uni_id_emisora = $this->session->id_unidad;//id de unidad logeada como administrado


	    //$verifica_notificacion_personalida = $this->session->userdata('verifica_notificacion_personalizada');
	     $verifica_notificacion_personalida = $_SESSION['verifica_notificacion_personalizada'] ;

		//echo "$verifica_notificacion_personalida  VAlor" ;


		//para evitar el reload
		if ($verifica_notificacion_personalida == 0)  {
	    $this->load->model('Model_Notificaciones');
		$datos['lstDepartamentos'] = $this->Model_Notificaciones->agregar_notificacion($uni_id_receptora, $uni_id_emisora ,$asunto,$mensaje, 1 );

		//$datos['id_unidad'] =  $id_unidad ;
		$datos['ar_pages'] = array('<a href="gestionar_notificaciones">Gestionar</a>');

		// $verifica_notificacion_personalida = $this->session->userdata('verifica_notificacion_personalizada');
		 // echo "$verifica_notificacion_personalida  VAlor" ;

		 //$verifica_notificacion_personalida
		$_SESSION['verifica_notificacion_personalizada']  = 1 ;

        $this->smartys->assign($datos);
        $this->smartys->render('enviar_notificacion_exito');

		} else {
    		redirect('notificaciones/gestionar_notificaciones');
    	}
    }

    public function comprar_notificaciones_custom(){
        if($this->input->is_ajax_request()){
            if(AppSession::usuario_logueado()){
                $this->load->model('Model_Notificaciones');
                $id_unidad = $this->session->id_unidad;
                $lstNotifi = $this->Model_Notificaciones->listado_notificacion_xUnidad_nuevas($id_unidad);
                $lstObserv = $this->Model_Notificaciones->listado_observaciones_xUnidad_nuevas($id_unidad);

                $res['notificaciones'] = array();
                $res['cantidad'] = count($lstNotifi) + count($lstObserv);

                foreach ($lstNotifi as $key => $value) {
                    $t = array();
                    $t['not_id'] = $value['rel_id'];
                    $t['not_asunto'] = $value['rel_asunto'];
                    $t['not_mensaje'] = $value['rel_mensaje'];
                    $t['not_fecha'] = $value['rel_fecha'];
                    $t['not_url'] = $value['rel_url'];
                    $t['not_tipo'] = 1;
                    $res['notificaciones'][] = $t;
                }
                foreach ($lstObserv as $key => $value) {
                    $t = array();
                    $t['not_id'] = $value['obs_id'];
                    $t['not_asunto'] = $value['obs_asunto'];
                    $t['not_mensaje'] = $value['obs_mensaje'];
                    $t['not_fecha'] = $value['obs_fecha'];
                    $t['not_url'] = '';
                    $t['not_tipo'] = 2;
                    $res['notificaciones'][] = $t;
                }

                //consultar a otras fuentes para generar notificaiones
                //boletas


                usort($res['notificaciones'],function($a,$b){
                    $aa = strtotime($a['not_fecha']);
                    $bb = strtotime($b['not_fecha']);

                    if ($aa == $bb) {
                        return 0;
                    }
                    return ($aa > $bb) ? -1 : 1;
                });
                $lst = array();
                foreach ($res['notificaciones'] as $key => $value) {
                    $lst[] = $value['not_id'].'-'.$value['not_tipo'];
                }
                $res['refid'] = $lst;
                $res['notificaciones'] = array_slice($res['notificaciones'],0 ,$this->numero_notificaciones);
                echo json_encode($res);
            }
        }


    }

  	public function comprobar_notificaciones()
    {

		$this->load->model('Model_Notificaciones');

		//$id_unidad = 2 ;

		$id_unidad = $this->session->id_unidad;



		//obtiene los registros de notificaciones y lo guardo en una variable
	    $lstNotificaciones = $this->Model_Notificaciones->listado_notificacion_xUnidad_nuevas($id_unidad);
	    $datos['lstNotificaciones'] =  $lstNotificaciones ;

		$output = array(
                        "data" =>  $lstNotificaciones
                        );

        //output to json format
        echo json_encode($datos['lstNotificaciones']);

    }

 /*	 public function enviar_observacion_formulario_borrador($id_unidad_receptora = null)
    {
        $datos = array(
            'titulo_header' => 'Enviar Observación'
            );

		$id_unidad_receptora = 1 ;

		//si se envia  el parametro, entonces se le enviará  los datos de la unidad a la vista
		//caso contrario el usuario tendrá que seleccionar manualmente la unidad
		if($id_unidad_receptora != null) {
			$this->load->model('Model_Notificaciones');
			 $fila = $this->Model_Notificaciones->conseguir_unidad($id_unidad_receptora);
			 $datos['fila'] = $fila;
		} else {
			 $datos['fila'] = '';
		}


		$this->session->set_userdata('verifica_obervacion_enviada', 0);


        $this->smartys->assign($datos);
        $this->smartys->render('enviar_observacion');
    } */

	 public function enviar_observacion_formulario($id_unidad_receptora = null)
    {

        if($id_unidad_receptora){
            enviar_observacion_reutilizable($id_unidad_receptora);
        }else{
            enviar_observacion_reutilizable();
        }

    }


	 public function enviar_observacion_procesador()
    {

        $datos = array(
            'titulo_header' => ' '
            );

		$post = $this->input->post();
		//asignaciones de variables
		$uni_id_receptora  = $post['selUnidad'];
		$asunto				= $post['asunto'];
		$mensaje			= $post['mensaje'];

		//$uni_id_emisora 	=  1; //acá irá el id de la unidad emisora (VARIABLE SESSION)
		$uni_id_emisora = $this->session->id_unidad;//id de unidad logeada como administrado

		//echo $uni_id_receptora . " - ";
		//echo $uni_id_emisora; exit;

	    $verifica_obervacion_enviada = $this->session->userdata('verifica_obervacion_enviada');

		//para evitar el reload
		if ($verifica_obervacion_enviada == 0)  {
	    $this->load->model('Model_Notificaciones');
		$res = $this->Model_Notificaciones->agregar_observacion($uni_id_receptora, $uni_id_emisora ,$asunto,$mensaje );

		//$datos['id_unidad'] =  $id_unidad ;
			if($res != false ) {
			$datos['ar_pages'] = array('<a href="enviar_observacion_formulario">Enviar Observación</a>');
			$this->smartys->assign($datos);
	        $this->smartys->render('enviar_observacion_exito');
			}else {
				redirect('notificaciones/gestionar_notificaciones');
			}


		} else {
    		redirect('notificaciones/gestionar_notificaciones');
    	}
    }

	    public function leer_observacion($obs_id = null)
    {
    	  $datos = array(
            'titulo_header' => '&nbsp;'
            );

		$this->load->model('Model_Notificaciones');

		//obtiene los datos de la notificacion
	      $observacion = $this->Model_Notificaciones->leer_observacion($obs_id );
          $datos['observacion'] =  $observacion;
	      $datos['part_title'] =  "Leer Observación";


		  //para obtener nombre de la unidad emisora
		  foreach ($observacion as $key ) {
			   $nombre_unidad_emisora = $this->Model_Notificaciones->conseguir_unidad_emisora($key['uni_id_emisora'] );
		  }

	    $datos['unidad_emisora'] =  $nombre_unidad_emisora ;
	    $datos['ar_pages'] = array('<a href="../gestionar_notificaciones">Gestionar</a>');

        $this->smartys->assign($datos);
        $this->smartys->render('leer_observacion');
    }

	 public function cambiar_estado_observacion($id = 0)
    {
    	$post = $this->input->post();
    	 $id = $post['id'];

		 $this->load->model('Model_Notificaciones');
		 $res = $this->Model_Notificaciones->cambiar_estado_observacion($id); 	//elimina el registro de la BD

		 return $res;
    }

	 public function eliminar_observacion($id = 0)
    {
    	$post = $this->input->post();
    	$id = $post['id'];

		 //eliminamos el registro
		 $this->load->model('Model_Notificaciones');
		 $res = $this->Model_Notificaciones->eliminar_observacion($id); 	//elimina el registro de la BD
		 if ($res)  {
		 	return true;
		 } else {
		 	return false;
		 }

    }


	// ===== paras peticiones ajax de las notificaciones generales
	 public function comprobar_observaciones()
    {

		$this->load->model('Model_Notificaciones');

		//$id_unidad = 2 ; ///////////// aquí se captura la variable de sessión

		$id_unidad = $this->session->id_unidad;

		//obtiene los registros de notificaciones y lo guardo en una variable
	    $lstObservaciones = $this->Model_Notificaciones->listado_observaciones_xUnidad_nuevas($id_unidad);
	    $datos['lstObservaciones'] =  $lstObservaciones ;

		        //output to json format
        echo json_encode($lstObservaciones);

    }


   	 public function contador_notifi_observ()
    {

		$this->load->model('Model_Notificaciones');

		//$id_unidad = 2 ; ///////////// aquí se captura la variable de sessión
		$id_unidad = $this->session->id_unidad;


		$total = 0 ;

		//obtiene la cantidad de Notificaciones
	    $cant_noti = $this->Model_Notificaciones->cantidad_notificaciones($id_unidad);

		$cant_obse = $this->Model_Notificaciones->cantidad_observaciones($id_unidad);

		$total =  $cant_noti  + $cant_obse;

      	 echo json_encode($total);

    }

}