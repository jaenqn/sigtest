
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Notificaciones extends CI_Model {


    public function __construct()
    {
        parent::__construct();
        $this->load->database();
		$this->load->library('session');

    }

	public function listar_notificaciones(){

		$res =   $this->db->query("SELECT * FROM `tbl_notificaciones`");
		$array = $res->result_array();
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;

    }

	public function listar_procesos_notificacion(){

		$res =   $this->db->query("SELECT * FROM `tbl_procesos_notificacion`");
		$array = $res->result_array();
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;

    }

	public function listar_notificaciones_xProceso($pro_id ){

		$res =   $this->db->query("SELECT * FROM `tbl_notificaciones` where  pro_id = '$pro_id'");
		$array = $res->result_array();
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;
    }


	public function conseguir_notificacion($id_notificacion){

	    $res = $this->db->query("SELECT * FROM `tbl_notificaciones` WHERE not_id =  $id_notificacion ");
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

	public function editar_notificacion($id, $asunto,$mensaje){

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

	public function listado_notificacion_xUnidad($id_unidad){

		$res =   $this->db->query("SELECT * FROM `rel_notificaciones_unidades`
									where uni_id_receptora = $id_unidad ");
		$array = $res->result_array();

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;

    }

	public function listado_observaciones_xUnidad($id_unidad){

		$res =   $this->db->query("SELECT * FROM `tbl_observaciones`
									where uni_id_receptora = $id_unidad ");
		$array = $res->result_array();

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;

    }

	public function notificacion_enviadas_xAdministrador($id_unidad){

		$res =   $this->db->query("SELECT * FROM `rel_notificaciones_unidades`
									where uni_id_emisora = $id_unidad and
										 rel_enviado = 1");
		$array = $res->result_array();

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;

    }


	public function leer_notificacion($id_rel){

		$res =   $this->db->query("SELECT * FROM `rel_notificaciones_unidades`
									where rel_id  = $id_rel ");
		$array = $res->result_array();


		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;

    }

	public function leer_observacion($obs_id){

		$res =   $this->db->query("SELECT * FROM `tbl_observaciones`
									where obs_id  = $obs_id ");
		$array = $res->result_array();


		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;

    }


	public function conseguir_unidad_emisora($id_unidad){
	    $res = $this->db->query("SELECT * FROM `dependencia` WHERE idDepend =  $id_unidad ");
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
		foreach ($array as $key ) {
			  return $key['desDepend'];
		}

    }

	 public function eliminar_notificacion($re_id){

		//se borra el id de la tabla-relacion de Notificaciones-Unidades
		$this->db->where('rel_id', $re_id);

	    $res = $this->db->delete('rel_notificaciones_unidades');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}

       return true;
    }


	public function cambiar_estado_notificacion($id){
		// 1 = nuevo
		// 2 = Visto
		$arrayDatos =  array (
		   'rel_estado'		=> 2
		);

		$this->db->where('rel_id', $id);
		$res = $this->db->update('rel_notificaciones_unidades', $arrayDatos);

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

	public function cambiar_estado_observacion($id){
		// 1 = nuevo
		// 2 = Visto
		$arrayDatos =  array (
		   'obs_estado'		=> 2
		);

		$this->db->where('obs_id', $id);
		$res = $this->db->update('tbl_observaciones', $arrayDatos);

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

	 public function agregar_notificacion($uni_id_receptora, $uni_id_emisora ,$asunto,$mensaje, $enviado_manual = null,$url = null){

		//para capturar la fecha y hora
		date_default_timezone_set('America/Lima'); //establece la fecha para -5
		$fecha = new DateTime();
		$fecha = $fecha->format('Y-m-d H:i');


		$arrayDatos =  array (
		   'uni_id_receptora' 	=> $uni_id_receptora,
		   'uni_id_emisora'  	=> $uni_id_emisora,
		   'rel_asunto' 		=> $asunto,
		   'rel_mensaje' 			=> $mensaje,
		   'rel_estado' 		=> 1,  //1 = nuevo ,  2 = visto
		   'rel_fecha' 			=> $fecha,
		   'rel_url'    	=> $url,
		   'rel_enviado'    	=> $enviado_manual
	  	);

	    $res = $this->db->insert('rel_notificaciones_unidades',$arrayDatos );

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else
		{
		  $this->session->set_userdata('verifica_notificacion_personalizada', 1);
		  return $res;
		}

   }

	//esto es para las notificaciones de la barra superior
	public function listado_notificacion_xUnidad_nuevas($id_unidad){

		$res =   $this->db->query("SELECT * FROM `rel_notificaciones_unidades`
									where uni_id_receptora = $id_unidad  and
										  rel_estado = 1 ");
		$array = $res->result_array();

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;
    }


	//devuelve los datos de la unidad, con su respectivo departamento
	public function conseguir_unidad($id_unidad){
	    $res = $this->db->query("SELECT * FROM `unidades`  inner join departamentos
								on unidades.dep_id_departamento = departamentos.dep_id
								WHERE uni_id =   $id_unidad ");
		$fila= $res->row();

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}else
		{
			return $fila;
		}

    }

	 public function agregar_observacion($uni_id_receptora, $uni_id_emisora ,$asunto,$mensaje){

		//para capturar la fecha y hora
		date_default_timezone_set('America/Lima'); //establece la fecha para -5
		$fecha = new DateTime();
		$fecha = $fecha->format('Y-m-d H:i');


		$arrayDatos =  array (
		   'uni_id_receptora' 	=> $uni_id_receptora,
		   'uni_id_emisora'  	=> $uni_id_emisora,
		   'obs_asunto' 		=> $asunto,
		   'obs_mensaje' 		=> $mensaje,
		   'obs_estado' 		=> 1,  //1 = nuevo ,  2 = visto
		   'obs_fecha' 			=> $fecha
	  	);

	    $res = $this->db->insert('tbl_observaciones',$arrayDatos );

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}else
		{
		  $this->session->set_userdata('verifica_obervacion_enviada', 1);
		  return $res;
		}

   }

	 public function eliminar_observacion($obs_id){

		//se borra el id de la tabla-relacion de Notificaciones-Unidades
		$this->db->where('obs_id', $obs_id);

	    $res = $this->db->delete('tbl_observaciones');
		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}

       return true;
    }

	//esto es para las observaciones de la barra superior
	public function listado_observaciones_xUnidad_nuevas($id_unidad){
    	//1 = nuevo
    	// 2 = visto

		$res =   $this->db->query("SELECT * FROM `tbl_observaciones`
									where uni_id_receptora = $id_unidad  and
										  obs_estado = 1 ");
		$array = $res->result_array();

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		}
       return $array;
    }

	public function cantidad_notificaciones($id_unidad)
	{
		$this->db->where('uni_id_receptora', $id_unidad);
		$this->db->where('rel_estado', 1);
		$res = $this->db->from('rel_notificaciones_unidades');
		$cantidad =  $this->db->count_all_results(); // Produces an integer, like 17

		if (!$res)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	else {
			return $cantidad;
		}

    }

		public function cantidad_observaciones($id_unidad)
	{
		$this->db->where('uni_id_receptora', $id_unidad);
		$this->db->where('obs_estado', 1);
		$res =  $this->db->from('tbl_observaciones');
		$cantidad =  $this->db->count_all_results(); // Produces an integer, like 17

		if (!$cantidad)
		{
		  $error = $this->db->error(); // Has keys 'code' and 'message'
		  echo "$error[message]";
		  return false;
		}	else {
			return $cantidad;
		}

    }


}