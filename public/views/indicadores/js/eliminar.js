$(document).ready(function()
{
	
	//PARA ELIMINAR DESDE LA TABLA	
    /***********--DELETE--***************/
	$("#tblListar_indicadores").on('click', 'a.delete', function(e)
	{		
	  e.preventDefault();
	 
	   id =  $(this).attr('id');
	   dataString = 'id='+ id;	    
  	   var b=$(this).parent().parent();	
  	   
  	  if(confirm("¿Seguro que desea eliminar este Indicador? "))
		   {
			 $.ajax({
					type: "POST",
					url: BASE_URL + "indicadores/eliminar_indicador_general/" + id  ,
					data: dataString,
					cache: false,
					success: function(e)
					{
						
						b.hide();
						console.log(e);
					}, 
						error: function(xhr, ajaxOptions, thrownError) {			
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				} 
				   });
		  return false;
		   }
	});
	
	
}); // document end
