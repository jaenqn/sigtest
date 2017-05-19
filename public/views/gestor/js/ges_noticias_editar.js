var gne = {};

window.onload = function(e){
    new Clipboard('.btn');
     var tpl_file_upload_dos = `
        <tr>
            <td style="width: 40px;vertical-align:middle" class="icon-files"><img src="{{img_url}}" title="{{img_title}}"></img></td>
            <td colspan="2"><span style="word-break: break-all;line-height:0px"><a href="#" target="_blank" class="ver_file">{{name}}</a></span></td>
            <td style="width: 140px;text-aling:center;vertical-align:middle">
                <button type="button" class="btn btn-default  btn-option-files copy" title="Copiar Url" disabled=""   data-id-fichero="-1"><span class="fa fa-link"></span></button>
                <button type="button" class="btn btn-default  btn-option-files portada" title="Seleccionar como portada"  disabled="" data-id-fichero="-1"><span class="fa fa-circle-o"></span></button>
                <button type="button" class="btn btn-default  btn-option-files loading" title="Cancelar subida"  data-id-fichero="-1" ><span class="fa fa-ban"></span></button>
            </td>
        </tr>
        <tr class="theprogress">

            <td style="padding:0px;vertical-align:middle" colspan="4"><div class="progress" style="margin-top: auto;margin-bottom: auto;">
                            <div class="progress-bar progress-bar-striped active" data-transitiongoal="10"></div>
                </div>
            </td>
        </tr>
    `;
     var tpl_file_upload = `
        <tr>
            <td style="width: 40px;vertical-align:middle" class="icon-files"><img src="{{img_url}}" title="{{img_title}}"></img></td>
            <td><span style="word-break: break-all;line-height:0px">{{name}}</span></td>
            <td style="padding:2px;vertical-align:middle"><div class="progress" style="margin-top: auto;margin-bottom: auto;">
                            <div class="progress-bar progress-bar-striped active" data-transitiongoal="10"></div>
                </div>
            </td>
            <td style="width: 40px;text-aling:center;vertical-align:middle">
                <button type="button" class="btn btn-default  btn-option-files loading" title="Cancelar subida"  ><span class="fa fa-ban"></span></button>
            </td>
        </tr>
    `;
        $(function(e){
            // CKEDITOR.config.contentsCss = BASE_URL + 'public/vendors/bootstrap/dist/css/bootstrap.min.css';

            CKEDITOR.config.contentsCss = [BASE_URL + 'public/vendors/bootstrap/dist/css/bootstrap.min.css',BASE_URL + 'public/views/templates/home/css/style.css'];
            CKEDITOR.config.toolbarGroups = [
                    { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
                    { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
                    { name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
                    { name: 'forms', groups: [ 'forms' ] },
                    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
                    { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
                    { name: 'links', groups: [ 'links' ] },
                    { name: 'insert', groups: [ 'insert' ] },
                    '/',
                    { name: 'styles', groups: [ 'styles' ] },
                    { name: 'colors', groups: [ 'colors' ] },
                    { name: 'tools', groups: [ 'tools' ] },
                    { name: 'others', groups: [ 'others' ] },
                    { name: 'about', groups: [ 'about' ] }
                ];
            CKEDITOR.config.removeButtons = 'Templates,NewPage,Preview,Print,Scayt,Flash,Smiley,SpecialChar,Iframe,About';
            $('#ckeditores').ckeditor();
        });
        // $('.contieneeditor').on('load','#cke_ckeditores',function(e){
        //     console.log('adasd');
        // })
    gne.filesUploads = $('#fileupload');
    gne.frmData = $('#frmData');
    gne.frmHTML = $('#frmHTML');
    gne.frmData.submit(function(e){
        e.preventDefault();
        $.post($(this).attr('action'), $(this).serializeArray(), function(data, textStatus, xhr) {
            console.log(data);
        },'json').fail(fnFailAjax);
    });
    gne.frmHTML.submit(function(e){
        e.preventDefault();
        $.post($(this).attr('action'), $(this).serializeArray(), function(data, textStatus, xhr) {
            console.log(data);
        },'json').fail(fnFailAjax);
    });
    var lstFicheros = $('#lstFicheros');
    lstFicheros.on('click','.btn-option-files',function(){
         // console.log(data);
                        //eliminarfichero subido
                        var idf = this.dataset.idFichero;
                        var self = this;
                        if($(this).hasClass('portada')){
                            $.getJSON(BASE_URL + 'noticias/setportada/' + idf, {}, function(json, textStatus) {
                                    if(json.resultado){
                                        $('#lstFicheros').find('.btn-option-files.portada.ini').removeClass('ini')
                                        .find('span').removeClass('fa-circle').addClass('fa-circle-o');

                                        $(self).find('span').removeClass('fa-circle-o').addClass('fa-circle').end().addClass('ini');
                                    }
                            }).fail(fnFailAjax);
                        }

                        if($(this).hasClass('loading')){

                            $.getJSON(BASE_URL + 'noticias/deletefile/' + idf, {}, function(json, textStatus) {
                                    if(json.resultado){
                                         $(self).toParent('tr').fadeOut('fast',function(){
                                            console.log('asd');
                                            $(this).remove();
                                        })
                                    }

                            }).fail(fnFailAjax);;
                        }
    })
    gne.jqUploader = gne.filesUploads.fileupload({
                dataType: 'json',
                acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
                add: function (e, data) {
                    data.url = BASE_URL + 'noticias/uploadfiles/' + $('#txtIdNoticia').val() ;
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

                    var tpl = tpl_file_upload_dos;
                    var XHR = data.jqXHR;
                    tpl = Handlebars.compile(tpl);
                    data.cProgress = $(tpl({
                        name : targetFile.name,
                        img_url : BASE_URL + 'public/app/img/iconos/'+ icono[1],
                        // ruta_file : BASE_URL + 'docs/_noticias//iconos/'+ icono[1],
                        img_title :  icono[2]

                    }));
                    data.cProgress.find('.btn-option-files').on('click',function(e){
                        // console.log(data);
                        // //eliminarfichero subido
                        // var idf = this.dataset.idFichero;
                        // var _alojado = this.dataset.alojado;
                        // var self = this;
                        // if($(this).hasClass('portada')){
                        //     $.getJSON(BASE_URL + 'noticias/setportada/' + idf, {}, function(json, textStatus) {
                        //             /*optional stuff to do after success */
                        //             console.log(json);
                        //             if(json.resultado){
                        //                 $('#lstFicheros').find('.btn-option-files.portada.ini').removeClass('ini')
                        //                 .find('span').removeClass('fa-circle').addClass('fa-circle-o');

                        //                 $(self).find('span').removeClass('fa-circle-o').addClass('fa-circle').end().addClass('ini');
                        //             }
                        //     }).fail(fnFailAjax);
                        // }
                        // if(idf != -1){
                        //     //verificar si el fichero ya fui alojado en la carpeta princiapl de la boleta sig
                        //     //definir las dos opciones disponibles para el caso
                        //     if(_alojado != 1){
                        //         $.post(BASE_URL + 'boletasig/eliminar_fichero', {id_fichero : idf}, function(datas, textStatus, xhr) {

                        //             if(datas.resultado){
                        //                 data.cProgress.fadeOut('fast', function() {
                        //                     $(this).remove();
                        //                 });
                        //             }

                        //         },'json').fail(fnFailAjax);
                        //     }else{
                        //         //eliminar alojado

                        //         $.post(BASE_URL + 'boletasig/eliminar_fichero_alojado', {id_fichero : idf}, function(datas, textStatus, xhr) {

                        //             if(datas.resultado){
                        //                 data.cProgress.fadeOut('fast', function() {
                        //                     $(this).remove();
                        //                 });
                        //             }

                        //         },'json').fail(fnFailAjax);
                        //     }
                        // }


                        // data.cProgress
                        // .find('.progress-bar-striped').removeClass('active');
                        // data.cProgress.fadeOut('fast', function() {
                        //     $(this).remove();
                        // });
                        // data.abort();
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
                    var ttt = data.jqXHR.responseJSON.files[0];
                    var idff = ttt.id_fichero;
                    var targetFile = data.files[0];
                    data.cProgress.find('.progress-bar-striped').removeClass('active')
                    .end()
                    .find('.ver_file').prop('href',BASE_URL + 'docs/_noticias/' + ttt.id_noticia + '/' + targetFile.name)
                    .end()
                    .find('.btn-option-files.loading').attr('title','Eliminar')
                    .end()
                    .find('.btn-option-files.portada').prop('disabled', false)
                    .end()
                    .find('.btn-option-files.copy').prop('disabled', false)
                    .end()
                    .find('.fa-ban').removeClass('fa-ban').addClass('fa-trash')
                    .end()
                    .eq(2).fadeOut('slow',function(e){
                        $(this).remove();
                    });

                    data.cProgress.find('.btn-option-files').each(function(e,v){
                        v.dataset.idFichero = idff;
                    });


                    var typeFile = targetFile.name.split('.').pop();
                    for (var i = ICONS.length - 1; i >= 0; i--) {
                        if(ICONS[i][0] == typeFile)
                            break;
                    }
                    var typef = ICONS[i];
                    if(typef[2] != 'Imagen'){
                        data.cProgress.find('.btn-option-files.portada').removeClass('portada').prop('disabled',true).find('span').removeClass('fa-circle-o').addClass('fa-minus-circle').prop('title','No se puede usar como portada');
                    }

                    // window.tttt = data.cProgress;
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