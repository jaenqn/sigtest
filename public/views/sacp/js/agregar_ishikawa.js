$(document).ready(function()
{
	
	
	
	
	
	
	
	function llenar_tabla_ishikawa () {
		
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
					
					
						if (datos.length == 0 ){							
							tabledata += '<tr> <td colspan="3"> <center> Sin datos</center></td></tr>';
						}
					
											
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
		
	}
	
	
	function llenar_tabla_cinco_porque () {
		
		var id_sacp = $('#id_sacp').val();
	  	dataString = 'id_sacp=' + id_sacp;
	  
			$.ajax({
				type: "POST",
				url: BASE_URL + "sacp/listado_cinco_porque_xSacp" ,
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
					
					
						if (datos.length == 0 ){							
							tabledata += '<tr> <td colspan="2"> <center> Sin datos</center></td></tr>';
						}
					
											
					for (i = 0; i < datos.length; i++) {						  
					   
					    tabledata +="<tr id='"+datos[i].sacishi_id+"'>"+							
							
							"<td>" + datos[i].sacishi_causa + "</td>"+					
							 
							"<td>"+						
								"<a class='preview' href='#'>"+
									"<img src='"+ BASE_URL + "public/views/sacp/img/text_preview.png' width='20px'></img> " +	
								"</a> &nbsp;&nbsp;" +
								
								"<a class='delete' href='#'>"+								
		                         	"<img src='"+ BASE_URL + "public/views/sacp/img/delete.png' width='20px'></img>" +
		                         "</a> " +						
							"</td>"+
							
							"</tr>";
						
									   
					}
					 $('#tabla_cinco_porque tbody').html(tabledata);
					
				
				}, 
				error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
				});		
		
	}
	
	//al presionar el boton de agregar Causa
	//llenará la tabla ishikawa - cinco por qué, con datos previos
	$("#agregar_causa").on('click',  function(e)
	{	 	   
	  	llenar_tabla_ishikawa ();
	  	llenar_tabla_cinco_porque();
		   
	});	
	
	
	//al presionar el boton de agregar Generar Diagragama 
	//abribará nueva ventana con el diagrama de Ishikawa
	$("#generar_diagrama").on('click',  function(e)
	{	 	  
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
								
					window.open(BASE_URL + 'sacp/generar_diagrama_ishikawa_xSacp/'+id_sacp, '_blank');				
				
				}, 
				error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
				});		    
		   
	});	
	





	
		
    /***********--DELETE--***************/
//PARA ELIMINAR DE LA TABLA DE ISHIKAWA
$("#tabla_ishikawa").on('click', 'a.delete', function(e)
{
  var id=$(this).parent().parent().attr('id');  
  // alert(id);exit; 
  var b=$(this).parent().parent();
  var dataString = 'id='+ id;
   if(confirm("Seguro que desea Borrar esta Causa? "))
	   {
		 $.ajax({
				type: "POST",
				url: BASE_URL + "sacp/eliminar_causa_ishikawa",
				data: dataString,
				cache: false,
				success: function(e)
				{
					b.hide();
				}
			   });
	    return false;
	   }
});

  /***********--DELETE--***************/
//PARA ELIMINAR DE LA TABLA DE CINCO POR QUÉ
$("#tabla_cinco_porque").on('click', 'a.delete', function(e)
{
  var id=$(this).parent().parent().attr('id');  
   //alert(id);exit; 
  var b=$(this).parent().parent();
  var dataString = 'id='+ id; 
	  
	  swal({
		  title: "¿Estás seguro que Desea Borrar?",
		  text: "No se podrá recuperar el registro!",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  cancelButtonText:  "Cancelar",
		  confirmButtonText: "Si, Borrar",
		  closeOnConfirm: true
		},
		function(){
		  
		  $.ajax({
					type: "POST",
					url: BASE_URL + "sacp/eliminar_causa_ishikawa",
					data: dataString,
					cache: false,
					success: function(e)
					{
						b.hide();
					}
				   });
		    return false;
		  
		});
   	  
});


    /***********--MOSTRAR DETALLE DE CINCO POR QUÉ--***************/
