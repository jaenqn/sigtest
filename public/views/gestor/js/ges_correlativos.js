window.onload = fnLoad;
function fnLoad(){
    var selCorreSig = $('#selCorreSig');
    var txtCorreSig = $('#txtCorreSig');
    var selCorreIncUni = $('#selCorreIncUni');
    var txtCorreInc = $('#txtCorreInc');
    var btnGuardar = $('#btnGuardar');
    var frmCorrelativo = $('#frmCorrelativo');
    selCorreSig.on('change',function(e){
        var opc = this.value;
        $.post(BASE_URL + 'correlativos/get_correlativo_sig/1/' + opc, {}, function(data, textStatus, xhr) {
            console.log(data);
            txtCorreSig.val(data[0].cor_val);
            txtCorreSig.prop('disabled',false);

        },'json').fail(fnFailAjax);
    });

    selCorreIncUni.on('change',function(e){
        var opc = this.value;
        $.post(BASE_URL + 'correlativos/get_correlativo_inc/3/' + opc, {}, function(data, textStatus, xhr) {
            console.log(data);
            txtCorreInc.val(data[0].cor_val);
            txtCorreInc.prop('disabled',false);

        },'json').fail(fnFailAjax);
    })
    frmCorrelativo.submit(function(e){
        console.log('asdasdasd');
        e.preventDefault();

        var frmRegistro = new Form('frmCorrelativo');
        // $('#frmRegistro').submit();
        var elem = frmRegistro.getElements();
        swal_option.confirm.title = 'Guardar Opciones';
        swal_option.confirm.text = '¿Desea guardar los datos?';
        swal_option.confirm.type = 'warning';
        swal_option.confirm.closeOnCancel = true;

        swal(swal_option.confirm,
            function(isConfirm){
                if (isConfirm) {
                    $.post(BASE_URL + 'correlativos/actualizar', {
                                boleta : {
                                    opc : elem.selCorreSig.value,
                                    value : elem.txtCorreSig.value
                                },
                                sacp : {
                                    opc : 1,
                                    value : elem.txtCorreSacp.value,
                                },
                                reporte : {
                                    opc : elem.selCorreIncUni.value,
                                    value : elem.txtCorreInc.value
                                },
                                autorizacion : {
                                    opc : 1,
                                    value : elem.txtCorreAutori.value
                                }
                    }, function(data, textStatus, xhr) {
                        console.log(data);

                                if(data.respuesta){
                                    swal("Datos Actualizados!",'', "success");
                                }
                    },'json').fail(fnFailAjax);
                }
        });
        return false;
    })
}