window.onload = fnLoad;
var dtListar;
var filtrosDatatable = [];
function fnLoad(){
    validator.message.date = 'not a real date';

    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var btnCancelar = $('#btnCancelar');
    var selDepProceso = $('#selDepProceso');
    var selUniProceso = $('#selUniProceso');
    var selUniProceso = $('#selUniProceso');

    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    selDepProceso.on('change',fnChangeDepartamento);
    selUniProceso.on('change',fnChangeUnidad);


    filtrosDatatable = [
        {column : 'dep_id',             filter : -1},
        {column : 'uni_id',             filter : -1},
        {column : 'pro_id_proceso',     filter : -1},
        {column : 'pet_estado',         filter : -1},
        {column : 'pet_nombre',         filter : ''}
    ];
    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false,
        serverSide : true,
        order : [0,'asc'],
        ajax : {
            url : BASE_URL + "proceso_etapa/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "pet_orden" },
            { data : "pet_nombre" },
            { data : "pro_nombre" },
            { data : "pet_estado", render : function(data,type,row){
                if(data == 1)
                    return 'Activo';
                else return 'Inactivo';
            } },
            { data : "pet_id",render:function(data, type, row){
                    var t = TEMPLATES.btn_acciones;
                    t = Handlebars.compile(t);
                    return t({id : data});

            } }

        ],


        columnDefs : [
            {
                targets : [ 4 ],
                orderable : false,
                width : '65px'

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        $(el.selDepProceso).val('').trigger('change');
        $(el.selUniProceso).html('').trigger('change');
        $(el.selUniProceso).prop('disabled',true);
        $(el.selProcesoEtapa).html('').trigger('change');
        $(el.selProcesoEtapa).prop('disabled',true);
        $(el.chkEstadoEtapa).iCheck('check');
        $(tituloModal).html('Agregar Etapa');
        frmRegistro.reset();

    }
    function fnAbrirModal(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';
        modRegistro.modal('show');

    }
    $('#frmRegistro').submit(function(e){
        e.preventDefault();

        // return false;
        var frmRegistro = new Form('frmRegistro');
        // $('#frmRegistro').submit();
        var elem = frmRegistro.getElements();

        switch(elem.btnRegistrar.dataset.accion){
            case 'guardar':
                swal_option.confirm.title = 'Guardar Etapa de Proceso';
                swal_option.confirm.text = '¿Desea guardar los datos de la Etapa de  Proceso?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Etapa de Proceso';
                swal_option.confirm.text = '¿Desea guardar los cambios  de la Etapa?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;

        }

        swal(swal_option.confirm,
        function(isConfirm){
          if (isConfirm) {
            switch(elem.btnRegistrar.dataset.accion){
                case 'guardar':
                    console.log('registrar');
                    $.post(BASE_URL + 'proceso_etapa/insertar', {
                        txtNombre : elem.txtNombreEtapa.value,
                        txtIdProceso : +elem.selProcesoEtapa.value,
                        txtOrden : +elem.txtOrdenEtapa.value,
                        txtEstado : elem.chkEstadoEtapa.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            dtListar.draw();
                            modRegistro.modal('hide');
                            swal("Etapa de Proceso Registrado!",'', "success");
                            reset();
                        }
                    },'json').error(function(e){console.log(e.responseText)});
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'proceso_etapa/actualizar', {
                        id : elem.txtId.value,
                        txtNombre : elem.txtNombreEtapa.value,
                        txtIdProceso : +elem.selProcesoEtapa.value,
                        txtOrden : +elem.txtOrdenEtapa.value,
                        txtEstado : elem.chkEstadoEtapa.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            opc_editar.value = 0;
                            opc_editar.value_proceso = 0;
                            opc_editar.is_edit = false;
                            dtListar.draw();
                            modRegistro.modal('hide');
                            reset();
                            swal("Datos Actualizados!",'', "success");
                            btnRegistrar.html('Guardar');
                            btnRegistrar.get(0).dataset.accion = 'guardar';

                        }
                    },'json').fail(fnFailAjax);
                    break;
            }
          }
        });

        return false;

    })
    function fnRegistrar(e)
    {
        // console.log('a');
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
        }
    }
    var opc_editar = {is_edit : false, value : 0, value_proceso : 0};
    function fnEditar(id)
    {

        console.log('editar');
          $.post(BASE_URL + 'proceso_etapa/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;

                opc_editar.is_edit = true;
                opc_editar.value = obj.idDepend;
                opc_editar.value_proceso = obj.pro_id_proceso;

                var frm = new Form('frmRegistro');
                var elem = frm.getElements();

                elem.txtNombreEtapa.value = obj.pet_nombre;
                elem.txtOrdenEtapa.value = obj.pet_orden;
                // elem.selUniProceso.value = obj[4];
                +obj.pet_estado == 1 ? $(elem.chkEstadoEtapa).iCheck('check') : $(elem.chkEstadoEtapa).iCheck('uncheck');

                $(elem.selDepProceso).val(obj.reportaDpend).trigger('change');
                // $(elem.selDepProceso).val(obj[12]).trigger('change');
                // $(elem.selUniProceso).val(obj[4]).trigger('change');
                elem.txtId.value = obj.pet_id;

                btnRegistrar.html('Guardar');

                btnRegistrar.get(0).dataset.accion = 'actualizar';
                $(tituloModal).html('Modificar Etapa');
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Etapa de Proceso",
            text: "¿Desea eliminar esta Etapa?",
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
            $.post(BASE_URL + 'proceso_etapa/eliminar/' + id, {}, function(data, textStatus, xhr) {

                if(data.resultado){
                    swal("Eliminado!", "La Etapa de Proceso fue eliminado", "success");
                    dtListar.row($(element).toParent('tr')).remove().draw();
                }
            },'json').fail(fnFailAjax);
          }
        });
        // $.post(BASE_URL + 'usuario/eliminar/' + id, {}, function(data, textStatus, xhr) {
        //     if(data.resultado)
        //         dtListar.row($(element).toParent('tr')).remove().draw();
        // },'json').fail(fnFailAjax);
    }

    var lstUniNull = true;
    var targetDep = -1;
    var targetUni = -1;
    function fnBuscarDos(e){
        e.preventDefault();
        var frmF = new Form('frmFiltrar').getElements();

        switch(this.id){
            case 'txtNombreEtapaF':
                filtrosDatatable[4].filter = this.value.trim();
                break;
            case 'selEstadoEtapaF':
                filtrosDatatable[3].filter = this.value;
                break;
            case 'selDepProcesoF':
                if(+this.value != -1){
                    filtrosDatatable[0].filter = this.value;
                    $.post(BASE_URL + 'proceso/listar_uni_by_dep/' + this.value, {}, function(data, textStatus, xhr) {

                        var r = null;

                        console.log(data);
                        if(data.length > 0){
                            targetDep = frmF.selDepProcesoF.value;
                            $(frmF.selUniProcesoF).prop('disabled',false).html('');
                            var t = Handlebars.compile(TEMPLATES.option);


                            $(frmF.selUniProcesoF).append(t({id : -1, text : 'Todos'}));
                            for (var i = data.length - 1; i >= 0; i--) {

                                $(frmF.selUniProcesoF).append(t({
                                    id : data[i].idDepend,
                                    text : data[i].desDepend
                                }))
                            }



                        }else{
                            targetDep = -1;
                            $(frmF.selUniProcesoF).prop('disabled',true).html('');
                        }
                    },'json');


                    $.post(BASE_URL + 'proceso/listar_by_dep/' + this.value, {}, function(data, textStatus, xhr) {

                        var r = null;

                        console.log(data);
                        if(data.length > 0){
                            targetUni = frmF.selUniProcesoF.value;
                            $(frmF.selProcesoEtapaF).prop('disabled',false).html('');
                            var t = TEMPLATES.option;
                            t = Handlebars.compile(t);


                            $(frmF.selProcesoEtapaF).append(t({id : -1, text : 'Todos'}));
                            for (var i = data.length - 1; i >= 0; i--) {

                                $(frmF.selProcesoEtapaF).append(t({
                                    id : data[i].pro_id,
                                    text : data[i].pro_nombre
                                }))
                            }


                            $(frmF.selProcesoEtapaF).prop('disabled',false);
                        }else{
                            targetUni = -1;
                            $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                        }

                    },'json');
                }else{
                    filtrosDatatable[0].filter = -1;

                    $(frmF.selUniProcesoF).prop('disabled',true).html('');

                    $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                }
                filtrosDatatable[1].filter = -1;
                filtrosDatatable[2].filter = -1;

                break;
            case 'selUniProcesoF':
                if(+this.value != -1){
                    filtrosDatatable[1].filter = this.value;
                    $.post(BASE_URL + 'proceso/listar_by_unidad/' + this.value, {}, function(data, textStatus, xhr) {

                        var r = null;

                        console.log(data);
                        if(data.length > 0){
                            targetUni = frmF.selUniProcesoF.value;
                            $(frmF.selProcesoEtapaF).prop('disabled',false).html('');
                            var t = TEMPLATES.option;
                            t = Handlebars.compile(t);


                            $(frmF.selProcesoEtapaF).append(t({id : -1, text : 'Todos'}));
                            for (var i = data.length - 1; i >= 0; i--) {

                                $(frmF.selProcesoEtapaF).append(t({
                                    id : data[i].pro_id,
                                    text : data[i].pro_nombre
                                }))
                            }



                        }else{
                            targetUni = -1;
                            $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                        }

                    },'json');
                }else{
                    $.post(BASE_URL + 'proceso/listar_by_dep/' + frmF.selDepProcesoF.value, {}, function(data, textStatus, xhr) {

                        var r = null;
                        console.log(data);
                        if(data.length > 0){
                            targetUni = frmF.selUniProcesoF.value;
                            $(frmF.selProcesoEtapaF).prop('disabled',false).html('');
                            var t = TEMPLATES.option;
                            t = Handlebars.compile(t);


                            $(frmF.selProcesoEtapaF).append(t({id : -1, text : 'Todos'}));
                            for (var i = data.length - 1; i >= 0; i--) {

                                $(frmF.selProcesoEtapaF).append(t({
                                    id : data[i].pro_id,
                                    text : data[i].pro_nombre
                                }))
                            }


                            $(frmF.selProcesoEtapaF).prop('disabled',false);
                        }else{
                            targetUni = -1;
                            $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                        }

                    },'json');
                    filtrosDatatable[1].filter = -1;
                }
                break;
            case 'selProcesoEtapaF':
                filtrosDatatable[2].filter = this.value;
                break;
        }
        dtListar.draw();
    }
    function fnBuscar(e){
        // console.log(this.value);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();


        if(frmF.selDepProcesoF.value > 0 && frmF.selDepProcesoF.value != targetDep){
            console.log('change');
                $.post(BASE_URL + 'unidad/listar_by_dep/' + frmF.selDepProcesoF.value, {}, function(data, textStatus, xhr) {

                    var r = null;

                    console.log(data);
                    if(data.length > 0){
                        targetDep = frmF.selDepProcesoF.value;
                        $(frmF.selUniProcesoF).prop('disabled',false).html('');
                        var t = TEMPLATES.option;
                        t = Handlebars.compile(t);


                        $(frmF.selUniProcesoF).append(t({id : -1, text : 'Todos'}));
                        for (var i = data.length - 1; i >= 0; i--) {

                            $(frmF.selUniProcesoF).append(t({
                                id : data[i].uni_id,
                                text : data[i].uni_nombre
                            }))
                        }



                    }else{
                        targetDep = -1;
                        $(frmF.selUniProcesoF).prop('disabled',true).html('');
                    }

                },'json');


            lstUniNull = false;
            // filtrosDatatable.push({
            //     column : 'dep_id_departamento',
            //     filter : frmF.selDepProcesoF.value
            // });
        }else if(frmF.selDepProcesoF.value == -1){
            // $(frmF.selUniProcesoF).trigger('change');
            $(frmF.selUniProcesoF).prop('disabled',true).html('');
            $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
        }

        if(frmF.selUniProcesoF.value > 0 && frmF.selUniProcesoF.value != targetUni){
            console.log('change uni');
                $.post(BASE_URL + 'proceso/listar_by_unidad/' + frmF.selUniProcesoF.value, {}, function(data, textStatus, xhr) {

                    var r = null;

                    console.log(data);
                    if(data.length > 0){
                        targetUni = frmF.selUniProcesoF.value;
                        $(frmF.selProcesoEtapaF).prop('disabled',false).html('');
                        var t = TEMPLATES.option;
                        t = Handlebars.compile(t);


                        $(frmF.selProcesoEtapaF).append(t({id : -1, text : 'Todos'}));
                        for (var i = data.length - 1; i >= 0; i--) {

                            $(frmF.selProcesoEtapaF).append(t({
                                id : data[i].pro_id,
                                text : data[i].pro_nombre
                            }))
                        }



                    }else{
                        targetUni = -1;
                        $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                    }

                },'json');


            lstUniNull = false;
            // filtrosDatatable.push({
            //     column : 'dep_id_departamento',
            //     filter : frmF.selUniProcesoF.value
            // });
        }else if(frmF.selUniProcesoF.value == -1){
            // $(frmF.selUniProcesoF).trigger('change');
            $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
        }


        if(frmF.selProcesoEtapaF.value > 0)
            filtrosDatatable.push({
                column : 'pro_id_proceso',
                filter : frmF.selProcesoEtapaF.value});


        if(frmF.selEstadoEtapaF.value >= 0)
            filtrosDatatable.push({
                column : 'pet_estado',
                filter : +frmF.selEstadoEtapaF.value});

        if(frmF.txtNombreEtapaF.value.trim() != '')
            filtrosDatatable.push({
                column : 'pet_nombre',
                filter : frmF.txtNombreEtapaF.value});


        dtListar.draw();

    }

    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscarDos).
    on('keyup','input[type="text"].input-filter',fnBuscarDos);

    function fnCancelar(e){
        e.preventDefault();
        reset();
        opc_editar.value = 0;
        opc_editar.value_proceso = 0;
        opc_editar.is_edit = false;
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }

    function fnChangeDepartamento(e){
        // console.log('hol');
        if(this.value!=''){
            $(selProcesoEtapa).prop('disabled',true).html('');
            $.post(BASE_URL + 'unidad/listar_by_dep/' + this.value, {}, function(data, textStatus, xhr) {
                var r = null;
                if(data.length > 0){

                    $(selUniProceso).prop('disabled',false).html('');
                    var t = TEMPLATES.option;
                    t = Handlebars.compile(t);
                    var fv = '';
                    for (var i = data.length - 1; i >= 0; i--) {
                        if(i == data.length -1 )
                            fv = data[i].uni_id;
                        $(selUniProceso).append(t({
                            id : data[i].uni_id,
                            text : data[i].uni_nombre
                        }))
                    }
                    if(fv!='')
                        $(selUniProceso).val('').trigger('change');
                    if(opc_editar.is_edit){
                         $(selUniProceso).val(opc_editar.value).trigger('change');
                    }
                }else{
                    $(selUniProceso).prop('disabled',true).html('');
                    $(selProcesoEtapa).prop('disabled',true).html('');
                }

            },'json');
        }
    }
    function fnChangeUnidad(e){
        console.log('hol');
        if(this.value!=''){
            $.post(BASE_URL + 'proceso/listar_by_unidad/' + this.value, {}, function(data, textStatus, xhr) {
            console.log(data);
                var r = null;
                if(data.length > 0){
                    $(selProcesoEtapa).prop('disabled',false).html('');
                    var t = TEMPLATES.option;
                    t = Handlebars.compile(t);
                    for (var i = data.length - 1; i >= 0; i--) {
                        $(selProcesoEtapa).append(t({
                            id : data[i].pro_id,
                            text : data[i].pro_nombre
                        }))
                    }
                    $(selProcesoEtapa).val('').trigger('change');
                    if(opc_editar.is_edit){
                         $(selProcesoEtapa).val(opc_editar.value_proceso).trigger('change');
                    }
                }else{
                    $(selProcesoEtapa).prop('disabled',true).html('');
                }

            },'json').fail(fnFailAjax);
        }
    }


}
