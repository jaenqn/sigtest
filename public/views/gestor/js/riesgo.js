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
    var selProcesoEtapa = $('#selProcesoEtapa');

    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);


    var filtrosDatatable = [];
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
            url : BASE_URL + "riesgo/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "rie_nombre" },
            { data : "pel_nombre" },
            { data : "rie_estado", render : function(data,type,row){
                if(data == 1)
                    return 'Activo';
                else return 'Inactivo';
            } },
            { data : "rie_id",render:function(data, type, row){
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
        $(el.selPeligro).val('').trigger('change');
        $(el.chkEstadoRiesgo).iCheck('check');
        $(tituloModal).html('Agregar Riesgo');
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
                swal_option.confirm.title = 'Guardar Riesgo';
                swal_option.confirm.text = '¿Desea guardar los datos del Riesgo?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Riesgo';
                swal_option.confirm.text = '¿Desea guardar los cambios  del Riesgo?';
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
                    $.post(BASE_URL + 'riesgo/insertar', {
                        txtNombre : elem.txtNombreRiesgo.value,
                        txtIdPeligro : +elem.selPeligro.value,
                        txtEstado : elem.chkEstadoRiesgo.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            dtListar.draw();
                            modRegistro.modal('hide');
                            swal("Riesgo Registrada!",'', "success");
                            reset();
                        }
                    },'json').error(function(e){console.log(e.responseText)});
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'riesgo/actualizar', {
                        id : elem.txtId.value,
                        txtNombre : elem.txtNombreRiesgo.value,
                        txtIdPeligro : +elem.selPeligro.value,
                        txtEstado : elem.chkEstadoRiesgo.checked
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
          $.post(BASE_URL + 'riesgo/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;

                var frm = new Form('frmRegistro');
                var elem = frm.getElements();

                elem.txtNombreRiesgo.value = obj.rie_nombre;
                $(elem.selPeligro).val(obj.pel_id_peligros).trigger('change');

                obj.rie_estado == 1 ? $(elem.chkEstadoRiesgo).iCheck('check') : $(elem.chkEstadoRiesgo).iCheck('uncheck');
                elem.txtId.value = obj.rie_id;

                btnRegistrar.html('Guardar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                $(tituloModal).html('Modificar Riesgo');
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Riesgo",
            text: "¿Desea eliminar este Riesgo?",
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
            $.post(BASE_URL + 'riesgo/eliminar/' + id, {}, function(data, textStatus, xhr) {
                console.log(data);

                if(data.resultado == true){
                    swal("Eliminado!", "El Riesgo fue eliminado", "success");
                    dtListar.row($(element).toParent('tr')).remove().draw();
                }else{
                    swal("Cancelado!", "El Riesgo no se puede eliminar", "error");
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




        if(frmF.selPeligroF.value > 0)
            filtrosDatatable.push({
                column : 'pel_id_peligros',
                filter : frmF.selPeligroF.value});

        if(frmF.selEstadoRiesgoF.value >= 0)
            filtrosDatatable.push({
                column : 'rie_estado',
                filter : frmF.selEstadoRiesgoF.value});


        if(frmF.txtNombreRiesgoF.value.trim() != '')
            filtrosDatatable.push({
                column : 'rie_nombre',
                filter : frmF.txtNombreRiesgoF.value});


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
