$(document).ready(function() {	
	
    //agrega una unidad de medida Dinamicamente      
 
   //input testigos Dínamicos 
   $('#btn_agregar_unidad').bind('click' , function () {   	    
   	    var unidad_nueva = $('#unidad_nueva').val();   	  
   	 
   	    dataString ='unidad_nueva='+unidad_nueva ;
   	       	    
   	    if(unidad_nueva.length>1){  	       
		   	    	
			$.ajax({				
				type: "POST",
				url: BASE_URL + 'Indicadores/agregar_unidadMedida',
				data: dataString,
				cache: false,
				success: function(e)
				{						  	
				  	$('#unidad_nueva').hide();
				  	$('#btn_agregar_unidad').hide();
				   	$('#select_unidades').append('<option value="">'+unidad_nueva+'</option>');
				   	alert('Se agregó nueva Unidad de Medida');		
				  
				} ,  //success end
				error: function(e)
				{					  	
				   	alert('No se pudo agregar nueva unidad');			
				  
				} //error end
			}); // ajax end
			
		   	  } else {		   	  	
		   	  	alert('Se requiere al menos dos caracteres');
		   	  }    	    
   	
   });          
       
	
});
