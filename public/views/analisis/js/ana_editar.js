var ep = {};

ep.tpl_trblancos = `
            <tr>
                <td>{{nom_blanco}}</td>
                <td class="nom-sec">{{nom_blanco_sec}}</td>
                <td style="width: 50px; "><a href="" class="btn-accion-blanco" data-accion="editar" data-id-object="{{id}}" data-id-blanco="{{id_blanco}}" data-id-tipo="{{tipo}}" title="Editar"><i class="fa fa-pencil"></i></a>&nbsp;&nbsp;<a href="" class="btn-accion-blanco" data-accion="eliminar" data-id-object="{{id}}" data-id-blanco="{{id_blanco}}" data-id-tipo="{{tipo}}" title="Eliminar"><i class="fa fa-trash"></i></a></td>
            </tr>
`;
ep.tpl_trblancos_null = `
            <tr ">
                <td colspan="2">Agregue Elementos</td>

            </tr>
`;
//txtMedPeligro
//txtMedAmbiental
ep.tpl_medidas = `
    <li data-id-medida="{{id_medida}}" data-nivel-jerar="{{id_jerar}}"><input type="hidden" name="{{tipo_medida}}[]" value="{{id_medida}}"><b><span class="fa fa-times remove-medida"></span></b><p>{{nom_medida}}</p></li>
`;
ep.tpl_sin_medidas = `
    <li data-id-medida="-1" class="sin-medidas"><p>Sin Medidas de Control</p></li>
`;

