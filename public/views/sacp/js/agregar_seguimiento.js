$(document).ready(function() {






    //al presionar la pestaña  seguimiento
    //llenará la tabla de seguimientos  con datos previos
    $("#profile-tab3").on('click', function(e) {
        llenar_tabla_seguimiento();

    });




    /***********--DELETE--***************/
    //PARA ELIMINAR DE LA TABLA SEGUIMIENTO
    $("#tbl_seguimiento").on('click', 'a.delete', function(e) {
        var id = $(this).parent().parent().attr('id');
        //alert(id);exit;
        var b = $(this).parent().parent();
        var dataString = 'id=' + id;

        swal({
                title: "¿Estás seguro que Desea este Seguimiento?",
                text: "No se podrá recuperar el registro!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                cancelButtonText: "Cancelar",
                confirmButtonText: "Si, Borrar",
                closeOnConfirm: true
            },
            function() {

                $.ajax({
                        type: "POST",
                        url: BASE_URL + "sacp/eliminar_seguimiento",
                        data: dataString,
                        cache: false,
                        success: function(e) {
                            b.hide();
                            swal("¡Seguimiento Borrado!", '', "success");
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }

                    }

                );
                return false;

            });

    });


    /***********--MOSTRAR DETALLE DE CADA SEGUIMIENTO--***************/
    //llenar los campos de preg y resp, con la causa especifica
    /*$("#tbl_seguimiento").on('click', 'a.preview', function(e)
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
    						  $("#implementa_segui_si").attr('checked', true);
    						  $("#implementa_segui_no").removeAttr('checked');
    					}else {
    						console.log('soy no');
    						$("#implementa_segui_si").removeAttr('checked');
    						 $("#implementa_segui_no").attr('checked', true);
    					}


    					 $("#fecha_segui").val(data.sacseg_fecha);
    				   	 $("#comentario_segui").val(data.sacseg_coment);



    				},

    		         	error: function(xhr, ajaxOptions, thrownError) {
    					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    						}

    			   });
    	    		return false;

    }); */



    /***********--EDIT--***************/
    $("#tblListar_unidades").on('click', 'a.edit', function(e) {
        var ID = $(this).parent().parent().attr('id');
        $(this).hide();
        $("#" + ID).find("a.update").show();
        $("#" + ID).find("a.cancel").show();
        $("#" + ID).find("a.delete").hide();
        $("#" + ID).find("span").hide();
        $("#" + ID).find("input.editbox_search").show();
        $("#" + ID).find("input.editbox_search").css("border", "1px solid red");
        $("#" + ID).find("input.editbox_search").css("width", "4em");
    });

    /***********--Cancel--***************/
    // $('.cancel').on('click',function(){
    $("#tblListar_unidades").on('click', 'a.cancel', function(e) {
        var ID = $(this).parent().parent().attr('id');

        var one_val = $("#one_" + ID).html();
        //var two_val=$("#two_"+ID).html();
        //var three_val=$("#three_"+ID).html();

        $("#one_input_" + ID).val(one_val);
        // $("#two_input_"+ID).val(two_val);
        //$("#three_input_"+ID).val(three_val);

        $("#" + ID).find("span").show();
        $("#" + ID).find("input.editbox_search").hide();


        $("#" + ID).find("a.update").hide();
        $("#" + ID).find("a.cancel").hide();
        $("#" + ID).find("a.delete").show();
        $("#" + ID).find("a.edit").show();
    });

    /***********--UPDATE--***************/
    //$(".update").on('click',function(){
    $("#tblListar_unidades").on('click', 'a.update', function(e) {

        var ID = $(this).parent().parent().attr('id');

        var medida = $("#one_input_" + ID).val();
        //para uso
        var two_val = $("#two_" + ID).html();

        var dataString = 'id=' + ID + '&medida=' + medida;


        if (medida.length > 1) {
            $.ajax({
                type: "POST",
                url: BASE_URL + "indicadores/actualizar_unidad_medida",
                data: dataString,
                cache: false,
                success: function(e) {
                    //alert('entre');

                    $("#one_" + ID).html(medida);
                    //$("#two_"+ID).html(sub_sistema);


                    $("#" + ID).find("span").show();
                    $("#" + ID).find("input.editbox_search").hide();


                    $("#" + ID).find("a.update").hide();
                    $("#" + ID).find("a.cancel").hide();

                    $("#" + ID).find("a.delete").show();
                    $("#" + ID).find("a.edit").show();

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }

            });


        } else {
            alert("¡Ingrese al menos 2 caracteres!");
        }
    });


    //agrega seguimiento  (de manera individual)
    /***********--ADD--***************/
    $("#btn_agregar_segui").on('click', '', function(e) {


        e.preventDefault();

        var accion = $("input:radio[name=implementa_segui]:checked").val();
        var comentario = $("#comentario_segui").val();
        var id_sacp = $("#id_sacp").val();

        console.log(accion);
        console.log(comentario);
        console.log(id_sacp);



        if (comentario.length > 3) {

            var dataString = 'id_sacp=' + id_sacp + '&accion=' + accion + '&comentario=' + comentario;

            $.ajax({
                type: "POST",
                url: BASE_URL + 'sacp/agregar_seguimiento_individual',
                data: dataString,
                cache: false,
                success: function(e) {
                    var id = e;
                    console.log(id);
                    /* var tabledata="<tr id='"+id+"'>"+

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
			   //$("#tblListar_unidades tr:last").find("input").val(""); */
                    llenar_tabla_seguimiento();
                    $("#comentario_segui").val("");
                    swal("¡Seguimiento Agregado!", '', "success");

                }, //success end
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("No se pudo Agregar causa de Ishikawa");
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            }); // ajax end

            //location.reload();
        } else {
            swal("¡Ingrese Comentario Valido!", '', "warning");
        }
    });







}); // document end

