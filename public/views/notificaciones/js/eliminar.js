$(document).ready(function()
{

	//PARA ELIMINAR DESDE LA TABLA
    /***********--DELETE--***************/
	$("#tblListar_recibidas").on('click', 'a.delete',function(e)
	{
	  e.preventDefault();

	   id =  $(this).attr('id');
	   dataString = 'id='+ id;
  	   var b=$(this).parent().parent();


	   if(confirm("¿Seguro que desea eliminar esta Notificación? "))
		   {
			 $.ajax({
					type: "POST",
					url: BASE_URL + "notificaciones/eliminar_notificacion" ,
					data: dataString,
					cache: false,
					success: function(e)
					{
						console.log(tabla_observ);
						tabla_observ.draw()
						// b.hide();
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
	  id = $('#rel_id').val();
	   dataString = 'id='+ id;
 	   	swal_option.confirm.title = 'Eliminar Notificación';
        swal_option.confirm.text = '¿Seguro que desea eliminar esta notificación?';
        swal_option.confirm.type = 'warning';
        swal_option.confirm.closeOnCancel = true;
        swal(swal_option.confirm,
            function(isConfirm){
                if (isConfirm) {
                	$.post(BASE_URL + 'notificaciones/eliminar_notificacion', {id: id }, function(data, textStatus, xhr) {
                		// console.log(data);
                				// swal("Datos Actualizados!",'', "success",function(is_confirm){
                				// 		console.log(is_confirm);
                				// 		if(is_confirm)
                				// 			window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
                				// 	});
                				swal({
									  title: "Notificación Eliminada!",
									  text: "",
									  type: "success",
									  showCancelButton: false,
									  confirmButtonText: "Aceptar",
									  closeOnConfirm: false
									},
									function(confirmado){
										console.log(confirmado);
									  	if(confirmado)
									  		window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
									});

                	},'json').fail(fnFailAjax);

                }
        });
	   // if(confirm("¿Seguro que desea eliminar esta Notificación? "))
		  //  {
			 // $.ajax({
				// 		type: "POST",
				// 		url: BASE_URL + "notificaciones/eliminar_notificacion" ,
				// 		data: dataString,
				// 		cache: false,
				// 		success: function(e)
				// 		{
				// 			  window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
				// 		},
				// 		error: function(xhr, ajaxOptions, thrownError) {
				// 			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				// 		}
				//    });
		  // return false;
		  //  }
	});


    // //para cambiar el estado de la Notificacion a visto
    // $("#btn_marcar").on('click',function(e)
    // {
    //     e.preventDefault();
    //     id = $('#rel_id').val();
    //     dataString = 'id='+ id;

    //     swal_option.confirm.title = 'Marcar como Leído';
    //     swal_option.confirm.text = '¿Seguro que desea cambiar el  estado de la notificación?';
    //     swal_option.confirm.type = 'warning';
    //     swal_option.confirm.closeOnCancel = true;
    //     swal(swal_option.confirm,
    //         function(isConfirm){
    //             if (isConfirm) {
    //                 $.post(BASE_URL + 'notificaciones/cambiar_estado_notificacion', {id: id }, function(data, textStatus, xhr) {
    //                     swal_option.confirm.title = '';
    //                     swal_option.confirm.text = '¿Está seguro de rechazar esta Boleta SIG?';
    //                     swal_option.confirm.type = 'warning';
    //                     swal_option.confirm.closeOnCancel = true;
    //                     swal_option.confirm.showLoaderOnConfirm = true;


    //                     swal(swal_option.confirm,
    //                     function(isConfirm){
    //                         if(isConfirm){
    //                             $.post(BASE_URL + 'boletasig/rechazar_proceso/' + idb, {}, function(data, textStatus, xhr) {
    //                                 console.log(data);
    //                                 if(data.resultado){
    //                                     setTimeout(function(){
    //                                         window.location = BASE_URL + 'boletasig/enviar_observacion';
    //                                     },1000)

    //                                 }
    //                             },'json').fail(fnFailAjax);
    //                         }
    //                     });

    //                             window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
    //                 },'json').fail(fnFailAjax);

    //             }
    //     });
    //    // if(confirm("¿Seguro que desea cambiar el estado de la  Notificación? "))
    //       //  {
    //          // $.ajax({
    //             //      type: "POST",
    //             //      url: BASE_URL + "notificaciones/cambiar_estado_notificacion" ,
    //             //      data: dataString,
    //             //      cache: false,
    //             //      success: function(e)
    //             //      {
    //             //            window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
    //             //      },
    //             //      error: function(xhr, ajaxOptions, thrownError) {
    //             //          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    //             //      }
    //             //    });
    //       // return false;
    //       //  }
    // });
	//para cambiar el estado de la Notificacion a visto
	$("#btn_marcar").on('click',function(e)
	{
	 	e.preventDefault();
        if(this.dataset.leido != 1){
            console.log('change');
            id = $('#rel_id').val();
            dataString = 'id='+ id;
            var self = this;
            $.post(BASE_URL + 'notificaciones/cambiar_estado_notificacion', {id: id }, function(data, textStatus, xhr) {
                            self.textContent  = 'Leído';
                            self.dataset.leido = 1;
            },'json');
        }



	   // if(confirm("¿Seguro que desea cambiar el estado de la  Notificación? "))
		  //  {
			 // $.ajax({
				// 		type: "POST",
				// 		url: BASE_URL + "notificaciones/cambiar_estado_notificacion" ,
				// 		data: dataString,
				// 		cache: false,
				// 		success: function(e)
				// 		{
				// 			  window.location.href = BASE_URL + "notificaciones/gestionar_notificaciones";
				// 		},
				// 		error: function(xhr, ajaxOptions, thrownError) {
				// 			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				// 		}
				//    });
		  // return false;
		  //  }
	});

	//para cambiar el estado de la Notificacion a visto
	$("#enviar_notificacion").on('click',function(e)
	{
	 	 e.preventDefault();
	     window.location.href = BASE_URL + "notificaciones/enviar_notificacion_formulario";

	});








}); // document end