ep.calculo_propel = {
    dataie : 1,
    dataif : 1,
    dataip : 1,
    dataic : 1,
    datapr : 4,
    datapp : 1,
    datapxs : 1,
    datasev : 1,
}
ep.calculo_proamb = {
    datapr : 1,
    datasev : 1,
    datapxs : 1,
}
ep.ids_medida = {
    peligro : 0,
    riesgo : 0
}
ep.data_edit = {is_editar : false, id_peligro : 0, id_riesgos : [], id_actividad : 0};
ep.data_edit_aspecto = {is_editar : false, id_aspecto : 0, id_impactos : [], id_actividad : 0};
ep.data_new = {riesgo : [], impacto : []};
$(document).ready(function() {
    moment.locale('es');

    $('.txt-fechas').daterangepicker({
      singleDatePicker: true,
      calender_style: "picker_2",
      autoUpdateInput : true,
      locale: {
          format: 'DD/MM/YY'
      }
    }, function(start, end, label) {
      console.log(start.toISOString(), end.toISOString(), label);
    }).each(function(e,v){
        if(!$(v).hasClass('active'))
            $(v).val('');
    });;
    ep.txtNomInvos = $('.txt-nom').on('keyup',function(e){
        if(this.value.trim() != ''){
            switch(this.id){
                case 'txtNomElabora':
                    if($('#txtFechaElaboracion').prop('disabled'))
                        $('#txtFechaElaboracion').prop('disabled', false);
                    break;
                case 'txtNomRevisa':
                    if($('#txtFechaRevisado').prop('disabled'))
                        $('#txtFechaRevisado').prop('disabled', false);
                    break;
                case 'txtNomAprueba':
                    if($('#txtFechaAprobacion').prop('disabled'))
                        $('#txtFechaAprobacion').prop('disabled', false);
                    break;
            }
        }else{

            switch(this.id){
                case 'txtNomElabora':
                    if(!$('#txtFechaElaboracion').prop('disabled'))
                        $('#txtFechaElaboracion').prop('disabled', true);
                    break;
                case 'txtNomRevisa':
                    if(!$('#txtFechaRevisado').prop('disabled'))
                        $('#txtFechaRevisado').prop('disabled', true);
                    break;
                case 'txtNomAprueba':
                    if(!$('#txtFechaAprobacion').prop('disabled'))
                        $('#txtFechaAprobacion').prop('disabled', true);
                    break;

            }
        }
    });
    ep.selEtapas = $('#selEtapas').on('change', fnChangeEtapas);
    ep.selActividad = $('#selActividad').on('change', fnChangeActividad);
    ep.btnAgregar = $('.btn-agregar').on('click', fnAgregarBlanco);//abre modales
    ep.btnAccionBlanco = $('.tbl-lista-blanco').on('click', '.btn-accion-blanco', fnAccionesBlanco);

    ep.selProceso = $('#selProceso');

    ep.selRiesgo = $('#selRiesgo').on('change', fnChangeRiesgo).on('select2:selecting',function(e,v){
        if(+e.params.args.data.id == -1){
            console.log(ep.selRiesgo.val());
            ep.data_new.riesgo = ep.selRiesgo.val();
            ep.selRiesgo.val('-1');
        }else{
            if(!is.null(ep.selRiesgo.val())){
                if(ep.selRiesgo.val().length == 1 && +ep.selRiesgo.val()[0] == -1){
                    ep.selRiesgo.val('');
                }
            }
        }
        console.log('asdasd');
    });
    ep.selPeligro = $('#selPeligro').on('change', fnChangePeligro);

    ep.selAspectoAmbiental = $('#selAspectoAmbiental').on('change', fnChangeAspecto);
    ep.selImpacto = $('#selImpacto').on('change', fnChangeImpacto).on('select2:selecting',function(e,v){
        if(+e.params.args.data.id == -1){
            ep.data_new.impacto = ep.selImpacto.val();
            ep.selImpacto.val('-1');
        }else{
            if(!is.null(ep.selImpacto.val())){
                if(ep.selImpacto.val().length == 1 && +ep.selImpacto.val()[0] == -1){
                    ep.selImpacto.val('');
                }
            }
        }
        console.log('asdasd');
    });

    ep.frmAnalisidProceso = $('#frmAnalisidProceso').on('submit', fnFrmGuardarAnalisi);
    ep.frmRegistroPeligro = $('#frmRegistroPeligro').on('submit', fnFrmGuardarPeligro);
    ep.frmRegistroAmbiental = $('#frmRegistroAmbiental').on('submit', fnFrmGuardarAmbiente);

    ep.btnAddMControl = $('.btnAddMControl').on('click', fnAgregarMedidaControl)
    ep.btnAddMCRiesgo = $('#btnAddMCRiesgo');
    ep.btnAddMCImpacto = $('#btnAddMCImpacto');

    ep.btnGuardarPeligro = $('#btnGuardarPeligro');
    ep.btnGuardarAmbiental = $('#btnGuardarAmbiental');

    ep.txtSumaPrPel = $('#txtSumaPrPel');
    ep.txtProbPel = $('#txtProbPel');
    ep.txtPuntajePrxSePel = $('#txtPuntajePrxSePel');
    ep.txtNivelRiesgoPel = $('#txtNivelRiesgoPel');
    ep.txtRiesgoSigPel = $('#txtRiesgoSigPel');

    ep.txtPuntajePrxSeImp = $('#txtPuntajePrxSeImp');
    ep.txtNivelRiesgoImp = $('#txtNivelRiesgoImp');
    ep.txtImpAmbSig = $('#txtImpAmbSig');

    ep.txtIdActividad = $('.txtIdActividad');
    ep.txtIdBlanco = $('.txtIdBlanco');
    calcularPrPel();

    ep.modalBlancos = $('.modal-blancos')
        .on('hide.bs.modal', fnHideModalBlanco)
        .on('show.bs.modal', fnShowModalBlanco);
    ep.modAddPeligro = $('#modAddPeligro');
    ep.modAddAspecto = $('#modAddAspecto');
    ep.tituloModalPel = $('#tituloModalPel');
    ep.tituloModalAmb = $('#tituloModalAmb');

    ep.radIEP = $('.radIEP').on('ifChecked', fnChangeCalRadPel);
    ep.radIFP = $('.radIFP').on('ifChecked', fnChangeCalRadPel);
    ep.radIPP = $('.radIPP').on('ifChecked', fnChangeCalRadPel);
    ep.radICP = $('.radICP').on('ifChecked', fnChangeCalRadPel);
    ep.radCalProb = $('.radCalProb');
    ep.radSevP = $('.radSevP').on('ifChecked', fnChangeRadSevPel).iCheck('disable');

    ep.radIPR = $('.radIPR').on('ifChecked', fnChangeCalRadAmb);
    ep.radISEV = $('.radISEV').on('ifChecked', fnChangeCalRadAmb);
    ep.radCalProbAm = $('.radCalProbAm');

    ep.lstMedidasRiesgo = $('#lstMedidasRiesgo').on('click', '.remove-medida', fnRemoveMedidaR);
    ep.lstMedidasAmbiental = $('#lstMedidasAmbiental').on('click', '.remove-medida', fnRemoveMedidaA);




    ep.selJerarquiaRiesgo = $('#selJerarquiaRiesgo').on('change', fnChangeJerarquia);
    ep.selJerarquiaImpacto = $('#selJerarquiaImpacto').on('change', fnChangeJerarquia);
    ep.selMedidaRiesgo = $('#selMedidaRiesgo').on('change', fnChangeMedidRiesgo);
    ep.selMedidaAmbiental = $('#selMedidaAmbiental').on('change', fnChangeMedidAmbiental);

    // ep.btnGuardarBlanco = $('.btnGuardarBlanco').on('click', fnGuardarBlanco);



    ep.lstPeligrosActi = $('#lstPeligrosActi');
    ep.lstAspectosActi = $('#lstAspectosActi');

    ep.datosNewEtapa = $('.datos-newetapa').on('keypress',function(e){


        console.log('asdasd');
        var eta_nombre = ep.frmNewEtapa.find('#txtNombreEtapaNew').eq(0);
        var eta_orden = ep.frmNewEtapa.find('#txtOrdenEtapaNew').eq(0);
        if(+e.charCode == 13){
            e.preventDefault();
            $.post(BASE_URL + 'proceso_etapa/insertar', {
                txtNombre: eta_nombre.val(),
                txtOrden: eta_orden.val(),
                txtIdProceso: ep.selProceso.val(),
                txtEstado: 'true',
            }, function(data, textStatus, xhr) {
                console.log(data);
                if(data.resultado){
                    console.log('es true');
                    var objEta = data.objRes;
                    $.post(BASE_URL + 'proceso_etapa/listar_by_procesos', {refid: +ep.selProceso.val()}, function(json, textStatus, xhr) {
                        console.log(json);
                        ep.selEtapas.setDataSelect({values : json,
                            id : 'pet_id', text : 'pet_nombre'}, 'Nuevo');

                        ep.selEtapas.val(objEta.pet_id).trigger('change');
                    },'json').fail(fnFailAjax);
                }
            },'json').fail(fnFailAjax);

        }

    });
    ep.frmNewEtapa = $('#frm-newetapa');
    ep.frmNewActividad = $('#frm-newactividad');
    ep.frmNewActi = $('#frmNewActi');
    ep.btnGuardarNewAct = $('#btnGuardarNewAct').on('click', fnGuardarNuevaActividad);

    ep.frmNewPel = $('#frmNewPel');
    ep.frmNewCatPel = $('#frmNewCatPel');
    ep.btnGuardarNewPel = $('.btn-guardar-pel').on('click', fnGuardarNewPeligro);
    ep.txtNewPel = $('.txt-newpel').on('keypress', fnTxtNewPeligro);
    ep.selCategoriaPeligroNew = $('#selCategoriaPeligroNew').on('change', fnChangeCatePel);

    ep.frmNewRiesgo = $('#frmNewRiesgo');

    ep.txtNomNewRiesgo = $('#txtNomNewRiesgo').on('keypress', _fnGuardarRiesgo);
    ep.btnGuardarNewRies = $('#btnGuardarNewRies').on('click', _fnGuardarRiesgo);

    ep.frmNewAaspecto = $('#frmNewAaspecto');
    ep.frmNewImpacto = $('#frmNewImpacto');
    ep.frmNewCatAsp = $('#frmNewCatAsp');

    ep.selCategoriaAspectoNew = $('#selCategoriaAspectoNew').on('change', function(e){

        if(+this.value == -1){
            ep.frmNewAaspecto[0].elements.txtNomNewCateAsp.value = '';
            if(ep.frmNewCatAsp.hasClass('hidden'))
                ep.frmNewCatAsp.removeClass('hidden');
        }else{
            if(!ep.frmNewCatAsp.hasClass('hidden'))
                ep.frmNewCatAsp.addClass('hidden');
        }
    });
    ep.refNewAmbiental = $('.ref-new-ambiental').on('keypress',_fnGuardarImpacto).on('click', _fnGuardarImpacto);
    ep.tpl_trblancos = Handlebars.compile(ep.tpl_trblancos);
    ep.tpl_medidas = Handlebars.compile(ep.tpl_medidas);

});
function _fnGuardarImpacto(e){
    function _resetText(){
        ep.frmNewAaspecto[0].elements.txtNomNewImpacto.value = '';
    }
    function __savecategoria(){
        var ele = ep.frmNewAaspecto.serializeArray();
        ele = ele.filter(function(v, i){
            if(v.name == "txtNomNewCateAsp"){
                v.name = 'txtNombre';
                return true;
            }
            return false;
        })

        ele = ele.concat([
                {name : 'txtTipoPeligro', value : 2},
                {name : 'txtEstado', value : 'true'}
            ]);
        $.post(BASE_URL + 'peligro_categoria/insertar', ele, function(data, textStatus, xhr) {
            if(data.resultado){
                var t = Handlebars.compile(TEMPLATES.option);
                ep.selCategoriaAspectoNew.append(t({id : data.objRes.cat_id, text : data.objRes.cat_nombre})).val(data.objRes.cat_id).trigger('change');

            }
        },'json').fail(fnFailAjax);
        ep.frmNewAaspecto[0].elements.txtNomNewCateAsp.value = '';
    }
    function __saveaspecto(){
        var ele = ep.frmNewAaspecto.serializeArray();
        ele = ele.filter(function(v, i){
            if(v.name == "selCategoriaAspectoNew"){
                v.name = 'txtIdCategoria';
                return true;
            }
            if(v.name == "txtNomNewAsp"){
                v.name = 'txtNombre';
                return true;
            }
            return false;
        })

        ele = ele.concat([
                {name : 'txtEstado', value : 'true'}
            ]);
        $.post(BASE_URL + 'aspecto_ambiental/insertar', frmele, function(data, textStatus, xhr) {
            if(data.resultado){
                var objR = data.objRes;


                $.getJSON(BASE_URL + 'proceso_actividad/ambiental_actividad/' + ep.selActividad.val() + (ep.data_edit_aspecto.is_editar ? '/' +ep.data_edit.id_aspecto :''), function(json, textStatus) {
                    if(json.length > 0){
                        ep.selAspectoAmbiental.setDataSelectGroup({
                            values : json, id : 'asp_id', text : 'asp_nombre'
                        },{value : -1, text : 'Nuevo'});
                        ep.selAspectoAmbiental.val(objR.asp_id).trigger('change');
                    }else{
                        ep.selAspectoAmbiental.html('').val('').trigger('change');
                    }

                });

                if(!ep.frmNewAaspecto.hasClass('hidden'))
                    ep.frmNewAaspecto.addClass('hidden');

            }
        },'json');
        ep.frmNewAaspecto[0].elements.txtNomNewAsp.value = '';
    }
    function __saveimpacto(){
        var ele = ep.frmNewImpacto.serializeArray();
        ele = ele.filter(function(v, i){
            if(v.name == "txtNomNewImpacto"){
                v.name = 'txtNombre';
                return true;
            }
            return false;
        })

        ele = ele.concat([
                {name : 'txtIdAspecto', value : ep.selAspectoAmbiental.val()},
                {name : 'txtEstado', value : 'true'}
            ]);
        $.post(BASE_URL + 'impacto_ambiental/insertar', ele, function(data, textStatus, xhr) {
            if(data.resultado){
                var t = Handlebars.compile(TEMPLATES.option);
                ep.data_new.impacto.push(''+data.objRes.imp_id);
                ep.selImpacto.append(t({id : data.objRes.imp_id, text : data.objRes.imp_nombre})).val(ep.data_new.impacto).trigger('change');
            }
        },'json').fail(fnFailAjax);
        ep.frmNewImpacto[0].elements.txtNomNewImpacto.value = '';
    }
    switch(this.dataset.proceso){
        case 'categoria':

            if((e.type == 'click' && this.type == 'button') || (e.type == 'keypress' && +e.charCode == 13) ) {
                if(e.type == 'keypress') e.preventDefault();
                __savecategoria();
            }
            break;
        case 'ambiental':

            if((e.type == 'click' && this.type == 'button') || (e.type == 'keypress' && +e.charCode == 13) ) {
                if(e.type == 'keypress') e.preventDefault();
                __saveaspecto();
            }
            break;
        case 'impacto':
            if((e.type == 'click' && this.type == 'button') || (e.type == 'keypress' && +e.charCode == 13) ) {
                if(e.type == 'keypress') e.preventDefault();
                __saveimpacto();
            }
            break;
    }
}
function _fnGuardarRiesgo(e){
    console.log(e);
    function __guardar(){
        var ele = ep.frmNewRiesgo.serializeArray();
        ele[0].name = 'txtNombre';
        ele = ele.concat([
                {name : 'txtIdPeligro', value : ep.selPeligro.val()},
                {name : 'txtEstado', value : 'true'}
            ]);
        $.post(BASE_URL + 'riesgo/insertar', ele, function(data, textStatus, xhr) {
            if(data.resultado){
                var t = Handlebars.compile(TEMPLATES.option);
                ep.data_new.riesgo.push(''+data.objRes.rie_id);


                ep.selRiesgo.append(t({id : data.objRes.rie_id, text : data.objRes.rie_nombre })).val(ep.data_new.riesgo).trigger('change');
                ep.txtNomNewRiesgo.val('');

            }
        },'json').fail(fnFailAjax);
    }
    switch(e.type){
        case 'keypress':
            if(+e.charCode == 13){
                e.preventDefault();
                __guardar();
            }
            break;
        case 'click':
            __guardar();
            break;
    }

}
function fnChangeCatePel(){
    if(+this.value == -1){
        ep.txtNewPel.val('');
        if(ep.frmNewCatPel.hasClass('hidden'))
            ep.frmNewCatPel.removeClass('hidden');
    }else{
        if(!ep.frmNewCatPel.hasClass('hidden'))
            ep.frmNewCatPel.addClass('hidden');
    }
}
function _fnGuardarNewPeligro(opc){
    var frmele = ep.frmNewPel.serializeArray();

    switch(opc){
        case 1:
            frmele.filter(function(v, i){
                if(v.name == 'txtNomNewCatePel'){
                    v.name = 'txtNombre';
                    return true;
                }
                return false;
            });
            frmele.push({name : 'txtTipoPeligro', value : '1'});
            frmele.push({name : 'txtEstado', value : 'true'});
            $.post(BASE_URL + 'peligro_categoria/insertar', frmele, function(data, textStatus, xhr) {
                if(data.resultado){
                    var g = document.createElement('option');
                    g.value = data.objRes.cat_id;
                    g.text = data.objRes.cat_nombre;
                    ep.selCategoriaPeligroNew.append(g);
                    if(!ep.frmNewCatPel.hasClass('hidden'))
                        ep.frmNewCatPel.addClass('hidden');
                    ep.selCategoriaPeligroNew.val(data.objRes.cat_id).trigger('change');
                }
            },'json');
            break;
        case 2:
            frmele.filter(function(v, i){
                if(v.name == 'selCategoriaPeligroNew'){
                    v.name = 'txtIdCategoria';
                    return true;
                }
                if(v.name == 'txtNomNewPel'){
                    v.name = 'txtNombre';
                    return true;
                }
                return false;
            });
            frmele.push({name : 'txtEstado', value : 'true'});
            $.post(BASE_URL + 'peligro/insertar', frmele, function(data, textStatus, xhr) {
                if(data.resultado){
                    var objR = data.objRes;


                    $.getJSON(BASE_URL + 'proceso_actividad/peligros_actividad/' + ep.selActividad.val() + (ep.data_edit.is_editar ? '/' +ep.data_edit.id_peligro :''), function(json, textStatus) {
                        if(json.length > 0){
                            ep.selPeligro.setDataSelectGroup({
                                values : json, id : 'pel_id', text : 'pel_nombre'
                            },{value : -1, text : 'Nuevo'});
                            ep.selPeligro.val(objR.pel_id).trigger('change');
                        }else{
                            ep.selPeligro.html('').val('').trigger('change');
                        }

                    });

                    if(!ep.frmNewPel.hasClass('hidden'))
                        ep.frmNewPel.addClass('hidden');

                }
            },'json');
            ep.frmNewPel[0].elements.txtNomNewPel.value = '';
            break;
    }
}
function fnTxtNewPeligro(e){

    if(+e.charCode == 13){
        e.preventDefault();

        if($(this).hasClass('pelcate')){
            _fnGuardarNewPeligro(1);
        }
        if($(this).hasClass('peligro')){
            _fnGuardarNewPeligro(2);
        }
    }

}

