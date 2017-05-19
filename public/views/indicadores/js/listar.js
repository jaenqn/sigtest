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
  	var tabla=  $('#tblListar_indicadores').DataTable({
		destroy : true,   
        ajax : {
			method: "POST",  			
            url : BASE_URL + "indicadores/listado_indicadores_generales" ,            	
         	error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
			},        
	
        columns: [
            { "data" : "ind_indicador", },
            { "data" : "ind_tipo" },
            { "data" : "med_nombre" },
            { "data" : "ind_formula" },
            { "data" : "ind_nivel" },     
            { "data" : 0 , render: function(data, row, tipy) {            	
            	unidades = '';
            	for (var i=0; i < data.length; i++) {
				  unidades += '- ' + data[i] + '<br>';
				};
				return unidades;           	
            	        	
            }} , 
            
            // { "defaultContent" : "Responsables" }  , 
            
            { "data" : "ind_estado" , render: function(data, row, tipy) {
            	if (data == 1 ) { 
            		return 'Activo' ;
            	}
	            else{
	            	return 'Inactivo' ;
	            	}            	
            }} , 
           
            { "data" : "ind_id" , render: function(data, row, tipy) {            				
            	//return '<a href="' + BASE_URL +'indicadores/editar_formulario/' + data + '">Editar</a> / ' +
            	//		'<a class="delete" href="#" id="' + data + '" >Eliminar</a>' ;
            	
            	return '<a href="' + BASE_URL +'indicadores/editar_formulario/' + data + '"  title="Editar">' +
            			'<i class="fa fa-pencil" style="font-size: 20px;"></i>' + 
            			'</a>' +   '&nbsp;&nbsp;'  +   			
            			
            			'<a class="delete" href="#" id="' + data + '"  title="Eliminar"> ' +
            			'<i class="fa fa-trash" style="font-size: 20px;"></i>' + 
            			'</a>' ;
            	
            } }, 
        ] ,
        
        language: espanol ,             

    });
    
    
  //listado cuando cambia el tipo de select
  $('#unidades, #unidad_medida ,#estado, #tipo').on('change', function() { 	  		  
  		  filtro_multiple ();    	  	  	
  	});
  	
  //listado cuando cambia el tipo de select
  $('#indicador').on('keyup', function() { 	
	  		  filtro_multiple ();  	  	  	  	
  }); 
  	 

  
  	
  	
  	function filtro_multiple () {
  		
  		indicador = $('#indicador').val();
  		if (indicador == false) {
  			indicador = '_todas_';
  		}
  		
  		
  		id_unidad = $('#unidades').val();
  		id_unidad_medida = $('#unidad_medida').val();
  		id_estado = $('#estado').val();
  		tipo = $('#tipo').val();
  		
  		console.log("indicador:" + indicador);
  		console.log("tipo: " + tipo); 
  		console.log("id_unidad: " + id_unidad);
  		console.log("id_unidad_medida: " + id_unidad_medida);
  		console.log("id_estado: " + id_estado);
  		
  		
  	
  		
  		dataString = 'indicador='+ indicador +'&id_unidad='+ id_unidad + '&id_unidad_medida='+ id_unidad_medida;
  		dataString += 'id_estado='+ id_estado +'&tipo='+ tipo;	
  		
  		console.log(dataString)	; 
  	     	 
  	 	var tabla=  $('#tblListar_indicadores').DataTable({
		destroy : true,
		     
        ajax : {
			method: "POST",  
            url : BASE_URL + "indicadores/filtros_tabla_gestionar/" +indicador+"/" + tipo  + "/" + id_unidad + "/" + id_unidad_medida +"/" +  id_estado +"/"  , 
            data: dataString,	
         	error: function(xhr, ajaxOptions, thrownError) {			
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
        },

       columns: [
            { "data" : "ind_indicador", },
            { "data" : "ind_tipo" },
            { "data" : "med_nombre" },
            { "data" : "ind_formula" },
            { "data" : "ind_nivel" },     
            { "data" : 0 , render: function(data, row, tipy) {            	
            	unidades = '';
            	for (var i=0; i < data.length; i++) {
				  unidades += '- ' + data[i] + '<br>';
				};
				return unidades;           	
            	        	
            }} , 
            
            // { "defaultContent" : "Responsables" }  , 
            
            { "data" : "ind_estado" , render: function(data, row, tipy) {
            	if (data == 1 ) { 
            		return 'Activo' ;
            	}
	            else{
	            	return 'Inactivo' ;
	            	}            	
            }} , 
           
            { "data" : "ind_id" , render: function(data, row, tipy) {            				
            	return '<a href="' + BASE_URL +'indicadores/editar_formulario/' + data + '">Editar</a> / ' +
            			'<a href="' + BASE_URL +'indicadores/eliminar/' + data + '">Eliminar</a>  ';
            	
            } }, 
        ] ,
        
        language: espanol ,             

    }); 
  }//fin de funcion filtrar 
    
  	

});  