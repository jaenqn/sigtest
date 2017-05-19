$(document).ready(function()
{
	
	
	$("#agregar_causa").on('click',  function(e)
	{	 
	   alert('presione');
	  	var id_sacp = $('#id_sacp').val();
	  	dataString = 'id_sacp=' + id_sacp;
	  
			$.ajax({
				type: "POST",
				url: BASE_URL + "sacp/listado_ishikawa_xSacp" ,
				data: dataString,
			    dataType : 'json',
				cache: false,
				complete: function() {					
					//alert("cerrar ");
				},
				success: function(datos)
				{	
					console.log('entre');											
					var tabledata = '';						
					for (i = 0; i < datos.length; i++) {						  
					   
					    tabledata +="<tr id='"+datos[i].sacishi_id+"'>"+
							
							"<td>"+
							   "<span>"+datos[i].tipo_texto+"</span>"+					   
							 "</td>"+
							
							"<td>" + datos[i].sacishi_causa + "</td>"+					
							 
							"<td>"+						
								"<a class='delete' href='#'>"+
		                         	"<img src='"+ BASE_URL + "public/views/sacp/img/delete.png' width='20px'></img>" +
		                         "</a> " +						
							"</td>"+
							
							"</tr>";		   
					}
					 $('#tabla_ishikawa tbody').html(tabledata);
					 //$("#tblListar_unidades tr:last").find("input").val(""); 					
					//$('#select_unidades').html(html); 
				
				}, 
				error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
				});
		    
		   
	});	
	
	
	
 

}); // document end
