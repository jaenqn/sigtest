$(document).ready(function()
{
		
    /***********--DELETE--***************/
//$(".delete").on('click',function()
$("#tblListar_unidades").on('click', 'a.delete', function(e)
{
  var id=$(this).parent().parent().attr('id');  
 // alert(id);exit; 
  var b=$(this).parent().parent();
  var dataString = 'id='+ id;
   if(confirm("Seguro que desea Borrar esta Unidad de Medida? "))
	   {
		 $.ajax({
				type: "POST",
				url: BASE_URL + "indicadores/eliminar_unidad_medida",
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
  
/***********--ADD--***************/
$("#tblListar_unidades").on('click', 'a.add', function(e) {   
   
	var unidad_medida_nueva=$("#unidad_medida_nueva").val();
	
	var copia_nombre_unidad = unidad_medida_nueva; //copia, para el insertado , luego del borrado de 
												// $("#tblListar_unidades tr:last").find("input").val(""); 

	if(unidad_medida_nueva.length>1){		
		
	var dataString ='unidad_nueva='+unidad_medida_nueva;	
	
		$.ajax({					
			type: "POST",
			url: BASE_URL + 'Indicadores/agregar_unidadMedida',
			data: dataString,
			cache: false,
			success: function(e)
			{				
			   var id=e;
			   //console.log(id);   
			   var tabledata="<tr id='"+id+"'>"+
					
					"<td>"+
					   "<span id='one_"+id +"'>"+unidad_medida_nueva+"</span>"+
					   	"<input  type='text' id='one_input_"+id+"' value="+copia_nombre_unidad+" class='editbox_search'  />"+
					 "</td>"+
					
					"<td> NO </td>"+					
					 
					"<td>"+
						"<a class='edit' href='#tblListar_unidades'>"+
                         	"<img src='"+ BASE_URL + "public/views/indicadores/img/edit.png' width='20px'></img>" +
                         "</a> " +
						"<a class='delete' href='#tblListar_unidades'>"+
                         	"<img src='"+ BASE_URL + "public/views/indicadores/img/delete.png' width='20px'></img>" +
                         "</a> " +
						"<a class='update' href='#tblListar_unidades'>"+
                         	"<img src='"+ BASE_URL + "public/views/indicadores/img/checkmark_24.png' width='20px'></img>" +
                         "</a> " +
						"<a class='cancel' href='#tblListar_unidades'>"+
                         	"<img src='"+ BASE_URL + "public/views/indicadores/img/block_24.png' width='20px'></img>" +
                         "</a> " +
					"</td>"+
					
					"</tr>";
			   	  
			  
			   $('#tblListar_unidades tr:last').before(tabledata);
			   $("#tblListar_unidades tr:last").find("input").val(""); 
			  
			}, //success end
			error: function(e){
				alert("No se pudo Agregar");
			}
		}); // ajax end
		
		//location.reload();
		}
	    else{
		  alert("Ingrese al menos 2 caracteres");
		}	
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
