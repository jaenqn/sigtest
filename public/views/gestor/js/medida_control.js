window.onload = fnLoad;

var mc = {};
var filtrosDatatable;
function fnLoad(){
    validator.message.date = 'not a real date';
    mc.elementsFilter = getById('frmFiltrar').elements;
    mc.btnNuevo = $('#btnNuevo');
    mc.btnRegistrar = $('#btnRegistrar');
    mc.tblListar = $('#tblListar');
    mc.modRegistro = $('#modRegistro').on('hide.bs.modal', fnHideModalReg);
    mc.btnCancelar = $('#btnCancelar');
    mc.frmRegistro = $('#frmRegistro');

    mc.tituloModal = $('#tituloModal');

    mc.btnNuevo.on('click',fnAbrirModal);
    mc.btnRegistrar.on('click',fnRegistrar);
    mc.btnCancelar.on('click',fnCancelar);
    mc.tblListar.on('click','.btnAcciones',fnAccionesItemTabla);


    filtrosDatatable = [];
    mc.dtListar = mc.tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false,
        serverSide : true,
        order : [0,'asc'],
        ajax : {
            url : BASE_URL + "medida_control/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "mco_nombre" },
            { data : "jmc_nombre" },
            { data : "mco_tipo", render : function(data,type,row){
                if(data == 1)
                    return 'Riesgos';
                else return 'Impactos Ambientales';

            }},
            { data : "mco_estado", render : function(data,type,row){
                if(data == 1)
                    return 'Activo';
                else return 'Inactivo';
            }},
            { data : "mco_id",render:function(data, type, row){
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
    function fnHideModalReg(){
        mc.frmRegistro
    };
    function reset(){
        var frm = getById('frmRegistro');
        var ele = frm.elements;
        ele.txtNombreMedida.value = '';
        $(ele.selJerarquia).val(1).trigger('change');
        $('.radTipoMedida').eq(0).iCheck('check');
        $(ele.chkEstadoMedida).iCheck('check');
        $('#tituloModal').html('Agregar Medida de Control');


    }
    function fnAbrirModal(e){
        e.preventDefault();
        reset();
        mc.btnRegistrar.html('Guardar');
        mc.btnRegistrar.get(0).dataset.accion = 'guardar';
        mc.modRegistro.modal('show');
    }
    mc.frmRegistro.submit(function(e){
        e.preventDefault();
        var tempaccion = mc.btnRegistrar[0].dataset.accion;
        switch(tempaccion){
            case 'guardar':
                swal_option.confirm.title = 'Guardar Medida de Control';
                swal_option.confirm.text = '¿Desea guardar los datos de la Medida de Control?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Medida de Control';
                swal_option.confirm.text = '¿Desea guardar los cambios  de la Medida de Control?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;

        }

        swal(swal_option.confirm,
        function(isConfirm){
          if (isConfirm) {
            switch(tempaccion){
                case 'guardar':
                    console.log('registrar');
                    $.post(BASE_URL + 'medida_control/insertar', mc.frmRegistro.serializeArray(), function(data, textStatus, xhr) {
                        if(data.resultado){
                            mc.dtListar.draw();
                            mc.modRegistro.modal('hide');
                            swal("Datos Registrados!",'', "success");
                            reset();
                        }
                    },'json').fail(fnFailAjax);
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'medida_control/actualizar', mc.frmRegistro.serializeArray(), function(data, textStatus, xhr) {
                        if(data.resultado){
                            mc.dtListar.draw();
                            mc.modRegistro.modal('hide');
                            reset();
                            swal("Datos Actualizados!",'', "success");
                            mc.btnRegistrar.html('Guardar');
                            mc.btnRegistrar.get(0).dataset.accion = 'guardar';

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
          $.post(BASE_URL + 'medida_control/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;
                var elemReg = mc.frmRegistro[0].elements;

                elemReg.txtNombreMedida.value = obj.mco_nombre;
                $(elemReg.selJerarquia).val(obj.mco_jerarquia).trigger('change');
                elemReg.radTipo.forEach(function(e,i){
                    if(+e.value == +obj.mco_tipo)
                        $(e).iCheck('check');
                });
                obj.mco_estado == 1 ? $(elemReg.chkEstadoMedida).iCheck('check') : $(elemReg.chkEstadoMedida).iCheck('uncheck');
                elemReg.txtId.value = obj.mco_id;

                mc.btnRegistrar.html('Guardar');
                mc.btnRegistrar.get(0).dataset.accion = 'actualizar';
                $(tituloModal).html('Modificar Impacto Ambiental');
                 mc.modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Medida de Control",
            text: "¿Desea eliminar esta Medida de Control?",
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
            $.post(BASE_URL + 'medida_control/eliminar/' + id, {}, function(data, textStatus, xhr) {

                if(data.resultado == true){
                    swal("Eliminado!", "Medida de Control  eliminado", "success");
                    mc.dtListar.page(mc.dtListar.page()).draw('page');
                }else{
                    swal("Cancelado!", "La Medida de Control no se puede eliminar", "error");
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




        if(frmF.selJerarquiF.value > 0)
            filtrosDatatable.push({
                column : 'mco_jerarquia',
                filter : frmF.selJerarquiF.value});

        if(frmF.selEstadoMedidaF.value >= 0)
            filtrosDatatable.push({
                column : 'mco_estado',
                filter : +frmF.selEstadoMedidaF.value});


        if(frmF.txtNombreMedidaF.value.trim() != '')
            filtrosDatatable.push({
                column : 'mco_nombre',
                filter : frmF.txtNombreMedidaF.value});


        mc.dtListar.draw();

    }

    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);

    function fnCancelar(e){
        e.preventDefault();
        reset();
        mc.btnRegistrar.html('Guardar');
        mc.btnRegistrar.get(0).dataset.accion = 'guardar';

    }




}
