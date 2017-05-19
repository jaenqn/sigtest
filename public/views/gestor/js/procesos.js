window.onload = fnLoad;
function fnLoad(){
    validator.message.date = 'not a real date';

    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var btnCancelar = $('#btnCancelar');
    var selDepProceso = $('#selDepProceso');
    var selUniProceso = $('#selUniProceso');

    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    selDepProceso.on('change',fnChangeDepartamento);

    var filtrosDatatable = [];
    filtrosDatatable = [
        {column : 'dep_id_departamento',    filter : -1},
        {column : 'uni_id_unidad',          filter : -1},
        {column : 'pro_estado',             filter : -1},
        {column : 'pro_nombre',             filter : ''}
    ]
    var dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false,
        serverSide : true,
        order : [0,'asc'],
        ajax : {
            url : BASE_URL + "proceso/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        createdRow : function ( row, data, index ) {
            if(data.rso_es_otro == 0)
                $(row).addClass('tr-otro-origen');
        },
        columns: [
            { data : "pro_nombre" },
            { data : "dep_nombre" },
            { data : "uni_nombre" },
            { data : "pro_estado", render : function(data,type,row){
                if(data == 1)
                    return 'Activo';
                else return 'Inactivo';
            } },
            { data : "pro_id",render:function(data, type, row){
                    var t = TEMPLATES.btn_acciones;
                    t = Handlebars.compile(t);
                    return t({id : data});

            } }

        ],


        columnDefs : [
            {
                targets : [ 4 ],
                orderable : false,
                width : '66px'

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        $(el.selDepProceso).val('').trigger('change');
        $(el.selUniProceso).html('').trigger('change');
        $(el.selUniProceso).prop('disabled',true);
        $(el.chkEstadoProceso).iCheck('check');
        $(tituloModal).html('Agregar Proceso');
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
                swal_option.confirm.title = 'Guardar Proceso';
                swal_option.confirm.text = '¿Desea guardar los datos del  Proceso?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Proceso';
                swal_option.confirm.text = '¿Desea guardar los cambios  del  Proceso?';
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
                    $.post(BASE_URL + 'proceso/insertar', {
                        txtNombre : elem.txtNombreProceso.value,
                        txtIdUnidad : elem.selUniProceso.value,
                        txtEstado : elem.chkEstadoProceso.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            dtListar.draw();
                            modRegistro.modal('hide');
                            swal("Proceso Registrado!",'', "success");
                            reset();
                        }
                    },'json').error(function(e){console.log(e.responseText)});
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'proceso/actualizar', {
                        id : elem.txtId.value,
                        txtNombre : elem.txtNombreProceso.value,
                        txtIdUnidad : elem.selUniProceso.value,
                        txtEstado : elem.chkEstadoProceso.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            opc_editar.value = 0;
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
        // switch(this.dataset.accion){
        //     case 'guardar':
        //         console.log('registrar');
        //         $.post(BASE_URL + 'proceso/insertar', {
        //             txtNombre : elem.txtNombreProceso.value,
        //             txtIdUnidad : elem.selUniProceso.value,
        //             txtEstado : elem.chkEstadoProceso.checked
        //         }, function(data, textStatus, xhr) {

        //             if(data.resultado){
        //                 dtListar.draw();
        //                 modRegistro.modal('hide');
        //                 swal("Proceso Registrado!",'', "success");
        //                 reset();
        //             }
        //         },'json').error(function(e){console.log(e.responseText)});
        //         break;
        //     case 'actualizar':
        //         console.log('actualizar');
        //         $.post(BASE_URL + 'proceso/actualizar', {
        //             id : elem.txtId.value,
        //             txtNombre : elem.txtNombreProceso.value,
        //             txtIdUnidad : elem.selUniProceso.value,
        //             txtEstado : elem.chkEstadoProceso.checked
        //         }, function(data, textStatus, xhr) {

        //             if(data.resultado){
        //                 opc_editar.value = 0;
        //                 opc_editar.is_edit = false;
        //                 dtListar.draw();
        //                 modRegistro.modal('hide');
        //                 reset();
        //                 swal("Datos Actualizados!",'', "success");
        //                 btnRegistrar.html('Guardar');
        //                 btnRegistrar.get(0).dataset.accion = 'guardar';

        //             }
        //         },'json').fail(fnFailAjax);
        //         break;
        // }
         // this.submit();
    })
    function fnRegistrar(e)
    {
        console.log('a');
        // validator.checkAll($(this))
        // e.preventDefault();
        // var frmRegistro = new Form('frmRegistro');
        // $('#frmRegistro').submit();
        // var elem = frmRegistro.getElements();

        // switch(this.dataset.accion){
        //     case 'guardar':
        //         console.log('registrar');
        //         $.post(BASE_URL + 'usuario/insertar', {
        //             txtNombre : elem.txtNombreUsuario.value,
        //             txtCargo : elem.txtCargoUsuario.value,
        //             txtFicha : elem.txtFichaUsuario.value,
        //             txtIdUnidad : elem.selUniProceso.value,
        //             txtUsuario : elem.txtCuentaUsuario.value,
        //             txtPass : elem.txtPassUsuario.value,
        //             txtTipoUsuario : elem.selTipoUsuario.value,
        //             txtEstado : elem.chkEstadoUsuario.checked
        //         }, function(data, textStatus, xhr) {

        //             if(data.resultado){
        //                 dtListar.draw();
        //                 modRegistro.modal('hide');
        //                 swal("Usuario Registrado!",'', "success");
        //                 reset();
        //             }
        //         },'json').error(function(e){console.log(e.responseText)});
        //         break;
        //     case 'actualizar':
        //         console.log('actualizar');
        //         $.post(BASE_URL + 'usuario/actualizar', {
        //             id : elem.txtId.value,
        //             txtNombre : elem.txtNombreUsuario.value,
        //             txtCargo : elem.txtCargoUsuario.value,
        //             txtFicha : elem.txtFichaUsuario.value,
        //             txtIdUnidad : elem.selUniProceso.value,
        //             txtUsuario : elem.txtCuentaUsuario.value,
        //             txtPass : elem.txtPassUsuario.value,
        //             txtTipoUsuario : elem.selTipoUsuario.value,
        //             txtEstado : elem.chkEstadoUsuario.checked
        //         }, function(data, textStatus, xhr) {

        //             if(data.resultado){
        //                 opc_editar.value = 0;
        //                 opc_editar.is_edit = false;
        //                 dtListar.draw();
        //                 modRegistro.modal('hide');
        //                 reset();
        //                 swal("Datos Actualizados!",'', "success");
        //                 btnRegistrar.html('Guardar');
        //                 btnRegistrar.get(0).dataset.accion = 'guardar';

        //             }
        //         },'json').fail(fnFailAjax);
        //         break;
        // }
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
    var opc_editar = {is_edit : false, value : 0};
    function fnEditar(id)
    {

        console.log('editar');
          $.post(BASE_URL + 'proceso/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.resObj;

                opc_editar.is_edit = true;
                opc_editar.value = obj.idDepend;

                var frm = new Form('frmRegistro');
                var elem = frm.getElements();

                elem.txtNombreProceso.value = obj.pro_nombre;
                // elem.selUniProceso.value = obj[4];
                // elem.selTipoUsuario.value = obj[7];
                // $(elem.selDepProceso).val(obj[11]).trigger('change');
                +obj.pro_estado == 1 ? $(elem.chkEstadoProceso).iCheck('check') : $(elem.chkEstadoProceso).iCheck('uncheck');

                $(elem.selDepProceso).val(obj.reportaDpend).trigger('change');
                // $(elem.selUniProceso).val(obj[4]).trigger('change');
                elem.txtId.value = obj.pro_id;

                btnRegistrar.html('Guardar');

                btnRegistrar.get(0).dataset.accion = 'actualizar';
                $(tituloModal).html('Modificar Proceso');
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Proceso",
            text: "¿Desea eliminar este Proceso?",
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
            $.post(BASE_URL + 'proceso/eliminar/' + id, {}, function(data, textStatus, xhr) {

                if(data.resultado){
                    swal("Eliminado!", "El Proceso fue eliminado", "success");
                    dtListar.page(dtListar.page()).draw('page');
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
    function fnChangeDepF(iddep,selDep,selUni){
        if(iddep != -1){

            $.post(BASE_URL + 'unidad/listar_by_dep/' + iddep, {}, function(data, textStatus, xhr) {

                var r = null;

                console.log(data);
                if(data.length > 0){
                    targetDep = selDep.value;
                    $(selUni).prop('disabled',false).html('');
                    var t = TEMPLATES.option;
                    t = Handlebars.compile(t);


                    $(selUni).append(t({id : -1, text : 'Todos'}));
                    for (var i = data.length - 1; i >= 0; i--) {

                        $(selUni).append(t({
                            id : data[i].uni_id,
                            text : data[i].uni_nombre
                        }))
                    }



                }else{
                    console.log('todo!');
                    targetDep = -1;
                    $(selUni).prop('disabled',true).html('');
                }

            },'json');
            filtrosDatatable[0].filter = iddep;
        }else{
            $(selUni).prop('disabled', true);
            $(selUni).html('');
            filtrosDatatable[0].filter = -1;
        }
        filtrosDatatable[1].filter = -1;

    }
    function fnBuscarDos(e){
        e.preventDefault();
        var frmF = new Form('frmFiltrar').getElements();

        switch(this.id){
            case 'txtNombreProcesoF':
                    filtrosDatatable[3].filter = this.value.trim();
                break;
            case 'selEstadoProcesoF':
                filtrosDatatable[2].filter = this.value;
                break;
            case 'selDepProcesoF':
                fnChangeDepF(this.value, frmF.selDepProcesoF, frmF.selUniProcesoF);
                break;
            case 'selUniProcesoF':
                filtrosDatatable[1].filter = this.value;
                break;
        }
        dtListar.draw();
    }
    function fnBuscar(e){
        // console.log(this.value);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();
        console.log(targetDep);
        console.log(frmF.selDepProcesoF.value);

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
                        console.log('todo!');
                        targetDep = -1;
                        $(frmF.selUniProcesoF).prop('disabled',true).html('');
                    }

                },'json');


            lstUniNull = false;
            filtrosDatatable.push({
                column : 'dep_id_departamento',
                filter : frmF.selDepProcesoF.value
            });
        }else if(frmF.selDepProcesoF.value == -1){
            targetDep = -1;
            // $(frmF.selUniProcesoF).trigger('change');
            $(frmF.selUniProcesoF).prop('disabled',true).html('');
        }


        if(frmF.selUniProcesoF.value > 0)
            filtrosDatatable.push({
                column : 'uni_id_unidad',
                filter : frmF.selUniProcesoF.value});


        if(frmF.selEstadoProcesoF.value >= 0)
            filtrosDatatable.push({
                column : 'pro_estado',
                filter : +frmF.selEstadoProcesoF.value});

        if(frmF.txtNombreProcesoF.value.trim() != '')
            filtrosDatatable.push({
                column : 'pro_nombre',
                filter : frmF.txtNombreProcesoF.value});


        dtListar.draw();

    }

    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscarDos).
    on('keyup','input[type="text"].input-filter',fnBuscarDos);

    function fnCancelar(e){
        e.preventDefault();
        reset();
        opc_editar.value = 0;
        opc_editar.is_edit = false;
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }

    function fnChangeDepartamento(e){
        // console.log('hol');
        if(this.value!=''){
            $.post(BASE_URL + 'unidad/listar_by_dep/' + this.value, {}, function(data, textStatus, xhr) {
                var r = null;
                if(data.length > 0){
                    $(selUniProceso).prop('disabled',false).html('');
                    var t = TEMPLATES.option;
                    t = Handlebars.compile(t);
                    for (var i = data.length - 1; i >= 0; i--) {
                        $(selUniProceso).append(t({
                            id : data[i].uni_id,
                            text : data[i].uni_nombre
                        }))
                    }
                    if(opc_editar.is_edit){
                         $(selUniProceso).val(opc_editar.value).trigger('change');
                    }
                }else{
                    $(selUniProceso).prop('disabled',true).html('');
                }

            },'json');
        }

    }



}
