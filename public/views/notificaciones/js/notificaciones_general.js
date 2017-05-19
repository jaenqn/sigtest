$(document).ready(function()
{	
	
	cant_obs = 0 ;
	cant_not = 0 ;
	
    html =  '';
    html2 = '';	   
	
	
	observaciones();	
	
	notificaciones();
    
    numero_total();
	
	   
   
   //comprobar si hay notificaciones nuevas 
		 
	function notificaciones () {	 	   
	  $.ajax({
				type: "POST",
				url: BASE_URL + "notificaciones/comprobar_notificaciones" ,				
			    dataType : 'json',
				cache: false,
				//async:false,  
				success: function(datos)
				{	
									
					cant_not =   datos.length;
					
					//alert(cant_not) ;			
							 					
					html = '';							
					for (i = 0; i < datos.length; i++) {
					   html += '<li>';
					   html +=   '<a href="' + BASE_URL + 'notificaciones/leer_notificacion/' + datos[i]['rel_id'] + '">';
                       html += 	  '<span>';
                       html += 		'<span>Notificacion' + (i + 1 ) + '</span>';
                       html += 		'<span class="time">' + datos[i]['rel_fecha'] + '</span>';
                       html += 	  '</span>';
                       html += 	  '<span class="message">' + datos[i]['rel_asunto'] + '</span>';
                       html +=   '</a>';
					   html +=  '</li>';
                	}
                	
                	//para ver todas las notificaciones
				/*	html += ' <li><div class="text-center">';
					html +=  '<a href="' + BASE_URL + 'notificaciones/gestionar_notificaciones"> <strong>Ver todas las Notificaciones</strong><i class="fa fa-angle-right"></i></a>';
					html +=  '</div></li>';	*/
                	
                	$('#menu1').prepend(html); 
				
				}, 
				error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
		});
	
   }
	
	
	//comprobar si hay observaciones nuevas 
	
	function observaciones () {
		   
	  $.ajax({
	  	
				type: "POST",
				url: BASE_URL + "notificaciones/comprobar_observaciones" ,				
			    dataType : 'json',
				cache: false,
				//async:false,  			
				success: function(datos2)
				{				
										
					//alert("hola");
					console.log("hola"); //para forzar la lectura de observaciones
							
					//cant_not = cant_not +  datos.length;
					cant_obs =     datos2.length;
					
					//alert(cant_obs) ;
				
												
					for (i = 0; i < datos2.length; i++) {
					   html2  += '<li>';
					   html2  +=   '<a href="' + BASE_URL + 'notificaciones/leer_observacion/' + datos2[i]['obs_id'] + '">';
                       html2  += 	  '<span>';
                       html2  += 		'<span>Observacion ' + (i + 1 ) + '</span>';
                       html2  += 		'<span class="time">' + datos2[i]['obs_fecha'] + '</span>';
                       html2  += 	  '</span>';
                       html2  += 	  '<span class="message">' + datos2[i]['obs_asunto'] + '</span>';
                       html2  +=   '</a>';
					   html2  +=  '</li>';
                	}
                	
                			   
					//para ver todas las notificaciones
					html2 += ' <li><div class="text-center">';
					html2 +=  '<a href="' + BASE_URL + 'notificaciones/gestionar_notificaciones"> <strong>Ver todas </strong><i class="fa fa-angle-right"></i></a>';
					html2 +=  '</div></li>';		
			
                	
                	$('#menu1').append(html2 ); 
                	
				
				}, 
				error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
		});
	
	}
	

	function numero_total () {
	
	total = cant_not + cant_obs;
	//alert(total + 'por qué 0?' );
				
	if (total == 0 )	{
			$('#cantidad_notificaciones').hide();
		}else {
			$('#cantidad_notificaciones').html(total);
		}	  
 	}
   
	
	
	

	
 

}); // document end
