window.onload = fnLoad;

function fnLoad(){
    moment.locale('es');
    var fecha_solicita = $('#fecha_solicita');
    var btnRechazar = $('#btnRechazar');

    fecha_solicita.text(moment(boleta_data.fecha_generado).format('LLL'));

    var frmBoletaSIG = $('#frmBoletaSIG');

    frmBoletaSIG.find('input').prop('disabled',true)
    .end().find('select').prop('disabled',true)
    .end().find('textarea').prop('disabled',true);

    frmBoletaSIG.submit(function(e){
        console.log('procesa');
        e.preventDefault();
        var frmReg = new Form('frmBoletaSIG');
        var elem = frmReg.getElements();
        $.post(BASE_URL + 'boletasig/procesa/' + elem.txtId.value, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.respuesta == true){
                swal({
                        title : 'Boleta  Procesada',
                        text : '',
                        type : 'success'

                },function(e,d){
                     setTimeout(function(){
                        window.location = BASE_URL + 'boletasig/listar';
                    },1000)
                })
            }

            /*optional stuff to do after success */
        },'json').fail(fnFailAjax);

        // swal_option.confirm.title = 'Aprobar Boleta';
        // swal_option.confirm.text = 'Está seguro de aprobar esta Boleta SIG?';
        // swal_option.confirm.type = 'warning';
        // swal_option.confirm.closeOnCancel = true;

        // swal(swal_option.confirm,
        // function(isConfirm){
        //   if (isConfirm) {
        //     console.log('aprobar');

        //     $.post(BASE_URL + 'boletasig/aprobar_boleta', {
        //         txtId : elem.txtId.value,
        //         txtTipo : elem.radTipoBoleta.value,
        //         txtUniRemi : elem.txtCodUniRem.value,
        //         txtUniRece : elem.selCorreIncUni.value,
        //         txtObserva : elem.txtDesObserva.value,
        //         txtCorregir : elem.txtDesCorregir.value,
        //         txtNombreEla : elem.txtNombreEla.value,
        //         txtFichaEla : elem.txtFichaEla.value,
        //         txtDniEla : elem.txtDniEla.value,
        //         txtNombreRev : elem.txtNombreRevisa.value,
        //         txtFichaRev : elem.txtFichaRevisa.value,
        //         txtDniRev : elem.txtDnRevisa.value
        //     }, function(data, textStatus, xhr) {
        //         console.log(data);
        //         if(data.resultado){
        //             // swal("Boleta aprobada!",'', "success");
        //             // swal({
        //             //     title : 'Boleta  aprobada',
        //             //     text : '',
        //             //     type : 'success'

        //             // },function(e,d){
        //             //     window.location = BASE_URL + 'boletasig/listar' ;
        //             // })
        //         }
        //     },'json').error(function(e){console.log(e.responseText)});

        //   }
        // });
    })
    btnRechazar.on('click',fnRechazar);

}

function fnRechazar(e){
    var idb = getById('txtId').value;
    swal_option.confirm.title = 'Rechazar Boleta';
    swal_option.confirm.text = '¿Está seguro de rechazar esta Boleta SIG?';
    swal_option.confirm.type = 'warning';
    swal_option.confirm.closeOnCancel = true;
    swal_option.confirm.showLoaderOnConfirm = true;


    swal(swal_option.confirm,
    function(isConfirm){
        if(isConfirm){
            $.post(BASE_URL + 'boletasig/rechazar_proceso/' + idb, {}, function(data, textStatus, xhr) {
                console.log(data);
                if(data.resultado){
                    setTimeout(function(){
                        window.location = BASE_URL + 'boletasig/enviar_observacion/'+idb+'/emi';
                    },1000)

                }
            },'json').fail(fnFailAjax);
        }
    });


    // console.log(e);
}