$(document).ready(function() {
   
    var id_unidad=$("#unidad").val();
	var mes=$("#mes").val();
	var ano=$("#ano").val();
	var tipo=$("#tipo").val();	
	var tiempo=$('input:radio[name=tiempo]').val();	
	
	console.log(id_unidad);
	console.log(mes);
	console.log(ano);
	console.log(tipo);
	console.log(tiempo);

//$('#reporte_pie').hide();//oculto la parte de grafico	
	
	
 //listado cuando cambia el tipo de select
  $('#unidad, #tipo ,  #ano ,#mes' ).on('change', function() { 	 
  	 		  
	    var id_unidad=$("#unidad").val();
		var tiempo2=$('input:radio[name=tiempo]:checked').val();
				
		console.log(tiempo2);
		
	   switch(tiempo2) {
	   	//mes
	    case '1':
	    	$('#contenedor_mes').show(); 
	        console.log('llamar reporte meses');
	        if(id_unidad != '') {
	        	 
	        	  reportar_meses();
	        	  $('#reporte_pie').show();//muestro oculto la parte de grafico
	        }
	      
	        break;
	    //trimestre
	    case '2':
	       console.log('oculto mes');
	        $('#reporte_pie').hide();//oculto la parte de grafico
	        $('#contenedor_mes').hide(); 
	        if(id_unidad != '') {
	        	 
	        	  reportar_trimestre();
	        	  $('#reporte_pie').hide();// oculto la parte de grafico
	        }       
	        
	        break;
	    //año
	    case '3':
	        $('#reporte_pie').hide();//oculto la parte de grafico
	        $('#contenedor_mes').hide();   
	        break;
	    default:
	            console.log('defecto');
			}    	  	  	
});



//CUANDO CAMBIA EL RADIO BUTON DE TIEMPO	
$('input[type=radio][name=tiempo]').on('change' , function (){	
    var id_unidad=$("#unidad").val();
	var tiempo2=$('input:radio[name=tiempo]:checked').val();
	
	console.log(tiempo2);
	
   switch(tiempo2) {
   	//mes
    case '1':
    	$('#contenedor_mes').show(); 
    	
        console.log('llamar reporte meses');
        if(id_unidad != '') {
        	 reportar_meses();
        	 $('#reporte_pie').show();//muestro
        }        
        break;
    //trimestre
    case '2':       
       
         $('#contenedor_mes').hide();        
         if(id_unidad != '') {	        	 
	        	  reportar_trimestre();
	        	  $('#reporte_pie').hide();// oculto la parte de grafico
	        }  
        
        
        break;
    //año
    case '3':
         $('#reporte_pie').hide();//oculto la parte de grafico
        $('#contenedor_mes').hide();   
        break;
    default:
            console.log('defecto');
		} 
	
});

	
	
function reportar_meses () {  
	
	var id_unidad=$("#unidad").val();	
	var mes=$("#mes").val();
	var ano=$("#ano").val();
	var tipo=$("#tipo").val();	
	var tiempo=$('input:radio[name=tiempo]').val();	
	
	console.log(id_unidad);
	
	
	var dataString = 'id_unidad=' + id_unidad + '&mes=' + mes + '&ano=' + ano + '&tipo='  + tipo + '&tiempo='+ tiempo;
	
		$.ajax({					
			type: "POST",
			url: BASE_URL + 'Indicadores/reporte_meses',
			data: dataString,
			cache: false,
			dataType : 'json',
			success: function(data)
			{				
			   //var id=e;
			   console.log('entre');  
			  var tabledata='<thead>' ;
			 	  tabledata +='<tr>' ;
			 	  tabledata +='<th>Indicador</th>' ;
			 	  tabledata +='<th>Tipo</th>' ;
			 	  tabledata +='<th>Formula</th>' ;
			 	  tabledata +='<th>Medida</th>' ;
			 	  tabledata +='<th>Consumo</th>' ;
			 	  tabledata +='</tr>' ;
			 	  tabledata +='</thead>' ;
			 	  tabledata +='<tbody>' ;
			  
			  for (var i=0; i < data.length; i++) {
				 
				      tabledata +="<tr>";
				  	  tabledata += "<td>" + data[i].ind_indicador + "</td>";
				  	  tabledata += "<td>" + data[i].ind_tipo + "</td>";
				  	   tabledata += "<td>" + data[i].ind_formula + "</td>";
				  	  tabledata += "<td>" + data[i].med_nombre + "</td>";
				  	  tabledata += "<td>" + data[i].induni_consumo + "</td>";
				  	 // tabledata += "<td>" + data[i].induni_consumo.toPrecision(1) + "</td>";//iNum.toPrecision(1);
				      tabledata +="</tr>";
				};		
			  
			  tabledata +="</tbody>";
			  tabledata +="</table>";
			  
			  //para llenar titulo de tabla
			  var nom_unidad = $("#unidad option:selected").text();
			  var nom_mes = $("#mes option:selected").text();
			  var nom_ano = $("#ano option:selected").text();
			     nom_fecha =  nom_mes + ' - ' + nom_ano;
			     $('#nombre_unidad').html(nom_unidad);
			     $('#nombre_fecha').html(nom_fecha);
			   
			    			   	  
			   $('#tblListar_reporte').empty();
			   $('#tblListar_reporte').append(tabledata);
			  // $("#tblListar_unidades tr:last").find("input").val(""); 
			  
			}, //success end
			error: function(xhr, ajaxOptions, thrownError) {			
						alert('No se pudo cargar tabla');
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
		}); // ajax end
			   
 }
   
 
    
$('#exportar_excel').on('click' , function (){	

	var tiempo2=$('input:radio[name=tiempo]:checked').val();
	var id_unidad=$("#unidad").val();
	console.log(tiempo2);
	
   switch(tiempo2) {
   	//mes
    case '1':
	    	if (id_unidad != '' ) {
	        console.log('llamar reporte  excel meses');
	        excel_reportar_meses();
	       }else {
	       	  alert("Selecciones una unidad");
	       }
        break;
    //trimestre
    case '2':
       console.log('oculto mes');
       
        $('#contenedor_mes').hide();        
        
        break;
    //año
    case '3':
        $('#contenedor_mes').hide();   
        break;
    default:
            console.log('defecto');
		} 
	
});

$('#exportar_pdf').on('click' , function (){	

	var tiempo2=$('input:radio[name=tiempo]:checked').val();
	var id_unidad=$("#unidad").val();
	console.log(tiempo2);
	
   switch(tiempo2) {
   	//mes
    case '1':
	    	if (id_unidad != '' ) {
	        console.log('llamar reporte  pdf meses');
	        pdf_reportar_meses();
	       }else {
	       	  alert("Selecciones una unidad");
	       }
        break;
    //trimestre
    case '2':
       console.log('oculto mes');
       
        $('#contenedor_mes').hide();        
        
        break;
    //año
    case '3':
        $('#contenedor_mes').hide();   
        break;
    default:
            console.log('defecto');
		} 
	
});
 
  function excel_reportar_meses () {  	
	
	var id_unidad=$("#unidad").val();
	
	var mes=$("#mes").val();
	var ano=$("#ano").val();
	var tipo=$("#tipo").val();	
	var nom_mes = $("#mes option:selected").text();
	
	
	window.open(BASE_URL + 'Indicadores/excel_reporte_meses/'+id_unidad+'/'+mes+'/'+ano+'/'+tipo+'/'+nom_mes, '_self');	
   
 }//fin excel_reportar_meses
 
 function pdf_reportar_meses () {  
	
	
	var id_unidad=$("#unidad").val();
	
	var mes=$("#mes").val();
	var ano=$("#ano").val();
	var tipo=$("#tipo").val();	
	var nom_mes = $("#mes option:selected").text();
	
	
	window.open(BASE_URL + 'Indicadores/pdf_reporte_meses/'+id_unidad+'/'+mes+'/'+ano+'/'+tipo+'/'+nom_mes, '_self');	
   
 }//fin excel_reportar_meses
  
 
 function reportar_trimestre () {  
	
	var id_unidad=$("#unidad").val();	
	var mes=$("#mes").val();
	var ano=$("#ano").val();
	var tipo=$("#tipo").val();		
	
	console.log(id_unidad);	
	
	var dataString = 'id_unidad=' + id_unidad + '&mes=' + mes + '&ano=' + ano + '&tipo='  + tipo ;
	
		$.ajax({					
			type: "POST",
			url: BASE_URL + 'Indicadores/reporte_trimestres',
			data: dataString,
			cache: false,
			dataType : 'json',
			success: function(data)
			{				
			   //var id=e;
			   console.log('entre');  
			  var tabledata= '<thead>'+ 
			 	  			    '<tr>' +
				 	  				'<th>Trimestre</th>' +
				 	  				'<th>Indicador</th>'+
				 	  				'<th>Tipo</th>'+
				 	  				'<th>Formula</th>'+
				 	  				'<th>Medida</th>'+
				 					'<th>Consumo</th>'+
			 	 				'</tr>'+
			 	  				'</thead>'+
			 	  				'<tbody>';
			 	
			 indice_fila = 0;
			
			 
			 	  				
			  for (var i=0; i < data.length; i++) {
			  	   
			  	    bandera = true;
			  	    tabledata += '<tr>' + 
			  					'<td rowspan="' + (data[indice_fila].length)  + '"> Trimestre: ' + (indice_fila + 1)  + '</td>';
			  	      
			  		   for (var j=0; j < data[i].length; j++) {	
			  		   	
			  		   	 if (bandera == true) {
			  		   	 	//tabledata += '<tr>';
			  		   	 	//no imprimir empiezo de fila			  		   	 	
			  		   	 } else {			  		   	 	
			  		   	 	tabledata += '<tr>';
			  		   	 }					   
						
					  	  tabledata += "<td>" + data[i][j].ind_indicador + "</td>";
					  	  tabledata += "<td>" + data[i][j].ind_tipo + "</td>";
					  	  tabledata += "<td>" + data[i][j].ind_formula + "</td>";
					  	  tabledata += "<td>" + data[i][j].med_nombre + "</td>";
					  	  if (data[i][j].consumo_total != null) {
					  	  	 tabledata += "<td>" + data[i][j].consumo_total + "</td>";
					  	  }else {
					  	  	 tabledata += "<td> Sin Datos</td>";
					  	  }
					  	 
					  	 // tabledata += "<td>" + data[i].induni_consumo.toPrecision(1) + "</td>";//iNum.toPrecision(1);
					      tabledata +="</tr>";
					      bandera = false;						  
						 };
					 
					 tabledata +="</tr>";	 
					 indice_fila++;	
					 console.log(tabledata);		    
				};		
			  
			  tabledata +="</tbody>";
			 // tabledata +="</table>";
			  
			  //para llenar titulo de tabla
			  var nom_unidad = $("#unidad option:selected").text();
			 // var nom_mes = $("#mes option:selected").text();
			  var nom_ano = $("#ano option:selected").text();
			     nom_fecha =  'Reporte Trimestral del ' + nom_ano;
			     $('#nombre_unidad').html(nom_unidad);
			     $('#nombre_fecha').html(nom_fecha);
			   
			    			   	  
			   $('#tblListar_reporte').empty();
			   $('#tblListar_reporte').append(tabledata);
			  // $("#tblListar_unidades tr:last").find("input").val(""); 
			  
			  console.log(tabledata);
			  
			}, //success end
			error: function(xhr, ajaxOptions, thrownError) {			
						alert('No se pudo cargar tabla');
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
		}); // ajax end
			   
 }
 
    
  	

});  