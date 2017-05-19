$(document).ready(function() {

$(".select2_single").select2({
      minimumResultsForEach : Infinity,
      placeholder: "Selecciones",
      allowClear: true
    });  
    

    
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
    
    
    var variableGlobal; //para guardar el json de registros dinamicos
    
    
    // el 1er listado por defecto
  	var tabla=  $('#tblListar').DataTable({
		   
        ajax : {
			method: "POST",  			
            url : BASE_URL + "notificaciones/filtrar_procesos/0" ,            	
         	error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
				
		/*	 success: function(datos) {	
			 	variableGlobal = datos;		
			    console.log(variableGlobal);	
			    //variableGlobal = json;			
				}      
        */	},        
	
        columns: [
            { "data" : "not_origen", },
            { "data" : "not_asunto" },
            //{ "defaultContent" : "<a href='#/not_id'>Editar</a>" }   
            { "data" : "not_id" , render: function(data, row, tipy) {
            	return '<a href="' + BASE_URL +'notificaciones/editar_formulario/' + data + '">Editar</a>' ;
            	
            } }, 
        ] ,
        
        language: espanol ,             

    });
    
   var datos =  tabla.data();
   
   console.log(datos);
  	    
    
    
  //listado cuando cambia el tipo de select
  $('select[name=\'proceso\']').on('change', function() { 	  	    
  	    
  	   pro_id = $('#proceso').val();  
  	     	 
  	 	var tabla=  $('#tblListar').DataTable({
		destroy : true,
       
        ajax : {
			method: "POST",  
            url : BASE_URL + "notificaciones/filtrar_procesos/" + pro_id  , 
            	
         	error: function(xhr, ajaxOptions, thrownError) {	
			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
        },

        columns: [
            { "data" : "not_origen" },
            { "data" : "not_asunto" },
           // { "defaultContent" : "<a href='#' class='editar'>Editar</a>" } 
            { "data" : "not_id" , render: function(data, row, tipy) {
            	return '<a href="' + BASE_URL +'notificaciones/editar_formulario/' + data + '">Editar</a>' ;
            	
            } },             

        ] ,
        
        language: espanol 
   		 });  	  	
  	 
  	
  	}); //fin del change of select 
  	
  	
  	
 // ===============  para exportr en excel ==============
  	$(".excel").bind('click',function(variableGlobal)
	{			 
		dataString = variableGlobal;		
		console.log(dataString);
	
	});
	
 	
  obtener_data_editar(" #tblListar tbody" , tabla); 	
	
  var obtener_data_editar = function(tbody, table) {
  	$(tbody).on("click" , "a.editar" , function() {
  		var data = table.row( $(this).parents("tr") ).data();
  		console.log(data); 
  	}); 
  } ;
    
  	

});  