//llenar los campos de preg y resp, con la causa especifica
$("#tabla_cinco_porque").on('click', 'a.preview', function(e)
{
  var id=$(this).parent().parent().attr('id');  
  // alert(id);exit; 
  //var b=$(this).parent().parent();
  var dataString = 'id='+ id;
  
		 $.ajax({
				type: "POST",
				url: BASE_URL + "sacp/obtener_cinco_porque",
				data: dataString,
				cache: false,
				success: function(data)
				{
					//console.log(data);
					
					//parseo 
					var data = JSON.parse(data);		
				
					
					//console.log('traigo datos' , data_parse.sacau_preg1);
					//console.log('traigo datos' , data_parse['sacau_preg1']);
					
					
					 $("#preg_1").val(data.sacau_preg1);
				   	 $("#resp_1").val(data.sacau_resp1);
				   	
				   	 $("#preg_2").val(data.sacau_preg2);
				   	 $("#resp_2").val(data.sacau_resp2);
				   	
				   	 $("#preg_3").val(data.sacau_preg3);
				   	 $("#resp_3").val(data.sacau_resp3);
				   	
				   	 $("#preg_4").val(data.sacau_preg4);
				   	 $("#resp_4").val(data.sacau_resp4);
				   	
				   	 $("#preg_5").val(data.sacau_preg5);
				   	 $("#resp_5").val(data.sacau_resp5);				   	
				   	
					$("#causa_raiz_encontrada").val(data.sacishi_causa);
					
				},           
				 	
		         	error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
						
			   });
	    		return false;
	   
});


					
/***********--EDIT--***************/			
$("#tblListar_unidades").on('click', 'a.edit', function(e)
{
	var ID=$(this).parent().parent().attr('id');
	$(this).hide();
	$("#"+ID).find("a.update").show();
	$("#"+ID).find("a.cancel").show();
	$("#"+ID).find("a.delete").hide();
	$("#"+ID).find("span").hide();
	$("#"+ID).find("input.editbox_search").show();
	$("#"+ID).find("input.editbox_search").css("border","1px solid red");
	$("#"+ID).find("input.editbox_search").css("width","4em");
});		

/***********--Cancel--***************/
 // $('.cancel').on('click',function(){
$("#tblListar_unidades").on('click', 'a.cancel', function(e) {
   var ID=$(this).parent().parent().attr('id');
   
   var one_val=$("#one_"+ID).html();
   //var two_val=$("#two_"+ID).html();
   //var three_val=$("#three_"+ID).html();
   
   $("#one_input_"+ID).val(one_val);
  // $("#two_input_"+ID).val(two_val);
   //$("#three_input_"+ID).val(three_val);
   
   $("#"+ID).find("span").show();
   $("#"+ID).find("input.editbox_search").hide();
   
   
   $("#"+ID).find("a.update").hide();
   $("#"+ID).find("a.cancel").hide();
   $("#"+ID).find("a.delete").show();
   $("#"+ID).find("a.edit").show();	
}); 

