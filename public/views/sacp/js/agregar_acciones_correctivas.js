$(document).ready(function() {


    //al presionar el boton de agregar Causa
    //llenará la tabla ishikawa - cinco por qué, con datos previos
    $("#agregar_causa ").on('click', function(e) {
        llenar_tabla_ishikawa();
        llenar_tabla_cinco_porque();
    });

    $("#tbl_causas_todas").on('click', 'a.ver_modal', function(e) {
        llenar_tabla_ishikawa();
        llenar_tabla_cinco_porque();

    });

    $("#profile-tab2").on('click', function(e) {
        llenar_tabla_causas();
    });


    //agrega causa-cinco-porque (de manera individual)
    /***********--ADD--***************/
    $("#guardar_accion_correctiva").on('click', '', function(e) {

        e.preventDefault();

        var descripcioin = $("#acciones_descripcion").val();
        var iper = $("input:radio[name=acciones_iper]:checked").val(); //1 = SI, 0= NO
        var responsable = $("#responsable_acciones").val();





        //var causa_tipo_en_texto = $("#causa_tipo_ishikawa option:selected").text();





        if (preg_1.length > 1 && preg_2.length > 1 && preg_3.length > 1 && preg_4.length > 1 && preg_5.length > 1) {

            var dataString = 'id_sacp=' + id_sacp + '&preg_1=' + preg_1 + '&resp_1=' + resp_1 + '&preg_2=' + preg_2 + '&resp_2=' + resp_2;
            dataString += '&preg_3=' + preg_3 + '&resp_3=' + resp_3 + '&preg_4=' + preg_4 + '&resp_4=' + resp_4 + '&preg_5=' + preg_5 + '&resp_5=' + resp_5;
            dataString += '&causa_raiz=' + causa_raiz_encontrada;

            $.ajax({
                type: "POST",
                url: BASE_URL + 'sacp/agregar_causa_cinco_porque',
                data: dataString,
                cache: false,
                success: function(e) {
                    var id = e;
                    console.log(id);
                    var tabledata = "<tr id='" + id + "'>" +


                        "<td>" + causa_raiz_encontrada + "</td>" +

                        "<td>" +
                        "<a class='delete' href='#'>" +
                        "<img src='" + BASE_URL + "public/views/sacp/img/text_preview.png' width='20px'></img> &nbsp;&nbsp" +
                        "<img src='" + BASE_URL + "public/views/sacp/img/delete.png' width='20px'></img>" +
                        "</a> " +
                        "</td>" +

                        "</tr>";


                    //$('#tabla_cinco_porque tbody').append(tabledata);
                    //para limpiar los inputs
                    $("#preg_1 ,#resp_1, #preg_2 ,#resp_2, #preg_3 ,#resp_3, #preg_4 ,#resp_4, #preg_5 ,#resp_5, #causa_raiz_encontrada ").val("");
                    llenar_tabla_cinco_porque();
                    swal("Causa Agregada!", '', "success");

                }, //success end
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("No se pudo Agregar causa de Ishikawa");
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            }); // ajax end

            //location.reload();
        } else {
            //alert("Ingrese Preguntas Validas");warning
            swal("Ingrese los Campos faltantes!", '', "warning");
        }
    });








}); // document end