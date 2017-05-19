window.onload = fnLoad;
var li_template_old = `<li>
                            <div>
                                <div><img src="{{nameFile}}" title="{{nameFileTwo}}"></img></div>
                                <div style="line-height: 16px"><a href="{{rutaDocumento}}" target="_blank"><span>{{desDoc}}</span></a></div>
                                <div><span>{{versionDocTemp}}</span></div>
                                <div><span>{{fecAprobacionArchivoTemp}}</span></div>
                            </div>
                        </li>`;
var li_template = `<li>
                            <div>
                                <div><img src="{{nameFile}}" title="{{nameFileTwo}}"></img></div>
                                <div><a href="{{rutaDocumento}}" target="_blank">{{desDoc}}</a></div>
                                <div><span>{{versionDoc}}</span></div>
                                <div><span>{{fecAprobacionArchivoTemp}}</span></div>
                            </div>
                        </li>`;
var ul_sub_carpeta = `<ul class="sub_folders sub-{{id_folder}}" style="list-style: none;margin: 0 0 0 10px;padding: 0px;">
                      {{#each folders}}
                        <li><a href="" class="ref_carpetas sub sub-{{nivelCarpeta}}" data-sub="on" data-id-carpeta="{{idCarpeta}}"><span class="estado-folder">&nbsp;+&nbsp;</span>&nbsp;{{descripcionCarpeta}}</a></li>
                      {{/each}}
                      </ul>`;
var li_carpetas_old = `  <li><a href="#" class="ref_carpetas" data-id-carpeta="{{idCarpeta}}">{{descripcionCarpeta}}</a></li>
                    `;
var li_carpetas = `  <li><a href="#" class="ref_carpetas ini" data-id-carpeta="{{idCarpeta}}"><span class="estado-folder">&nbsp;+&nbsp;</span>&nbsp;{{descripcionCarpeta}}</a></li>
                    `;
