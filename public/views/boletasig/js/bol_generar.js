window.onload = fnLoad;
var OPC_BOLETA = {
    tipo : 1,
}
var jqUploader;
function fnLoad(){
    var tpl_file_upload = `
        <tr>
            <td style="width: 40px" class="icon-files"><img src="{{img_url}}" title="{{img_title}}"></img></td>
            <td><a href="{{urlfile}}" target="_blank" class="show-file">{{name}}</a></td>
            <td style="padding:2px;vertical-align:middle"><div class="progress" style="margin-top: auto;margin-bottom: auto;">
                            <div class="progress-bar progress-bar-striped active" data-transitiongoal="10"></div>
                </div>
            </td>
            <td style="width: 40px;text-aling:center;vertical-aling:middle">
                <button type="button" class="btn btn-default  btn-option-files loading" title="Cancelar subida"  data-id-fichero="-1"><span class="fa fa-ban"></span></button>
            </td>
        </tr>
    `;
    var radTipoBoletaC = $('.radTipoBoletaC');

    var fecha_solicita = $('#fecha_solicita');
    var frmBoletaSIG = $('#frmBoletaSIG');
    var txtBolCorrelativo = $('#txtBolCorrelativo');
    var btnAgregarFichero = $('#btnAgregarFichero');
    var lstFicheros = $('#lstFicheros');
    var textCorrelativo = $('#textCorrelativo');
    var prevFileUp = $('#prevFileUp');
    var fileuploadss = $('#fileupload');
    moment.locale('es');
    updateCorrelativo();

    fecha_solicita.text(moment().format('LLL'));
    // radTipoBoletaC.on('change',function(e){
    //     console.log(this);
    // })
    setInterval(function(){
        fecha_solicita.text(moment().format('LLL'));
        updateCorrelativo();
    },1000)
    radTipoBoletaC.on('ifChecked', function(event){
        console.log(this);
        OPC_BOLETA.tipo = this.value;
        updateCorrelativo();
    });
    function updateCorrelativo(){
        // var self = this;
        var t = textCorrelativo.get(0).dataset.correlativo;
         $.post(BASE_URL + 'correlativos/solicitar_cboleta/' + OPC_BOLETA.tipo, {}, function(data, textStatus, xhr) {
            // console.log(data);
            if(t != data.correlativo)
                textCorrelativo.text(data.correlativo);
            // txtBolCorrelativo.data(data.correlativo);
        },'json');
    }

    frmBoletaSIG.submit(function(e){

        e.preventDefault();
        var frmReg = new Form('frmBoletaSIG');
        var elem = frmReg.getElements();
        swal_option.confirm.title = 'Generar Boleta';
        swal_option.confirm.text = '¿Desea generar Boleta SIG?';
        swal_option.confirm.type = 'warning';
        swal_option.confirm.closeOnCancel = true;

        swal(swal_option.confirm,
        function(isConfirm){
          if (isConfirm) {
            console.log('registrar');
            $.post(BASE_URL + 'boletasig/crear', {
                txtTipo : elem.radTipoBoleta.value,
                txtUniRemi : elem.txtCodUniRem.value,
                txtUniRece : elem.selCorreIncUni.value,
                txtObserva : elem.txtDesObserva.value,
                txtCorregir : elem.txtDesCorregir.value
            }, function(data, textStatus, xhr) {
                console.log(data);
                if(data.resultado){
                    // swal("Proceso Registrado!",'', "success");
                    swal({
                        title : 'Boleta  generada',
                        text : '',
                        type : 'success',
                        showCancelButton: false,
                        closeOnConfirm: false,
                        showLoaderOnConfirm: true,
                        closeOnConfirm : false,

                    },function(isConfirm){
                        setTimeout(function(){
                            window.location = BASE_URL + 'boletasig/listar' ;
                        }, 400);
                        // window.location = BASE_URL + 'boletasig/listar' ;
                    })
                }
            },'json').error(fnFailAjax);
          }
        });
    })

    jqUploader = fileuploadss.fileupload({
                dataType: 'json',
                acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
                add: function (e, data) {
                    data.url = BASE_URL + 'boletasig/upload_ficheros';
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
                        urlfile : '#',
                        img_url : BASE_URL + 'public/app/img/iconos/'+ icono[1],
                        img_title :  icono[2]

                    }));
                    data.cProgress.find('.btn-option-files').on('click',function(e){
                        console.log(data);
                        console.log(this);
                        var idf = this.dataset.idFichero;
                        if(idf != -1){
                            $.post(BASE_URL + 'boletasig/eliminar_fichero', {id_fichero : idf}, function(datas, textStatus, xhr) {

                                if(datas.resultado){
                                    data.cProgress.fadeOut('fast', function() {
                                        $(this).remove();
                                    });
                                }

                            },'json').fail(fnFailAjax);
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
                    console.log(data.response());
                    var file_ref = data.result.files[0];
                    data.cProgress.find('.progress-bar-striped').removeClass('active')
                    .end()
                    .find('.btn-option-files').attr('title','Eliminar').attr('data-id-fichero',file_ref.id_fichero)
                    .end()
                    .find('.fa-ban').removeClass('fa-ban').addClass('fa-trash').end()
                    .find('.show-file').attr('href',BASE_URL + file_ref.url);
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

    // btnAgregarFichero.on



}