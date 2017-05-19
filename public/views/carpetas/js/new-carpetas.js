window.onload = fnLoad;
var dtListar;
var jqUploader;
var selDepartamento;
var selUnidad;
var btnNuevaCarpeta;
var btnSubirArchivo;
var nivelVistaCarpetas = 1;
var vistadepuni = 0;
var OPCIONES_SUBCARPETA = {};
function getData(){
    return DATAFILES.carpeta;
}
function fnLoad(el){
    var count_files = 0;
    // $('.progress .progress-bar').progressbar();
    var tpl_icons = `<img src="{{nameFile}}" title="{{nameFileTwo}}"></img>`;
    var filesUploadTpl = `
                      <div class="newload">
                        <div class="col-sm-6 tituloDocumento"><span>{{name}}</span></div>
                        <div class="col-sm-6">
                          <div class="progress">
                            <div class="progress-bar progress-bar-success" data-transitiongoal="0"></div>
                          </div>
                        </div>
                      </div>`;
    $('#menu_toggle').on('click',function(){dtListar.columns.adjust()})

    var fileuploadss = $('#fileupload');
    var frmCrearCarpeta = $('#frmCrearCarpeta');
    var frmRefDocs = $('#frmRefDocs');
    var lstDocumentosSubida = $('#lstDocumentosSubida');
    var btnLimpiarSubidas = $('#btnLimpiarSubidas');
    var clearFixPreTable = $('#clearFixPreTable');
    var selTipoCarpeta = $('#selTipoCarpeta');
    var btnActualizarCarpeta = $('#btnActualizarCarpeta');
    selDepartamento = $('#selDepartamento');
    selUnidad = $('#selUnidad');
    selDepartamento.on('change',fnChangeDep);
    selUnidad.on('change',fnChangeUni);
    btnLimpiarSubidas.on('click',function(e){

        $(this).addClass('hidden');
        lstDocumentosSubida.find('.newload').remove();
        clearFixPreTable.css('height','0px');
    })
    btnActualizarCarpeta.on('click',function(e){
        frmRefDocs.submit();
    })
    selTipoCarpeta.on('change',fnChangeTipoCarpeta);
    function initUpload(){
        // if(typeof(jqUploader) == 'undefined'){
           jqUploader = fileuploadss.fileupload({
                dataType: 'json',
                acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
                add: function (e, data) {
                    data.url = BASE_URL + 'documentos/upload_docs/' + DATAFILES.carpeta;
                    count_files++;
                    if(count_files >= 1){
                        clearFixPreTable.css('height','1px');
                        btnLimpiarSubidas.removeClass('hidden');
                    }
                    console.log(data);
                    var targetFile = data.files[0];
                    var tpl = filesUploadTpl;
                    tpl = Handlebars.compile(tpl);
                    data.cProgress = $(tpl({name : targetFile.name}));

                    lstDocumentosSubida.append(data.cProgress);
                    data.submit();
                    btnLimpiarSubidas.prop('disabled',true);
                    // data.contex2tx = $('<button/>').text('Upload')
                    //     .appendTo(document.body)
                    //     .click(function () {
                    //         data.contex2t = $('<p/>').text('Uploading...').replaceAll($(this));
                    //         data.submit();
                    //     });

                },
                done: function (e, data) {
                    console.log(data);
                    console.log(data.response());
                    count_files--;
                    if(count_files == 0)
                        btnLimpiarSubidas.prop('disabled',false);
                    dtListar.ajax.reload();
                    // data.cProgress.remove();
                    // var t = data.cProgress.find('.progress').text('dadasd');
                    // $(data.cProgress).text('Finish');
                    // data.contex2t.text('Upload finished: ');
                },
                progress: function (e, data) {
                    // var elprogress;

                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    // if(progress == 100)
                        console.log(data);
                        console.log(progress);
                        var t = data.cProgress.find('.progress-bar');
                        t.get(0).dataset.transitiongoal = progress;

                        // t.progressbar();


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
        // }

    }
    $('#txtAprobacionDoc').daterangepicker({
                singleDatePicker: true,
                timePicker: false,
                calender_style: "picker_2",
                autoUpdateInput : true,
                locale: {
                    format: 'DD/MM/YYYY'
                }
              }, function(start, end, label) {
                // console.log(start.toISOString(), end.toISOString(), label);
              });
    btnNuevaCarpeta = $('#btnNuevaCarpeta');
    var btnCrearCarpeta = $('#btnCrearCarpeta');
    btnSubirArchivo = $('#btnSubirArchivo');
    var prevFileUp = $('#prevFileUp');
    var modalCarpeta = $('#modalConfCarpeta-create');
    var modalDocumento = $('#modalConfDocumento');

    btnNuevaCarpeta.on('click',fnOpenModelCreateFolder);
    btnCrearCarpeta.on('click',fnCreateFolder);
    frmCrearCarpeta.submit(fnCreateFolderSubmit);
    frmRefDocs.submit(fnCreateDocSubmit);
    btnSubirArchivo.on('click',fnSubirFichero);
    //##ABRIR-MODAL-CREAR-CARPETA
    function fnOpenModelCreateFolder(e){
        // var objModalCP = new ModalConfigCarpeta();
           var frm = new Form('frmCrearCarpeta');
        var elem = frm.getElements();
        console.log(DATAFILES.carpeta);
        if(DATAFILES.carpeta != 'folder'){
            // $(elem.selCategoria).addClass('hidden');

            $(elem.selCategoria).toParent('.form-group').addClass('hidden');
            if(vistadepuni != 0){
                if(vistadepuni == 1){

                }

            }
        }
        $(elem.selCategoria).val('').trigger('change');
        frm.reset();
        $(elem.txtVisible).iCheck('check');
        btnCrearCarpeta.html('Crear');
        btnCrearCarpeta.get(0).dataset.accion = 'guardar';
        modalCarpeta.modal( 'show');

    }
    function fnSubirFichero(e){
        // e.preventDefault();
        console.log('clicked');
        prevFileUp.trigger('click');
        // prevFileUp.click();
    }
    function fnCreateDocSubmit(e){
        e.preventDefault();
        $.post(BASE_URL + 'documentos/actualizar', $(this).serializeArray() , function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){
                dtListar.page(dtListar.page()).draw('page');
                modalDocumento.modal('hide');
            }
        },'json').fail(fnFailAjax);
        console.log(this);
    }
    function fnCreateFolderSubmit(e){
        e.preventDefault();


        var btn = $('#btnCrearCarpeta').get(0);

        var frm = new Form('frmCrearCarpeta');
        var elem = frm.getElements();

        switch(btn.dataset.accion){
            case 'guardar':
                var dataset = {
                    txtTitulo: elem.txtTitulo.value,
                    txtVisible: elem.txtVisible.checked,
                    txtIdPadreCarpeta: DATAFILES.carpeta
                };
                if(nivelVistaCarpetas == 1)
                    dataset.txtCategoria = elem.selCategoria.value;
                $.post(BASE_URL + 'carpeta/create_folder', dataset, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.proceso)
                    {
                        modalCarpeta.modal('hide');

                        $(elem.selCategoria).val('').trigger('change');
                        $(elem.txtVisible).iCheck('uncheck');
                        frm.reset();
                        // dtListar.draw();
                        dtListar.page(data.num_paginador).draw('page');
                    }

                },'json').fail(fnFailAjax);
                break;
            case 'actualizar':
                var dataset = {
                    txtTitulo: elem.txtTitulo.value,
                    txtVisible: elem.txtVisible.checked,
                    txtIdCarpeta: elem.txtIdCarpeta
                };
                if(nivelVistaCarpetas == 1)
                    dataset.txtCategoria = elem.selCategoria.value;

                $.post(BASE_URL + 'carpeta/actualizar',dataset , function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado)
                    {
                        modalCarpeta.modal('hide');

                        $(elem.selCategoria).val('').trigger('change');
                        $(elem.txtVisible).iCheck('uncheck');
                        frm.reset();
                        // dtListar.draw();
                        dtListar.page(dtListar.page()).draw('page');
                        btnCrearCarpeta.get(0).dataset.accion = 'guardar';
                        btnCrearCarpeta.html('Crear');


                    }
                },'json').fail(fnFailAjax);


                break;
        }

    }
    //##CREAR-CARPETA
    function fnCreateFolder(e){
        var frm = new Form('frmCrearCarpeta');
        var elem = frm.getElements();
        switch(this.dataset.accion){
            case 'guardar':
                var dataset = {
                    txtTitulo: elem.txtTitulo.value,
                    txtVisible: elem.txtVisible.checked,
                    txtIdPadreCarpeta: DATAFILES.carpeta
                };
                switch(nivelVistaCarpetas){
                    case 1://carpetas principales
                        dataset.txtCategoria = elem.selCategoria.value;
                        break;

                    case 3://carpetas de departamento
                        // dataset.txtIdPadreCarpeta = 'folderdep';
                        // dataset.dependencia = selDepartamento.val();
                        break;
                }
                if(vistadepuni != 0){
                    if(vistadepuni == 1){
                        dataset.idDepartamento = getById('selDepartamento').value;
                        dataset.tipocrear = 2;
                        dataset.idUnidad = getById('selUnidadFrm').value;
                    }
                    if(vistadepuni == 11){
                        dataset.txtIdPadreCarpeta = OPCIONES_SUBCARPETA.idcarpetapadre;
                        dataset.tipocrear = 1;
                    }
                }

                $.post(BASE_URL + 'carpeta/create_folder', dataset , function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.proceso)
                    {
                        modalCarpeta.modal('hide');

                        $(elem.selCategoria).val('').trigger('change');
                        $(elem.txtVisible).iCheck('uncheck');
                        frm.reset();
                        // dtListar.draw();
                        dtListar.page(data.num_paginador).draw('page');
                    }else{


                    }

                },'json').fail(fnFailAjax);
                break;
            case 'actualizar':
                var dataset = {
                    txtTitulo: elem.txtTitulo.value,
                    txtVisible: elem.txtVisible.checked,
                    txtIdCarpeta: elem.txtIdCarpeta.value,
                    txtCategoria : elem.selCategoria.value
                };
                if(nivelVistaCarpetas == 1)
                    dataset['txtCategoria'] = elem.selCategoria.value;
                $.post(BASE_URL + 'carpeta/actualizar', dataset , function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado)
                    {
                        modalCarpeta.modal('hide');

                        $(elem.selCategoria).val('').trigger('change');
                        $(elem.txtVisible).iCheck('uncheck');
                        frm.reset();
                        // dtListar.draw();
                        dtListar.page(dtListar.page()).draw('page');
                        btnCrearCarpeta.get(0).dataset.accion = 'guardar';
                        btnCrearCarpeta.html('Crear');


                    }else{
                        $('#msgErrorCarpeta').removeClass('hidden');
                        setTimeout(function(){
                            $('#msgErrorCarpeta').addClass('hidden');
                        }, 3000)
                    }
                },'json').fail(fnFailAjax);


                break;
        }

    }

    var tblArchivos = $('#tblArchivos');
    dtListar = tblArchivos.DataTable({
                language: lenguajeDatatable,
                scrollX : "100%",
                scrollXInner : "100%",
                lengthChange : false,
                dom : 'ltp',
                processing : false,
                serverSide : true,
                autoWidth: true,
                responsive: true,
                pageLength : 5,
                order : [1,'asc'],
                // order : [],
                fixedHeader: true,
                ajax : {
                    url : BASE_URL + "carpeta/f/"+ DATAFILES.carpeta,
                    type : "POST",
                    // data : function(d){
                    //     d.filters = filtrosDatatable;
                    // },
                    error : fnFailAjax
                },
                columns: [
                    { data : 'FaIcono', render : function(data,type,row){
                         var t = Handlebars.compile(tpl_icons);
                        if(row.TipoFichero == 1){
                            return t({
                                nameFile : BASE_URL + 'public/app/img/iconos/folder.png',
                                nameFileTwo : 'Carpeta'
                            });
                        }else{
                            return t({
                                nameFile : BASE_URL + 'public/app/img/iconos/' + data,
                                nameFileTwo : row.nameFileTwo
                            });
                        }

                        return `<img src="http://sig.devep-jp.com:8888/public/app/img/iconos/folder.png" title="PDF">`;

                        if(row.TipoFichero == 2)
                            return '<span class="fa ' + row.FaIcono +'"></span>';
                        else return '<span class="fa fa-folder"></span>';

                    } },
                    { data : 'Descripcion','dataset.nombre':'carlos', className: "obj-target",render : function(d,t,r){
                        if(r.TipoFichero == 1){
                            if(d.trim() != ''){
                                // return '<span style="line-height: 0px">' + d + '</span>';
                                return '<span style="line-height: 0px">' + d + '</span>';
                            }
                            else{
                                //no existe descripción, se muestra el nombre del fihcero completo
                                return '<span style="line-height: 0px">' + r.NombreFichero + '</span>';
                            }
                        }else{
                            // console.log(d);
                            if(d){

                                if(d.trim() != ''){
                                    // return '<span style="line-height: 0px">' + d + '</span>';
                                    return '<a href="'+BASE_URL + r.RutaDoc+'" target="_blank" style="color:inherit"><span style="line-height: 0px">' + d + '</span></a>';
                                }
                                else{
                                    //no existe descripción, se muestra el nombre del fihcero completo
                                    return '<a href="'+BASE_URL+r.RutaDoc+'" target="_blank" style="color:inherit"><span style="line-height: 0px">' + r.NombreFichero + '</span></a>';
                                }
                            }
                        }
                    }},
                    {data : 'CategoriaFichero', render : function(d,t,r){
                        var categoria = obtenerCategoriaCarpeta(d);
                        // console.log(categoria);
                        if(categoria){
                            return '<span style="line-height: none">' + categoria.nomArchivo + '</span>';
                        }else return '-----';
                    }},
                    {data : 'Visible', render : function(d,t,r){
                        if(r.TipoFichero == 2){
                            if(+d == 1)
                                return '<span class="glyphicon glyphicon-eye-open" data-toggle="tooltip" data-placement="left" title="" data-original-title="Visible"></span>';
                            else
                                return '<span class="glyphicon glyphicon-eye-close" data-toggle="tooltip" data-placement="left" title="" data-original-title="Oculto"></span>';
                        }
                        if(r.TipoFichero == 1){
                            if(+d == 9)
                                return '<span class="glyphicon glyphicon-eye-open" data-toggle="tooltip" data-placement="left" title="" data-original-title="Visible"></span>';
                            else
                                return '<span class="glyphicon glyphicon-eye-close" data-toggle="tooltip" data-placement="left" title="" data-original-title="Oculto"></span>';
                        }

                    }},
                    { data : 'IdFichero',render : function(data,type,row){
                         return '<button type="button" class="btn btn-default btn-option-files"   title="Eliminar" data-original-title="Eliminar" data-tipo-archivo="'+row.TipoFichero+'" data-id-archivo="' + row.IdFichero + '" data-accion="eliminar"><span class="fa fa-trash"></span></button><button type="button" class="btn btn-default btn-option-files"   title="Configuración"  data-tipo-archivo="'+row.TipoFichero+'" data-id-archivo="' + row.IdFichero + '" data-accion="editar"><span class="fa fa-gear"></span></button>';

                    } }


                ],


                columnDefs : [
                    {
                        targets : [ 0 ],
                        orderable : false,
                        className : 'icon-files',
                        width : '20px',
                        createdCell : function (td, cellData, rowData, row, col) {
                            // tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"
                            // var x = td;
                            // console.log(td);
                             $(td).css({
                                'text-align' : 'center',
                                'vertical-align' : 'middle'
                            });

                        }

                    },

                    {
                        targets : [1],
                          createdCell : function (td, cellData, rowData, row, col) {
                            // tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"
                            // var x = td;
                            // console.log(td);
                            $(td).css({
                                'vertical-align' : 'middle'
                            });

                        },

                    },
                    {
                        targets : [2],
                        orderable : true,
                        width : '260px'

                    },
                    {
                        targets : [3],
                        orderable : true,
                        width : '50px',
                        createdCell : function (td, cellData, rowData, row, col) {
                            // tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"
                            // var x = td;
                            // console.log(td);
                            $(td).css({
                                'text-align' : 'center',
                                'vertical-align' : 'middle'
                            });

                        },

                    },
                    {
                        targets : [ 4],
                        orderable : false,
                        width : '64px',
                        createdCell : function (td, cellData, rowData, row, col) {
                            // tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"
                            // var x = td;
                            // console.log(td);
                            $(td).css({
                                'text-align' : 'center',
                                'vertical-align' : 'middle'
                            });

                        },

                    },
                    {
                        targets : [1],
                        createdCell : function (td, cellData, rowData, row, col) {
                            // tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"
                            var x = td;
                            x.dataset.tipoArchivo = 1;
                            x.dataset.idArchivo = 1;
                            x.dataset.idDependencia = 1;


                        },
                        orderable : true,

                    }
                    // {
                    //     targets : [2],
                    //     visible : nivelVistaCarpetas == 2 ? false : true
                    // }

                ],
                createdRow : function ( row, data, index ) {

                    if(data.TipoFichero == 1){
                        $(row).addClass('is-folder');
                    }
                    row.dataset.uniqueFile = data.IdFichero + '-'+ data.TipoFichero;
                    $(row).css('height','20px');

                    // if ( data[5].replace(/[\$,]/g, '') * 1 > 150000 ) {
                    //     $('td', row).eq(5).addClass('highlight');
                    // }
                }
            });


    dtListar.on( 'draw.dt', function () {
        console.log('is draw');
        // console.log( 'Redraw occurred at: '+new Date().getTime() );
        $('#rutaCarpetas .enlaces-carpeta').remove();
        if(DATAFILES.carpeta!='folder'){

            var rutas = dtListar.ajax.json().ref.ruta_carpeta;
            console.log(rutas);
            if(rutas){
                var totalR = rutas.length;


                $(rutas).each(function(index, el) {
                    if(index < totalR - 1){
                        if(el.descripcionCarpeta.trim() == '')
                            $('#rutaCarpetas').append('<li class="enlaces-carpeta"><a class="ref-rutas" href="#" data-id-carpeta="'+el.idCarpeta+'">'+ el.desCarpeta +'</a></li>');
                        else   $('#rutaCarpetas').append('<li class="enlaces-carpeta"><a class="ref-rutas" href="#" data-id-carpeta="'+el.idCarpeta+'">'+ el.descripcionCarpeta +'</a></li>');
                    }else{
                        if(el.descripcionCarpeta.trim() == '')
                            $('#rutaCarpetas').append('<li class="enlaces-carpeta active"><a  class="active">'+ el.desCarpeta +'</a></li>');
                        else $('#rutaCarpetas').append('<li class="enlaces-carpeta active"><a  class="active">'+ el.descripcionCarpeta +'</a></li>');
                    }

                    console.log(index);


                });
            }

        }

        if(nivelVistaCarpetas == 2){
            dtListar.column(2).visible(false);
        }else dtListar.column(2).visible(true);
        $('[data-toggle="tooltip"]').tooltip({
            container: '#tblArchivos'
        });

    });
    // dtListar
    var pagina_raiz_datable = 0;
    //##DOBLE-CLICK
    $('#tblArchivos').on('dblclick','tr.is-folder',function(e){
        console.log(this);

        if(nivelVistaCarpetas == 1){
            nivelVistaCarpetas = 2;
            $('#frmGroupCategoria').addClass('hidden');
        }
        if(vistadepuni != 0){
            if(vistadepuni == 1){
                console.log('cambiar vista unidad a 11');
                vistadepuni = 11;
                console.log(vistadepuni);
                $('#selUnidadFrm').val('').trigger('change').parents('.form-group').addClass('hidden');
                var targettr = this.dataset.uniqueFile.split('-');
                OPCIONES_SUBCARPETA.idcarpetapadre = +targettr[0];
                // uniqueFile
            }
            if(vistadepuni == 11){
                var targettr = this.dataset.uniqueFile.split('-');
                OPCIONES_SUBCARPETA.idcarpetapadre = +targettr[0];
            }
        }
        e.preventDefault();
        console.log('dblclick');
        console.log(dtListar.row(this).data());
        var objRow = dtListar.row(this).data();
        if(DATAFILES.carpeta == 'folder')
            pagina_raiz_datable = dtListar.page();
        btnSubirArchivo.prop('disabled',false);
        btnNuevaCarpeta.prop('disabled',false);
        DATAFILES.carpeta = objRow.IdFichero;

        // fileuploadss.get(0).dataset.url = BASE_URL + 'documentos/upload_docs/' + DATAFILES.carpeta;
        initUpload();

        dtListar.ajax.url(BASE_URL + "carpeta/f/"+ DATAFILES.carpeta);
        dtListar.order( [ 1, 'asc' ] ).draw();
        // $(dtListar.ajax.json().ref.ruta_carpeta).each(function(e,v){
        //     console.log(v);
        // });

        // location = BASE_URL + 'carpeta/f/' + objRow.IdFichero;
        // console.log(dtListar.row().data());
        return false;
    });
    var targettr = {node:false,unique:-1}
    $('#tblArchivos').on('click','tr',function(e){
        // e.preventDefault();
        if(!targettr.node){
            console.log('first');
            targettr.node = this;
            targettr.unique = this.dataset.uniqueFile;
            $(this).addClass('tr-target');
        }

        if(this.dataset.uniqueFile != targettr.unique){
            $(targettr.node).removeClass('tr-target');
            targettr.node = this;
            targettr.unique = this.dataset.uniqueFile;
            $(this).addClass('tr-target');
        }
        // $(this).addClass('tr-target');
        // return false;
    });
    $('#btnRaiz').on('click',function(e){
        console.log('es un numero : ' + nivelVistaCarpetas);

        $('#frmGroupCategoria').removeClass('hidden');
        e.preventDefault();
         DATAFILES.carpeta = 'folder';
        btnSubirArchivo.prop('disabled',true);
        // dtListar.ajax.url(BASE_URL + "carpeta/f/folder");
        nivelVistaCarpetas = 1;
        // switch(nivelVistaCarpetas){
        //     case 1:

        //         break;
        //     case 2:
        //         DATAFILES.carpeta = 'folder';
        //         btnSubirArchivo.prop('disabled',true);
        //         dtListar.ajax.url(BASE_URL + "carpeta/f/folder");
        //         nivelVistaCarpetas = 1;
        //         break;
        //     // case 3:
        //     //     console.log('cambio 3');
        //     //     selDepartamento.trigger('change');
        //     //     break;
        //     // case 4:
        //     //     break;
        // }
        console.log(vistadepuni);
        if(vistadepuni != 0){
            console.log(vistadepuni);
            btnNuevaCarpeta.prop('disabled', false);
        }else{
            console.log(vistadepuni);
            vistadepuni = 0;
        }
        selDepartamento.val('').trigger('change').prop('disabled',true);
        selTipoCarpeta.val('1').trigger('change');

        // console.log(pagina_raiz_datable);
        // dtListar.ajax.params().start = pagina_raiz_datable;
        // dtListar.order([ 1, 'asc' ]).draw();
        // dtListar.draw();
        // dtListar.page(3).draw('page');
        console.log('termino');

        return false;
    })
    //##REF-RUTAS
    $('#rutaCarpetas').on('click','a.ref-rutas',function(e){
        e.preventDefault();
        console.log(vistadepuni);
        DATAFILES.carpeta = this.dataset.idCarpeta;
        if(vistadepuni == 1 || vistadepuni == 11){
            OPCIONES_SUBCARPETA.idcarpetapadre = this.dataset.idCarpeta;
            console.log(vistadepuni);
            var rutas = dtListar.ajax.json().ref.ruta_carpeta;
            var i;
            for (i = rutas.length - 1; i >= 0; i--) {
                if(rutas[i].idCarpeta == DATAFILES.carpeta)
                    break;
            };
            console.log(vistadepuni);
            console.log(rutas[i]);
            if(+rutas[i].idDepenCarpeta == +getById('selDepartamento').value){
                console.log('solo sin soniguales');
                btnSubirArchivo.prop('disabled',true);
                btnNuevaCarpeta.prop('disabled',false);
                vistadepuni = 1;
                $('#selUnidadFrm').parents('.form-group').removeClass('hidden');
            }
            console.log(vistadepuni);
            // $(dtListar.ajax.json().ref.ruta_carpeta).each(function(e,v){
            //     console.log(v);
            //     console.log(getById('selDepartamento').value);
            //     if(+v.idDepenCarpeta == +getById('selDepartamento').value){
            //         console.log('iguales');
            //         btnSubirArchivo.prop('disabled',true);
            //         btnNuevaCarpeta.prop('disabled',false);
            //         vistadepuni = 1;
            //         $('#selUnidadFrm').parents('.form-group').removeClass('hidden');

            //     }
            // });
        }

        dtListar.ajax.url(BASE_URL + "carpeta/f/"+ DATAFILES.carpeta);
        dtListar.order([ 1, 'asc' ]).draw();
        dtListar.draw();
        return false;
    })
    $('#rutaCarpetas').on('click','a.active',function(e){

        // DATAFILES.carpeta = this.dataset.idCarpeta;
        // dtListar.ajax.url(BASE_URL + "carpeta/f/"+ DATAFILES.carpeta);
        dtListar.draw();
    })
    $('#tblArchivos').on('click','.btn-option-files',function(e){
        // console.log(this);
        e.preventDefault();
        datatarget = this.dataset;
        // console.log(datatarget.accion);
        if(datatarget.tipoArchivo == 1){
            //folder
            switch(datatarget.accion){
                case 'editar':
                    // modalCarpeta.modal('show');
                    $.post(BASE_URL + 'carpeta/data/' + datatarget.idArchivo, {}, function(data, textStatus, xhr) {
                        console.log(data);
                        var obj = data.objRes;
                        var frm = new Form('frmCrearCarpeta');
                        var ele = frm.getElements();
                        ele.txtTitulo.value = obj.descripcionCarpeta;
                        +obj.estadoCarpeta == 9 ? $(ele.txtVisible).iCheck('check') : $(ele.txtVisible).iCheck('uncheck');
                        $(ele.selCategoria).val(obj.idArchivoCarpeta).trigger('change');
                        ele.txtIdCarpeta.value = obj.idCarpeta;

                        $(ele.selUnidadFrm).val(obj.idDepenCarpeta).trigger('change');
                        btnCrearCarpeta.get(0).dataset.accion = 'actualizar';
                        btnCrearCarpeta.html('Actualizar');
                        modalCarpeta.modal('show');

                        if(vistadepuni != 0){

                        }

                        /*optional stuff to do after success */
                    },'json').fail(fnFailAjax);
                    break;
                case 'eliminar':
                    swal({
                        title: "Eliminar Carpeta",
                        text: "¿Desea eliminar esta carpeta?",
                        type: "warning",
                        showCancelButton: true,
                        animation: "slide-from-top",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "Sí, Eliminar!",
                        cancelButtonText: "No, Cancelar!",
                        closeOnConfirm: false,
                        closeOnCancel: true,
                        showLoaderOnConfirm: true
                    },
                    function(isConfirm){
                      if (isConfirm) {

                            $.post(BASE_URL + 'carpeta/delete_folder/' + datatarget.idArchivo, {}, function(data, textStatus, xhr) {
                                console.log(data);
                                if(data.respuesta == true){
                                    swal("Eliminado!", "La carpeta fue eliminada", "success");

                                    dtListar.page(dtListar.page()).draw('page');
                                    // dtListar.draw();
                                }else{
                                    swal("Cancelado!", "La carpeta no se puede eliminar", "error");
                                }
                                /*optional stuff to do after success */
                            },'json').fail(fnFailAjax);
                      }
                    });
                    break;


            }
        }else{
            //2##ARCHIVOS##DOCUMENTOS archivos
             switch(datatarget.accion){
                case 'editar':


                    $.post(BASE_URL + 'documentos/data/' + datatarget.idArchivo, {}, function(obj, textStatus, xhr) {
                        console.log(obj);
                        // var obj = data.objRes;
                        var frm = new Form('frmRefDocs');
                        var ele = frm.getElements();
                        ele.txtTituloDoc.value = obj.desDoc;
                        obj.estadoDoc == '1' ? $(ele.txtVisibleDoc).iCheck('check') : $(ele.txtVisibleDoc).iCheck('uncheck');
                        // $(ele.selCategoria).val(obj.idArchivoCarpeta).trigger('change');
                        ele.txtIdDocumento.value = obj.idDoc;
                        ele.txtVerDoc.value = +obj.versionDoc;
                        // btnCrearCarpeta.get(0).dataset.accion = 'actualizar';
                        // btnCrearCarpeta.html('Actualizar');

                        if(obj.fecAprobacionArchivo != null){
                            var dd = moment(obj.fecAprobacionArchivo);
                            if(dd.isValid()){
                                $('#txtAprobacionDoc').data('daterangepicker').setStartDate(dd.format('DD/MM/YYYY'));
                                $('#txtAprobacionDoc').data('daterangepicker').setEndDate(dd.format('DD/MM/YYYY'));
                                $('#txtAprobacionDoc').val(dd.format('DD/MM/YYYY'));

                            }

                            // ele.txtAprobacionDoc.value = momen(obj.fecAprobacionArchivo).format('DD/MM/YYYY');
                        }else{
                            $('#txtAprobacionDoc').data('daterangepicker').setStartDate(moment().format('DD/MM/YYYY'));
                            $('#txtAprobacionDoc').data('daterangepicker').setEndDate(moment().format('DD/MM/YYYY'));
                            $('#txtAprobacionDoc').val('');
                        }

                        modalDocumento.modal('show');
                    },'json').fail(fnFailAjax);

                    break;
                case 'eliminar':
                    break;
             }


        }
    })

    function obtenerCategoriaCarpeta(id){
        for (var i = CATEGORIAS_CARPETA.length - 1; i >= 0; i--) {
            if(+CATEGORIAS_CARPETA[i].idArchivo == +id)
                return CATEGORIAS_CARPETA[i];
        }
        return false;
    }
    // $('#tblArchivos').on('focus','tr',function(e){
    //     e.preventDefault();
    //     console.log('focus');
    //     $(this).addClass('tr-target');
    //     return false;
    // });
    //   $('#tblArchivos').on('selectstart','td span',function(e){
    //     e.preventDefault();
    //     console.log('asdasd');
    //     return false;
    // });
    //     $('#tblArchivos').on('mousedown','td span',function(e){
    //     e.preventDefault();
    //     return false;
    // });
}
//##OPCIONES-CARPETA
function fnChangeTipoCarpeta(e){
    switch(+this.value){
        case 1:
            console.log('modo general');
            $('#btnCrearCarpeta').prop('disabled',false);
            //genrales
            selDepartamento.val('').trigger('change').prop('disabled',true);
            selUnidad.val('').trigger('change').prop('disabled',true);
            DATAFILES.carpeta = 'folder';
            $('#btnSubirArchivo').prop('disabled',true);
            dtListar.ajax.url(BASE_URL + "carpeta/f/folder");
            // dtListar.order([ 1, 'asc' ]).draw();
            dtListar.draw();
            nivelVistaCarpetas = 1;
            vistadepuni = 0;
            break;
        case 2:
            console.log('modo departamentos');
            $('#selUnidadFrm').parents('.form-group').removeClass('hidden');
            $('#selCategoria').parents('.form-group').addClass('hidden');

            //habilitar solo el departamento
            btnNuevaCarpeta.prop('disabled',true);
            btnSubirArchivo.prop('disabled',true);
            selUnidad.prop('disabled',true);
            opcSelDepartamento();
            vistadepuni = 1;
            nivelVistaCarpetas = 3;
            break;
        case 3:
            console.log('modo unidades');
            //habilitar unidades, la búsqueda se cancela para deps
            vistadepuni = 2;
            nivelVistaCarpetas = 4;
            opcSelDepartamento();
            break;
    }
}
var opc_filtro_carpeta = 1;
function opcSelUnidad(idunidad){
    selUnidad.prop('disabled',false);
    $.getJSON(BASE_URL + '/unidad/listar_by_dep/' + idunidad , {}, function(json, textStatus) {
            // console.log(json);
            var iopc = [];
            for (var i = 0; i < json.length; i++) {
                var t = Handlebars.compile(TEMPLATES.option);
                iopc.push(t({
                    id : json[i].idDepend,
                    text : json[i].desDepend
                }))
            };
            selUnidad.html(iopc.join(''))
            selUnidad.trigger('change');
    });
}
function opcSelDepartamento(){
    selDepartamento.prop('disabled',false);
    $.getJSON(BASE_URL + '/departamento/listar_activos', {}, function(json, textStatus) {
            // console.log(json);
            var iopc = [];
            for (var i = 0; i < json.length; i++) {
                var t = Handlebars.compile(TEMPLATES.option);
                iopc.push(t({
                    id : json[i].idDepend,
                    text : json[i].desDepend
                }))
            };
            selDepartamento.html(iopc.join(''))
            selDepartamento.trigger('change');
    });
}
//##CAMBIAR-DEPARTAMENTO
function fnChangeDep(e){

    console.log('change dep');
    if(this.value == ''){
        btnNuevaCarpeta.prop('disabled',false);
    }else{
        if(vistadepuni == 1 || vistadepuni == 11){

            btnNuevaCarpeta.prop('disabled',false);
            btnSubirArchivo.prop('disabled',true);
            $('#selUnidadFrm').parents('.form-group').removeClass('hidden');
            DATAFILES.carpeta = this.value;
            // dtListar.draw();
            console.log(DATAFILES.carpeta);
            dtListar.ajax.url(BASE_URL + "carpeta/f/"+ DATAFILES.carpeta + '?t=dep');
            dtListar.order( [ 1, 'asc' ] ).draw();

            //Cambiar el contenido del select de unidades por cada cambio en el selcte de departamentos
            var iddep = +this.value;
            var selE = $('#selUnidadFrm');
            $.getJSON(BASE_URL + '/unidad/listar_by_dep/' + iddep , {}, function(json, textStatus) {

                    var iopc = [];
                    for (var i = 0; i < json.length; i++) {
                        var t = Handlebars.compile(TEMPLATES.option);
                        iopc.push(t({
                            id : json[i].idDepend,
                            text : json[i].desDepend
                        }))
                    };
                    selE.html(iopc.join(''));
                    selE.trigger('change');
                    if(json.length == 0){
                        $('#btnCrearCarpeta').prop('disabled',true);
                    }else $('#btnCrearCarpeta').prop('disabled',false);

            });
            vistadepuni = 1;
            //cambiar departametno o carga el contendio del departamento o solo del
        }else{
            opcSelUnidad(this.value);
            //cargar unidades del departamento
        }
    }

}
function fnChangeUni(e){
      console.log('change uni');
    DATAFILES.carpeta = this.value;
    // dtListar.draw();
    console.log(DATAFILES.carpeta);
    dtListar.ajax.url(BASE_URL + "carpeta/f/"+ DATAFILES.carpeta + '?t=uni');
    dtListar.order( [ 1, 'asc' ] ).draw();
}

