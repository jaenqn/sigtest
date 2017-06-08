<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Contingencia extends CI_Controller {

    function __construct() {
        parent::__construct();
		$this->load->library('session');
		AppSession::logueado();
    }
	
	public function index()
    {
		redirect('contingencia/subir');
    }  
	

	 //
	 public function subir()
    {
        $datos = array(
            'titulo_header' => 'Subir Plan de Contingencia'
            );
		
		//@$_SESSION['verifica_agregarContingencia'] == '0';

		//para evitar el reload
		$this->session->set_userdata('verifica_plan', 0);
		
		
		//maximo tamaño en bytes permitido en el servidor
		$max_post_length = (int)(str_replace('M', '', ini_get('post_max_size')) * 1024 * 1024);
		
		$maximo_megas = round($max_post_length / (1024*1024), 2);

		$datos['maximo_megas'] = $maximo_megas;
		$datos['max_post'] = $max_post_length;
        $this->smartys->assign($datos);
		$this->smartys->render('subir');
        //$this->load->view('contingencia/subir.tpl');
    }


	function do_upload()	
	{
					
		
		 $this->load->model('Model_Contingencia');

		  $datos = array(
            'titulo_header' => 'Subir Plan de Contingencia'
            );


		// ==== para registrar datos en la BD============


		$verifica_plan = $this->session->userdata('verifica_plan');

		//evitar reload
		if ($verifica_plan == 0 ) {
			
			
			
			$post = $this->input->post();
			
			//$max_post_length = ini_get('post_max_size'); //en megas 
			
			$max_post_length = (int)(str_replace('M', '', ini_get('post_max_size')) * 1024 * 1024);
			
			//echo "$max_post_length"; exit;
			if($post == false) {
			 redirect('contingencia/subir');
			}
			$descripcion 	  = 	$post['descripcion'];
			$fecha_aprobacion = 	$post['fecha_aprobacion'];

			$resultado = $this->Model_Contingencia->insertarContingencia($descripcion, $fecha_aprobacion);
			
			//si no se registro correctamente en la bd
			if ($resultado['resultado'] == FALSE ) {

			$datos['verifica'] = $verifica_plan;
			$datos['error'] = ' No se pudo registrar en la BASE DATOS';
			$datos['titulo_header'] = 'Subir Plan de Contingencia';
			$this->smartys->assign($datos);
			$this->smartys->render('subir');

			} else {

			// ==== para la subida de archivo============
			
			//$ruta = DOCSPATH . 'planescontingencia' ;
			
			$config['upload_path'] = 'temp_contingencia';
			$config['allowed_types'] = 'pdf|doc|docx';
			$config['max_size'] = '20000';

			//concateno la descripcion y el id guardo en la bd para el nombre del fichero
			$config['file_name'] = $resultado['num_id'];

			$this->load->library('upload', $config);
			$this->config->set_item('language', 'spanish');

			//si subio correctamente el archivo
			if ( ! $this->upload->do_upload())
			{
				$datos['error'] = $this->upload->display_errors();
				//$this->load->view('upload_form', $error);
				$res = $this->Model_Contingencia->eliminarContingencia($resultado['num_id'] ); 	//elimina el registro de la BD

				if ($res != true) {
					//echo "no se elimino el registro";
					$datos['eliminar'] = "no se pudo eliminar";
				}

				$this->smartys->assign($datos);
				$this->smartys->render('subir');
			}
			else
			{
				//$data = array('upload_data' => $this->upload->data());
				//$this->load->view('upload_success', $data);
				$this->session->set_userdata('verifica_plan', 1);
				$verifica_plan = $this->session->userdata('verifica_plan');
				$datos['verifica'] = $verifica_plan;				
				$datos['ar_pages'] = array('<a href="subir">Subir</a>');
				
				//enviar notificacion automatica
				enviar_notificacion_sistema(  15, 16 , 27 );
				
				$this->smartys->assign($datos);
				$this->smartys->render('subir_exito');
			}
		}



		} else {
				echo "ya se cargo el plan ";
				//$datos['mensaje_reload'] = 'Ya se registro el Plan';

				$datos['verifica'] = $verifica_plan;
				redirect('contingencia/subir');

		}


	}




	//vista listar
	 public function listar()
    {
        $datos = array(
            'titulo_header' => 'Listado de Planes de Contingencia'
            );

		$this->load->model('Model_Contingencia');

	    $lstContigencia = $this->Model_Contingencia->listarContingencia();

		$datos['lstContigencia'] = $lstContigencia;

        $this->smartys->assign($datos);
        $this->smartys->render('listar');
    }

	//elimina plan (archivo Pdf y registro de BD)
	 public function eliminar($id = 0)
    {
    	//primero eliminamos el fichero
    	$post = $this->input->post();
    	$id = $post['id'];

		//echo "$id";

        $file = "contingencia/$id.pdf";
		$do = unlink($file);
		if($do != true){
		  echo "Hubo un error al tratar de borrar el archivo" . $file . "<br />";
		 }
		else {

			 //eliminamos el registro
			 $this->load->model('Model_Contingencia');
			 $res = $this->Model_Contingencia->eliminarContingencia($id); 	//elimina el registro de la BD
			
			 return true;
		}

		return false;

    }
	
	 public function cambiar_estado_contigencia($id = 0)
    {
    	   		
    	$post = $this->input->post();
    	$id = $post['id'];	 
		
		//echo $id;   					    			 
		 $this->load->model('Model_Contingencia');
		 $res = $this->Model_Contingencia->cambiar_estado_contingencia($id); 	//cambia estado
		 
		 return $res;
		 
		
    }



  /* para el data table */

  public function datatables_list()

    {

        $this->load->model('Model_Datatables');

        $order = false;

        $selects = array(

            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",

            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"

            );

        if(isset($_POST['order'])){


            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {

                case 'get_estado':

                    $order = array('uni_estado' => $_POST['order']['0']['dir']);

                    break;



            }

        }

        $filter = array();

        $likes = array();

        if($this->input->post('filters')){

            $p = $this->input->post('filters');

            $i = 0;

            foreach ($p as $key => $value) {

                switch ($value['column']) {

                    case 'uni_nombre':

                        $likes[] = $p[$i];

                        break;

                    case 'dep_id_departamento':

                    case 'uni_estado':

                        $filter[] = $p[$i];

                        break;

                }

                $i++;

            }

        }

        $_POST['f'] = $filter;

        $_POST['l'] = $likes;

        $joins = array(

              //  array('departamentos','departamentos.dep_id = unidades.dep_id_departamento')

            );

        $datas = $this->Model_Datatables->get_datatables('tbl_incidencias','ent_Incidencias',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);

        // $list = get_object_vars($list);

        $data = array();

        $no = $_POST['start'];





        $output = array(

                        "draw" => $_POST['draw'],

                        "recordsTotal" => $datas['count_all'],

                        "recordsFiltered" => $datas['count_filtered'],

                        "data" => $datas['list'],

                        "post" => $_POST

                );

        //output to json format

        echo json_encode($output);

    }



}