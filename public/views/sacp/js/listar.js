$(document).ready(function() {
    
    espanol =  {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
} ;

   
    // el 1er listado por defecto
  	var tabla=  $('#tblListar_sacp').DataTable({
		destroy : true,   
        ajax : {
			method: "POST",  			
            url : BASE_URL + "sacp/listar_sacp_general" ,            	
         	error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
			},        
	
        columns: [
               { "data" : "sacp_2_numero" },
               { "data" : "sacp_3_norma" },
               { "data" : "sacp_3_requisito" },
               { "data" : "sacp_1_fecha" },
               { "defaultContent"  : "sin respuesta" },
               { "defaultContent"  : "sin plazo" },
               { "defaultContent"  : "sin verificar" },
           	  
	          
	            
	             { "data" : "sacp_estado" , render: function(data, row, tipy) {            	
	            	if (data == 1 ) { 
	            		return 'Pendiente' ;
	            	}
	            	else if (data == 2) {
		            	return 'Aprobado' ;
		            } 	          
		            else if (data == 3){
		            	return 'Rechazado' ;
		            	}  
		            else {
		            	return 'Sin asignar' ;
		            	}          	
	            	        	
	            }} ,              
	                  
	            { "data" : "sacp_id" , render: function(data, row, tipy) {            				
	            	//return '<a href="' + BASE_URL +'indicadores/editar_formulario/' + data + '">Ver</a> / ' +
	            	//		'<a class="delete" href="#" id="' + data + '" >Eliminar</a>' ;
	            	
	            	return '<a href="' + BASE_URL +'sacp/revisar_sacp/' + data + '"  title="Ver">' +
	            			'<i class="fa fa-eye" style="font-size: 20px;"></i>' + 
	            			'</a>' +   '&nbsp;&nbsp;'  +   			
	            			
	            			'<a class="delete" href="#" id="' + data + '"  title="Eliminar"> ' +
	            			'<i class="fa fa-trash" style="font-size: 20px;"></i>' + 
	            			'</a>' ;
	            	
	            } }, 
        ] ,
        
        language: espanol ,             

    });
    

//listado cuando cambia el tipo de select
  $('#tipo_reporte, #tipo_incidente ,#causa, #selDepartamento, #selUnidad, #fecha_reporte, #fecha_incidente, #estado').on('change', function() { 	  		  
  		  
  		  //alert('fechas');  		  
  		  filtro_multiple (); 
  		     	  	  	
  	});  	
  //listado cuando cambia el tipo de input:text
  $('#num_incidente').on('keyup', function() { 	
	  		  
	  if (	$('#num_incidente').val().length  > 3 ) {	  	
		  	//alert('entrando');
		  	filtro_multiple ();  	
	  }  	  		  
	  		    	  	  	
  }); 
  	 

  
  	//2do listado, al cambiar los filtros
  	
  	function filtro_multiple () {
  		
  		//comprobamos si los input:text tienen valor
  		//sino tienen, asignar valor todas, para imprimir todas
  		num_incidente = $('#num_incidente').val();
  		if (num_incidente == false) {
  			num_incidente = '_todas_';
  		}
  		
  		fecha_reporte = $('#fecha_reporte').val();
  		if (fecha_reporte == false) {
  			fecha_reporte = '_todas_';
  		}
  		
  		fecha_incidente = $('#fecha_incidente').val();
  		if (fecha_incidente == false) {
  			fecha_incidente = '_todas_';
  		}
  		
  		
  		
  		tipo_reporte	= $('#tipo_reporte').val();
  		tipo_incidente	= $('#tipo_incidente').val();
  		causa 			= $('#causa').val();  		
  		selDepartamento = $('#selDepartamento').val();
  		selUnidad 		= $('#selUnidad').val();
  		estado 			= $('#estado').val();
  		
  		//Mostrar 
  		console.log("num_incidente:" + num_incidente);
  		console.log("fecha_reporte: " + fecha_reporte); 
  		console.log("fecha_incidente: " + fecha_incidente);
  		
  		console.log("tipo_reporte: " + tipo_reporte);
  		console.log("tipo_incidente: " + tipo_incidente);
  		console.log("causa: " + causa);
  		console.log("selDepartamento: " + selDepartamento);
  		console.log("selUnidad: " + selUnidad);
  		console.log("estado: " + estado);
  		
  	
  		
  		
  	
  		
  		dataString = 'num_incidente='+ num_incidente +'&fecha_reporte='+ fecha_reporte + '&fecha_incidente='+ fecha_incidente;
  		dataString += 'tipo_reporte='+ tipo_reporte +'&tipo_incidente='+ tipo_incidente +'&causa='+ causa;
  		dataString += 'selDepartamento='+ selDepartamento +'&selUnidad='+ selUnidad +'&estado='+ estado;		
  		
  		console.log(dataString)	; 
  		
  		
  	     	 
  	 	var tabla=  $('#tblListar_incidencias').DataTable({
		destroy : true,   
        ajax : {
			method: "POST",  
			data: dataString,			
            url : BASE_URL + "incidencias/filtros_tabla_incidencias/"  +num_incidente+"/" + fecha_reporte  + "/" + fecha_incidente + "/" + tipo_reporte +"/" +  tipo_incidente +"/"  + causa  + "/" + selDepartamento + "/" + selUnidad +"/" +  estado,             	
         	error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
			},        
	
        columns: [
               { "data" : "inc_numero" },
           	  { "data" : "inc_tipo" , render: function(data, row, tipy) {            	
	            	if (data == 0 ) { 
	            		return 'Incidente' ;
	            	}		           
		            else if (data == 1) {
		            	return 'Accidente' ;
		            	} 	           
		            else {
		            	return 'Sin Asignar' ;
		            }          	
	            	        	
	          	  }} ,    
	        
	            { "data" : "desDepend" },
	            { "data" : "inc_fch_reporte" },
	            { "data" : "inc_fechaHora_incidente" }, 
	            { "data" : "inc_locacion_incidente" },   
	            { "data" : "inc_tipo_incidente" , render: function(data, row, tipy) {            	
	            	if (data == 1 ) { 
	            		return 'Seguridad' ;
	            	}
		            else if (data == 2 ) {
		            	return 'Salud' ;
		            	} 
		            else if (data == 3 ) {
		            	return 'Ambiental' ;
		            	} 
		            else if (data == 4) {
		            	return 'Social' ;
		            	} 	           
		            else {
		            	return 'Sin Asignar' ;
		            }          	
	            	        	
	            }} ,    
	           { "data" : "inc_causa_inmediata_incidente" , render: function(data, row, tipy) {            	
	            	if (data == 1 ) { 
	            		return 'Actos' ;
	            	}
	            	else if (data == 2) {
		            	return 'Condiciones' ;
		            } 	          
		            else{
		            	return 'Sin asignar' ;
		            	}           	
	            	        	
	            }} , 
	            
	             { "data" : "inc_estado" , render: function(data, row, tipy) {            	
	            	if (data == 1 ) { 
	            		return 'Pendiente' ;
	            	}
	            	else if (data == 2) {
		            	return 'Aprobado' ;
		            } 	          
		            else if (data == 3){
		            	return 'Rechazado' ;
		            	}  
		            else {
		            	return 'Sin asignar' ;
		            	}          	
	            	        	
	            }} ,              
	                  
	            { "data" : "inc_id" , render: function(data, row, tipy) {            				
	            	//return '<a href="' + BASE_URL +'indicadores/editar_formulario/' + data + '">Ver</a> / ' +
	            	//		'<a class="delete" href="#" id="' + data + '" >Eliminar</a>' ;
	            	
	            	return '<a href="' + BASE_URL +'incidencias/revisar_sacp/' + data + '"  title="Ver">' +
	            			'<i class="fa fa-eye" style="font-size: 20px;"></i>' + 
	            			'</a>' +   '&nbsp;&nbsp;'  +   			
	            			
	            			'<a class="delete" href="#" id="' + data + '"  title="Eliminar"> ' +
	            			'<i class="fa fa-trash" style="font-size: 20px;"></i>' + 
	            			'</a>' ;
	            	
	            } }, 
        ] ,
        
        language: espanol ,             

    });
    

   }//fin filtro multiple
    
 
  	

});  