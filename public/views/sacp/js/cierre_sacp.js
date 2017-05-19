$(document).ready(function()
{
	
	

 //para cerrar SACP
/***********--CERRAR SACP--***************/
$("#btn_cerrar_cierre").on('click', '', function(e) {   
    
    
    e.preventDefault();   
   
   	var firma = $("#firma_cierre").val();
	var comentario =$("#comentario_cierre").val();
	var id_sacp =$("#id_sacp").val();
	
	console.log(firma);	
	console.log(comentario);
	console.log(id_sacp);
	
	
	
	if(firma.length>3 && comentario > 3){	
	        casa =1;
	 else{
		   swal("¡Rellene los campos Correctamente!",'', "warning");
		   return false;
		}	

	
	
	 
	  swal({
		  title: "¿Estás seguro que Desea Cerrar esta SACP?",
		  text: "¡Ya no se podrá editar ni agregar datos !",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#DD6B55",
		  cancelButtonText:  "Cancelar",
		  confirmButtonText: "Si, Cerrar",
		  closeOnConfirm: false
		},
		function(){
			
			
			if(firma.length>3 && comentario > 3){		
		
			var dataString ='id_sacp='+id_sacp + '&firma=' +firma + '&comentario=' + comentario;	
	
		  
			  $.ajax({
						type: "POST",
						url: BASE_URL + "sacp/eliminar_seguimiento",
						data: dataString,
						cache: false,
						success: function(e)
						{
							
							swal("¡Sacp Cerrada!",'', "success");
						},
						error: function(xhr, ajaxOptions, thrownError) {			
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
					 
					 } 
					   
					 );
			
		
			}
	    
			
					  
		});

	
 }); 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


}); // document end

window.onload = fnload;
function fnload ()
{	
	$("#tbl_seguimiento").on('click', 'a.preview', function(e)
{
  var id_sacseg=$(this).parent().parent().attr('id');  
  // alert(id);exit; 
  //var b=$(this).parent().parent();
  var dataString = 'id_sacseg='+ id_sacseg;
  
		 $.ajax({
				type: "POST",
				url: BASE_URL + "sacp/obtener_seguimiento",
				data: dataString,
				cache: false,
				success: function(data)
				{
					//console.log(data);
					
					//parseo 
					var data = JSON.parse(data);		
					
					if (data.sacseg_accion == 1 ) {
						console.log('soy si');
						  $("#implementa_segui_si").iCheck('check');
						  $("#implementa_segui_no").iCheck('uncheck'); 					 	
					}else {
						console.log('soy no');
						$("#implementa_segui_si").iCheck('uncheck'); 	
						 $("#implementa_segui_no").iCheck('check');					 
					}
					
									
					 $("#fecha_segui").val(data.sacseg_fecha);
				   	 $("#comentario_segui").val(data.sacseg_coment);
				   	
				  
					
				},           
				 	
		         	error: function(xhr, ajaxOptions, thrownError) {			
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
						
			   });
	    		return false;
	   
});
	
		
}; // document end
