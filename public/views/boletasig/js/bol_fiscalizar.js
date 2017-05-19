window.onload = fnLoad;

function fnLoad(e){
    var frmFiscalizarBoleta = $('#frmFiscalizarBoleta');
    var btnRechazarRespuesta = $('#btnRechazarRespuesta');
    var frmBoletaSIG = $('#frmBoletaSIG');
    var frmBoletaSIGRes = $('#frmBoletaSIGRes');
    var txtFechaFiscaliza = $('#txtFechaFiscaliza');
    moment.locale('es');
    txtFechaFiscaliza.val(moment().format('dddd DD MMM YYYY, hh:mm a'));
    setInterval(function(){
        txtFechaFiscaliza.val(moment().format('dddd DD MMM YYYY, hh:mm a'));
    },1000)
    var fecha_solicita = $('#fecha_solicita');
    var fecha_solicita_res = $('#fecha_solicita_res');
    frmBoletaSIG.find('input').prop('disabled',true);
    frmBoletaSIGRes.find('input').prop('disabled',true).end().find('textarea').prop('disabled',true);
    // fecha_solicita.val(moment().format('LLL'));

    fecha_solicita.text(moment(boleta_data.fecha_generado).format('dddd DD MMM YYYY, hh:mm a'));
    fecha_solicita_res.val(moment(boleta_data.fecha_respuesta).format('dddd DD MMM YYYY, hh:mm a'));
    frmFiscalizarBoleta.on('submit',fnSubmitFiscalizar);
    btnRechazarRespuesta.on('click',fnRechazarRes);



}
function fnSubmitFiscalizar(e){
    e.preventDefault();
    var datapost = (new Form(this)).getNameValue();
    $.post(BASE_URL + 'boletasig/cerrar_boleta', datapost , function(data, textStatus, xhr) {
        console.log(data);
        if(data.resultado){
            swal('Boleta SIG Cerrada','','success');
        }


    },'json').fail(fnFailAjax);


}
function fnRechazarRes(){
    var idb = document.getElementById('txtId');
    $.post(BASE_URL + 'boletasig/rechazar_respuesta/' + idb.value,{}, function(data, textStatus, xhr) {
        console.log(data);
    },'json').fail(fnFailAjax);
}

