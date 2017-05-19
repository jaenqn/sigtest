window.onload = fnLoad;
var jqUploaderSeg;


function fnLoad(){

    realoadfechas('span.txt-fecha');
    var frmBoletaSIG = $('#frmBoletaSIG');
    frmBoletaSIG.find('input').prop('disabled', true).end().find('textarea').prop('disabled', true);

    var countfiles = 0;
    var tpl_seguimiento =  `

                <div class="byline">
                    <span class="txt-fecha" data-fecha="{{fechasf}}">{{fecha}} </span> por <a href="">{{responsable}}</a>
                </div>
                <p class="excerpt">{{observacion}}</p>
                {{#if exist_files}}
                <div>
                    <ul class="showfiles">
                    {{#each files}}
                        <li>
                            <a href="{{ruta_archivo}}">{{abo_nombre_fichero}}</a>
                        </li>
                    {{/each}}
                    </ul>
                </div>
                {{/if}}
                <hr>
    `;
    tpl_seguimiento = Handlebars.compile(tpl_seguimiento);
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


    var fileuploadss = $('#fileupload-seguimiento');
    var lstFicheros = $('#lstFicherosSeguimiento');
    var frmBoletaSIG = $('#frmBoletaSeguimiento');
    var lstseguimiento = $('#lstseguimiento');
    var txtidbolseg = $('#txtidbolseg');
    var btnFinalizarSeg = $('#btnFinalizarSeg').on('click', fnClickFinalizar);

    function realoadfechas(target){
        let targetnow = moment();
        $(target).each(function(e,v){
            let tempdate = moment(this.dataset.fecha);
            if(targetnow.format('D/M/Y') == tempdate.format('D/M/Y'))
                $(v).text(tempdate.fromNow());
            else $(v).text(moment(this.dataset.fecha).format('HH:mm'));
        });
    }
    function fnClickFinalizar(){
        $.post(BASE_URL + 'boletasig/finseguimiento', {id_boleta: txtidbolseg.val()}, function(data, textStatus, xhr) {
            console.log(data);

        },'json').fail(fnFailAjax);
    }
    frmBoletaSIG.submit(function(e){
        e.preventDefault();
        if(lstFicheros.find('tr').length > 0){

            // var confimsubmit = false;



                swal_option.confirm.title = 'Agregar Observación';
                swal_option.confirm.text = '¿Está seguro de guardar observación ?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;

                swal(swal_option.confirm,
                function(isConfirm){
                  if (isConfirm) {
                    $.post(BASE_URL + 'boletasig/agregar_seguimiento', frmBoletaSIG.serializeArray() , function(data, textStatus, xhr) {
                        let objr = data.objRes;
                        console.log(data);
                        lstFicheros.html('');
                        $('#txtObseSeg').val('');
                        if(data.resultado){
                            swal("Observación registrada!",'', "success");
                        }

                        let values = {
                            fecha : moment(objr.fecha_registro).fromNow(),
                            fechasf : objr.fecha_registro,
                            responsable : objr.datos_usuario.usu_nombre + ' ' + objr.datos_usuario.usu_nombre,
                            observacion : objr.observacion,
                            exist_files : objr.ficheros.length > 0 ? true : false,
                            files : objr.ficheros
                        }
                        let lines = lstseguimiento.find('.today .byline');

                        if(lines.length > 0){
                            lines.eq(0).before(tpl_seguimiento(values));
                        }else{
                            lstseguimiento.find('.today').eq(0).find('.title').eq(0).after(tpl_seguimiento(values));
                        }
                        realoadfechas('.today span.txt-fecha');
                    },'json').fail(fnFailAjax);

                  }
                });

        }

    });


    jqUploaderSeg = fileuploadss.fileupload({
                dataType: 'json',
                acceptFileTypes: /(\.|\/)(gif|jpe?g|png|pdf|doc?x|ppt?x|xls?x)$/i,
                add: function (e, data) {
                    data.url = BASE_URL + 'boletasig/upload_ficheros_seg';
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
                        console.log(this);
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
                                        countfiles--;
                                    }

                                },'json').fail(fnFailAjax);
                            }else{
                                //eliminar alojado

                                $.post(BASE_URL + 'boletasig/eliminar_fichero_alojado', {id_fichero : idf}, function(datas, textStatus, xhr) {

                                    if(datas.resultado){
                                        data.cProgress.fadeOut('fast', function() {
                                            $(this).remove();
                                        });
                                        countfiles--;
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
                    countfiles++;
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
    .error(fnFailAjax);
}