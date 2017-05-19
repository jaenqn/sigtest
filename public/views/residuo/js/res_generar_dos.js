window.onload = fnLoad;

var rg = {};
var tpl_fuente = `   <tr>
                        <td><input type="text" name="txtFuenGenAGDR[]" value="" placeholder=""></td>
                        <td><input type="text" name="txtFuenGenIUEEP[]" value="" placeholder=""></td>
                        <td><input type="text" name="txtFuenGenTR[]" value="" placeholder=""></td>
                      </tr>`;
var tpl_fuente_dos =    `
                        <tr>
                            <input type="hidden" name="txtFuenteId[]" value="new-data">
                            <td><input type="text" name="txtFuenGenAGDR[]" value="" placeholder=""></td>
                            <td><input type="text" name="txtFuenGenIUEEP[]" value="" placeholder=""></td>
                            <td style="display:flex" class="fuenteGenTR"><input type="text" class="txtFuenGenTR" name="txtFuenGenTR[]" value="" placeholder=""><button type="button" data-id-obj="-1" class="btnEliminarAccion  btn-option-files"  style="width:35px;background: inherit;border-top: 0px solid rgb(115, 135, 156);border-bottom: 0px solid rgb(115, 135, 156);border-right: 0px solid rgb(115, 135, 156);border-left: 0px;" title="Eliminar Actividad"><i class="fa fa-trash" style="font-size:1.2em"></i></button></td>
                        </tr>
                        `;
var tpl_button = `
    <button type="button" data-id-obj="-1" class="btnEliminarAccion btn-option-files" style="width:35px;background: inherit;border-top: 0px solid rgb(115, 135, 156);border-bottom: 0px solid rgb(115, 135, 156);border-right: 0px solid rgb(115, 135, 156);border-left: 0px;" title="Eliminar Actividad"><i class="fa fa-trash" style="font-size:1.2em"></i></button>
`;
var tblFuenteResiduo = $('#tblFuenteResiduo');