/***********--UPDATE--***************/
//$(".update").on('click',function(){
$("#tblListar_unidades").on('click', 'a.update', function(e) {
	
		var ID=$(this).parent().parent().attr('id');		 
   
		var medida=$("#one_input_"+ID).val();		
		//para uso
		var two_val=$("#two_"+ID).html();
			
		var dataString = 'id='+ ID+'&medida='+medida;	
		
		
		if(medida.length>1){		
				$.ajax({
				   type: "POST",
				   url: BASE_URL + "indicadores/actualizar_unidad_medida",
				   data: dataString,
				   cache: false,
				   success: function(e)
				   {
				   			//alert('entre');
							
							$("#one_"+ID).html(medida);
							//$("#two_"+ID).html(sub_sistema);
							
							
							$("#"+ID).find("span").show();
							$("#"+ID).find("input.editbox_search").hide();
							
							
							$("#"+ID).find("a.update").hide();
							$("#"+ID).find("a.cancel").hide();
							
							$("#"+ID).find("a.delete").show();
							$("#"+ID).find("a.edit").show();	

				   },            	
	         	error: function(xhr, ajaxOptions, thrownError) {			
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
				   
			});
				   
	
		} 	
		
		else{
		  alert("¡Ingrese al menos 2 caracteres!");
		}
  });
 
 
 //agrega causa-ishikawa   (de manera individual)  
/***********--ADD--***************/
$("#guardar_causa_ishikawa").on('click', '', function(e) {   
   
   	var causa_tipo_ishikawa = $("#causa_tipo_ishikawa").val();
	var causa_texto_ishikawa =$("#causa_texto_ishikawa").val();
	var id_sacp =$("#id_sacp").val();
	
	console.log(causa_tipo_ishikawa);	
	console.log(causa_texto_ishikawa);
	console.log(id_sacp);
	
	var causa_tipo_en_texto = $("#causa_tipo_ishikawa option:selected").text();
	
	
  console.log(causa_tipo_en_texto);
	 

	if(causa_texto_ishikawa.length>1){		
		
	var dataString ='tipo='+causa_tipo_ishikawa + '&texto=' +causa_texto_ishikawa + '&id_sacp=' + id_sacp;	
	
		$.ajax({					
			type: "POST",
			url: BASE_URL + 'sacp/agregar_causa_ishikawa',
			data: dataString,
			cache: false,
			success: function(e)
			{				
			   var id=e;
			   console.log(id);   
			   var tabledata="<tr id='"+id+"'>"+
					
					"<td>"+
					   "<span id='one_"+id +"'>"+causa_tipo_en_texto+"</span>"+					   
					 "</td>"+
					
					"<td>" + causa_texto_ishikawa + "</td>"+					
					 
					"<td>"+						
						"<a class='delete' href='#'>"+
                         	"<img src='"+ BASE_URL + "public/views/sacp/img/delete.png' width='20px'></img>" +
                         "</a> " +						
					"</td>"+
					
					"</tr>";
			   	  
			  
			    //$('#tabla_ishikawa tbody').append(tabledata);
			   //$("#tblListar_unidades tr:last").find("input").val(""); 
			     llenar_tabla_ishikawa ();			     			   
			    $("#causa_texto_ishikawa").val("");
			     swal("Causa Agregada!",'', "success");
			  
			}, //success end
			error: function(xhr, ajaxOptions, thrownError){
				//alert("No se pudo Agregar causa de Ishikawa");
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		}); // ajax end
		
		//location.reload();
		}
	    else{
		  alert("Ingrese al menos 2 caracteres");
		}	
 });
 

//para copiar el contenido de la respuesta  5
// al causa raiz, al dejar el input resp_5
$("#resp_5").on('focusout', '', function(e) {  
	
	resp_5 = $("#resp_5").val();
	$("#causa_raiz_encontrada").val(resp_5);	
	
 });



 //agrega causa-cinco-porque (de manera individual)  
/***********--ADD--***************/
$("#guardar_causa_cinco").on('click', '', function(e) {   
   
   e.preventDefault();
   
   var id_sacp =$("#id_sacp").val();
   
   	var preg_1 = $("#preg_1").val();
   	var resp_1 = $("#resp_1").val();
   	
   	var preg_2 = $("#preg_2").val();
   	var resp_2 = $("#resp_2").val();
   	
   	var preg_3 = $("#preg_3").val();
   	var resp_3 = $("#resp_3").val();
   	
   	var preg_4 = $("#preg_4").val();
   	var resp_4 = $("#resp_4").val();
   	
   	var preg_5 = $("#preg_5").val();
   	var resp_5 = $("#resp_5").val();
   	
   	
	var causa_raiz_encontrada =$("#causa_raiz_encontrada").val();
	
	
	
	//console.log(causa_tipo_ishikawa);	
	//console.log(causa_texto_ishikawa);
	  //console.log(causa_tipo_en_texto);
	console.log(id_sacp);
	
	//var causa_tipo_en_texto = $("#causa_tipo_ishikawa option:selected").text();
	
	

	 

	if(preg_1.length>1 && preg_2.length>1 && preg_3.length>1 && preg_4.length>1 && preg_5.length>1){		
		
	var dataString ='id_sacp='+id_sacp + '&preg_1=' +preg_1 + '&resp_1=' + resp_1 + '&preg_2=' +preg_2 + '&resp_2=' + resp_2;
	dataString  +=  '&preg_3=' +preg_3 + '&resp_3=' + resp_3 + '&preg_4=' +preg_4 + '&resp_4=' + resp_4 + '&preg_5=' +preg_5 + '&resp_5=' + resp_5;    
	dataString  +=  '&causa_raiz=' +causa_raiz_encontrada;
	
		$.ajax({					
			type: "POST",
			url: BASE_URL + 'sacp/agregar_causa_cinco_porque',
			data: dataString,
			cache: false,
			success: function(e)
			{				
			   var id=e;
			   console.log(id);   
			   var tabledata="<tr id='"+id+"'>"+
					
					
					"<td>" + causa_raiz_encontrada + "</td>"+					
					 
					"<td>"+						
						"<a class='delete' href='#'>"+
							"<img src='"+ BASE_URL + "public/views/sacp/img/text_preview.png' width='20px'></img> &nbsp;&nbsp" +
                         	"<img src='"+ BASE_URL + "public/views/sacp/img/delete.png' width='20px'></img>" +
                         "</a> " +						
					"</td>"+
					
					"</tr>";
			   	  
			  
			    //$('#tabla_cinco_porque tbody').append(tabledata);
			   //para limpiar los inputs
			    $("#preg_1 ,#resp_1, #preg_2 ,#resp_2, #preg_3 ,#resp_3, #preg_4 ,#resp_4, #preg_5 ,#resp_5, #causa_raiz_encontrada ").val("");
			    llenar_tabla_cinco_porque();
			     swal("Causa Agregada!",'', "success");
			  
			}, //success end
			error: function(xhr, ajaxOptions, thrownError){
				//alert("No se pudo Agregar causa de Ishikawa");
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		}); // ajax end
		
		//location.reload();
		}
	    else{
		  //alert("Ingrese Preguntas Validas");warning
		  swal("Ingrese los Campos faltantes!",'', "warning");
		}	
 }); 
 
 
//al presionar el boton se  guardara todas las causas en la sacp,
// tanto ishikawa como cinco por que 
$("#btn_agregar_causas").on('click', '', function(e)
{
    var id_sacp =$("#id_sacp").val();
   //alert(id);exit; 
	//var b=$(this).parent().parent();
	var dataString = 'id_sacp='+ id_sacp; 
	  
	  swal({
		  title: "¿Seguro que Desea Agregar Todas las Causas?",		  
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  cancelButtonText:  "No",
		  confirmButtonText: "Si",
		  closeOnConfirm: true
		},
		function(){
		  
		  $.ajax({
					type: "POST",
					url: BASE_URL + "sacp/agregar_causas_todas",
					data: dataString,
					cache: false,
					success: function(e)
					{
						//llenar_tabla_causas();
					}
				   });
		    return false;
		  
		});
   	  
});
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
$("#btn_cerrar_pie, #btn_cerrar_cabeza").on('click',function(){
 	
 		 $.ajax({
				type: "POST",
				url: BASE_URL + "indicadores/listar_unidades_medidas" ,
				//data: dataString,
			    dataType : 'json',
				cache: false,
				complete: function() {					
					//alert("cerrar ");
				},
				success: function(datos)
				{	
					console.log('entre');											
					html = '';						
					for (i = 0; i < datos.length; i++) {						  
					   html += '<option value="' + datos[i]['med_id'] + '">' +  datos[i]['med_nombre'] + '</option> ';	
					}				
					$('#select_unidades').html(html); 
				
				}, 
				error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
				});
 
 //al cerra el modal
 
 });
 

}); // document end
