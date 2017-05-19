window.onload = fnLoad;
var dtListar;
function fnLoad(){
    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var btnCancelar = $('#btnCancelar');
    var selDepartamentoOrigen = $('#selDepartamentoOrigen');
    var selUnidadOrigen = $('#selUnidadOrigen');

    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    selDepartamentoOrigen.on('change',fnChangeDepartamento);

    var filtrosDatatable = [];
    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [], //Initial no order.
        ajax : {
            url : BASE_URL + "residuo/datatables_list_origen",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        createdRow : function ( row, data, index ) {
            // if(data.rso_es_otro == 0)
            //     $(row).addClass('tr-otro-origen');
        },
        columns: [
            { data : "rso_nombre" },
            { data : "dep_nombre" },
            { data : "uni_nombre" },
            { data : "rso_id",render:function(data, type, row){
                // console.log(row);
                // console.log(type);
                // console.log(row);
                // if(row.rso_es_otro == 0){
                //     var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnAgregarOtro" data-accion="agregar-otro">agregar</a>';
                //     t = Handlebars.compile(t);
                //     return t({id : data});
                // }else{
                    var t = TEMPLATES.btn_acciones;
                    // var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a> / <a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';
                    t = Handlebars.compile(t);
                    return t({id : data});
                // }

            } }

        ],


        columnDefs : [
            {
                targets : [ 3 ],
                orderable : false,

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        $(el.selDepartamentoOrigen).val('').trigger('change');
        $(el.selUnidadOrigen).html('').trigger('change');

        frmRegistro.reset();

    }
    function fnAbrirModal(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';
        modRegistro.modal('show');

    }

    function fnRegistrar(e)
    {

        e.preventDefault();
        var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();

        switch(this.dataset.accion){
            case 'guardar':
                console.log('registrar');
                $.post(BASE_URL + 'residuo/insertar_origen', {
                    txtNombre : elem.txtNombreOrigen.value,
                    txtIdUnidad : elem.selUnidadOrigen.value
                }, function(data, textStatus, xhr) {

                    if(data.resultado){
                        dtListar.draw();
                        reset();
                        modRegistro.modal('hide');
                    }
                },'json').error(function(e){console.log(e.responseText)});
                break;
            case 'actualizar':
                console.log('actualizar');
                $.post(BASE_URL + 'residuo/actualizar_origen', {
                    id : elem.txtId.value,
                    txtNombre : elem.txtNombreOrigen.value,
                    txtIdUnidad : elem.selUnidadOrigen.value
                }, function(data, textStatus, xhr) {

                    if(data.resultado){
                        opc_editar.value = 0;
                        opc_editar.is_edit = false;
                        dtListar.draw();
                        reset();
                        btnRegistrar.html('Guardar');
                        btnRegistrar.get(0).dataset.accion = 'guardar';
                        modRegistro.modal('hide');
                    }
                },'json').fail(fnFailAjax);
                break;
            case 'agregar-otro':
                console.log('agregar-otro');
                $.post(BASE_URL + 'residuo/actualizar_origen', {
                    id : elem.txtId.value,
                    txtNombre : elem.txtNombreOrigen.value,
                    txtIdUnidad : elem.selUnidadOrigen.value,
                    txtEstadoOtro : 1
                }, function(data, textStatus, xhr) {

                    if(data.resultado){
                        opc_editar.value = 0;
                        opc_editar.is_edit = false;
                        dtListar.draw();
                        reset();
                        btnRegistrar.html('Guardar');
                        btnRegistrar.get(0).dataset.accion = 'guardar';
                        modRegistro.modal('hide');
                    }
                },'json').fail(fnFailAjax);
                break;
        }
    }
    var targetTR;
    function fnAccionesItemTabla(e){
        e.preventDefault();
        var id = this.dataset.idObj;
        switch(this.dataset.accion){
            case 'editar':
                targetTR = $(this).toParent('tr');
                fnEditar(id);
                break;
            case 'eliminar':
                fnEliminar(id,this);
                break;
            case 'agregar-otro':
                fnAgregarOtro(id,this);
                break;
        }
    }
    var opc_editar = {is_edit : false, value : 0};
    function fnEditar(id)
    {

        console.log('editar');
          $.post(BASE_URL + 'residuo/data_origen/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;
                opc_editar.is_edit = true;
                opc_editar.value = obj.uni_id_unidad;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombreOrigen.value = obj.rso_nombre;
                $(ele.selDepartamentoOrigen).val(obj.reportaDpend).trigger('change');

                ele.txtId.value = id;

                btnRegistrar.html('Guardar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnAgregarOtro(id)
    {

        console.log('agregar-otro');
          $.post(BASE_URL + 'residuo/data_origen/' + id, {}, function(data, textStatus, xhr) {

            if(data.resultado){

                var obj = data.objRes;
                opc_editar.is_edit = true;
                opc_editar.value = obj.uni_id_unidad;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombreOrigen.value = obj.rso_nombre;
                $(ele.selDepartamentoOrigen).val(obj.dep_id_departamento).trigger('change');

                ele.txtId.value = id;

                btnRegistrar.html('Agregar');
                btnRegistrar.get(0).dataset.accion = 'agregar-otro';
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')

        $.post(BASE_URL + 'residuo/eliminar_origen/' + id, {}, function(data, textStatus, xhr) {
            if(data.resultado)
                dtListar.row($(element).toParent('tr')).remove().draw();
        },'json').fail(fnFailAjax);
    }

    var lstUniNull = true;
    var targetDep = -1;
    function fnBuscar(e){

        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();


        if(frmF.selDepOrigF.value > 0 && frmF.selDepOrigF.value != targetDep){
            console.log('change');
                  $.post(BASE_URL + 'unidad/listar_by_dep/' + frmF.selDepOrigF.value, {}, function(data, textStatus, xhr) {

                    var r = null;

                    console.log(data);
                    if(data.length > 0){
                        targetDep = frmF.selDepOrigF.value;
                        $(frmF.selUniOrigF).prop('disabled',false).html('');
                        var t = TEMPLATES.option;
                        t = Handlebars.compile(t);


                        $(frmF.selUniOrigF).append(t({id : -1, text : 'Todos'}));
                        for (var i = data.length - 1; i >= 0; i--) {

                            $(frmF.selUniOrigF).append(t({
                                id : data[i].idDepend,
                                text : data[i].desDepend
                            }))
                        }



                    }else{
                        targetDep = -1;
                        $(frmF.selUniOrigF).prop('disabled',true).html('');
                    }

                },'json');


            lstUniNull = false;
            filtrosDatatable.push({
                column : 'dep_id_departamento',
                filter : frmF.selDepOrigF.value
            });
        }else if(frmF.selDepOrigF.value == -1){
            // $(frmF.selUniOrigF).trigger('change');
            $(frmF.selUniOrigF).prop('disabled',true).html('');
        }


        if(frmF.selUniOrigF.value > 0)
            filtrosDatatable.push({
                column : 'uni_id_unidad',
                filter : frmF.selUniOrigF.value});
        else if(frmF.selUniOrigF.value == -1){
            filtrosDatatable.push({
                column : 'dep_id_departamento',
                filter : frmF.selDepOrigF.value
            });
        }

        if(frmF.txtNomOrigenF.value.trim() != '')
            filtrosDatatable.push({
                column : 'rso_nombre',
                filter : frmF.txtNomOrigenF.value});


        dtListar.draw();

    }

    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);

    function fnCancelar(e){
        e.preventDefault();
        reset();
        opc_editar.value = 0;
        opc_editar.is_edit = false;
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }

    function fnChangeDepartamento(e){


        if(this.value!=''){
            $.post(BASE_URL + 'unidad/listar_by_dep/' + this.value, {}, function(data, textStatus, xhr) {
                var r = null;
                if(data.length > 0){
                    $(selUnidadOrigen).prop('disabled',false).html('');
                    var t = TEMPLATES.option;
                    t = Handlebars.compile(t);
                    for (var i = data.length - 1; i >= 0; i--) {
                        $(selUnidadOrigen).append(t({
                            id : data[i].uni_id,
                            text : data[i].uni_nombre
                        }))
                    }
                    if(opc_editar.is_edit){
                         $(selUnidadOrigen).val(opc_editar.value).trigger('change');
                    }
                }else{
                    $(selUnidadOrigen).prop('disabled',true).html('');
                }

            },'json').fail(fnFailAjax);
        }
    }



}
