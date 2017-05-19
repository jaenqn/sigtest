$(document).ready(function()
{
		
    /***********--DELETE--***************/
	$("#tblListar").on('click', "a.delete", function()
	{		
	  var id=$(this).parent().parent().attr('id');	 	 
	 
	  var b=$(this).parent().parent();
	  var dataString = 'id='+ id;
	   if(confirm("¿Seguro que desea eliminar este Plan de Contingencia? "))
		   {
			 $.ajax({
					type: "POST",
					url: BASE_URL + "contingencia/eliminar" ,
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
	
	
	    /***********--APROBAR-***************/
	$("#tblListar").on('click', "a.aprobar", function(e)
	{		
	   e.preventDefault();
		
	  var id=$(this).parent().parent().attr('id');		  
	  var celda_aprobar=$(this).parent().parent().find('td:eq(2)') ;
	  var boton_aprobar=$(this).parent().parent().find('td:eq(4)').find('a.aprobar') ;
	  
	  
	 
	 
	  var dataString = 'id='+ id;
	  
	 
	   if(confirm("¿Seguro que desea aprobar este Plan de Contingencia? "))
		   {
		   //	alert('entre');
			 $.ajax({
					type: "POST",
					url: BASE_URL + "contingencia/cambiar_estado_contigencia/" + id,
					data: dataString,
					cache: false,
					success: function(e)
					{
					  celda_aprobar.html('Publicado'); 
	  				  boton_aprobar.hide();
					}, 
					error: function(xhr, ajaxOptions, thrownError) {			
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					} 
				   });
		  return false;
		   }
	});
	
					
/***********--EDIT--***************/			
$(".edit_btn").bind('click',function()
{
	var ID=$(this).parent().parent().attr('id');
	$(this).hide();
	$("#"+ID).find("a.update").show();
	$("#"+ID).find("a.cancel").show();
	$("#"+ID).find("a.delete").hide();
	$("#"+ID).find("span").hide();
	$("#"+ID).find("input.editbox_search").show();
	$("#"+ID).find("select.editbox_search").show();
	$("#"+ID).find("input.editbox_search").css("border","1px solid red");
});		

/***********--Cancel--***************/
  $('.cancel').bind('click',function(){
   var ID=$(this).parent().parent().attr('id');
   
   var one_val=$("#one_"+ID).html();
   var two_val=$("#two_"+ID).html();
   var three_val=$("#three_"+ID).html();
   
   $("#one_input_"+ID).val(one_val);
   $("#two_input_"+ID).val(two_val);
   $("#three_input_"+ID).val(three_val);
   
   $("#"+ID).find("span").show();
   $("#"+ID).find("input.editbox_search").hide();
    $("#"+ID).find("select.editbox_search").hide();
   
   $("#"+ID).find("a.update").hide();
   $("#"+ID).find("a.cancel").hide();
   $("#"+ID).find("a.delete").show();
   $("#"+ID).find("a.edit_btn").show();	
}); 

/***********--UPDATE--***************/
$(".update").bind('click',function(){
		var ID=$(this).parent().parent().attr('id');		

		var tipo_mant=$("#zero_input_tipo_"+ID+" :selected").val();	    
   
		var sistema=$("#one_input_sistema_"+ID).val();
		var sub_sistema=$("#two_input_sub_sistema_"+ID).val();
		var pieza=$("#three_input_pieza_"+ID).val();
		var parte=$("#four_input_parte_"+ID).val();
		var componente=$("#five_input_componente_"+ID).val();
		var actividad=$("#six_input_actividad_"+ID).val();
		var tiempo=$("#seven_input_tiempo_"+ID).val();	
		
		 var hechopor=$("input:radio[name=hechopor_"+ID+"]:checked").val();    
		
		
		var dataString = 'id='+ ID+'&tipo_mant='+tipo_mant+'&sistema='+sistema+'&sub_sistema='+sub_sistema+'&pieza='+pieza+'&parte='+parte+'&componente='+componente
		    			 +'&actividad='+actividad+'&tiempo='+tiempo+'&hechopor='+hechopor;
	
		
		if(actividad.length>0&&sistema.length>0&&sub_sistema.length>0&&tiempo.length>0){
		
				$.ajax({
				   type: "POST",
				   url: "query_update.php",
				   data: dataString,
				   cache: false,
				   success: function(e)
				   {
				   			if (tipo_mant == 1 ) {
				   				$("#zero_"+ID).html('Eléctrico');
				   			} else {
				   					$("#zero_"+ID).html('Mecánico');
				   			}
							
							$("#one_"+ID).html(sistema);
							$("#two_"+ID).html(sub_sistema);
							$("#three_"+ID).html(pieza);
							$("#four_"+ID).html(parte);
							$("#five_"+ID).html(componente);
							$("#six_"+ID).html(actividad);
							$("#seven_"+ID).html(tiempo);
							
						
							
							
							
							$("#"+ID).find("span").show();
							$("#"+ID).find("input.editbox_search").hide();
							$("#"+ID).find("select.editbox_search").hide();
							
							$("#"+ID).find("a.update").hide();
							$("#"+ID).find("a.cancel").hide();
							
							$("#"+ID).find("a.delete").show();
							$("#"+ID).find("a.edit_btn").show();	

				    }
				   });
				   
	
		} 	
		
		else{
		  alert("field missing");
		}
  });
  
/***********--ADD--***************/
$("#add").bind('click',function(){
	
    var hechopor=$('input:radio[name=hechopor]:checked').val();    
    var tipo_mant=$('#tipo_mant :selected').val();	    
   
	var sistema=$("#sistema").val();
	var sub_sistema=$("#sub_sistema").val();
	var pieza=$("#pieza").val();
	var parte=$("#parte").val();
	var componente=$("#componente").val();
	var actividad=$("#actividad").val();
	var tiempo=$("#tiempo").val();	
	
	var id_plan=$('#id_plan').val();
	var codigo_plan=$('#codigo_plan').val();
	
	
	

	if(actividad.length>0&&sistema.length>0&&sub_sistema.length>0){			
		
		
	var dataString ='tipo_mant='+tipo_mant+'&sistema='+sistema+'&sub_sistema='+sub_sistema+'&pieza='+pieza+'&parte='+parte+'&componente='+componente+'&actividad='+actividad+'&tiempo='+tiempo+'&hechopor='+hechopor;
	    dataString =  dataString + '&id_plan='+id_plan+'&codigo_plan='+codigo_plan;
	
	
	
	$.ajax({
		
		type: "POST",
		url: "query_insert.php",
		data: dataString,
		cache: false,
		success: function(e)
		{
		
			
		   var id=e;   
		   var tabledata="<tr id="+id+">"+
				
				"<td>"+
				   "<span id='one_"+id.replace(/^\s+|\s+$/g,"")+"'>"+id+"</span>"+
				   	"<input  type='text' id='one_input_"+id.replace(/^\s+|\s+$/g,"")+"' value="+tipo_man+" class='editbox_search'  />"+
				 "</td>"+
				
				"<td>"+
				   "<span id='two_"+id.replace(/^\s+|\s+$/g,"")+"'>"+sistema+"</span>"+
				   	"<input type='text' id='two_input_"+id.replace(/^\s+|\s+$/g,"")+"' value="+sistema+" class='editbox_search'  />"+
				"</td>"+
				
				"<td>"+
				  "<span id='three_"+id.replace(/^\s+|\s+$/g,"")+"'>"+sub_sistema+"</span>"+
				  "<input type='text' id='three_input_"+id.replace(/^\s+|\s+$/g,"")+"' value="+sub_sistema+" class='editbox_search' />"+
				 "</td>"+
				 
				"<td>"+
					"<a href='#'  class='edit_btn'>Edit</a> "+
					"<a href='#' class='update'  >Update</a>"+
					"<a href='#'  class='cancel' >Cancel</a>"+
					"<a href='#' class='delete' > Delete </a>"+
				"</td>"+
				
				"</tr>";
		   	  
		  
		   $('#tabla tr:last').before(tabledata);
		   $("#tabla tr:last").find("input").val("");
		  
		} //success end
	}); // ajax end
	
	location.reload();
	}
    else{
	  alert("Falta Llenar Campos");
	}	
 });

}); // document end
