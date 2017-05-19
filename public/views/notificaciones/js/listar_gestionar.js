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
    
    
    var id_unidad = $('#id_unidad').val();
 
    
    
    
    // el 1er listado por defecto
  	var tabla=  $('#tblListar_recibidas').DataTable({
		
        ajax : {
			method: "POST",  			
            url : BASE_URL + "notificaciones/listado_notificaciones_recibidas/"  ,            	
         	error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
		   	},        
	
        columns: [
            { "data" : "rel_fecha", },
            { "data" : "rel_asunto" },           
            { "data" : "rel_estado" , render: function(data, row, tipy) {            	
	            	if (data == 1 ) { 
	            					return 'Nuevo' ;
	            					}
	            	else {
	            		return 'Visto' ;
	            	}
	             }  	
            } , 			       
            { "data" : "rel_id" , render: function(data, row, tipy) {
            	//return '<a href="' + BASE_URL +'notificaciones/leer_notificacion/' + data + '">Leer / </a>' +
            	//		'<a class="delete" href="#" id="' + data + '" >Eliminar</a>' ;
            	
            	return '<a href="' + BASE_URL +'notificaciones/leer_notificacion/' + data + '"  title="Leer">' +
            			'<i class="fa fa-eye" style="font-size: 20px;"></i>' + 
            			'</a>' +   '&nbsp;&nbsp;'  +   			
            			
            			'<a class="delete" href="#" id="' + data + '"  title="Eliminar"> ' +
            			'<i class="fa fa-trash" style="font-size: 20px;"></i>' + 
            			'</a>' ;
            	
            	
            } }, 
        ] ,
        
        language: espanol ,             

    });
    
 

	
  var obtener_data_editar = function(tbody, table) {
  	$(tbody).on("click" , "a.editar" , function() {
  		var data = table.row( $(this).parents("tr") ).data();
  		console.log(data); 
  	}); 
  } ;
    
  	

});  