function fnGuardarNewPeligro(e){
    console.log(e);
    if($(this).hasClass('pelcate')){
        //agregar nueva categoria de peligro
        _fnGuardarNewPeligro(1);
    }
    if($(this).hasClass('peligro')){
        //agregar nuevo peligro
        _fnGuardarNewPeligro(2);
    }
}
function fnGuardarNuevaActividad(){
    console.log(ep.frmAnalisidProceso.serializeArray());
    var valPost = ep.frmAnalisidProceso.serializeArray().filter(function(v, i){
        switch(v.name){
            case 'txtNomActiNew':
            case 'txtOrdenActiNew':
            case 'txtPuestoActiNew':
            case 'radSituacionActividad':
            case 'radUbicacionActividad':
            case 'radTipoPersonalActividad':
            case 'selEtapas':
                return true;break;
        }
    });
    valPost.push({name : 'insert_tipo', value : 2});
    $.post(BASE_URL + 'proceso_actividad/insertar', valPost, function(data, textStatus, xhr) {
        console.log(data);
        var objAc = data.objRes;
        if(data.resultado){
            _cargarActividad(ep.selEtapas.val(),objAc.pac_id);
        }
    },'json').fail(fnFailAjax);

}
function fnRemoveMedidaR(e){
    $(this).parents('li').remove();
    if(ep.lstMedidasRiesgo.find('li').length == 0){
        ep.lstMedidasRiesgo.html(ep.tpl_sin_medidas);
    }

}
function fnRemoveMedidaA(e){
    $(this).parents('li').remove();
    if(ep.lstMedidasAmbiental.find('li').length == 0){
        ep.lstMedidasAmbiental.html(ep.tpl_sin_medidas);
    }

}
function fnFrmGuardarPeligro(e){
    console.log('in-submit-frm-pel');
    e.preventDefault();
    switch(this.dataset.accion){
        case 'registrar':
            var swo = get_swaloption();
            swo.title = 'Guardar Peligro en Actividad';
            swo.text = '¿Desea guardar estos datos?';
            swo.type = 'warning';
            swo.closeOnCancel = true;
            swo.showLoaderOnConfirm = true;

            swal(swo,
                function(){
                    var datasfrm = ep.frmRegistroPeligro.serializeArray();
                    datasfrm.forEach(function(v, i){
                        if(v.name == 'selRiesgo')
                            v.value = ep.selRiesgo.val();
                    })

                    $.post(BASE_URL + 'analisis_proceso/guardar_blanco/1', datasfrm, function(data, textStatus, xhr) {
                        console.log(data);
                        ep.modAddPeligro.modal('hide');
                        ep.selActividad.trigger('change');
                        swal("Datos Guardados!",'', "success");
                    },'json').fail(fnFailAjax);
                });
            break;
        case 'actualizar':

            var swo = get_swaloption();
            swo.title = 'Actualizar Peligro en Actividad';
            swo.text = '¿Desea actualizar estos datos?';
            swo.type = 'warning';
            swo.closeOnCancel = true;
            swo.showLoaderOnConfirm = true;

            swal(swo,
                function(){
                    var datasfrm = ep.frmRegistroPeligro.serializeArray();
                    datasfrm.forEach(function(v, i){
                        if(v.name == 'selRiesgo')
                            v.value = ep.selRiesgo.val();
                    })
                    $.post(BASE_URL + 'analisis_proceso/actualizar_blanco/1', datasfrm, function(data, textStatus, xhr) {
                        console.log(data);
                        ep.modAddPeligro.modal('hide');
                        ep.selActividad.trigger('change');
                        swal("Datos Actualizados!",'', "success");
                    },'json').fail(fnFailAjax);
                });
            // $.post(BASE_URL + 'analisis_proceso/actualizar_blanco/1', ep.frmRegistroPeligro.serializeArray(), function(data, textStatus, xhr) {
            //     console.log(data);

            // },'json').fail(fnFailAjax);
            break;

    }
}
function fnFrmGuardarAmbiente(e){

    e.preventDefault();
    switch(this.dataset.accion){
        case 'registrar':
            var swo = get_swaloption();
            swo.title = 'Guardar Aspecto Ambiental en Actividad';
            swo.text = '¿Desea guardar estos datos?';
            swo.type = 'warning';
            swo.closeOnCancel = true;
            swo.showLoaderOnConfirm = true;

            swal(swo,
                function(){

                    var datasfrm = ep.frmRegistroAmbiental.serializeArray();
                    datasfrm.forEach(function(v, i){
                        if(v.name == 'selImpacto')
                            v.value = ep.selImpacto.val();
                    });

                    $.post(BASE_URL + 'analisis_proceso/guardar_blanco/2', datasfrm, function(data, textStatus, xhr) {
                        console.log(data);
                        ep.modAddAspecto.modal('hide');
                        ep.selActividad.trigger('change');
                        swal("Datos Guardados!",'', "success");
                    },'json').fail(fnFailAjax);
                });
            break;
        case 'actualizar':

            var swo = get_swaloption();
            swo.title = 'Actualizar Aspecto Ambiental en Actividad';
            swo.text = '¿Desea actualizar estos datos?';
            swo.type = 'warning';
            swo.closeOnCancel = true;
            swo.showLoaderOnConfirm = true;

            swal(swo,
                function(){

                    var datasfrm = ep.frmRegistroAmbiental.serializeArray();
                    datasfrm.forEach(function(v, i){
                        if(v.name == 'selImpacto')
                            v.value = ep.selImpacto.val();
                    });
                    $.post(BASE_URL + 'analisis_proceso/actualizar_blanco/2', datasfrm, function(data, textStatus, xhr) {
                        console.log(data);
                        ep.modAddAspecto.modal('hide');
                        ep.selActividad.trigger('change');
                        swal("Datos Actualizados!",'', "success");
                    },'json').fail(fnFailAjax);
                });
            // $.post(BASE_URL + 'analisis_proceso/actualizar_blanco/1', ep.frmRegistroPeligro.serializeArray(), function(data, textStatus, xhr) {
            //     console.log(data);

            // },'json').fail(fnFailAjax);
            break;

    }

    // e.preventDefault();
    // $.post(BASE_URL + 'analisis_proceso/guardar_blanco/1', ep.frmRegistroPeligro.serializeArray(), function(data, textStatus, xhr) {
    //     console.log(data);
    // },'json').fail(fnFailAjax);
}

