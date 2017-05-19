$(document).ready(function()
{

$('#ayuda_subir').on('click',    function(e) {
              	
              	alert('hola');
              	
              $.ajax({
					type: "POST",
					url: BASE_URL + "reutilizables/combobox_unidades" ,
					data: dataString,
				    dataType : 'json',
					cache: false,
					success: function(datos)
					{	
						//alert("hola");
							
						//console.log(datos);
														
						html = '';						
						for (i = 0; i < datos.length; i++) {						  
						   html += '<option value="' + datos[i]['idDepend'] + '">' +  datos[i]['desDepend'] + '</option> ';	
						}				
						$('#selUnidad').html(html); 
					
					}, 
					error: function(xhr, ajaxOptions, thrownError) {			
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
				});
  );
});