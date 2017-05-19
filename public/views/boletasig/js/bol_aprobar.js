window.onload = fnLoad;
function fnLoad(){
    moment.locale('es');
    var fecha_solicita = $('#fecha_solicita');
    fecha_solicita.text(moment(boleta_data.fecha_generado).format('LLL'));

    var frmBoletaSIG = $('#frmBoletaSIG');
    var btnRechazar = $('#btnRechazar');

    if(boleta_data.rechazado){
        frmBoletaSIG.find('input').prop('disabled',true).end()
        .find('select').prop('disabled',true).end()
        .find('textarea').prop('disabled',true).end();
    }
    else{
        frmBoletaSIG.find('input.radTipoBoletaC').prop('disabled',true);
    }


    // $('#tbSeguridad').iCheck('disabled');
    frmBoletaSIG.submit(function(e){

        e.preventDefault();
        var frmReg = new Form('frmBoletaSIG');
        var elem = frmReg.getElements();
        swal_option.confirm.title = 'Aprobar Boleta';
        swal_option.confirm.text = 'Está seguro de aprobar esta Boleta SIG?';
        swal_option.confirm.type = 'warning';
        swal_option.confirm.closeOnCancel = true;

        swal(swal_option.confirm,
        function(isConfirm){
          if (isConfirm) {
            console.log('aprobar');

            $.post(BASE_URL + 'boletasig/aprobar_boleta', {
                txtId : elem.txtId.value,
                txtObserva : elem.txtDesObserva.value,
                txtCorregir : elem.txtDesCorregir.value
            }, function(data, textStatus, xhr) {
                console.log(data);
                if(data.resultado == true){
                    // swal("Boleta aprobada!",'', "success");
                    swal({
                        title : 'Boleta  aprobada',
                        text : '',
                        type : 'success'

                    },function(e,d){
                        // window.close();
                        window.location = BASE_URL + 'boletasig/listar' ;
                    })
                }
            },'json').error(function(e){console.log(e.responseText)});

          }
        });
    });
    btnRechazar.on('click',fnRechazarBoleta);

}

function fnRechazarBoleta(e){
    var idBol = getById('txtId').value;

    swal_option.confirm.title = 'Rechazar Boleta';
    swal_option.confirm.text = 'Está seguro de rechazar esta Boleta SIG?';
    swal_option.confirm.type = 'warning';
    swal_option.confirm.closeOnCancel = true;

    swal(swal_option.confirm,
    function(isConfirm){
      if (isConfirm) {
        console.log('rechazar');

        $.post(BASE_URL + 'boletasig/rechazar_elaborado/' + idBol, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado == true){
                // swal("Boleta aprobada!",'', "success");
                swal({
                    title : 'Boleta  rechazada',
                    text : '',
                    type : 'success'

                },function(e,d){
                    // window.close();
                    window.location = BASE_URL + 'boletasig/listar' ;
                })
            }
        },'json').error(function(e){console.log(e.responseText)});

      }
    });

}