window.onload = fnLoad;
var frmAutorizar;
function fnLoad(){
    moment.locale('es');
    var txtFechaSolicitud = $('#txtFechaSolicitud');
    var btnAutorizar = $('#btnAutorizar');
    frmAutorizar = $('#frmAutorizar');
    frmAutorizar.on('submit',fnAutorizar);
    txtFechaSolicitud.text(moment(txtFechaSolicitud.data('fecha')).format('dddd DD MMM YYYY'));
    // txtFechaSolicitud.get(0).dataset('')
    btnAutorizar.on('click',function(e){
        e.preventDefault();
        var id_solicitud = this.dataset.idSolicitud;
        $.post(BASE_URL + 'residuo/autorizar_solicitud/' + id_solicitud, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){
                window.location = BASE_URL + 'residuo/autorizacion/' + id_solicitud;
            }
        },'json').fail(fnFailAjax);

    });
}
function fnAutorizar(e){
    e.preventDefault();
    var frm = new Form(frmAutorizar.get(0));
    var datapost = frm.getNameValue();
    console.log(datapost);
    $.post(BASE_URL + 'residuo/autorizar_solicitud', datapost, function(data, textStatus, xhr) {

          if(data.resultado){
                  swal({
                        title : 'Solicitud   Autorizada',
                        text : '',
                        type : 'success',
                        showCancelButton: false,
                        closeOnConfirm: false,
                        showLoaderOnConfirm: true,
                        closeOnConfirm : false,

                    },function(isConfirm){
                        console.log(isConfirm);
                        setTimeout(function(){
                            window.location = BASE_URL + 'residuo/listar' ;
                        }, 1000)

                    })
                // swal('Solicitud Enviada','','success');

            }
    },'json').fail(fnFailAjax);
}
