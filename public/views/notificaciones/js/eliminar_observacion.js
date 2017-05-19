$(document).ready(function()
{

	//PARA ELIMINAR DESDE LA TABLA
    /***********--DELETE--***************/
	$("#tblListar_observaciones").on('click', 'a.delete',function(e)
	{
	  e.preventDefault();

	   id =  $(this).attr('id');
	   dataString = 'id='+ id;
  	   var b=$(this).parent().parent();

	   if(confirm("¿Seguro que desea eliminar esta Observacion? "))
		   {
			 $.ajax({
					type: "POST",
					url: BASE_URL + "notificaciones/eliminar_notificacion" ,
					data: dataString,
					cache: false,
					success: function(e)
					{
					b.hide();


					},
						error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
				   });
		  return false;
		   }
	});


	//para eliminar desde LEER NOTIFICACION
	 /***********--DELETE--***************/
	$("#btn_eliminar").on('click',function(e)
	{
	  e.preventDefault();
	  id = $('#obs_id').val();
	  dataString = 'id='+ id;


	   if(confirm("¿Seguro que desea eliminar esta Observación? "))
		   {
			 $.ajax({
						type: "POST",
						url: BASE_URL + "notificaciones/eliminar_observacion" ,
						data: dataString,
						cache: false,
						success: function(e)
						{
							  window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
				   });
		  return false;
		   }
	});


	//para cambiar el estado de la Notificacion a visto
	$("#btn_marcar").on('click',function(e)
	{
	 	 e.preventDefault();
	 	 if(this.dataset.leido != 1){
	 	 	console.log('change');
	 	 	id = $('#obs_id').val();
	    	dataString = 'id='+ id;
	    	var self = this;

	   // if(confirm("¿Seguro que desea cambiar el estado de la  Observación? "))
		   // {
			 $.ajax({
						type: "POST",
						url: BASE_URL + "notificaciones/cambiar_estado_observacion" ,
						data: dataString,
						cache: false,
						success: function(e)
						{
							self.textContent  = 'Leído';
							self.dataset.leido = 1;

							  // window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
						}
				   });
		  return false;
		   // }
	 	 }

	});

	//para cambiar el estado de la Notificacion a visto
	$("#enviar_notificacion").on('click',function(e)
	{
	 	 e.preventDefault();
	     window.location.href = BASE_URL + "notificaciones/enviar_notificacion_formulario";

	});







}); // document end
