var tabla_observ;
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


     //PARA LISTAR REGISTROS DE OBSERVACIONES

   $("#profile-tab2").bind('click', function(e)
   {

  	tabla_observ =  $('#tblListar_observaciones').DataTable({
		destroy: "true",
        ajax : {
			method: "POST",
            url : BASE_URL + "notificaciones/listado_observaciones_recibidas"  ,
         	error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
		   	},

        columns: [
            { "data" : "obs_fecha", },
            { "data" : "obs_asunto" },
            { "data" : "obs_estado" , render: function(data, row, tipy) {
	            	if (data == 1 ) {
	            					return 'Nuevo' ;
	            					}
	            	else {
	            		return 'Visto' ;
	            	}
	             }
            } ,
            { "data" : "obs_id" , render: function(data, row, tipy) {
            	//return '<a href="' + BASE_URL +'notificaciones/leer_observacion/' + data + '">Leer  </a>' ;
            			//'<a class="delete" href="#" id="' + data + '" >Eliminar</a>' ;

            	return '<a href="' + BASE_URL +'notificaciones/leer_observacion/' + data + '"  title="Leer">' +
            			'<i class="fa fa-eye" style="font-size: 20px;"></i>' +
            			'</a>' +   '&nbsp;&nbsp;'  +

            			'<a class="delete" href="#" id="' + data + '"  title="Eliminar"> ' +
            			'<i class="fa fa-trash" style="font-size: 20px;"></i>' +
            			'</a>' ;

            } },
        ] ,

        language: espanol ,

    });

 	});	//fin de evento



});