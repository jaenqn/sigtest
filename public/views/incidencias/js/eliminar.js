$(document).ready(function()
{
	
	//PARA ELIMINAR DESDE LA TABLA	
    /***********--DELETE--***************/
	$("#tblListar_incidencias").on('click', 'a.delete', function(e)
	{		
	  e.preventDefault();
	 
	   id =  $(this).attr('id');
	   dataString = 'id='+ id;	
	   
	   //alert(id);exit;
	       
  	   var b=$(this).parent().parent();	
  	   
  	  if(confirm("¿Seguro que desea eliminar esta Incidencia? "))
		   {
			 $.ajax({
					type: "POST",
					url: BASE_URL + "incidencias/eliminar_incidencia_general/" + id  ,
					data: dataString,
					cache: false,
					success: function(e)
					{
						
						if ( e == 'no_permiso') {
							
							alert('No tiene permiso para eliminar');
							
						}else {
							b.hide();
							console.log(e);
							
						}
						
						
					}, 
						error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
				   });
		  return false;
		   }
	});
	
	
}); // document end
