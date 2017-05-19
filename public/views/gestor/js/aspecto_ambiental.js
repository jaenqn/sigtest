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
            url : BASE_URL + "aspecto_ambiental/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "asp_nombre" },
            { data : "cat_nombre" },
            { data : "asp_estado", render : function(data,type,row){
                if(data == 1)
                    return 'Activo';
                else return 'Inactivo';
            } },
            { data : "asp_id",render:function(data, type, row){
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
        $(el.selTipoCategoria).val('').trigger('change');
        $(el.chkEstadoAspecto).iCheck('check');
        $(tituloModal).html('Agregar Aspecto Ambiental');
        frmRegistro.reset();

    }
    function fnAbrirModal(e){
        e.preventDefault();
        reset();
        $('#txtNombreAspecto').focus();
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
                swal_option.confirm.title = 'Guardar Aspecto Ambiental';
                swal_option.confirm.text = '¿Desea guardar los datos del Aspecto Ambiental?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Aspecto Ambiental';
                swal_option.confirm.text = '¿Desea guardar los cambios  del Aspecto Ambiental?';
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
                    $.post(BASE_URL + 'aspecto_ambiental/insertar', {
                        txtNombre : elem.txtNombreAspecto.value,
                        txtIdCategoria : +elem.selTipoCategoria.value,
                        txtEstado : elem.chkEstadoAspecto.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            dtListar.draw();
                            modRegistro.modal('hide');
                            swal("Aspecto Ambiental Registrado!",'', "success");
                            reset();
                        }
                    },'json').error(function(e){console.log(e.responseText)});
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'aspecto_ambiental/actualizar', {
                        id : elem.txtId.value,
                        txtNombre : elem.txtNombreAspecto.value,
                        txtIdCategoria : +elem.selTipoCategoria.value,
                        txtEstado : elem.chkEstadoAspecto.checked
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
          $.post(BASE_URL + 'aspecto_ambiental/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;

                var frm = new Form('frmRegistro');
                var elem = frm.getElements();

                elem.txtNombreAspecto.value = obj.asp_nombre;
                $(elem.selTipoCategoria).val(obj.cat_id_categoria).trigger('change');
                obj.asp_estado == 1 ? $(elem.chkEstadoAspecto).iCheck('check') : $(elem.chkEstadoAspecto).iCheck('uncheck');
                elem.txtId.value = obj.asp_id;

                btnRegistrar.html('Guardar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                $(tituloModal).html('Modificar Aspecto Ambiental');
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Aspecto Ambiental",
            text: "¿Desea eliminar este Aspecto Ambiental?",
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
            $.post(BASE_URL + 'aspecto_ambiental/eliminar/' + id, {}, function(data, textStatus, xhr) {

                if(data.resultado == true){
                    swal("Eliminado!", "El Aspecto Ambiental fue eliminado", "success");
                    dtListar.row($(element).toParent('tr')).remove().draw();
                }else{
                    swal("Cancelado!", "El Aspecto Ambiental no se puede eliminar", "error");
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

        if(frmF.selEstadoAspectoF.value >= 0)
            filtrosDatatable.push({
                column : 'asp_estado',
                filter : +frmF.selEstadoAspectoF.value});


        if(frmF.txtNombreAspectoF.value.trim() != '')
            filtrosDatatable.push({
                column : 'asp_nombre',
                filter : frmF.txtNombreAspectoF.value});


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
