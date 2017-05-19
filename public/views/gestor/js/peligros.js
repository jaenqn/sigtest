window.onload = fnLoad;
var dtListar;
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

    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);


    var filtrosDatatable = [];
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
            url : BASE_URL + "peligro/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "pel_nombre" },
            { data : "cat_nombre" },
            { data : "pel_estado", render : function(data,type,row){
                if(data == 1)
                    return 'Activo';
                else return 'Inactivo';
            } },
            { data : "pel_id",render:function(data, type, row){
                    var t = TEMPLATES.btn_acciones;
                    t = Handlebars.compile(t);
                    return t({id : data});

            } }

        ],


        columnDefs : [
            {
                targets : [ 3 ],
                orderable : false,
                width : '65px'

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        $(el.selDepProceso).val('').trigger('change');

        $(el.chkEstadoPeligro).iCheck('check');

        $(el.radTipoCategoria).each(function(e,v){
            $(v).iCheck('uncheck');
        });
        $(tituloModal).html('Agregar Peligro');
        frmRegistro.reset();

    }
    function fnAbrirModal(e){
        e.preventDefault();
        reset();
        $('#txtNombrePeligro').focus();
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
                swal_option.confirm.title = 'Guardar Peligro';
                swal_option.confirm.text = '¿Desea guardar los datos del Peligro?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Peligro';
                swal_option.confirm.text = '¿Desea guardar los cambios  del Peligro?';
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
                    $.post(BASE_URL + 'peligro/insertar', {
                        txtNombre : elem.txtNombrePeligro.value,
                        txtIdCategoria : +elem.selTipoCategoria.value,
                        txtEstado : elem.chkEstadoPeligro.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            dtListar.draw();
                            modRegistro.modal('hide');
                            swal("Peligro Registrado!",'', "success");
                            reset();
                        }
                    },'json').error(function(e){console.log(e.responseText)});
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'peligro/actualizar', {
                        id : elem.txtId.value,
                        txtNombre : elem.txtNombrePeligro.value,
                        txtIdCategoria : +elem.selTipoCategoria.value,
                        txtEstado : elem.chkEstadoPeligro.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
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
    var opc_editar = {is_edit : false, value : 0, value_proceso : 0,value_etapa : 0};
    function fnEditar(id)
    {

        console.log('editar');
          $.post(BASE_URL + 'peligro/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;

                var frm = new Form('frmRegistro');
                var elem = frm.getElements();

                elem.txtNombrePeligro.value = obj.pel_nombre;
                $(elem.selTipoCategoria).val(obj.cat_id_categoria).trigger('change');
                obj.pel_estado == 1 ? $(elem.chkEstadoPeligro).iCheck('check') : $(elem.chkEstadoPeligro).iCheck('uncheck');
                elem.txtId.value = obj.pel_id;

                btnRegistrar.html('Guardar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                $(tituloModal).html('Modificar Peligro');
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Peligro",
            text: "¿Desea eliminar este Peligro?",
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
            $.post(BASE_URL + 'peligro/eliminar/' + id, {}, function(data, textStatus, xhr) {

                if(data.resultado == true){
                    swal("Eliminado!", "El Peligro fue eliminado", "success");
                    dtListar.row($(element).toParent('tr')).remove().draw();
                }else{
                    swal("Cancelado!", "El Peligro no se puede eliminar", "error");
                }

            },'json').fail(fnFailAjax);
          }
        });
        // $.post(BASE_URL + 'usuario/eliminar/' + id, {}, function(data, textStatus, xhr) {
        //     if(data.resultado)
        //         dtListar.row($(element).toParent('tr')).remove().draw();
        // },'json').fail(fnFailAjax);
    }



    function fnBuscar(e){
        // console.log(this.value);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();




        if(frmF.selTipoCategoriaF.value > 0)
            filtrosDatatable.push({
                column : 'cat_id_categoria',
                filter : frmF.selTipoCategoriaF.value});

        if(frmF.selEstadoPeligroF.value >= 0)
            filtrosDatatable.push({
                column : 'pel_estado',
                filter : +frmF.selEstadoPeligroF.value});


        if(frmF.txtNombrePeligroF.value.trim() != '')
            filtrosDatatable.push({
                column : 'pel_nombre',
                filter : frmF.txtNombrePeligroF.value});


        dtListar.draw();

    }

    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);

    function fnCancelar(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }




}
