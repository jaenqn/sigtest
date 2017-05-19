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


   var ano = $('#ano').val();
   var mes = $('#mes').val();
   
   console.log(ano); 
    console.log(mes);
   
    // el 1er listado por defecto
  	var tabla=  $('#tblListar_xUnidad').DataTable({
		destroy : true, 
		lengthChange : false, //deshabilita select , para mostrar cantidad de resultados
		
        ajax : {
			method: "POST",  			
            url : BASE_URL + "indicadores/listar_indicadores_xUnidad/" + ano + "/" + mes ,            	
         	error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
			},        
	
        columns: [
            { "data" : "ind_indicador", },            
            { "data" : "induni_estado" , render: function(data, row, tipy) {   
            	estado = data;//para ver si ingresa o edita            	         	
            	if(data == 1) {
            		return "Ingresado";
            	} else {
            		return "Pendiente";
            	}       	
            	        	
            }} , 
            
            // { "defaultContent" : "Responsables" }  , 
            
            { "data" : "induni_id", render: function(data1, row, tipy) {
            	if (estado == 1 ) { 
            		//return "<a href='" + BASE_URL + "indicadores/edicion_indicador_formulario/" + data1 + "' > Editar</a>" ;
            		return '<a href="' + BASE_URL +'indicadores/edicion_indicador_formulario/' + data1 + '"  title="Editar">' +
            			'&nbsp;&nbsp;<i class="fa fa-pencil" style="font-size: 20px;"></i>' + 
            			'</a>' +   '&nbsp;&nbsp;';	
            	}
	            else{
	            	//return "<a href='" + BASE_URL + "indicadores/ingreso_indicador_formulario/" + data1 + "' > Ingresar</a>" ;
	            	return '<a href="' + BASE_URL +'indicadores/ingreso_indicador_formulario/' + data1 + '"  title="Ingresar">' +
            			'&nbsp;&nbsp;<i class="fa fa-plus-square" style="font-size: 20px;"></i>' + 
            			'</a>' +   '&nbsp;&nbsp;'  ;	            	
	            	}  
	            		            	         	
            }} 
        ] ,
        
        language: espanol ,             

    });
    
    
	//listado cuando cambia el tipo de select
  $('#ano, #mes').on('change', function() { 	  		  
  		  nuevo_listado_indicadores ();    	  	  	
  	});
  	
function nuevo_listado_indicadores () {
  		
	var ano = $('#ano').val();
	var mes = $('#mes').val();
     	 
 	 // el 1er listado por defecto
	var tabla=  $('#tblListar_xUnidad').DataTable({
	destroy : true, 
	lengthChange : false, //deshabilita select , para mostrar cantidad de resultados
	
    ajax : {
		method: "POST",  			
        url : BASE_URL + "indicadores/listar_indicadores_xUnidad/" + ano + "/" + mes ,            	
     	error: function(xhr, ajaxOptions, thrownError) {			
		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			} 
		},        

    columns: [
        { "data" : "ind_indicador", },            
        { "data" : "induni_estado" , render: function(data, row, tipy) {   
        	estado = data;         	
        	if(data == 1) {
        		return "Ingresado";
        	} else {
        		return "Pendiente";
        	}       	
        	        	
        }} , 
        
        // { "defaultContent" : "Responsables" }  , 
        
        { "data" : "induni_id" ,render: function(data1, row, tipy) {
        	console.log(estado);
        	if (estado == 1 ) { 
            		//return "<a href='" + BASE_URL + "indicadores/edicion_indicador_formulario/" + data1 + "' > Editar</a>" ;
            		return '<a href="' + BASE_URL +'indicadores/edicion_indicador_formulario/' + data1 + '"  title="Editar">' +
            			'&nbsp;&nbsp;<i class="fa fa-pencil" style="font-size: 20px;"></i>' + 
            			'</a>' +   '&nbsp;&nbsp;';		
            	}
	            else{
	            	 //return "<a href='" + BASE_URL + "indicadores/ingreso_indicador_formulario/" + data1 + "' > Ingresar</a>" ;
	            	 return '<a href="' + BASE_URL +'indicadores/ingreso_indicador_formulario/' + data1 + '"  title="Ingresar">' +
            			'&nbsp;&nbsp;<i class="fa fa-plus-square" style="font-size: 20px;"></i>' + 
            			'</a>' +   '&nbsp;&nbsp;'  ;	            	
	            	}                   	
        }} 
    ] ,
    
    language: espanol ,             

    });
}//fin de funcion nuevo_listado_indicadores 
  	

  
  	
  

});  