function fnFrmGuardarAnalisi(e){
    e.preventDefault();
    var ele = ep.frmAnalisidProceso.serializeArray();

    var swo = get_swaloption();
    swo.title = 'Guardar Análisis de Proceso';
    swo.text = '¿Desea guardar estos datos?';
    swo.type = 'warning';
    swo.closeOnCancel = true;
    swo.showLoaderOnConfirm = true;

    swal(swo,
        function(){
            switch(+getById('txtModjs').value){
                case 2:
                    ele = ele.filter(function(v, i){
                        switch(v.name){
                            case 'txtSede':
                            case 'txtIDProceso':
                            case 'txtNomElabora':
                            case 'txtFechaElaboracion':
                            case 'txtNomRevisa':
                            case 'txtFechaRevisado':
                            case 'txtNomAprueba':
                            case 'txtFechaAprobacion':
                            case 'txtModProceso':
                                return true;
                                break;
                        }
                        return false;
                    })
                    $.post(BASE_URL + 'analisis_proceso/guardar', ele, function(data, textStatus, xhr) {
                        if(data.respuesta){
                            swal("Datos Guardados!",'', "success");
                        }

                    },'json').fail(fnFailAjax);
                    break;
                case 1:
                    break;
            }
        });
}

function fnGuardarBlanco(e){
    e.preventDefault();
    switch(this.dataset.tipoBlanco){
        case 'peligro':
            break;
        case 'ambiental':

            $.post(BASE_URL + 'analisis_proceso/guardar_blanco/2', {param1: 'value1'}, function(data, textStatus, xhr) {

            },'json');
            break;
    }
}
function fnHideModalBlanco(e){
    switch(this.dataset.modTipo){
        case 'peligro':
            fnHideAddPeligro(this);
            break;
        case 'ambiental':
            fnHideAddAspecto(this);
            break;
    }
    ep.txtIdBlanco.val('');
    ep.frmRegistroPeligro[0].dataset.accion = 'registrar';
    ep.frmRegistroAmbiental[0].dataset.accion = 'registrar';
}
function fnShowModalBlanco(e){
    console.log('open modal');
    switch(this.dataset.modTipo){
        case 'peligro':


            // if(this.dataset.modoModal == 'registrar'){
            //     ep.lstMedidasRiesgo.html(ep.tpl_sin_medidas);
            //     $.getJSON(BASE_URL + 'proceso_actividad/peligros_actividad/' + ep.selActividad.val(), function(json, textStatus) {
            //         if(json.length > 0){
            //             ep.selPeligro.setDataSelectGroup({
            //                 values : json, id : 'pel_id', text : 'pel_nombre'
            //             });
            //             ep.selPeligro.val('').trigger('change');
            //         }else{
            //             ep.selPeligro.html('').val('').trigger('change');
            //         }
            //     }).fail(fnFailAjax);
            // }

            // if(this.dataset.modoModal == 'actualizar'){
            //     //cargar la lista de medidas
            //     console.log('mod actualizar');
            //     $.getJSON(BASE_URL + 'proceso_actividad/peligros_actividad/' + ep.selActividad.val() + '/' + ep.data_edit.id_peligro, function(json, textStatus) {
            //         if(json.length > 0){
            //             ep.selPeligro.setDataSelectGroup({
            //                 values : json, id : 'pel_id', text : 'pel_nombre'
            //             });
            //             ep.selPeligro.val(ep.data_edit.id_peligro).trigger('change');

            //             //cargar los datos de la actividad
            //             $.getJSON(BASE_URL + 'analisis_proceso/getdatablanco/1/' + ep.data_edit.id_actividad, function(json, textStatus) {
            //                 console.log(json);
            //                 ep.selRiesgo.val(json.rie_id_riesgo.split(',')).trigger('change');

            //                 ep.lstMedidasRiesgo.find('.sin-medidas').remove();
            //                 json.medidas_control.forEach(function(v, i){

            //                     ep.lstMedidasRiesgo.append(ep.tpl_medidas({
            //                         id_medida : v.mco_id,
            //                         id_jerar : v.jmc_nivel,
            //                         tipo_medida : 'txtMedPeligro',
            //                         nom_medida : v.mco_nombre
            //                     }));
            //                 });

            //                 ep.radIEP.each(function(i, v){
            //                     console.log(v.value);
            //                     if(v.value ==  +json.acb_vfp_ie){
            //                         console.log('sí')
            //                         $(v).iCheck('check');

            //                     }else console.log('no')
            //                 })
            //                 ep.radIFP.each(function(i, v){
            //                     if(v.value ==  +json.acb_vfp_if)
            //                         $(v).iCheck('check');
            //                 })
            //                 ep.radIPP.each(function(i, v){
            //                     if(v.value ==  +json.acb_vfp_ip)
            //                         $(v).iCheck('check');
            //                 })
            //                 ep.radICP.each(function(i, v){
            //                     if(v.value ==  +json.acb_vfp_ic)
            //                         $(v).iCheck('check');
            //                 })

            //                 ep.radSevP.each(function(i, v){
            //                     if(v.value ==  +json.acb_sev)
            //                         $(v).iCheck('check');
            //                 })




            //             }).fail(fnFailAjax);

            //         }else{
            //             ep.selPeligro.html('').val('').trigger('change');
            //         }
            //     }).fail(fnFailAjax);
            // }
            break;
        case 'ambiental':

            // if(this.dataset.modoModal == 'registrar'){
            //     ep.lstMedidasAmbiental.html(ep.tpl_sin_medidas);
            //     $.getJSON(BASE_URL + 'proceso_actividad/ambiental_actividad/' + ep.selActividad.val(), function(json, textStatus) {
            //         if(json.length > 0){
            //             ep.selAspectoAmbiental.setDataSelectGroup({
            //                 values : json, id : 'asp_id', text : 'asp_nombre'
            //             });
            //             ep.selAspectoAmbiental.val('').trigger('change');
            //         }else{
            //             ep.selAspectoAmbiental.html('').val('').trigger('change');
            //         }
            //     }).fail(fnFailAjax);
            // }
            break;
    }
}
function existe_medida_peligro(idmedida){
    var targetif = idmedida;
    var lilmed = ep.lstMedidasRiesgo.find('li').toArray();
    var continueData = false;
    lilmed.forEach(function(v, i){
        if(targetif == v.dataset.idMedida)
            continueData = true;
    });
    return continueData;
}
function existe_medida_ambiental(idmedida){
    var targetif = idmedida;
    var lilmed = ep.lstMedidasAmbiental.find('li').toArray();
    var continueData = false;
    lilmed.forEach(function(v, i){
        if(targetif == v.dataset.idMedida)
            continueData = true;
    });
    return continueData;
}
function fnAgregarMedidaControl(e){
    switch(this.dataset.mcoTipo){
        case 'riesgo':
            // $.post(BASE_URL + 'medida_control/agregar_medida', {param1: 'value1'}, function(data, textStatus, xhr) {
            //     /*optional stuff to do after success */
            // });
            var targetif = ep.selMedidaRiesgo.val();
            if(!existe_medida_peligro(targetif)){
                $.getJSON(BASE_URL + 'medida_control/simpledata/' + targetif, function(json, textStatus) {
                    if(!is.null(json)){
                        ep.lstMedidasRiesgo.find('.sin-medidas').remove();
                        //ordenar lista en base a jerarquía
                        ep.lstMedidasRiesgo.append(ep.tpl_medidas({
                            id_medida : json.mco_id,
                            id_jerar : json.jmc_nivel,
                            tipo_medida : 'txtMedPeligro',
                            nom_medida : json.mco_nombre
                        }));
                        var lstLI = ep.lstMedidasRiesgo.find('li').toArray();
                        var idjerar = [1,2,3,4,5];
                        var lstlif = [];
                        idjerar.forEach(function(v, i){
                            var tmp = lstLI.filter(function(vv, ii){
                                return +vv.dataset.nivelJerar == v;
                            });
                            if(tmp.length > 0) lstlif = lstlif.concat(tmp);
                        });
                        ep.lstMedidasRiesgo.html(lstlif);
                    }
                });
                ep.selMedidaRiesgo.val('').trigger('change');
            }
            break;
        case 'impacto':

            var targetif = ep.selMedidaAmbiental.val();
            if(!existe_medida_ambiental(targetif)){
                $.getJSON(BASE_URL + 'medida_control/simpledata/' + targetif, function(json, textStatus) {
                    if(!is.null(json)){
                        ep.lstMedidasAmbiental.find('.sin-medidas').remove();
                        //ordenar lista en base a jerarquía
                        ep.lstMedidasAmbiental.append(ep.tpl_medidas({
                            id_medida : json.mco_id,
                            id_jerar : json.jmc_nivel,
                            tipo_medida : 'txtMedAmbiental',
                            nom_medida : json.mco_nombre
                        }));
                        var lstLI = ep.lstMedidasAmbiental.find('li').toArray();
                        var idjerar = [1,2,3,4,5];
                        var lstlif = [];
                        idjerar.forEach(function(v, i){
                            var tmp = lstLI.filter(function(vv, ii){
                                return +vv.dataset.nivelJerar == v;
                            });
                            if(tmp.length > 0) lstlif = lstlif.concat(tmp);
                        });
                        ep.lstMedidasAmbiental.html(lstlif);
                    }
                });
                ep.selMedidaAmbiental.val('').trigger('change');
            }
            break;
    }
}
function fnChangeMedidRiesgo(e){
    console.log('change medida');
    console.log(this.value);
    if(existe_medida_peligro(this.value)) ep.btnAddMCRiesgo.prop('disabled', true);
    else ep.btnAddMCRiesgo.prop('disabled', false);
}
function fnChangeMedidAmbiental(e){
    console.log('change medida ambiental');
    console.log(this.value);
    if(existe_medida_ambiental(this.value)) ep.btnAddMCImpacto.prop('disabled', true);
    else ep.btnAddMCImpacto.prop('disabled', false);
}
function fnChangeJerarquia(e){

    switch(this.dataset.jerarTipo){
        case 'riesgo':
            console.log('jerar riesgo');
            $.getJSON(BASE_URL + 'medida_control/listar_by_jerarquia/' + this.value + '/1', function(json, textStatus) {
                console.log(json);
                if(json.length > 0){
                    ep.selMedidaRiesgo.setDataSelect({
                        values : json,
                        id : 'mco_id',
                        text : 'mco_nombre',
                    });
                    ep.btnAddMCRiesgo.prop('disabled', false)
                    ep.selMedidaRiesgo.val(json[0].mco_id).trigger('change').prop('disabled', false);
                }else{
                    ep.selMedidaRiesgo.html('').val('').trigger('change').prop('disabled', true);
                }

            });
            break;
        case 'impacto':
            console.log('jerar impacto');
            $.getJSON(BASE_URL + 'medida_control/listar_by_jerarquia/' + this.value + '/2', function(json, textStatus) {

                console.log(json);
                if(json.length > 0){
                    ep.selMedidaAmbiental.setDataSelect({
                        values : json,
                        id : 'mco_id',
                        text : 'mco_nombre',
                    });
                    ep.btnAddMCImpacto.prop('disabled', false)
                    ep.selMedidaAmbiental.val(json[0].mco_id).trigger('change').prop('disabled', false);
                }else{
                    ep.selMedidaAmbiental.html('').val('').trigger('change').prop('disabled', true);
                }
            });
            break;
    }
}
function fnChangeRadSevPel(){
    console.log('change-serv-pel');
    ep.calculo_propel.datasev = +this.value;
    ep.calculo_propel.datapxs= ep.calculo_propel.datasev *ep.calculo_propel.datapp;
    ep.txtPuntajePrxSePel.text(ep.calculo_propel.datapxs);
    //calcular nivel de riesgo;
    calcularNivelRiesgoPel();

}

