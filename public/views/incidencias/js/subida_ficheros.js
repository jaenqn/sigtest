$(document).ready(function() {
		
	
	mostrarArchivos();
    $("#boton_subir").on('click', function() {
        subirArchivos();
    });
    $("#listado_evidencia").on('click', '.eliminar_archivo', function() {
        var archivo = $(this).parents("tr").find("td").eq(0).text();
        console.log(archivo);
        archivo = $.trim(archivo);
        console.log(archivo);
        
        eliminarArchivos(archivo);
    });
     
     
     //comprobar si se llenaron algunas variables
     //para preguntar al usuario si cierra por accidente 
      needToConfirm = false; 
     // window.onbeforeunload = askConfirm;
	  function askConfirm() {
	    if (needToConfirm) {
	        // Put your custom message here 
	        return "¿Desea Salir Sin guardar?"; 
	    }
	  }
	  
	
	$("input").change(function() {		
		  apellidos_reporta = $("#apellidos_reporta").val();
	      empresa_reporta = $("#empresa_reporta").val();
	      ocupacion_reporta = $("#ocupacion_reporta").val();
		   if (apellidos_reporta.length > 0 || empresa_reporta.length > 0 || ocupacion_reporta.length > 0){  	      	
     	      	
     	      	 needToConfirm = true;     	      	   	      	
     	      }else {
     	      	
     	      	 needToConfirm = false;    
     	      }
	});
      
	
   function subirArchivos() {
                $("#archivo").upload(BASE_URL + 'Incidencias/evidencia_subir_archivo',
                {
                    //nombre_archivo: $("#nombre_archivo").val(),
                     descripcion: $("#descripcion_documento").val(),
                     identificador: $("#identificador_reporte").val(),
                     tipo: 1
                },
                function(respuesta) {
                    //Subida finalizada.
                    $("#barra_de_progreso").val(0);
                    if (respuesta === 1) {
                        mostrarRespuesta('El archivo ha sido subido correctamente.', true);
                        $("#descripcion_documento, #archivo").val('');
                    } else {
                        //mostrarRespuesta('El archivo NO se ha podido subir.', false);
                        
                         mostrarRespuesta( respuesta, false);
                    }
                    mostrarArchivos();
                }, function(progreso, valor) {
                    //Barra de progreso.
                    $("#barra_de_progreso").val(valor);
                });
            }
            function eliminarArchivos(archivo) {
                $.ajax({
                    url: BASE_URL + 'Incidencias/evidencia_eliminar_archivo',
                    type: 'POST',
                    timeout: 10000,
                    data: {archivo: archivo},
                    error: function(xhr, ajaxOptions, thrownError) {
                        mostrarRespuesta('Error al intentar eliminar el archivo.', false);
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    },
                    success: function(respuesta) {
                    	
                    	/* for (var i = 0; i < respuesta.length; i++) {
                                   console.log(respuesta[i]);
                                }*/
                    	                    	
                    	
                    	//obtener 2do indice
                    	
                    	tipo = typeof(respuesta);                    	
                    	console.log(tipo );
                    	
                        if (respuesta[2] == 1) {
                            mostrarRespuesta('El archivo ha sido eliminado.', true);
                            console.log('correcto!');
                        } else {
                            mostrarRespuesta('Error al intentar eliminar el archivo.', false); 
                            console.log('incorrecto!');                           
                        }
                        mostrarArchivos();
                    }
                });
            }
          
            
            function mostrarArchivos() {
            	
            	identificador =  $("#identificador_reporte").val();
            	tipo = 1;
            	dataString =  'identificador=' +identificador +'&tipo=' + tipo;
            	
            	
                $.ajax({
                	type: "POST",
                    url: BASE_URL + 'Incidencias/evidencia_mostrar_archivos',
                    data: dataString,
                    dataType: 'JSON',
                    success: function(respuesta) {
                        if (respuesta) {
                            var html = '';
                            for (var i = 0; i < respuesta.length; i++) {
                                if (respuesta[i] != undefined) {
                                   // html += '<div class="row"> <span class="col-lg-2"> ' + respuesta[i] + 
                                   // 	' </span> <div class="col-lg-2"> <a class="eliminar_archivo btn btn-danger" href="javascript:void(0);"> Eliminar </a> </div> </div> <hr />';
                                   
                                    html += '<tr> <td class="nom_archivo" style="width: 25em; word-break:break-all;"> ' + respuesta[i]['incevi_nom_fichero'] + '</td> '+
                                   		    	  '<td style="width: 30em; word-break:break-all;">'+ respuesta[i]['incevi_descripcion'] +'</td> '+
                                    	    '<td >' +                                     	    	   
                                    	    	   '<a href="' + BASE_URL + 'docs/evidencia_incidencias/'+ respuesta[i]['incevi_nom_fichero']  +'" target="_blank" class="btn btn-primary"> Ver  </a>' + 
                                    	    	   '<a class="eliminar_archivo btn btn-danger" href="javascript:void(0);"> Eliminar </a>' + 
                                    	    '</td> </tr>'; 	
                                }
                            }
                            $("#listado_evidencia tbody").html(html);
                        }
                    }, 
                   error: function(xhr, ajaxOptions, thrownError) {			
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}   
                });
            }
            function mostrarRespuesta(mensaje, ok){
                $("#respuesta").removeClass('alert-success').removeClass('alert-danger').html(mensaje);              
               
                if(ok){
                    $("#respuesta").addClass('alert-success alert-dismissible fade in');
                }else{
                    $("#respuesta").addClass('alert-danger');
                }
            }          
               
});