window.onload = fnload;

function fnload() {
    $("#tbl_seguimiento").on('click', 'a.preview', function(e) {
        var id_sacseg = $(this).parent().parent().attr('id');
        // alert(id);exit;
        //var b=$(this).parent().parent();
        var dataString = 'id_sacseg=' + id_sacseg;

        $.ajax({
            type: "POST",
            url: BASE_URL + "sacp/obtener_seguimiento",
            data: dataString,
            cache: false,
            success: function(data) {
                //console.log(data);

                //parseo
                var data = JSON.parse(data);

                if (data.sacseg_accion == 1) {
                    console.log('soy si');
                    $("#implementa_segui_si").iCheck('check');
                    $("#implementa_segui_no").iCheck('uncheck');
                } else {
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
    function llenar_tabla_seguimiento() {

        var id_sacp = $('#id_sacp').val();
        dataString = 'id_sacp=' + id_sacp;

        $.ajax({
            type: "POST",
            url: BASE_URL + "sacp/listado_seguimiento_xSacp",
            data: dataString,
            dataType: 'json',
            cache: false,
            complete: function() {
                //alert("cerrar ");
            },
            success: function(datos) {
                console.log('llenar tabla seguimiento');
                var tabledata = '';
                //console.log(datos);

                if (datos.length == 0) {
                    tabledata += '<tr> <td colspan="4"> <center> Sin datos</center></td></tr>';
                }


                for (i = 0; i < datos.length; i++) {

                    tabledata += "<tr id='" + datos[i].sacseg_id + "'>" +

                        "<td>" + datos[i].sacseg_fecha + "</td>" +

                        "<td>";
                    if (datos[i].sacseg_accion == 1) {
                        tabledata += "<span> SI </span>";
                    } else {
                        tabledata += "<span> NO </span>";
                    }

                    tabledata += "</td>" +



                        "<td>" + datos[i].sacseg_coment + "</td>" +

                        "<td>" +

                        "<a class='preview' href='#'>" +
                        "<img src='" + BASE_URL + "public/views/sacp/img/text_preview.png' width='20px'></img> " +
                        "</a> &nbsp;&nbsp;" +

                        "<a class='delete' href='#'>" +
                        "<img src='" + BASE_URL + "public/views/sacp/img/delete.png' width='20px'></img>" +
                        "</a> " +
                        "</td>" +

                        "</tr>";

                }
                $('#tbl_seguimiento tbody').html(tabledata);
                //$("#tblListar_unidades tr:last").find("input").val("");

                //$('#select_unidades').html(html);

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });

    }