function calcularNivelRiesgoPel(){

    var t = '';
    if(ep.calculo_propel.datapxs > 15 )
        t = 'Inaceptable';
    else if(ep.calculo_propel.datapxs > 7)
        t = 'Importante';
    else if(ep.calculo_propel.datapxs > 2)
        t = 'Moderado';
    else if(ep.calculo_propel.datapxs > 1)
        t = 'Aceptable';
    else if(ep.calculo_propel.datapxs > 0)
        t = 'Tolerable';
    ep.txtNivelRiesgoPel.text(t);
    ep.txtRiesgoSigPel.text(ep.calculo_propel.datapxs >= 10 ? 'SI' : 'NO');
}
function calcularNivelImpactoAmb(){

    var t = '';
    if(ep.calculo_proamb.datapxs > 15 )
        t = 'Inaceptable';
    else if(ep.calculo_proamb.datapxs > 7)
        t = 'Importante';
    else if(ep.calculo_proamb.datapxs > 2)
        t = 'Moderado';
    else if(ep.calculo_proamb.datapxs > 1)
        t = 'Aceptable';
    else if(ep.calculo_proamb.datapxs > 0)
        t = 'Tolerable';
    ep.txtNivelRiesgoImp.text(t);
    ep.txtImpAmbSig.text(ep.calculo_proamb.datapxs >= 10 ? 'SI' : 'NO');
}
function calculoProbPel(){
    var sumpr = ep.calculo_propel.datapr;
    if(sumpr <= 7){
        ep.calculo_propel.datapp = 1;
        return 1;
    }
    if(sumpr > 7 && sumpr <= 10){
        ep.calculo_propel.datapp = 2;
        return 2;
    }
    if(sumpr > 10 && sumpr <= 13){
        ep.calculo_propel.datapp = 3;
        return 3;
    }
    if(sumpr > 13 && sumpr <= 16){
        ep.calculo_propel.datapp = 4;
        return 4;
    }
    if(sumpr > 16 && sumpr <= 20){
        ep.calculo_propel.datapp = 5;
        return 5;
    }

}
function calcularPrPel(){
     ep.calculo_propel.datapr =  ep.calculo_propel.dataie +
        ep.calculo_propel.dataif +
        ep.calculo_propel.dataip +
        ep.calculo_propel.dataic;
    ep.txtSumaPrPel.text(
        ep.calculo_propel.datapr
        );
    ep.txtProbPel.text(calculoProbPel());
    ep.calculo_propel.datapxs = ep.calculo_propel.datapp*ep.calculo_propel.datasev;
    ep.txtPuntajePrxSePel.text(ep.calculo_propel.datapxs);
    calcularNivelRiesgoPel();


}
function calcularPrAmb(){
    ep.calculo_proamb.datapxs = ep.calculo_proamb.datapr*ep.calculo_proamb.datasev;
    ep.txtPuntajePrxSeImp.text(ep.calculo_proamb.datapxs);
    calcularNivelImpactoAmb();
}
function fnChangeCalRadPel(){

    console.log(this);
    if($(this).hasClass('radIEP'))
        ep.calculo_propel.dataie = +this.value;
    if($(this).hasClass('radIFP'))
        ep.calculo_propel.dataif = +this.value;
    if($(this).hasClass('radIPP'))
        ep.calculo_propel.dataip = +this.value;
    if($(this).hasClass('radICP'))
        ep.calculo_propel.dataic = +this.value;
    calcularPrPel();

}
function fnChangeCalRadAmb(){

    console.log(this);
    if($(this).hasClass('radIPR'))
        ep.calculo_proamb.datapr = +this.value;
    if($(this).hasClass('radISEV'))
        ep.calculo_proamb.datasev = +this.value;
    calcularPrAmb();

}
function fnChangePeligro(e) {
    console.log('change peligro');

    if (this.value != '') {
        if(+this.value != -1){

            if(!ep.frmNewPel.hasClass('hidden'))
                ep.frmNewPel.addClass('hidden');
            $.getJSON(BASE_URL + 'riesgo/listar_by_peligro/' + this.value, function(data, textStatus) {
                var t = Handlebars.compile(TEMPLATES.option);
                var html = t({id : -1, text : 'Nuevo'});
                if(data.length > 0){
                    data.forEach(function(v, i) {
                        html += t({
                            id: v.rie_id,
                            text: v.rie_nombre
                        })
                    });

                    ep.selRiesgo
                        .html(html);

                    if(!ep.data_edit.is_editar){
                        ep.selRiesgo
                            .val(data[0].rie_id)
                            .trigger('change');
                            // ep.radSevP.eq(0).iCheck('check');
                    }else{
                        ep.selRiesgo
                            .val(ep.data_edit.id_riesgos)
                            .trigger('change');

                    }
                    ep.radSevP.iCheck('enable');



                    ep.radCalProb.iCheck('enable');


                    ep.btnAddMCRiesgo.prop('disabled', false);
                    ep.btnGuardarPeligro.prop('disabled', false);

                    ep.selJerarquiaRiesgo.val('').trigger('change').prop('disabled', false);

                }else{
                    ep.selRiesgo.html(html).val('-1').trigger('change');
                    ep.radSevP.iCheck('disable').eq(0).iCheck('check');
                    ep.btnAddMCRiesgo.prop('disabled', true);
                    ep.selJerarquiaRiesgo.val('').trigger('change').prop('disabled', true);


                    resetLabelsPel();
                    ep.radCalProb.iCheck('disable');

                    // ep.selMedidaRiesgo.html('').prop('disabled', true);
                }
                if(ep.selRiesgo.prop('disabled'))
                    ep.selRiesgo.prop('disabled', false);
                ep.selMedidaRiesgo.html('').prop('disabled', true);
            });
        }else{
            //Nuevo
            ep.selRiesgo.val('').trigger('change');
            ep.selCategoriaPeligroNew.val('').trigger('change');
            if(!ep.selRiesgo.prop('disabled'))
                ep.selRiesgo.prop('disabled', true);
            if(ep.frmNewPel.hasClass('hidden'))
                ep.frmNewPel.removeClass('hidden');
        }
    }else{


    }
    ep.lstMedidasRiesgo.html(ep.tpl_sin_medidas);
    resetCalculoProbabiidad();

}
function resetLabelsPel(){

    ep.txtSumaPrPel.text('0');
    ep.txtProbPel.text('0');
    ep.txtPuntajePrxSePel.text('0');
    ep.txtNivelRiesgoPel.text(' - - - - - ');
    ep.txtRiesgoSigPel.text(' - - ');

    ep.calculo_propel.dataie = 1;
    ep.calculo_propel.dataif = 1;
    ep.calculo_propel.dataip = 1;
    ep.calculo_propel.dataic = 1;
    ep.calculo_propel.datapr = 4;
    ep.calculo_propel.datapp = 1;
    ep.calculo_propel.datapxs = 1;
    ep.calculo_propel.datasev = 1;

    ep.btnGuardarPeligro.prop('disabled', true);

}
function resetLabelsAmb(){


    ep.txtPuntajePrxSeImp.text('0');
    ep.txtNivelRiesgoImp.text(' - - - - - ');
    ep.txtImpAmbSig.text(' - - ');

    ep.calculo_proamb.datapr = 1;
    ep.calculo_proamb.datasev = 1;
    ep.calculo_proamb.datapxs = 1;

    ep.btnGuardarAmbiental.prop('disabled', true);

}
function fnChangeAspecto(e) {
    console.log('change aspecto');
    console.log(this.value);
    if (this.value != '') {
        if(+this.value != -1){

            if(!ep.frmNewAaspecto.hasClass('hidden'))
                ep.frmNewAaspecto.addClass('hidden');
            $.getJSON(BASE_URL + 'impacto_ambiental/listar_by_aspecto/' + this.value, function(data, textStatus) {
                var t = Handlebars.compile(TEMPLATES.option);
                var html = t({id : -1, text : 'Nuevo'});
                if(data.length > 0){
                    data.forEach(function(v, i) {
                        html += t({
                            id: v.imp_id,
                            text: v.imp_nombre
                        })
                    });


                    ep.selImpacto
                        .html(html);

                    if(!ep.data_edit_aspecto.is_editar){
                        ep.selImpacto
                            .val(data[0].imp_id)
                            .trigger('change');
                    }else{

                        ep.selImpacto
                            .val(ep.data_edit_aspecto.id_impactos)
                            .trigger('change');
                        // console.log(ep.data_edit_aspecto);
                        // ep.selImpacto.find('option').each(function(e,vv){
                        //     var ref = +vv.value;
                        //     console.log(ref);
                        //     var resf = ep.data_edit_aspecto.id_impactos.filter(function(v,i){
                        //             console.log('value impc : ' +v);
                        //         return ref == +v;
                        //     });
                        //     console.log(resf);
                        //     if(resf.length > 0 )
                        //         $(vv).prop('selected', true);
                        // }).end().trigger('change');
                    }
                    // ep.radSevP.iCheck('enable').eq(0).iCheck('check');
                    ep.radCalProbAm.iCheck('enable');

                    ep.btnAddMCImpacto.prop('disabled', false);
                    ep.btnGuardarAmbiental.prop('disabled', false);

                    ep.selJerarquiaImpacto.val('').trigger('change').prop('disabled', false);

                }else{
                    ep.selImpacto.html(html).val('-1').trigger('change');
                    ep.btnAddMCImpacto.prop('disabled', true);
                    ep.selJerarquiaImpacto.val('').trigger('change').prop('disabled', true);

                    resetLabelsAmb();
                    ep.radCalProbAm.iCheck('disable');

                    // ep.selMedidaRiesgo.html('').prop('disabled', true);
                }

                if(ep.selImpacto.prop('disabled'))
                    ep.selImpacto.prop('disabled', false);
                ep.selMedidaAmbiental.html('').prop('disabled', true);
            });
        }else{

            //Nuevo
            ep.frmNewAaspecto.find('input[type="text"]').each(function(e,v){
                v.value = '';
            })
            ep.selImpacto.val('').trigger('change');
            ep.selCategoriaAspectoNew.val('').trigger('change');
            if(!ep.selImpacto.prop('disabled'))
                ep.selImpacto.prop('disabled', true);
            if(ep.frmNewAaspecto.hasClass('hidden'))
                ep.frmNewAaspecto.removeClass('hidden');
        }
    }else{


    }
    ep.lstMedidasAmbiental.html(ep.tpl_sin_medidas);
    resetCalculoProbImpacto();

}
function fnHideAddPeligro(elemodal){

    ep.selRiesgo.html('').val('').trigger('change');
    if(!ep.selRiesgo.prop('disabled')) ep.selRiesgo.prop('disabled', true);
    ep.radSevP.iCheck('disable').eq(0).iCheck('check');
    ep.radCalProb.iCheck('disable');
    ep.selJerarquiaRiesgo.prop('disabled', true);
    ep.selMedidaRiesgo.prop('disabled', true);

    ep.data_edit.is_editar = false;
    ep.data_edit.id_peligro = 0;
    ep.data_edit.id_actividad = 0;
    ep.data_edit.id_riesgos = 0;
    resetCalculoProbabiidad();
    elemodal.dataset.modoModal = 'registrar';
    resetLabelsPel();
    ep.tituloModalPel.text('Agregar Peligro a Actividad');
}
function fnHideAddAspecto(elemodal){

    ep.selImpacto.html('').val('').trigger('change');
    if(!ep.selImpacto.prop('disabled')) ep.selImpacto.prop('disabled', true);
    ep.radCalProbAm.iCheck('disable');
    ep.selJerarquiaImpacto.prop('disabled', true);
    ep.selMedidaAmbiental.prop('disabled', true);

    ep.data_edit_aspecto.is_editar = false;
    ep.data_edit_aspecto.id_aspecto = 0;
    ep.data_edit_aspecto.id_actividad = 0;
    ep.data_edit_aspecto.id_impactos = 0;
    resetCalculoProbImpacto();
    elemodal.dataset.modoModal = 'registrar';
    resetLabelsAmb();
    ep.tituloModalAmb.text('Agregar Aspecto Ambiental a Actividad');
}
function resetCalculoProbabiidad(){
    if(!ep.data_edit.is_editar){
        ep.radIEP.eq(0).iCheck('check');
        ep.radIFP.eq(0).iCheck('check');
        ep.radIPP.eq(0).iCheck('check');
        ep.radICP.eq(0).iCheck('check');
    }
}
function resetCalculoProbImpacto(){
    if(!ep.data_edit_aspecto.is_editar){
        ep.radIPR.eq(0).iCheck('check');
        ep.radISEV.eq(0).iCheck('check');
    }
}
function fnChangeRiesgo(e) {
    console.log('change riesgo');
    console.log(ep.selRiesgo.val());
    function _resetInRiesgo(){
        resetLabelsPel();

        ep.radCalProb.iCheck('disable');
        ep.btnAddMCRiesgo.prop('disabled', true);
        ep.selJerarquiaRiesgo.val('').trigger('change').prop('disabled', true);
    }
    // resetCalculoProbabiidad();
    if(+this.value.trim() == 0){
        if(!ep.frmNewRiesgo.hasClass('hidden')) ep.frmNewRiesgo.addClass('hidden');
        ep.radSevP.iCheck('disable');
        _resetInRiesgo();

        // resetLabelsPel();
        // ep.radSevP.iCheck('disable').eq(0).iCheck('check');
        // ep.radCalProb.iCheck('disable');
        // ep.btnAddMCRiesgo.prop('disabled', true);
        // ep.selJerarquiaRiesgo.val('').trigger('change').prop('disabled', true);
    }else{
        if(+this.value == -1){
            ep.radSevP.iCheck('disable');
            _resetInRiesgo();
            if(ep.frmNewRiesgo.hasClass('hidden')) ep.frmNewRiesgo.removeClass('hidden');

            // resetLabelsPel();
            // ep.radSevP.iCheck('disable').eq(0).iCheck('check');
            // ep.radCalProb.iCheck('disable');
            // ep.btnAddMCRiesgo.prop('disabled', true);
            // ep.selJerarquiaRiesgo.val('').trigger('change').prop('disabled', true);


        }else{
            ep.radSevP.iCheck('enable');
            if(!ep.frmNewRiesgo.hasClass('hidden')) ep.frmNewRiesgo.addClass('hidden');
            ep.radCalProb.iCheck('enable');
            if(ep.btnAddMCRiesgo.prop('disabled') == true) ep.btnAddMCRiesgo.prop('disabled', false);
            if(ep.selJerarquiaRiesgo.prop('disabled') == true) ep.selJerarquiaRiesgo.prop('disabled', false)
            if(ep.btnGuardarPeligro.prop('disabled') == true) ep.btnGuardarPeligro.prop('disabled', false);
            calcularPrPel();
        }
    }



}
function fnChangeImpacto(e) {
    console.log('change-impacto');
    console.log(ep.selImpacto.val());
    // resetCalculoProbabiidad();
    function _resetInImpacto(){
        resetLabelsAmb();
        ep.radCalProbAm.iCheck('disable');
        ep.btnAddMCImpacto.prop('disabled', true);
        ep.selJerarquiaImpacto.val('').trigger('change').prop('disabled', true)
    }
    if(ep.selImpacto.val() == null || ep.selImpacto.val().length == 0){
        if(!ep.frmNewImpacto.hasClass('hidden')) ep.frmNewImpacto.addClass('hidden');

        _resetInImpacto();
    }else{

        if(+this.value == -1){

            _resetInImpacto();
            if(ep.frmNewImpacto.hasClass('hidden')) ep.frmNewImpacto.removeClass('hidden');

            // resetLabelsPel();
            // ep.radSevP.iCheck('disable').eq(0).iCheck('check');
            // ep.radCalProb.iCheck('disable');
            // ep.btnAddMCRiesgo.prop('disabled', true);
            // ep.selJerarquiaRiesgo.val('').trigger('change').prop('disabled', true);


        }else{
            if(!ep.frmNewImpacto.hasClass('hidden')) ep.frmNewImpacto.addClass('hidden');
            ep.radCalProbAm.iCheck('enable');
            if(ep.btnAddMCImpacto.prop('disabled') == true) ep.btnAddMCImpacto.prop('disabled', false);
            if(ep.selJerarquiaImpacto.prop('disabled') == true) ep.selJerarquiaImpacto.prop('disabled', false)
            if(ep.btnGuardarAmbiental.prop('disabled') == true) ep.btnGuardarAmbiental.prop('disabled', false);
            calcularPrAmb();
        }
    }
}
function _cargarPeligro(){

}
function _cargarActividad(idetapa, targetact = false){

        // ep.selPeligro.val('').trigger('change');
        $.getJSON(BASE_URL + 'proceso_actividad/listar_by_etapa/' + idetapa, {}, function(data, textStatus) {
            var t = Handlebars.compile(TEMPLATES.option);
            var html = '';
            ep.selActividad.html('');
            html += t({
                id: -1,
                text: 'Nuevo'
            });
            if (data.length > 0) {
                data.forEach(function(e, i) {
                    html += t({
                        id: e.pac_id,
                        text: e.pac_nombre
                    });
                });
                // ep.selActividad.html(html).val(data[0].pac_id).trigger('change');
            }
            if(targetact)
                ep.selActividad.html(html).val(targetact).trigger('change');
            else ep.selActividad.html(html).val('').trigger('change');
        });

}
function fnChangeEtapas(e) {
    if(ep.selActividad.prop('disabled'))
        ep.selActividad.prop('disabled', false);
    console.log('change-etapas');
    if (+this.value != -1) {
        _cargarActividad(this.value);
        ep.frmNewEtapa.addClass('hidden');
    }else{
        ep.frmNewEtapa.removeClass('hidden');
        if(!ep.frmNewActividad.hasClass('hidden'))
            ep.frmNewActividad.addClass('hidden');
        ep.selActividad.html('').val('').trigger('change').prop('disabled', true);


    }
    // ep.selPeligro.val('').trigger('change');
}

