window.onload = fnLoad;
var dtListar;
var filtrosDatatable;
var is_editando = false;
function fnLoad(){
    validator.message.date = 'not a real date';

    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var btnCancelar = $('#btnCancelar');
    var selDepProceso = $('#selDepProceso');
    var selUniProceso = $('#selUniProceso');
    var selProcesoEtapa = $('#selProcesoEtapa');
    var elementsFilter = new Form('frmFiltrar').getElements();

    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    selDepProceso.on('change',fnChangeDepartamento);
    selUniProceso.on('change',fnChangeUnidad);
    selProcesoEtapa.on('change',fnChangeProceso);

    filtrosDatatable = [];
    filtrosDatatable = [
        {column : 'dep_id', filter : -1},
        {column : 'uni_id', filter : -1},
        {column : 'pro_id_proceso', filter : -1},
        {column : 'pet_id_procesos_etapa', filter : -1},
        {column : 'pac_estado', filter : -1},
        {column : 'pac_nombre', filter : ''}
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
            url : BASE_URL + "proceso_actividad/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "pac_orden" },
            { data : "pac_nombre" },
            { data : "pro_nombre" },
            { data : "pet_nombre" },
            { data : "pac_situacion" ,render : function(data, type, row){
                for (var i = row.tipo_situacion.length - 1; i >= 0; i--) {
                    if(row.tipo_situacion[i].id == data)
                        return row.tipo_situacion[i].nombre;

                }
                return '---';
            }},
            { data : "pac_ubicacion" ,render : function(data, type, row){
                for (var i = row.tipo_ubicacion.length - 1; i >= 0; i--) {
                    if(row.tipo_ubicacion[i].id == data)
                        return row.tipo_ubicacion[i].nombre;

                }
                return '---';
            }},
            { data : "pac_tipo_personal" ,render : function(data, type, row){
                for (var i = row.tipo_personal.length - 1; i >= 0; i--) {
                    if(row.tipo_personal[i].id == data)
                        return row.tipo_personal[i].ref;

                }
                return '---';
            }},
            { data : "pac_estado", render : function(data,type,row){
                if(data == 1)
                    return 'Activo';
                else return 'Inactivo';
            } },
            { data : "pac_id",render:function(data, type, row){
                    var t = TEMPLATES.btn_acciones;
                    t = Handlebars.compile(t);
                    return t({id : data});

            } }

        ],


        columnDefs : [
            {
                targets : [ 0,6,7,8 ],
                createdCell : function (td, cellData, rowData, row, col) {

                     $(td).css({
                        'text-align' : 'center',
                        'vertical-align' : 'middle'
                    });

                }

            },
            {
                targets : [ 8 ],
                orderable : false,
                width : '65px'

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        console.log(el);

        $(el.selDepProceso).val('').trigger('change');

        $(el.selUniProceso).html('').trigger('change');
        $(el.selUniProceso).prop('disabled',true);

        $(el.selProcesoEtapa).html('').trigger('change');
        $(el.selProcesoEtapa).prop('disabled',true);

        $(el.selEtapaActividad).html('').trigger('change');
        $(el.selEtapaActividad).prop('disabled',true);

        $(el.chkEstadoActividad).eq(0).iCheck('check');

        $(el.radSituacionActividad).each(function(e,v){
            if(v.checked)
                $(v).iCheck('uncheck');
        });
        $(el.radUbicacionActividad).each(function(e,v){
            if(v.checked)
                $(v).iCheck('uncheck');
        });
        $(el.radTipoPersonalActividad).each(function(e,v){
            if(v.checked)
                $(v).iCheck('uncheck');
        });
        frmRegistro.reset();
        $(tituloModal).html('Agregar Actividad');


    }
    function fnAbrirModal(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';
        modRegistro.modal('show');
        is_editando = false;

    }
    $('#frmRegistro').submit(function(e){
        e.preventDefault();

        // return false;
        var frmRegistro = new Form('frmRegistro');
        // $('#frmRegistro').submit();
        var elem = frmRegistro.getElements();

        switch(elem.btnRegistrar.dataset.accion){
            case 'guardar':
                swal_option.confirm.title = 'Guardar Actividad de Proceso';
                swal_option.confirm.text = '¿Desea guardar los datos de la Actividad de  Proceso?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Actividad de Proceso';
                swal_option.confirm.text = '¿Desea guardar los cambios  de la Actividad?';
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
                    $.post(BASE_URL + 'proceso_actividad/insertar', {
                        txtNombre : elem.txtNombreActividad.value,
                        txtOrden : +elem.txtOrdenActividad.value,
                        txtIdEtapaActividad : +elem.selEtapaActividad.value,
                        txtPuesto : elem.txtPuestoActividad.value,
                        txtSituacion : elem.radSituacionActividad.value,
                        txtUbicacion : elem.radUbicacionActividad.value,
                        txtTipoPersonal : elem.radTipoPersonalActividad.value,
                        txtEstado : elem.chkEstadoActividad.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            dtListar.draw();
                            modRegistro.modal('hide');
                            swal("Actividad  de Proceso Registrada!",'', "success");
                            reset();
                        }
                    },'json').error(function(e){console.log(e.responseText)});
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'proceso_actividad/actualizar', {
                        id : elem.txtId.value,
                        txtNombre : elem.txtNombreActividad.value,
                        txtOrden : +elem.txtOrdenActividad.value,
                        txtIdEtapaActividad : +elem.selEtapaActividad.value,
                        txtPuesto : elem.txtPuestoActividad.value,
                        txtSituacion : +elem.radSituacionActividad.value,
                        txtUbicacion : +elem.radUbicacionActividad.value,
                        txtTipoPersonal : +elem.radTipoPersonalActividad.value,
                        txtEstado : elem.chkEstadoActividad.checked
                    }, function(data, textStatus, xhr) {
                        console.log(data);
                        if(data.resultado){
                            opc_editar.value = 0;
                            opc_editar.value_proceso = 0;
                            opc_editar.value_etapa = 0;
                            opc_editar.is_edit = false;
                            dtListar.draw();
                            modRegistro.modal('hide');
                            reset();
                            swal("Datos Actualizados!",'', "success");
                            btnRegistrar.html('Guardar');
                            btnRegistrar.get(0).dataset.accion = 'guardar';

                        }
                    },'json').fail(fnFailAjax);
                    opc_editar.is_edit = false;
                    opc_editar.value = 0;
                    opc_editar.value_proceso = 0;
                    opc_editar.value_etapa = 0;

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
        is_editando = false;
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
    var opc_editar = {is_edit : false, value : 0, value_proceso : 0,value_etapa : 0};
    function fnEditar(id)
    {

        console.log('editar');
          $.post(BASE_URL + 'proceso_actividad/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;

                opc_editar.is_edit = true;
                opc_editar.value = obj.idDepend;
                opc_editar.value_proceso = obj.pro_id_proceso;
                opc_editar.value_etapa= obj.pet_id_procesos_etapa;


                var frm = new Form('frmRegistro');
                var elem = frm.getElements();

                elem.txtNombreActividad.value = obj.pac_nombre;
                elem.txtOrdenActividad.value = obj.pac_orden;
                elem.txtPuestoActividad.value = obj.pac_puesto_trabajo;

                $(elem.radSituacionActividad).each(function(e,v){

                    if(v.value == obj.pac_situacion) $(v).iCheck('check');
                })
                $(elem.radUbicacionActividad).each(function(e,v){
                    if(v.value == obj.pac_ubicacion) $(v).iCheck('check');
                })
                $(elem.radTipoPersonalActividad).each(function(e,v){
                    if(v.value == obj.pac_tipo_personal) $(v).iCheck('check');
                })
                // elem.selUniProceso.value = obj[4];
                // elem.selTipoUsuario.value = obj[7];
                // $(elem.selDepProceso).val(obj[11]).trigger('change');

                console.log('pase');
                is_editando = true;
                $(elem.selDepProceso).val(obj.reportaDpend).trigger('change');

                // $(elem.selDepProceso).val(obj[12]).trigger('change');
                // $(elem.selDepProceso).val(obj[12]).trigger('change');
                // $(elem.selUniProceso).val(obj[4]).trigger('change');
                elem.txtId.value = obj.pac_id;

                btnRegistrar.html('Guardar');
                +obj.pac_estado == 1 ? $('#chkEstadoActividad').iCheck('check') : $('#chkEstadoActividad').iCheck('uncheck');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                $(tituloModal).html('Modificar Actividad');

            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Actividad de Proceso",
            text: "¿Desea eliminar esta Actividad?",
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
            $.post(BASE_URL + 'proceso_actividad/eliminar/' + id, {}, function(data, textStatus, xhr) {

                if(data.resultado){
                    swal("Eliminado!", "La Actividad de Proceso fue eliminado", "success");
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
    var targetProceso = -1;
    function listarEtapasByProc(dataid){
        $.post(BASE_URL + 'proceso_etapa/listar_by_procesos', {refid: dataid}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.length > 0){
                $(elementsFilter.selEtapaActividadF).prop('disabled',false).html('');
                $(elementsFilter.selEtapaActividadF).setDataSelect({values : data, id : 'pet_id', text : 'pet_nombre'}, 'Todos');
            }else{
                  $(elementsFilter.selEtapaActividadF).prop('disabled',true).html('');
            }
        },'json').fail(fnFailAjax);
    }
    function listarProByDep(iddep){

        $.post(BASE_URL + 'proceso/listar_by_dep/' + iddep, {}, function(data, textStatus, xhr) {

            var r = null;

            console.log(data);
            if(data.length > 0){
                var dataRefId = [];
                data.forEach(function(v,e){
                    dataRefId.push(+v.pro_id);
                });
                listarEtapasByProc(dataRefId.length == 1 ? dataRefId[0] : dataRefId );
                // targetUni = frmF.selUniProcesoF.value;
                $(elementsFilter.selProcesoEtapaF).prop('disabled',false).html('');
                var t = TEMPLATES.option;
                t = Handlebars.compile(t);


                $(elementsFilter.selProcesoEtapaF).append(t({id : -1, text : 'Todos'}));
                for (var i = data.length - 1; i >= 0; i--) {

                    $(elementsFilter.selProcesoEtapaF).append(t({
                        id : data[i].pro_id,
                        text : data[i].pro_nombre
                    }))
                }


                $(elementsFilter.selProcesoEtapaF).prop('disabled',false);
            }else{
                targetUni = -1;
                $(elementsFilter.selProcesoEtapaF).prop('disabled',true).html('');
            }

        },'json');
    }
    function fnBuscarDos(e){
        e.preventDefault();
        // var frmF = new Form('frmFiltrar').getElements();
        switch(this.id){
            case 'txtNombreActividadF':
                filtrosDatatable[5].filter = this.value.trim();
                break;
            case 'selEstadoActividadF':
                filtrosDatatable[4].filter = this.value;
                break;
            case 'selDepProcesoF':

               if(+this.value != -1){

                    $.post(BASE_URL + 'proceso/listar_uni_by_dep/' + this.value, {}, function(data, textStatus, xhr) {

                        var r = null;

                        console.log(data);
                        if(data.length > 0){


                            // targetDep = elementsFilter.selDepProcesoF.value;
                            $(elementsFilter.selUniProcesoF).prop('disabled',false).html('');
                            $(elementsFilter.selUniProcesoF).setDataSelect({values : data, id : 'idDepend', text : 'desDepend'}, 'Todos');


                        }else{
                            targetDep = -1;
                            // $(frmF.selUniProcesoF).val('').trigger('change');
                            $(elementsFilter.selUniProcesoF).prop('disabled',true).html('');
                            // $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                        }

                    },'json');
                    listarProByDep(this.value);
               }else{
                    $(elementsFilter.selUniProcesoF).prop('disabled', true).html('');
                    $(elementsFilter.selProcesoEtapaF).prop('disabled', true).html('');
                    $(elementsFilter.selEtapaActividadF).prop('disabled', true).html('');
               }
               filtrosDatatable[0].filter = this.value;
                break;
            case 'selUniProcesoF':
                if(+this.value != -1){

                    $.post(BASE_URL + 'proceso/listar_by_unidad/' + this.value, {}, function(data, textStatus, xhr) {

                        var r = null;

                        console.log(data);
                        if(data.length > 0){
                            var dataRefId = [];
                            data.forEach(function(v,e){
                                dataRefId.push(+v.pro_id);
                            });
                            listarEtapasByProc(dataRefId.length == 1 ? dataRefId[0] : dataRefId );
                            // targetUni = frmF.selUniProcesoF.value;
                            $(elementsFilter.selProcesoEtapaF).prop('disabled',false).html('');
                            var t = TEMPLATES.option;
                            t = Handlebars.compile(t);


                            // $(elementsFilter.selProcesoEtapaF).append(t({id : -1, text : 'Todos'}));
                            $(elementsFilter.selProcesoEtapaF).setDataSelect({values : data, id : 'pro_id', text : 'pro_nombre'}, 'Todos');




                        }else{
                            targetUni = -1;
                            $(elementsFilter.selProcesoEtapaF).prop('disabled',true).html('');
                        }

                    },'json');

                }else{
                    listarProByDep(elementsFilter.selDepProcesoF.value);
                }
                filtrosDatatable[1].filter = this.value;
                break;
            case 'selProcesoEtapaF':
                var refid = this.value;
                if(+this.value != -1)
                    filtrosDatatable[2].filter = this.value;
                else{
                    filtrosDatatable[2].filter = -1;
                    var temp = $(this).find('option').toArray();
                    refid = [];
                    temp.forEach(function(e,i){
                        if(+e.value != -1)
                            refid.push(+e.value);
                    });
                }
                listarEtapasByProc(refid);
                break;
            case 'selEtapaActividadF':
                filtrosDatatable[3].filter = this.value;
                break;
        }
        dtListar.draw();
    }
    function fnBuscar(e){
        // console.log(this.value);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();

        console.log(frmF.selDepProcesoF.value);
        console.log(targetDep);
        if(frmF.selDepProcesoF.value > 0 && frmF.selDepProcesoF.value != targetDep){
            console.log('change dep');
                $.post(BASE_URL + 'unidad/listar_by_dep/' + frmF.selDepProcesoF.value, {}, function(data, textStatus, xhr) {

                    var r = null;

                    console.log(data);
                    if(data.length > 0){
                        targetDep = frmF.selDepProcesoF.value;
                        $(frmF.selUniProcesoF).prop('disabled',false).html('');
                        $(frmF.selUniProcesoF).setDataSelect({values : data,id : 'uni_id', text : 'uni_nombre'},true);
                    }else{
                        targetDep = -1;
                        // $(frmF.selUniProcesoF).val('').trigger('change');
                        $(frmF.selUniProcesoF).prop('disabled',true).html('');
                        // $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                    }

                },'json');
                $.post(BASE_URL + 'proceso/listar_by_departamento/' + frmF.selDepProcesoF.value, {param1: 'value1'}, function(data, textStatus, xhr) {
                    console.log(data);

                    if(data.length > 0){
                        // targetDep = frmF.selDepProcesoF.value;
                        $(frmF.selProcesoEtapaF).prop('disabled',false).html('');
                        $(frmF.selProcesoEtapaF).setDataSelect({values : data,id : 'pro_id', text : 'pro_nombre'},true);

                    }else{
                        $(frmF.selProcesoEtapaF).setDataSelect({values : [],id : 'pro_id', text : 'pro_nombre'},true);
                        // targetDep = -1;
                        // $(frmF.selProcesoEtapaF).val('').trigger('change');
                        // $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                    }

                /*optional stuff to do after success */
                },'json');


            lstUniNull = false;
            // filtrosDatatable.push({
            //     column : 'dep_id_departamento',
            //     filter : frmF.selDepProcesoF.value
            // });
        }else if(frmF.selDepProcesoF.value == -1){
            targetDep = -1;
            console.log('todo!');
            $(frmF.selUniProcesoF).prop('disabled',true).html('');
            $(frmF.selEtapaActividadF).prop('disabled',true).html('');
            $(frmF.selProcesoEtapaF).setDataSelect({values : [],id : 'pro_id', text : 'pro_nombre'},true);

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
                        $(frmF.selProcesoEtapaF).setDataSelect({values : [],id : 'pro_id', text : 'pro_nombre'},true);
                        // $(frmF.selProcesoEtapaF).val('').trigger('change');
                        // $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
                    }

                },'json');


            lstUniNull = false;
            // filtrosDatatable.push({
            //     column : 'dep_id_departamento',
            //     filter : frmF.selUniProcesoF.value
            // });
        }else if(frmF.selUniProcesoF.value == -1){
            targetUni = -1;
            $.post(BASE_URL + 'proceso/listar_by_departamento/' + frmF.selDepProcesoF.value, {param1: 'value1'}, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.length > 0){

                        $(frmF.selProcesoEtapaF).prop('disabled',false).html('');
                        $(frmF.selProcesoEtapaF).setDataSelect({values : data,id : 'pro_id', text : 'pro_nombre'},true);

                    }else{
                        $(frmF.selProcesoEtapaF).setDataSelect({values : [],id : 'pro_id', text : 'pro_nombre'},true);

                    }


            },'json');

            // $(frmF.selUniProcesoF).trigger('change');
            // $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
        }

        if(frmF.selProcesoEtapaF.value > 0 && frmF.selProcesoEtapaF.value != targetProceso){
            console.log('change proceso');
                  $.post(BASE_URL + 'proceso_etapa/listar_by_proceso/' + frmF.selProcesoEtapaF.value, {}, function(data, textStatus, xhr) {

                    var r = null;

                    console.log(data);
                    if(data.length > 0){
                        targetProceso = frmF.selProcesoEtapaF.value;
                        $(frmF.selEtapaActividadF).prop('disabled',false).html('');
                        var t = TEMPLATES.option;
                        t = Handlebars.compile(t);


                        $(frmF.selEtapaActividadF).append(t({id : -1, text : 'Todos'}));
                        for (var i = data.length - 1; i >= 0; i--) {

                            $(frmF.selEtapaActividadF).append(t({
                                id : data[i].pet_id,
                                text : data[i].pet_nombre
                            }))
                        }



                    }else{
                        targetProceso = -1;
                        $(frmF.selEtapaActividadF).prop('disabled',true).html('');
                    }

                },'json');


            lstUniNull = false;
            filtrosDatatable.push({
                column : 'pro_id_proceso',
                filter : frmF.selProcesoEtapaF.value
            });
        }else if(frmF.selProcesoEtapaF.value == -1){
            targetProceso = -1;
            $(frmF.selEtapaActividadF).prop('disabled',true).html('');
            // $(frmF.selProcesoEtapaF).trigger('change');
            // $(frmF.selProcesoEtapaF).prop('disabled',true).html('');
        }




        if(frmF.selEtapaActividadF.value > 0)
            filtrosDatatable.push({
                column : 'pet_id_procesos_etapa',
                filter : frmF.selEtapaActividadF.value});


        if(frmF.selEstadoActividadF.value >= 0)
            filtrosDatatable.push({
                column : 'pet_estado',
                filter : +frmF.selEstadoActividadF.value});

        if(frmF.txtNombreActividadF.value.trim() != '')
            filtrosDatatable.push({
                column : 'pet_nombre',
                filter : frmF.txtNombreActividadF.value});


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
        opc_editar.value_etapa = 0;
        opc_editar.is_edit = false;
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }

    function fnChangeDepartamento(e){
        // console.log('hol');
        if(this.value!=''){
            $(selProcesoEtapa).prop('disabled',true).html('');
            $.post(BASE_URL + 'proceso/listar_uni_by_dep/' + this.value, {}, function(data, textStatus, xhr) {
                var r = null;
                if(data.length > 0){

                    $(selUniProceso).prop('disabled',false).html('');

                    t = Handlebars.compile(TEMPLATES.option);
                    var fv = '';
                    for (var i = data.length - 1; i >= 0; i--) {
                        if(i == data.length -1 )
                            fv = data[i].idDepend;
                        $(selUniProceso).append(t({
                            id : data[i].idDepend,
                            text : data[i].desDepend
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
    function fnChangeProceso(e){
        console.log('hol');
        if(this.value!=''){
            $.post(BASE_URL + 'proceso_etapa/listar_by_procesos/' + this.value, {refid: this.value}, function(data, textStatus, xhr) {
            console.log(data);
                var r = null;
                if(data.length > 0){
                    $(selEtapaActividad).prop('disabled',false).html('');
                    var t = TEMPLATES.option;
                    t = Handlebars.compile(t);
                    for (var i = data.length - 1; i >= 0; i--) {
                        $(selEtapaActividad).append(t({
                            id : data[i].pet_id,
                            text : data[i].pet_nombre
                        }))
                    }

                    console.log(opc_editar);
                    if(opc_editar.is_edit){
                         $(selEtapaActividad).val(opc_editar.value_etapa).trigger('change');
                    }else{
                        $(selEtapaActividad).val('').trigger('change');
                    }
                }else{
                    $(selEtapaActividad).prop('disabled',true).html('');
                }
                if(is_editando){
                  opc_editar.is_edit = false;
                    opc_editar.value = 0;
                    opc_editar.value_proceso = 0;
                    opc_editar.value_etapa = 0;
                modRegistro.modal('show');
            }
            },'json').fail(fnFailAjax);

        }
    }


}
