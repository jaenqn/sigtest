window.onload = fnLoaded;
var li_template = `<li>
                            <div>
                                <div><img src="{{nameFile}}" title="{{nameFileTwo}}"></img></div>
                                <div><a href="{{rutaDocumento}}" target="_blank">{{desDoc}}</a></div>
                                <div style=""><span>{{versionDoc}}</span></div>
                                <div style=""><span>{{fecAprobacionArchivoTemp}}</span></div>
                            </div>
                        </li>`;
var ul_sub_carpeta = `<ul class="sub_folders sub-{{id_folder}}" style="list-style: none;margin: 0 0 0 10px;padding: 0px;">
                      {{#each folders}}
                        <li><a href="" class="ref_carpetas sub sub-{{nivelCarpeta}}" data-sub="on" data-id-carpeta="{{idCarpeta}}"><span class="estado-folder">&nbsp;+&nbsp;</span>&nbsp;{{descripcionCarpeta}}</a></li>
                      {{/each}}
                      </ul>`;
var referencial;
var ids = [];
var inter = [];
function isload(id){
    for (var i = ids.length - 1; i >= 0; i--) {
        if(id == ids[i]){

            return true;
        }
    };
    return false;
}
// function fnLoadDocs(e){
//     e.preventDefault();


// }
fnLoadDocs.prototype.getId = function(){
    return 100;

}
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
function fnLoaded(){
    var pre_target = false;
    var target_id = 0;
    $('#lstEnlacesDoc').on('click','.ref_carpetas.ini',fnLoadDocs);
    // $('#lstEnlacesDoc').on('click','.ref_carpetas',function(e){
    //     // if(typeof(referencial) != 'undefined'){
    //     //     console.log(referencial);

    //     //     if(referencial.find('.sub_folders').length == 0){
    //     //         console.log('borrar');
    //     //         // referencial.remove();
    //     //     }
    //     // }
    //     if(!$(this).hasClass('sub')){
    //         ids = [];
    //         $('#lstEnlacesDoc .sub_folders').remove();
    //     }
    //     e.preventDefault();
    //     var id_carpeta = this.dataset.idCarpeta;
    //     console.log(id_carpeta);
    //     if(pre_target){
    //         $(pre_target).toParent('li').removeClass('marcado');
    //         // target_id = id_carpeta;
    //     }

    //     $(this).toParent('li').addClass('marcado');
    //     console.log($(this).next());
    //     var tt = Handlebars.compile(ul_sub_carpeta);
    //     var self = this;
    //     pre_target = this;
    //     if(target_id != id_carpeta){

    //         if(!isload(id_carpeta)){
    //             ids.push(id_carpeta);
    //             // inter.push({id:id_carpeta,load:false})
    //         }
    //             $.post(BASE_URL + 'documentos/by_carpeta/' + id_carpeta, {}, function(data, textStatus, xhr) {
    //                 console.log(data);
    //                 if(data.docs.length > 0){
    //                     $('#listaDocumentos').html('');
    //                     $(data.docs).each(function(i,e){
    //                         if(e.desDoc.trim() == '')
    //                             e.desDoc = 'Sin título';
    //                             // e.rutaDocumento = BASE_URL + e.rutaDoc + e.nombreDoc;
    //                             e.rutaDocumento = BASE_URL + e.rutaDoc;
    //                             var m = moment(e.fecAprobacionArchivo);
    //                             e.nameFile = BASE_URL + 'public/app/img/iconos/' + e.nameFile;
    //                             if(m.isValid())
    //                                 e.fecAprobacionArchivoTemp ='Aprobado : ' + m.format('DD-MM-YYYY');
    //                             else
    //                                 e.fecAprobacionArchivoTemp ='';
    //                         t = Handlebars.compile(li_template);
    //                         $('#listaDocumentos').append(t(e));


    //                     })
    //                 }else{
    //                     $('#listaDocumentos').html('<li><span>Aún no hemos subido ningún archivo para esta carpeta!</span></li>');
    //                 }

    //                 if(data.folders.length > 0){
    //                     // if(!isload(id_carpeta)){
    //                         if($('#lstEnlacesDoc').find('.sub-' + id_carpeta).length > 0){
    //                             $('#lstEnlacesDoc').find('.sub-' + id_carpeta).remove();

    //                         }
    //                         $(pre_target).after(tt({folders : data.folders,id_folder : id_carpeta }));
    //                     // }


    //                 }
    //                 referencial = $(pre_target).parent();


    //             },'json').fail(fnFailAjax);
    //             // ids.push(id_carpeta);



    //         // if(typeof(referencial) != 'undefined'){
    //         //     if(referencial.find('.sub_folders').length == 0){
    //         //         console.log('borrar');
    //         //         referencial.remove();
    //         //     }
    //         // }
    //         // if($(this).parent().find('.sub-folders').length == 0){

    //         //     $('#lstEnlacesDoc .sub_folders').remove();
    //         // }
    //     }else{

    //     }
    //     target_id = id_carpeta;
    // });
    // $('#lstEnlacesDoc').on('click','.ref_carpetassub.sub',function(e){
    //     // if(!$(this).hasClass('sub'))
    //         $('.sub_folders').remove();
    //     e.preventDefault();
    //     var id_carpeta = this.dataset.idCarpeta;
    //     console.log(id_carpeta);
    //     if(pre_target){
    //         $(pre_target).toParent('li').removeClass('marcado');
    //         // target_id = id_carpeta;
    //     }

    //     $(this).toParent('li').addClass('marcado');
    //     console.log($(this));
    //     var tt = Handlebars.compile(ul_sub_carpeta);
    //     var self = this;
    //     pre_target = this;
    //     if(target_id != id_carpeta){
    //         $.post(BASE_URL + 'documentos/by_carpeta/' + id_carpeta, {}, function(data, textStatus, xhr) {
    //             console.log(data);
    //             if(data.docs.length > 0){
    //                 $('#listaDocumentos').html('');
    //                 $(data.docs).each(function(i,e){
    //                     if(e.desDoc.trim() == '')
    //                         e.desDoc = 'Sin título';
    //                         e.rutaDocumento = BASE_URL + e.rutaDoc + e.nombreDoc;
    //                         var m = moment(e.fecAprobacionArchivo);
    //                         e.nameFile = BASE_URL + 'public/app/img/iconos/' + e.nameFile;
    //                         if(m.isValid())
    //                             e.fecAprobacionArchivoTemp ='Aprobado : ' + m.format('DD-MM-YYYY');
    //                         else
    //                             e.fecAprobacionArchivoTemp ='';
    //                     t = Handlebars.compile(li_template);
    //                     $('#listaDocumentos').append(t(e));

    //                 })
    //             }else{
    //                 $('#listaDocumentos').html('<li><span>Aún no hemos subido ningún archivo para esta carpeta!</span></li>');
    //             }
    //             if(data.folders.length > 0)
    //                 $(pre_target).append(tt({folders : data.folders}));

    //         },'json').fail(fnFailAjax);
    //     }
    //     // target_id = id_carpeta;
    // });





}