function fnAccionesBlanco(e) {
    e.preventDefault();
    console.log('accion-blanco');
    console.log(this.dataset);
    switch (this.dataset.idTipo) {
        case 'peligro':
            switch(this.dataset.accion){
                case 'editar':
                    console.log('editar');
                    ep.modAddPeligro[0].dataset.modoModal = 'actualizar';
                    ep.tituloModalPel.text('Modificar Peligro de Actividad');
                    ep.data_edit.is_editar = true;
                    ep.data_edit.id_peligro = this.dataset.idObject;
                    ep.data_edit.id_actividad = this.dataset.idBlanco;
                    ep.frmRegistroPeligro[0].dataset.accion = 'actualizar';
                    ep.txtIdBlanco.val(this.dataset.idBlanco);


                    //cargar la lista de medidas
                    console.log('mod actualizar');
                    $.getJSON(BASE_URL + 'proceso_actividad/peligros_actividad/' + ep.selActividad.val() + '/' + ep.data_edit.id_peligro, function(json, textStatus) {
                        if(json.length > 0){
                            ep.selPeligro.setDataSelectGroup({
                                values : json, id : 'pel_id', text : 'pel_nombre'
                            },{value : -1, text : 'Nuevo'});


                            //cargar los datos de la actividad
                            $.getJSON(BASE_URL + 'analisis_proceso/getdatablanco/1/' + ep.data_edit.id_actividad, function(json, textStatus) {
                                console.log(json);
                                ep.data_edit.id_riesgos = json.rie_id_riesgo.split(',');
                                ep.selPeligro.val(ep.data_edit.id_peligro).trigger('change');
                                // ep.selRiesgo.val().trigger('change');

                                ep.radIEP.each(function(i, v){
                                    if(v.value ==  +json.acb_vfp_ie)
                                        $(v).iCheck('check');
                                })
                                ep.radIFP.each(function(i, v){
                                    if(v.value ==  +json.acb_vfp_if)
                                        $(v).iCheck('check');
                                })
                                ep.radIPP.each(function(i, v){
                                    if(v.value ==  +json.acb_vfp_ip)
                                        $(v).iCheck('check');
                                })
                                ep.radICP.each(function(i, v){
                                    if(v.value ==  +json.acb_vfp_ic)
                                        $(v).iCheck('check');
                                })

                                ep.radSevP.each(function(i, v){
                                    if(v.value ==  +json.acb_sev)
                                        $(v).iCheck('check');
                                })
                                ep.calculo_propel.dataie = +json.acb_vfp_ie;
                                ep.calculo_propel.dataif = +json.acb_vfp_if;
                                ep.calculo_propel.dataip = +json.acb_vfp_ip;
                                ep.calculo_propel.dataic = +json.acb_vfp_ic;
                                ep.calculo_propel.datasev = +json.acb_sev;

                                ep.lstMedidasRiesgo.find('.sin-medidas').remove();
                                json.medidas_control.forEach(function(v, i){

                                    ep.lstMedidasRiesgo.append(ep.tpl_medidas({
                                        id_medida : v.mco_id,
                                        id_jerar : v.jmc_nivel,
                                        tipo_medida : 'txtMedPeligro',
                                        nom_medida : v.mco_nombre
                                    }));
                                });





                                ep.modAddPeligro.modal('show');
                            }).fail(fnFailAjax);
                        }else{
                            ep.selPeligro.html('').val('').trigger('change');
                        }
                    }).fail(fnFailAjax);





                    break;
                case 'eliminar':
                    var wso = get_swaloption();
                    wso.title = 'Eliminar Peligro de Actividad';
                    wso.text = '¿Desea quitar este elemento?';
                    wso.type = 'warning';
                    wso.closeOnCancel = true;
                    wso.showLoaderOnConfirm = true;
                    var selfthis = this;
                    swal(wso,function(){

                        $.getJSON(BASE_URL + 'analisis_proceso/eliminar_blanco/1/' + selfthis.dataset.idBlanco, function(json, textStatus) {
                            console.log(json);
                            if(json.resultado){
                                $(selfthis).parents('tr').remove();
                                swal("Elemento Eliminado!",'', "success");
                            }

                        }).fail(fnFailAjax);
                    })
                    break;
            }
            break;
        case 'aspecto':
            switch(this.dataset.accion){
                case 'editar':
                    console.log('editar');
                    ep.modAddAspecto[0].dataset.modoModal = 'actualizar';
                    ep.tituloModalAmb.text('Modificar Aspecto Ambiental de Actividad');
                    ep.data_edit_aspecto.is_editar = true;
                    ep.data_edit_aspecto.id_aspecto = this.dataset.idObject;
                    ep.data_edit_aspecto.id_actividad = this.dataset.idBlanco;
                    ep.frmRegistroAmbiental[0].dataset.accion = 'actualizar';
                    ep.txtIdBlanco.val(this.dataset.idBlanco);


                    //cargar la lista de medidas
                    console.log('mod actualizar');
                    $.getJSON(BASE_URL + 'proceso_actividad/ambiental_actividad/' + ep.selActividad.val() + '/' + ep.data_edit_aspecto.id_aspecto, function(json, textStatus) {
                        if(json.length > 0){
                            ep.selAspectoAmbiental.setDataSelectGroup({
                                values : json, id : 'asp_id', text : 'asp_nombre'
                            }, {value : -1, text : 'Nuevo'});

                            //cargar los datos de la actividad
                            $.getJSON(BASE_URL + 'analisis_proceso/getdatablanco/2/' + ep.data_edit_aspecto.id_actividad, function(json, textStatus) {
                                console.log('datos-blanco-aspecto');
                                var idsimpc = json.imp_id_impacto.split(',');
                                console.log(idsimpc);

                                ep.radIPR.each(function(i, v){
                                    if(v.value ==  +json.aba_vfp_pr) $(v).iCheck('check');
                                });
                                ep.radISEV.each(function(i, v){
                                    if(v.value ==  +json.aba_vfp_sev) $(v).iCheck('check');
                                });

                                ep.calculo_proamb.datapr = +json.aba_vfp_pr;
                                ep.calculo_proamb.datasev = +json.aba_vfp_sev;


                                ep.data_edit_aspecto.id_impactos = idsimpc;

                                // ep.selImpacto.val(idsimpc).trigger('change');

                                ep.lstMedidasAmbiental.find('.sin-medidas').remove();

                                json.medidas_control.forEach(function(v, i){

                                    ep.lstMedidasAmbiental.append(ep.tpl_medidas({
                                        id_medida : v.mco_id,
                                        id_jerar : v.jmc_nivel,
                                        tipo_medida : 'txtMedAmbiental',
                                        nom_medida : v.mco_nombre
                                    }));
                                });





                                ep.selAspectoAmbiental.val(ep.data_edit_aspecto.id_aspecto).trigger('change');

                                ep.modAddAspecto.modal('show');
                            }).fail(fnFailAjax);


                        }else{
                            ep.selAspectoAmbiental.html('').val('').trigger('change');
                        }

                    }).fail(fnFailAjax);





                    break;
                case 'eliminar':
                    var wso = get_swaloption();
                    wso.title = 'Eliminar Aspecto Ambiental de Actividad';
                    wso.text = '¿Desea quitar este elemento?';
                    wso.type = 'warning';
                    wso.closeOnCancel = true;
                    wso.showLoaderOnConfirm = true;
                    var selfthis = this;
                    swal(wso,function(){

                        $.getJSON(BASE_URL + 'analisis_proceso/eliminar_blanco/2/' + selfthis.dataset.idBlanco, function(json, textStatus) {
                            console.log(json);
                            if(json.resultado){
                                $(selfthis).parents('tr').remove();
                                swal("Elemento Eliminado!",'', "success");
                            }

                        }).fail(fnFailAjax);
                    })
                    break;
            }
            break;
    }
}

