$(document).ready(function() {
	
  	var ano=$("#ano").val();	
    var id_departamento = $("#selDepartamento").val();
    var id_unidad       = $("#selUnidad").val();
    
	reportar_inicial(ano,id_departamento, id_unidad);
	
 	
    

	/*console.log(ano);
	console.log(id_departamento);
	console.log(id_unidad);*/
	
	
	$('#ano ,  #selUnidad').on('change' , function () {
		
		var ano=$("#ano").val();	
	    var id_departamento = $("#selDepartamento").val();
	    var id_unidad       = $("#selUnidad option:selected").val();	
		
		reportar_inicial(ano,id_departamento,id_unidad);
				
	});
	
	
	$(' #selDepartamento').on('change' , function () {
		
		var ano=$("#ano").val();	
	    var id_departamento = $("#selDepartamento").val();
	    var id_unidad       = $("#selUnidad option:selected").val();	
	    
	    id_unidad = '_todas_';
		
		reportar_inicial(ano,id_departamento,id_unidad);
				
	});
	
	

	
	//reporte al iniciar
	function reportar_inicial (ano,id_departamento,id_unidad) {  
	
	/*var ano=$("#ano").val();	
    var id_departamento = $("#selDepartamento").val();
    var id_unidad       = $("#selUnidad option:selected").val();	*/
	
	console.log('========2da impresionnn ===============');
	console.log(ano);
	console.log("id depa " , id_departamento);
	console.log("id unidad " , id_unidad);
	
	//para la impresion  de años 
	if (ano == '_todas_') {
		ano_texto = 'General';
	}else {
		ano_texto = ano;
	}
	
	//para la Departamentos y Unidades
	if (id_departamento == '_todas_') {
		depa_texto = 'Todos los Departamentos';
	}else {
		depa_texto = $("#selDepartamento option:selected").text();;
	}
	
	//para la Departamentos y Unidades
	if (id_unidad == '_todas_') {
		uni_texto = 'Todas las Unidades';
	}else {
		uni_texto = $("#selUnidad option:selected").text();;
	}
	
	
	
	
	var dataString = 'ano=' + ano + '&id_departamento=' + id_departamento + '&id_unidad=' + id_unidad;
	
		$.ajax({					
			type: "POST",
			url: BASE_URL + 'incidencias/resumen_general',
			data: dataString,
			cache: false,
			dataType : 'json',
			success: function(data)
			{				
			   //var id=e;
			   //console.log('entre');  
			   var  tabledata = '<table class="table table-bordered table-striped table-hover">';
			  	  tabledata +='<thead>' ;
			 	  tabledata +='<tr>' ;
			 	  tabledata +='<th colspan="8" class="alineacion"><h4>Reporte de Incidencias - Cuadro de Resumen</h4></th>' ;
			 	  tabledata +='</tr>' ;
			 	  
			 	  tabledata +='<tr>' ;
			 	  tabledata +='<th colspan="2" rowspan="2" class="alineacion">Fecha</th>  <th colspan="3" class="alineacion" >Incidentes </th> <th colspan="3" class="alineacion">Accidentes</th>' ;
			 	  tabledata +='</tr>' ;
			 	  
			 	  tabledata +='<tr>' ;
			 	  tabledata +='<th rowspan="2" class="texto-vertical">pendientes</th>  <th rowspan="2" class="texto-vertical">Aprobados </th> <th rowspan="2" class="texto-vertical">Rechazados </th> <th rowspan="2" class="texto-vertical">pendientes</th>  <th rowspan="2" class="texto-vertical" >Aprobados </th> <th  rowspan="2" class="texto-vertical">Rechazados </th> ' ;
			 	  tabledata +='</tr>' ;
			 	  
			 	  tabledata +='<tr>' ;
			 	  tabledata +=' <th >Año </th>  <th>Mes </th> ' ;
			 	  tabledata +='</tr>' ;
			 	  
			 	  
			 	  tabledata +='</thead>' ;
			 	  tabledata +='<tbody>' ;
			 	  
			 	
			      
			      total = data.lstPendientes_incid[0].enero;		      
			      console.log("total " + total);		
			      
			         total2 = data.lstAprobados_incid[0].enero	;	 	      
			      console.log("total2 " + total2);	      
			     	
			     
			      tabledata +='<tr>' ;
			 	  tabledata   +='<th rowspan="13" class="alineacion_vert" style=" background-color: none;  " >'+ ano_texto +' </th><td>Enero </td> <td>'+ data.lstPendientes_incid[0].enero +'</td>  <td>' + data.lstAprobados_incid[0].enero + ' </td>  <td>' + data.lstRechazados_incid[0].enero + '</td>  <td>' + data.lstPendientes_accid[0].enero + '</td>  <td>' + data.lstAprobados_accid[0].enero + ' </td>  <td>' + data.lstRechazados_accid[0].enero + '</td> ' ;
			 	  tabledata +='</tr>' ;
			  	
			  	  
			  	  tabledata +='<tr>' ;
			 	  tabledata   +='<td>Febrero </td> <td>'+ data.lstPendientes_incid[0].febrero +'</td>  <td>' + data.lstAprobados_incid[0].febrero + ' </td>  <td>' + data.lstRechazados_incid[0].febrero + '</td>  <td>' + data.lstPendientes_accid[0].febrero + ' </td>  <td>' + data.lstAprobados_accid[0].febrero + ' </td>  <td>' + data.lstRechazados_accid[0].febrero + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	  tabledata +='<tr>' ;
			 	  tabledata   +='<td>Marzo </td> <td>'+ data.lstPendientes_incid[0].marzo +'</td>  <td>' + data.lstAprobados_incid[0].marzo + ' </td>  <td>' + data.lstRechazados_incid[0].marzo + ' </td>  <td>' + data.lstPendientes_accid[0].marzo + ' </td>  <td>' + data.lstAprobados_accid[0].marzo + '</td>  <td>' + data.lstRechazados_accid[0].marzo + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	  tabledata +='<tr>' ;
			 	  tabledata   +='<td>Abril </td> <td>'+ data.lstPendientes_incid[0].abril +'</td>  <td>' + data.lstAprobados_incid[0].abril + ' </td>  <td>' + data.lstRechazados_incid[0].abril + ' </td>  <td>' + data.lstPendientes_accid[0].abril + ' </td>  <td>' + data.lstAprobados_accid[0].abril + ' </td>  <td>' + data.lstRechazados_accid[0].abril + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	  tabledata +='<tr>' ;
			 	  tabledata   +='<td>Mayo </td> <td>'+ data.lstPendientes_incid[0].mayo +'</td>  <td>' + data.lstAprobados_incid[0].mayo + '</td>  <td>' + data.lstRechazados_incid[0].mayo + ' </td>  <td>' + data.lstPendientes_accid[0].mayo + ' </td>  <td>' + data.lstAprobados_accid[0].mayo + ' </td>  <td>' + data.lstRechazados_accid[0].mayo + '</td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	   tabledata +='<tr>' ;
			 	  tabledata   +='<td>Junio </td> <td>'+ data.lstPendientes_incid[0].junio +'</td>  <td>' + data.lstAprobados_incid[0].junio + ' </td>  <td>' + data.lstRechazados_incid[0].junio + ' </td>  <td>' + data.lstPendientes_accid[0].junio + ' </td>  <td>' + data.lstAprobados_accid[0].junio + ' </td>  <td>' + data.lstRechazados_accid[0].junio + '</td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	   tabledata +='<tr>' ;
			 	  tabledata   +='<td>Julio </td> <td>'+ data.lstPendientes_incid[0].julio +'</td>  <td>' + data.lstAprobados_incid[0].julio + ' </td>  <td>' + data.lstRechazados_incid[0].julio + '</td>  <td>' + data.lstPendientes_accid[0].julio + ' </td>  <td>' + data.lstAprobados_accid[0].julio + ' </td>  <td>' + data.lstRechazados_accid[0].julio + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	   tabledata +='<tr>' ;
			 	  tabledata   +='<td>Agosto </td> <td>'+ data.lstPendientes_incid[0].agosto +'</td>  <td>' + data.lstAprobados_incid[0].agosto + ' </td>  <td>' + data.lstRechazados_incid[0].agosto + ' </td>  <td>' + data.lstPendientes_accid[0].agosto + ' </td>  <td>' + data.lstAprobados_accid[0].agosto + ' </td>  <td>' + data.lstRechazados_accid[0].agosto + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	   tabledata +='<tr>' ;
			 	  tabledata   +='<td>Septiembre </td> <td>'+ data.lstPendientes_incid[0].septiembre +'</td>  <td>' + data.lstAprobados_incid[0].septiembre + '</td>  <td>' + data.lstRechazados_incid[0].septiembre + ' </td>  <td>' + data.lstPendientes_accid[0].septiembre + ' </td>  <td>' + data.lstAprobados_accid[0].septiembre + ' </td>  <td>' + data.lstRechazados_accid[0].septiembre + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	   tabledata +='<tr>' ;
			 	  tabledata   +='<td>Octubre </td> <td>'+ data.lstPendientes_incid[0].octubre +'</td>  <td>' + data.lstAprobados_incid[0].octubre + ' </td>  <td>' + data.lstRechazados_incid[0].octubre + '</td>  <td>' + data.lstPendientes_accid[0].octubre + ' </td>  <td>' + data.lstAprobados_accid[0].octubre + ' </td>  <td>' + data.lstRechazados_accid[0].octubre + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	   tabledata +='<tr>' ;
			 	  tabledata   +='<td>Noviembre </td> <td>'+ data.lstPendientes_incid[0].noviembre +'</td>  <td>' + data.lstAprobados_incid[0].noviembre + ' </td>  <td>' + data.lstRechazados_incid[0].noviembre + ' </td>  <td>' + data.lstPendientes_accid[0].noviembre + ' </td>  <td>' + data.lstAprobados_accid[0].noviembre + ' </td>  <td>' + data.lstRechazados_accid[0].noviembre + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			 	  
			 	   tabledata +='<tr>' ;
			 	  tabledata   +='<td>Diciembre </td> <td>'+ data.lstPendientes_incid[0].diciembre +'</td>  <td>' + data.lstAprobados_incid[0].diciembre + ' </td>  <td>' + data.lstRechazados_incid[0].diciembre + ' </td>  <td>' + data.lstPendientes_accid[0].diciembre + ' </td>  <td>' + data.lstAprobados_accid[0].diciembre + ' </td>  <td>' + data.lstRechazados_accid[0].diciembre + ' </td>' ;
			 	  tabledata +='</tr>' ;	
			  		
			  	  tabledata +='<tr>' ;
			 	  tabledata   +='<th colspan="1">TOTAL GENERAL  <th>'+ data.lstTotal_incid[0].pendiente +'</th>  <th>'+ data.lstTotal_incid[0].aprobado +' </th>  <th>'+ data.lstTotal_incid[0].rechazado +' </th><th> ' +  data.lstTotal_accid[0].pendiente +'</th>  <th>' +  data.lstTotal_accid[0].aprobado +'</th>  <th>' +  data.lstTotal_accid[0].rechazado +'</th>' ;
			 	  tabledata  +='</tr>' ;	
			  	
			  
			  tabledata +="</tbody>";
			  tabledata +="</table>";
			  
			  //para llenar titulo de tabla
		
			     titulo_resumen =  depa_texto + ' / ' + uni_texto;
			     $('#titulo_resumen').html(titulo_resumen);
			     $('#titulo_ano').html(ano_texto);
			   
			    			   	  
			   $('#contenedor_tblListar_resumen').empty();
			   $('#contenedor_tblListar_resumen').append(tabledata);
			  // $("#tblListar_unidades tr:last").find("input").val(""); 
			  
			}, //success end
			error: function(xhr, ajaxOptions, thrownError) {			
						alert('No se pudo cargar tabla');
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
		}); // ajax end
			   
 }
   

	//para el exportado 
	$('#exportar_excel').on('click' , function (){	

	var ano=$("#ano").val();	
    var id_departamento = $("#selDepartamento").val();
    var id_unidad       = $("#selUnidad").val();
	
	console.log(' ======= Reporte ============');
	console.log(ano);
	console.log(id_departamento);
	console.log(id_unidad);
	
	//para la Departamentos y Unidades
	if (id_departamento == '_todas_') {
		depa_texto = 'Todos los Departamentos';
	}else {
		depa_texto = $("#selDepartamento option:selected").text();;
	}
	
	//para la Departamentos y Unidades
	if (id_unidad == '_todas_') {
		uni_texto = 'Todas las Unidades';
	}else {
		uni_texto = $("#selUnidad option:selected").text();;
	}
	
	 titulo_resumen =  depa_texto + ' - ' + uni_texto;
	 //console.log(titulo_resumen);
   
	
	window.open(BASE_URL + 'Incidencias/excel_reporte_accid_incid/'+ano+'/'+id_departamento+'/'+id_unidad+'/'+titulo_resumen, '_self');	
	
	});


	
});