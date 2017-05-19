window.onload = fnload;
function fnload ()
{	
	
	$('.filtro_causa').on('ifChecked', function() {	
		
		 id_sub_estandar =  this.value;
		 dataString = 'id_sub_estandar='+ id_sub_estandar;		
	
		 $.ajax({
					type: "POST",
					url: BASE_URL + "Incidencias/listar_sub_estandar" ,
					data: dataString,
				    dataType : 'json',
					cache: false,
					success: function(datos)
					{	
						//alert("hola");
							
						//console.log(datos);
														
						html = '';						
						for (i = 0; i < datos.length; i++) {						  
						   html += '<option value="' + datos[i]['cau_id'] + '">' +  datos[i]['cau_nombre'] + '</option> ';	
						}	
						
						$('#causas_subEstandar').empty; 			
						$('#causas_subEstandar').html(html); 
					
					}, 
					error: function(xhr, ajaxOptions, thrownError) {			
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
				});
	});	
	
		
}; // document end