function fnLoad(){
    rg.selInstalacion =  $('#selInstalacion');
    rg.tbodyDetaRes =  $('#tbodyDetaRes');
    rg.frmDeclara =  $('#frmDeclara');
    var btnAgregarFuente = $('#btnAgregarFuente');

    rg.selInstalacion.on('change',fnChangeinst);
    btnAgregarFuente.on('click',fnAgregarFuente);

    rg.selResiduo = $('#selResiduo');
    rg.selResiduoYear = $('#selResiduoYear');
    rg.frmDeclara.on('submit', fnSubmitDeclara);

    tblFuenteResiduo.on('click','.btnEliminarAccion', fneliminarAccion);

    rg.selResiduoYear.on('change', fnSelYearChange);
    rg.selResiduo.on('change', fnSelResChange);
    rg.selResiduoYear.trigger('change');
    rg.selInstalacion.trigger('change');
    rg.selResiduo.trigger('change');
    rg.nf = new Intl.NumberFormat("de-DE", {minimumFractionDigits : 2, maximumFractionDigits : 2});
    rg.nd3 = new Intl.NumberFormat("de-DE", {minimumFractionDigits : 3, maximumFractionDigits : 3});
    rg.ni = new Intl.NumberFormat("de-DE", {minimumFractionDigits : 0, maximumFractionDigits : 0});
}
function fnSubmitDeclara(e){
    e.preventDefault();
    $.post(BASE_URL + 'residuo/actualizar_declaracion', rg.frmDeclara.serializeArray(), function(data, textStatus, xhr) {
        // console.log(data);

        if(data.resultado){
                  swal({
                        title : 'Declaración Actualizada',
                        text : '',
                        type : 'success',
                        showCancelButton: false,
                        closeOnConfirm: false,
                        showLoaderOnConfirm: true,
                        closeOnConfirm : false,

                    },function(isConfirm){
                        setTimeout(function(){
                            window.location = BASE_URL + 'residuo/declaracion_residuos' ;
                        }, 500)

                    })
                // swal('Solicitud Enviada','','success');

        }
    },'json').fail(fnFailAjax);
}
function fnChangeinst(e){
    var id_ins = this.value;
    $.getJSON(BASE_URL + '/instalacion/get_data/' + id_ins, {}, function(json, textStatus) {
            console.log(json);
            json.nombre_siglas = json.ins_razon_social + ' - ' + json.ins_rz_siglas + '/' + json.ins_nombre;
            json.ins_direccion_format = json.ins_attr_direccion + '. ' + json.ins_direccion;
            $(json).setObjectValues('objIns');

            // var iopc = [];
            // for (var i = 0; i < json.length; i++) {
            //     var t = Handlebars.compile(TEMPLATES.option);
            //     iopc.push(t({
            //         id : json[i].idDepend,
            //         text : json[i].desDepend
            //     }))
            // };
            // selDepartamento.html(iopc.join(''))
    });

   // loadDataResiduos();
    // $.post(BASE_URL + 'instalacion/get_data/' + id_ins, {}, function(data, textStatus, xhr) {
    //     $
    // },'json');
}
function fnSelYearChange(){
    // loadDataResiduos();
}
function fnSelResChange(){
    //cargar la sumade las cantidades, peso y volumen total por año y meses
    $.post(BASE_URL + 'residuo/get_res_declaracion?tipo=2', {
        idYear          : rg.selResiduoYear.val(),
        idInstalacion   : rg.selInstalacion.val(),
        idResiduo       : this.value
    }, function(data, textStatus, xhr) {

        rg.tbodyDetaRes.find('.res-deta-peso').text(rg.nf.format(+data.res_peso)).end().
        find('.res-deta-volumen').text(rg.nf.format(+data.res_volumen)).end().
        find('.res-deta-cantidad').text(rg.ni.format(+data.res_cantidad));

        $('.datos-meses').each(function(e, v){

            if(data.res_peligro == 1 && v.dataset.tipo == 'pel' ){

                switch(+v.dataset.num){
                    case 1: v.textContent = rg.nd3.format(+data.resv_1/1000); break;
                    case 2: v.textContent = rg.nd3.format(+data.resv_2/1000); break;
                    case 3: v.textContent = rg.nd3.format(+data.resv_3/1000); break;
                    case 4: v.textContent = rg.nd3.format(+data.resv_4/1000); break;
                    case 5: v.textContent = rg.nd3.format(+data.resv_5/1000); break;
                    case 6: v.textContent = rg.nd3.format(+data.resv_6/1000); break;
                    case 7: v.textContent = rg.nd3.format(+data.resv_7/1000); break;
                    case 8: v.textContent = rg.nd3.format(+data.resv_8/1000); break;
                    case 9: v.textContent = rg.nd3.format(+data.resv_9/1000); break;
                    case 10: v.textContent = rg.nd3.format(+data.resv_10/1000); break;
                    case 11: v.textContent = rg.nd3.format(+data.resv_11/1000); break;
                    case 12: v.textContent = rg.nd3.format(+data.resv_12/1000); break;
                }



            }else if(data.res_peligro == 0 && v.dataset.tipo == 'otr'){
                switch(+v.dataset.num){
                    case 1: v.textContent = rg.nd3.format(+data.resv_1/1000); break;
                    case 2: v.textContent = rg.nd3.format(+data.resv_2/1000); break;
                    case 3: v.textContent = rg.nd3.format(+data.resv_3/1000); break;
                    case 4: v.textContent = rg.nd3.format(+data.resv_4/1000); break;
                    case 5: v.textContent = rg.nd3.format(+data.resv_5/1000); break;
                    case 6: v.textContent = rg.nd3.format(+data.resv_6/1000); break;
                    case 7: v.textContent = rg.nd3.format(+data.resv_7/1000); break;
                    case 8: v.textContent = rg.nd3.format(+data.resv_8/1000); break;
                    case 9: v.textContent = rg.nd3.format(+data.resv_9/1000); break;
                    case 10: v.textContent = rg.nd3.format(+data.resv_10/1000); break;
                    case 11: v.textContent = rg.nd3.format(+data.resv_11/1000); break;
                    case 12: v.textContent = rg.nd3.format(+data.resv_12/1000); break;
                }

            }else {
                switch(+v.dataset.num){
                        case 1: v.textContent = '-';
                        case 2: v.textContent = '-';
                        case 3: v.textContent = '-';
                        case 4: v.textContent = '-';
                        case 5: v.textContent = '-';
                        case 6: v.textContent = '-';
                        case 7: v.textContent = '-';
                        case 8: v.textContent = '-';
                        case 9: v.textContent = '-';
                        case 10: v.textContent = '-';
                        case 11: v.textContent = '-';
                        case 12: v.textContent = '-';
                }
            }
        });

    },'json').fail(fnFailAjax);
}
function verificar_fuentes(){
    var tblb = tblFuenteResiduo.find('tbody');
    if(tblb.children().length == 1){
        tblb.children().eq(0).find('.btnEliminarAccion').remove();
    }
}
function fneliminarAccion(){
    console.log('eliminar');
    refid = +this.dataset.idObj;
    var self = this;
    console.log(refid);
    if(refid != -1){
        $.post(BASE_URL + 'residuo/fuente_declaracion/eliminar/' + refid, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){
                $(self).parents('tr').remove();
                verificar_fuentes();
            }
        },'json');
    }else{
        $(this).parents('tr').remove();
        verificar_fuentes();
    }

}
//carga los residuos de la instalación y año
function loadDataResiduos(){
    console.log('load data res');
    $.post(BASE_URL + 'residuo/get_res_declaracion?tipo=1', {
        idYear          : rg.selResiduoYear.val(),
        idInstalacion   : rg.selInstalacion.val()
    }, function(data, textStatus, xhr) {
        // console.log(data);
        var t = Handlebars.compile(TEMPLATES.option);
        var html = t({id : '', text : ''});
        data.forEach(function(e,i){
            html += t({id : e.res_id, text : e.res_nombre})
        });
        rg.selResiduo.html(html);
    },'json').fail(fnFailAjax);
}
function test(datavalues, nameobject){
    $('[data-object="'+ nameobject +'"]').each(function(e,v){
                console.log(v);
                switch(v.tagName.toLowerCase()){
                    case 'span':
                        v.textContent = 'adasdasdasd';
                        break;
                }
    })
}
function fnAgregarFuente(e){
    // e.preventDefault();
    console.log('add');
    var tblb = tblFuenteResiduo.find('tbody');
    if(tblb.children().length == 1){
        tblb.children().eq(0).find('.fuenteGenTR').append(tpl_button);
    }
    tblFuenteResiduo.find('tbody').append($(tpl_fuente_dos));

    $('.stepContainer').height($('#step-2').outerHeight());
}