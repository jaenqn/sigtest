$(document).ready(function() {
	
	
	mostrarArchivos_respuesta();
    $("#boton_subir_respuesta").on('click', function() {
        subirArchivos_respuesta();
    });
    $("#listado_evidencia_respuesta").on('click', '.eliminar_archivo', function() {
        var archivo = $(this).parents("tr").find("td").eq(0).text();
        console.log(archivo);
        archivo = $.trim(archivo);
        console.log(archivo);
        
        eliminarArchivos_respuesta(archivo);
    });
     
     
	
	
   function subirArchivos_respuesta() {
   			
   	
                $("#archivo_respuesta").upload(BASE_URL + 'Incidencias/evidencia_subir_archivo_respuesta',
                {
                    //nombre_archivo: $("#nombre_archivo").val(),
                     descripcion: $("#descripcion_documento_respuesta").val(),
                     identificador: $("#identificador_reporte").val(),
                     tipo: 2
                },
                function(respuesta) {
                	                	
                    //Subida finalizada.
                    $("#barra_de_progreso").val(0);
                    if (respuesta === 1) {
                        mostrarRespuesta_respuesta('El archivo ha sido subido correctamente.', true);
                        $("#descripcion_documento_respuesta, #archivo_respuesta").val('');
                    } else {
                        //mostrarRespuesta('El archivo NO se ha podido subir.', false);
                        
                         mostrarRespuesta_respuesta( respuesta, false);
                    }
                    mostrarArchivos_respuesta();
                }, function(progreso, valor) {
                    //Barra de progreso.
                    $("#barra_de_progreso").val(valor);
                });
            }
  function eliminarArchivos_respuesta(archivo) {
                $.ajax({
                    url: BASE_URL + 'Incidencias/evidencia_eliminar_archivo',
                    type: 'POST',
                    timeout: 10000,
                    data: {archivo: archivo},
                    error: function(xhr, ajaxOptions, thrownError) {
                        mostrarRespuesta_respuesta('Error al intentar eliminar el archivo.', false);
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    },
                    success: function(respuesta) {
                        if (respuesta[2] == 1) {
                            mostrarRespuesta_respuesta('El archivo ha sido eliminado.', true);
                        } else {
                            mostrarRespuesta_respuesta('Error al intentar eliminar el archivo.', false);                            
                        }
                        mostrarArchivos_respuesta();
                    }
                });
            }
            
                       
            
            function mostrarArchivos_respuesta() {
            	
            	identificador =  $("#identificador_reporte").val();
            	tipo = 2;
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
                            $("#listado_evidencia_respuesta tbody").html(html);
                        }
                    }, 
                   error: function(xhr, ajaxOptions, thrownError) {			
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}   
                });
            }
            function mostrarRespuesta_respuesta(mensaje, ok){
                $("#respuesta_respuesta").removeClass('alert-success').removeClass('alert-danger').html(mensaje);                
                         
                if(ok){
                    $("#respuesta_respuesta").addClass('alert-success alert-dismissible fade in');
                }else{
                    $("#respuesta_respuesta").addClass('alert-danger');
                }
            }          
               
});