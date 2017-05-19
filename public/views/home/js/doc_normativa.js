window.onload = fnLoad;
var li_template = `<li>
                            <div>
                                <div><img src="{{nameFile}}" title="{{nameFileTwo}}"></img></div>
                                <div><a href="{{rutaDocumento}}" target="_blank">{{desDoc}}</a></div>
                                <div><span>{{versionDoc}}</span></div>
                                <div><span>{{fecAprobacionArchivoTemp}}</span></div>
                            </div>
                        </li>`;

function fnLoad(){
    fnCallResultados('',1);
    var txtSearch = $('#txtSearch');
    var frmBuscarNormativa = $('#frmBuscarNormativa');
    var pre_target = false;
    var target_id = 0;
    frmBuscarNormativa.on('submit',function(e){
        e.preventDefault();

        fnCallResultados(this.elements.txtSearch.value);

    })

    function fnCallResultados(text_search, limit = 0){
        $.post(BASE_URL + 'documentos/by_categoria/' + ID_CATEGORIA, {
                id_carpetas : ID_CARPETAS,
                search : text_search,
                limit_date_recent : limit
            }, function(data, textStatus, xhr) {
                console.log(data);
                if(data.length > 0){
                    $('#listaDocumentos').html('');
                    $(data).each(function(i,e){
                        if(e.desDoc.trim() == '')
                            e.desDoc = 'Sin título';
                        e.rutaDocumento = BASE_URL + e.rutaDoc;
                        // e.rutaDocumento = BASE_URL + e.rutaDoc + e.nombreDoc;
                        var m = moment(e.fecAprobacionArchivo);
                        e.nameFile = BASE_URL + 'public/app/img/iconos/' + e.nameFile;

                        if(e.versionDoc.trim() == '')
                            e.versionDoc = '--';
                        if(m.isValid())
                            e.fecAprobacionArchivoTemp ='Aprobado : ' + m.format('DD-MM-YYYY');
                        else
                            e.fecAprobacionArchivoTemp ='-- -- -- ';
                        e.versionDocTemp = '';
                        if(e.versionDoc.trim() != '')
                            e.versionDocTemp = 'Versión : ' + e.versionDoc;
                        t = Handlebars.compile(li_template);
                        $('#listaDocumentos').append(t(e));
                    })
                }else{
                    $('#listaDocumentos').html('<li><span>No existen coincidencias!</span></li>');
                }

        },'json').fail(fnFailAjax);
    }
    txtSearch.on('change',function(e){

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
    //         $.post(BASE_URL + 'documentos/by_carpeta/' + id_carpeta, {

    //         }, function(data, textStatus, xhr) {
    //             console.log(data);
    //             if(data.length > 0){
    //                 $('#listaDocumentos').html('');
    //                 $(data).each(function(i,e){
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

    //         },'json').fail(fnFailAjax);
    //     }
    //     target_id = id_carpeta;
    // });





}