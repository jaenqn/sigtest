window.onload = fnLoad;
var jqUploader;

function fnLoad(){

     var tpl_file_upload = `
        <tr>
            <td style="width: 40px;vertical-align:middle" class="icon-files"><img src="{{img_url}}" title="{{img_title}}"></img></td>
            <td><div style="word-break: break-all;">{{name}}</div></td>
            <td style="padding:2px;vertical-align:middle"><div class="progress" style="margin-top: auto;margin-bottom: auto;">
                            <div class="progress-bar progress-bar-striped active" data-transitiongoal="10"></div>
                </div>
            </td>
            <td style="width: 40px;text-aling:center;vertical-align:middle">
                <button type="button" class="btn btn-default  btn-option-files loading" title="Cancelar subida"  ><span class="fa fa-ban"></span></button>
            </td>
        </tr>
    `;

    moment.locale('es');
    var fecha_solicita = $('#fecha_solicita');
    var fecha_solicita_res = $('#fecha_solicita_res');
    var fileuploadss = $('#fileupload');
    var lstFicheros = $('#lstFicheros');

    var accionesPosteriores = $('.acciones-posteriores').on('ifChecked', fnCheckPosteriores);
    var frmBoletaSIG = $('#frmBoletaSIG');
    var btnActualizarRes = $('#btnActualizarRes').on('click', fnClickActualizar);
    var frmBoletaSIGDeta = $('#frmBoletaSIGDeta');
    frmBoletaSIGDeta.find('input').prop('disabled',true);
    fecha_solicita.val(moment().format('LLL'));
    fecha_solicita_res.val(moment().format('LLL'));
    setInterval(function(){
        fecha_solicita.val(moment().format('LLL'));
        fecha_solicita_res.val(moment().format('LLL'));
    },1000);

    lstFicheros.on('click','.btn-option-files.loaded',fnDeleteFile);
    frmBoletaSIG.submit(function(e){
        e.preventDefault();
        var frmReg = new Form('frmBoletaSIG');
        var elem = frmReg.getElements();
        var confimsubmit = false;
        $('.chkAccInme').each(function(e, v){
            if(v.checked == true)
                confimsubmit = true;
        });
        if(getById('txtAccionInmediata').value.trim() != ''){
            confimsubmit = true;
        }

        if(confimsubmit){
            swal_option.confirm.title = 'Respuesta Boleta';
            swal_option.confirm.text = '¿Está seguro de guardar respuesta a  Boleta SIG?';
            swal_option.confirm.type = 'warning';
            swal_option.confirm.closeOnCancel = true;

            swal(swal_option.confirm,
            function(isConfirm){
              if (isConfirm) {
                $.post(BASE_URL + 'boletasig/responder', frmBoletaSIG.serializeArray() , function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado){
                            swal({
                                title : 'Respuesta  guardada',
                                text : '',
                                type : 'success'

                            },function(e,d){
                                setTimeout(function(e){
                                    window.location = BASE_URL + 'boletasig/listar' ;
                                },900)

                            })


                    }
                    // if(data.resultado){
                    //     swal("Proceso Registrado!",'', "success");
                    // }


                },'json').fail(fnFailAjax);

              }
            });
        }
    });
    function fnClickActualizar(e){
        e.preventDefault();
    }
    function fnCheckPosteriores(e){
        if(+this.value == 9){
            accionesPosteriores.each(function(e,v){
                if(v.value != 9)
                    $(v).iCheck('uncheck');
            });
            $('#txtplazo').val('');
        }else{
            accionesPosteriores.each(function(e,v){
                if(v.value == 9)
                    $(v).iCheck('uncheck');
            })
        }
    }
    function fnDeleteFile(e){
        var idf = this.dataset.idFichero;
        var _alojado = this.dataset.alojado;
        var target_tr = $(this).toParent('tr');
        if(idf != -1){
            $.post(BASE_URL + 'boletasig/eliminar_fichero_alojado', {id_fichero : idf}, function(datas, textStatus, xhr) {
                console.log(datas);
                if(datas.resultado){
                    target_tr.remove();
                    // data.cProgress.fadeOut('fast', function() {
                    //     $(this).remove();
                    // });
                }

            },'json').fail(fnFailAjax);
        }
    }
    jqUploader = fileuploadss.fileupload({
                dataType: 'json',
                acceptFileTypes: /(\.|\/)(gif|jpe?g|png|pdf|doc?x|ppt?x|xls?x)$/i,
                add: function (e, data) {
                    data.url = BASE_URL + 'boletasig/upload_ficheros_res';
                    // count_files++;
                    // if(count_files >= 1){
                    //     clearFixPreTable.css('height','1px');
                    //     btnLimpiarSubidas.removeClass('hidden');
                    // }

                    console.log(data);

                    var targetFile = data.files[0];
                    var typeFile = targetFile.name.split('.').pop();
                    for (var i = ICONS.length - 1; i >= 0; i--) {
                        if(ICONS[i][0] == typeFile)
                            break;
                    }
                    var icono = ICONS[i];

                    var tpl = tpl_file_upload;
                    var XHR = data.jqXHR;
                    tpl = Handlebars.compile(tpl);
                    data.cProgress = $(tpl({
                        name : targetFile.name,
                        img_url : BASE_URL + 'public/app/img/iconos/'+ icono[1],
                        img_title :  icono[2]

                    }));
                    data.cProgress.find('.btn-option-files').on('click',function(e){
                        console.log(data);
                        //eliminarfichero subido
                        var idf = this.dataset.idFichero;
                        console.log(idf);
                        var _alojado = this.dataset.alojado;
                        if(idf != -1){
                            //verificar si el fichero ya fui alojado en la carpeta princiapl de la boleta sig
                            //definir las dos opciones disponibles para el caso
                            if(_alojado != 1){
                                $.post(BASE_URL + 'boletasig/eliminar_fichero', {id_fichero : idf}, function(datas, textStatus, xhr) {

                                    if(datas.resultado){
                                        data.cProgress.fadeOut('fast', function() {
                                            $(this).remove();
                                        });
                                    }

                                },'json').fail(fnFailAjax);
                            }else{
                                //eliminar alojado

                                $.post(BASE_URL + 'boletasig/eliminar_fichero_alojado', {id_fichero : idf}, function(datas, textStatus, xhr) {

                                    if(datas.resultado){
                                        data.cProgress.fadeOut('fast', function() {
                                            $(this).remove();
                                        });
                                    }

                                },'json').fail(fnFailAjax);
                            }
                        }
                        data.cProgress
                        .find('.progress-bar-striped').removeClass('active');
                        data.cProgress.fadeOut('fast', function() {
                            $(this).remove();
                        });
                        data.abort();
                    });


                    lstFicheros.append(data.cProgress);
                    data.submit();
                    // btnLimpiarSubidas.prop('disabled',true);
                    // data.contex2tx = $('<button/>').text('Upload')
                    //     .appendTo(document.body)
                    //     .click(function () {
                    //         data.contex2t = $('<p/>').text('Uploading...').replaceAll($(this));
                    //         data.submit();
                    //     });


                },
                done: function (e, data) {
                    console.log(data);
                    data.cProgress.find('.progress-bar-striped').removeClass('active')
                    .end()
                    .find('.btn-option-files').attr('title','Eliminar')
                    .end()
                    .find('.fa-ban').removeClass('fa-ban').addClass('fa-trash');
                    // count_files--;
                    // if(count_files == 0)
                    //     btnLimpiarSubidas.prop('disabled',false);
                    // dtListar.ajax.reload();
                    // data.cProgress.remove();
                    // var t = data.cProgress.find('.progress').text('dadasd');
                    // $(data.cProgress).text('Finish');
                    // data.contex2t.text('Upload finished: ');
                },
                progress: function (e, data) {
                    // var elprogress;

                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    // // if(progress == 100)
                    //     console.log(data);
                    //     console.log(progress);
                        var t = data.cProgress.find('.progress-bar');
                    //     t.get(0).dataset.transitiongoal = progress;

                    //     // t.progressbar();
                    $(t).css(
                        'width',
                        progress + '%'
                    );
                }
    })
    .error(function (jqXHR, textStatus, errorThrown) {
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });

}