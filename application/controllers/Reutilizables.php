<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Reutilizables extends CI_Controller {

    function __construct() {
        parent::__construct();		
    } 	
	
	
	
	//para comboBox de Unidades, de acuerdo a departamento seleccionado
	 public function combobox_unidades($dep_id = null)
    {
      	$post = $this->input->post();
    	$dep_id = $post['dep_id'];
    	
    	//$dep_id = 2;
    	
    	$this->load->helper('form'); 
	    
		
	    $this->load->model('Model_Reutilizables');
		$datos['lstUnidades'] = $this->Model_Reutilizables->listar_unidadades_xDepartamento($dep_id);	
		
		
		//para que cree el array de id y nombre de las unidades
		/*foreach ($datos['lstUnidades'] as $item) {
			$lista[$item['uni_id']] = $item['uni_nombre'];
		}	 */		
		
		//string del select customizado 
		
		if(!$datos['lstUnidades']) 
			return false; 
		else {
			 
	        //output to json format
	        echo json_encode($datos['lstUnidades']);			
			}	
    }
	
	 //lista  toda unidades al presionar el  select de una vista
	 //para no sobrecargar la carga de la vista
	 public function listar_unidades()
    {      
    	
    	$this->load->helper('form'); 		
	    $this->load->model('Model_Reutilizables');
		$datos['lstUnidades'] = $this->Model_Reutilizables->listar_unidadades_simple();				
		
		if(!$datos['lstUnidades']) 
			return false; 
		else {			 
	        //output to json format
	        echo json_encode($datos['lstUnidades']);			
			}	
    }
   
   
  
 
    

   

}