function fnChangeActividad(e) {
    console.log('cambio acntividad');
    var htmlP = ep.tpl_trblancos_null;
    var htmlA = ep.tpl_trblancos_null;
    var tbodyasp = ep.lstAspectosActi.find('tbody');
    tbodyasp.html(ep.tpl_trblancos_null);
    var tbodype = ep.lstPeligrosActi.find('tbody');
    tbodype.html(ep.tpl_trblancos_null);
    if(!(+this.value == 0 || this.value == '')){


        //cargar, los peligros y aspectos ambientales de la actividad
        ep.txtIdActividad.val(this.value);
        if(+this.value != -1){
            if(!ep.frmNewActividad.hasClass('hidden'))
                ep.frmNewActividad.addClass('hidden');
            $.getJSON(BASE_URL + 'proceso_actividad/get_blancos/' + this.value, {}, function(data, textStatus) {
                console.log(data);


                data.lstAspectos.forEach(function(e, i) {

                    var rul = $('<ul></ul>');
                    e.lst_impactos.forEach(function(v, i){
                        rul.append($('<li></li>').text(v.imp_nombre));
                    });

                    var htmlt = $(ep.tpl_trblancos({
                        nom_blanco: e.asp_nombre,
                        id_blanco: e.aba_id,
                        nom_blanco_sec: e.imp_nombre,
                        id: e.asp_id,
                        tipo: 'aspecto'
                    }));

                    htmlt.find('.nom-sec').append(rul);
                    if(i == 0)
                        tbodyasp.html(htmlt);
                    else tbodyasp.append(htmlt);
                });




                data.lstPeligros.forEach(function(e, i) {
                    var rul = $('<ul></ul>');
                    e.lst_riesgos.forEach(function(v, i){
                        rul.append($('<li></li>').text(v.rie_nombre));
                    });
                    var htmlt = $(ep.tpl_trblancos({
                            nom_blanco: e.pel_nombre,
                            id_blanco: e.acb_id,
                            id: e.pel_id,
                            tipo: 'peligro'
                        }));
                    // else htmlt += ep.tpl_trblancos({
                    //     nom_blanco: e.pel_nombre,
                    //     id_blanco: e.acb_id,
                    //     id: e.pel_id,
                    //     tipo: 'peligro'
                    // });

                    htmlt.find('.nom-sec').append(rul);
                    if(i == 0)
                        tbodype.html(htmlt);
                    else tbodype.append(htmlt);

                });


            }).fail(fnFailAjax);
        }else{
            if(ep.frmNewActividad.hasClass('hidden'))
                ep.frmNewActividad.removeClass('hidden')
                .find('#txtNomActiNew').val('').end()
                .find('#txtOrdenActiNew').val(1).end()
                .find('#txtPuestoActiNew').val('');
                ep.frmNewActividad.find('.radSituacionActividad').eq(0).iCheck('check')
                ep.frmNewActividad.find('.radUbicacionActividad').eq(0).iCheck('check')
                ep.frmNewActividad.find('.radTipoPersonalActividad').eq(0).iCheck('check');
            //agregar nuevo

        }
    }
    // ep.selPeligro.val('').trigger('change');
}
function reset_peligro(){

}
function reset_aspectoambi(){

}
function fnAgregarBlanco(e) {
    e.preventDefault();
    var selval = ep.selActividad.val();
    if (!(selval == '' || +selval == -1 || +selval == 0)) {
        switch (this.dataset.addTipo) {
            case 'peligro':

                ep.modAddPeligro[0].dataset.modoModal = 'registrar';



                ep.lstMedidasRiesgo.html(ep.tpl_sin_medidas);
                $.getJSON(BASE_URL + 'proceso_actividad/peligros_actividad/' + ep.selActividad.val(), function(json, textStatus) {
                    if(json.length > 0){
                        ep.selPeligro.setDataSelectGroup({
                            values : json, id : 'pel_id', text : 'pel_nombre'
                        },{value : -1, text : 'Nuevo'});
                        ep.selPeligro.val('').trigger('change');
                    }else{
                        ep.selPeligro.html('').val('').trigger('change');
                    }
                    ep.modAddPeligro.modal('show');
                }).fail(fnFailAjax).done(function(){
                    console.log('asdasdasdasdasdasd');
                });

                resetLabelsPel();
                break;
            case 'aspecto':
                ep.modAddAspecto[0].dataset.modoModal = 'registrar';



                ep.lstMedidasAmbiental.html(ep.tpl_sin_medidas);
                $.getJSON(BASE_URL + 'proceso_actividad/ambiental_actividad/' + ep.selActividad.val(), function(json, textStatus) {
                    if(json.length > 0){
                        ep.selAspectoAmbiental.setDataSelectGroup({
                            values : json, id : 'asp_id', text : 'asp_nombre'
                        },{value : -1, text : 'Nuevo'});
                        ep.selAspectoAmbiental.val('').trigger('change');
                    }else{
                        ep.selAspectoAmbiental.html('').val('').trigger('change');
                    }
                    ep.modAddAspecto.modal('show');
                }).fail(fnFailAjax);
                resetLabelsAmb();
                break;
        }
    }
}