var ids = [];
function isload(id){
    for (var i = ids.length - 1; i >= 0; i--) {
        if(id == ids[i]){

            return true;
        }
    };
    return false;
}
function fnLoad(){
    var selDepartamento = $('#selDepartamento');
    var selunidades = $('#selunidades');
    var lstEnlacesDoc = $('#lstEnlacesDoc');
    var pre_target = false;
    var target_id = 0;
    selDepartamento.on('change',function(e){
        console.log(this.value);
        var id_departamento = this.value;
        $.post(BASE_URL + 'dependencia/unidad_by_dep/' + id_departamento, {}, function(data, textStatus, xhr) {
            console.log(data);
            var option = '<option></option>';
            for (var i = 0 ; i < data.length; i++) {
                option += `<option value="${data[i].idDepend}">${data[i].desDepend}</option>`;
            }
            selunidades.html(option);
            selunidades.prop('disabled',false);
            /*optional stuff to do after success */
        },'json');
    })
    selunidades.on('change',function(e){
        $.post(BASE_URL + 'carpeta/listar_by_unidad/' + this.value + '?nivel=1', {}, function(data, textStatus, xhr) {
            /*optional stuff to do after success */
            console.log(data);
            if(data.length > 0){
                lstEnlacesDoc.html('');
                $(data).each(function(i,e){
                    if(e.descripcionCarpeta.trim() == '')
                        e.descripcionCarpeta = 'Sin título';
                        // e.rutaDocumento = BASE_URL + e.rutaDoc + e.nombreDoc;
                        // var m = moment(e.fecAprobacionArchivo);
                        // e.nameFile = BASE_URL + 'public/app/img/iconos/' + e.nameFile;
                        // if(m.isValid())
                            // e.fecAprobacionArchivoTemp ='Aprobado : ' + m.format('DD-MM-YYYY');
                        // else
                            // e.fecAprobacionArchivoTemp ='';
                    t = Handlebars.compile(li_carpetas);
                    lstEnlacesDoc.append(t(e));
                })
            }else{
                lstEnlacesDoc.html('<li><span>No posee carpetas!</span></li>');
            }

        },'json').fail(fnFailAjax);
    });
    // $('#lstEnlacesDoc').on('click','.ref_carpetas',function(e){



    //     e.preventDefault();
    //     var id_carpeta = this.dataset.idCarpeta;
    //     if(pre_target){
    //         $(pre_target).toParent('li').removeClass('marcado');
    //         // target_id = id_carpeta;
    //     }

    //     $(this).toParent('li').addClass('marcado');
    //     pre_target = this;
    //     if(target_id != id_carpeta){
    //         $.post(BASE_URL + 'documentos/by_carpeta/' + id_carpeta, {}, function(data, textStatus, xhr) {
    //             console.log(data);
    //             var data = data.docs;
    //             if(data.length > 0){
    //                 $('#listaDocumentos').html('');
    //                 $(data).each(function(i,e){
    //                     if(e.desDoc.trim() == '')
    //                         e.desDoc = 'Sin título';
    //                         // e.rutaDocumento = BASE_URL + e.rutaDoc + e.nombreDoc;
    //                         e.rutaDocumento = BASE_URL + e.rutaDoc;
    //                         var m = moment(e.fecAprobacionArchivo);
    //                         e.nameFile = BASE_URL + 'public/app/img/iconos/' + e.nameFile;
    //                         if(m.isValid())
    //                             e.fecAprobacionArchivoTemp ='Aprobado : ' + m.format('DD-MM-YYYY');
    //                         else
    //                             e.fecAprobacionArchivoTemp ='';

    //                         if(e.versionDoc.trim() != '')
    //                             e.versionDocTemp = 'Versión : ' + e.versionDoc;
    //                     t = Handlebars.compile(li_template);
    //                     $('#listaDocumentos').append(t(e));
    //                 })
    //             }else{
    //                 $('#listaDocumentos').html('<li><span>Aún no hemos subido ningún archivo para esta carpeta!</span></li>');
    //             }

    //         },'json').fail(fnFailAjax);
    //     }
    //     target_id = id_carpeta;
    // });

    $('#lstEnlacesDoc').on('click','.ref_carpetas.ini',fnLoadDocs);
    function fnLoadDocs(e){


       // if(typeof(referencial) != 'undefined'){
        //     console.log(referencial);

        //     if(referencial.find('.sub_folders').length == 0){
        //         console.log('borrar');
        //         // referencial.remove();
        //     }
        // }
        // this.prototype.pre_target =
        // if(!$(this).hasClass('sub')){
        //     ids = [];
        //     $('#lstEnlacesDoc .sub_folders').remove();
        // }
        e.preventDefault();

        var id_carpeta = this.dataset.idCarpeta;
        console.log(id_carpeta);
        // if(pre_target){
        //     $(pre_target).toParent('li').removeClass('marcado');
        //     // target_id = id_carpeta;
        // }

        // $(this).toParent('li').addClass('marcado');
        // console.log($(this).next());
        var tt = Handlebars.compile(ul_sub_carpeta);
        var self = this;
        // pre_target = this;
        $(this).find('.estado-folder').html('&nbsp;-&nbsp;');
        if(!$(this).hasClass('selected')){
            // $(this).find('.estado-folder').html('&nbsp;+&nbsp;');
            if(!isload(id_carpeta)){
                ids.push(id_carpeta);
                // inter.push({id:id_carpeta,load:false})
            }
            $.post(BASE_URL + 'documentos/by_carpeta/' + id_carpeta, {}, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.docs.length > 0){
                        $('#listaDocumentos').html('');
                        $(data.docs).each(function(i,e){
                            if(e.desDoc.trim() == '')
                                e.desDoc = 'Sin título';
                                // e.rutaDocumento = BASE_URL + e.rutaDoc + e.nombreDoc;
                                e.rutaDocumento = BASE_URL + e.rutaDoc;
                                var m = moment(e.fecAprobacionArchivo);
                                e.nameFile = BASE_URL + 'public/app/img/iconos/' + e.nameFile;

                                if(e.versionDoc.trim() == '')
                                    e.versionDoc = '--';
                                if(m.isValid())
                                    e.fecAprobacionArchivoTemp ='Aprobado : ' + m.format('DD-MM-YYYY');
                                else
                                    e.fecAprobacionArchivoTemp ='-- -- --';
                            t = Handlebars.compile(li_template);
                            $('#listaDocumentos').append(t(e));


                        })
                    }else{
                        $('#listaDocumentos').html('<li><span>Aún no hemos subido ningún archivo para esta carpeta!</span></li>');
                    }

                    if(data.folders.length > 0){
                            console.log($(self).next());
                            $(self).after(tt({folders : data.folders,id_folder : id_carpeta }));
                            console.log($(self).next());
                            $(self).next().on('click','.ref_carpetas.sub-' + id_carpeta,fnLoadDocs);
                    }
            },'json').fail(fnFailAjax);

            var x = $(this).toParent('.sub_folders').find('.selected');
            x.next().remove();
            x.find('.estado-folder').html('&nbsp;+&nbsp;');
            x.removeClass('selected');
            // $(this).toParent('.sub_folders').find('.selected').next().remove();
            $(this).addClass('selected');
            // $(this).removeClass('selected');
        }
        else{
            $(this).find('.estado-folder').html('&nbsp;+&nbsp;');
            $(this).next().remove();
            $(this).removeClass('selected');
            $('#listaDocumentos').html('');
        }
        // target_id = id_carpeta;
        // $(this).addClass('selected');
}






}