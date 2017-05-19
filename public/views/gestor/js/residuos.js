window.onload = fnLoad;
var dtListar;
var temp_serialize;
$(document).ready(function() {

});
function fnLoad(){
    moment().locale('es');

    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var frmFiltrar = $('#frmFiltrar');
    var btnCancelar = $('#btnCancelar');
    // var option-residuo = $('.option-residuo');

    var selDepartamentoOrigen = $('#selDepartamentoOrigen');

    var selUnidadOrigen = $('#selUnidadOrigen');



    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    selDepartamentoOrigen.on('change',fnChangeDepartamento);
    var filtrosDatatable = [];
    var filtrosDatatableDos = {peligro : -1,organico : -1,estado : -1};
    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [0,'asc'], //Initial no order.
        ajax : {
            url : BASE_URL + "residuo/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
                d.filtersDos = filtrosDatatableDos;

            },
            error : function(e){console.log(e.responseText);}
        },
        createdRow : function ( row, data, index ) {
            if(data.res_es_otro == 0)
                $(row).addClass('tr-otro-origen');
        },
        columns: [
            { data : "res_nombre" },
            { data : "res_peligro" , render : function(data, type, row){
                if(data == 1)
                    return 'Sí';
                else return 'No';
            }},
            { data : "res_organico", render : function(d, t ,r){
                if(d == 1) return 'Sí';
                else return 'No';
            } },
            { data : "get_estado" },
            { data : "res_id",render:function(data, type, row){
                // console.log(row);
                // console.log(type);
                // console.log(row);
                if(row.res_es_otro == 0){
                    var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnAgregarOtro" data-accion="agregar-otro">agregar</a>';
                    t = Handlebars.compile(t);
                    return t({id : data});
                }else{
                    var t = TEMPLATES.btn_acciones;
                    // var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a>/<a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';
                    t = Handlebars.compile(t);
                    return t({id : data});
                }

            } }

        ],


        columnDefs : [
            {
                targets : [ 4 ],
                orderable : false,

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        $(el.radResEstado).iCheck('uncheck');
        $(el.radResOrganico).iCheck('uncheck');
        $(el.radResPeligroso).iCheck('uncheck');
        // $(el.selDepartamentoOrigen).val('').trigger('change');
        // $(el.selUnidadOrigen).html('').trigger('change');

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

        var opcs_swal = swal_option;
        var pross_continue = true;
        switch(this.dataset.accion){
            case 'guardar':
                opcs_swal.confirm.title = 'Guardar Residuo';
                opcs_swal.confirm.text = '¿Desea guardar los datos del Residuo?';
                opcs_swal.confirm.type = 'warning';
                opcs_swal.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                if(temp_serialize == $(frmRegistro.getNode()).serialize())
                    pross_continue = false;
                opcs_swal.confirm.title = 'Actualizar  Residuo';
                opcs_swal.confirm.text = '¿Desea guardar los cambios  del Residuo?';
                opcs_swal.confirm.type = 'warning';
                opcs_swal.confirm.closeOnCancel = true;
                break;

        }
        var self = this;
        if(pross_continue){
            swal(swal_option.confirm,
            function(isConfirm){
              if (isConfirm) {
                switch(self.dataset.accion){
                    case 'guardar':
                        console.log('registrar');
                        $.post(BASE_URL + 'residuo/insertar', {
                            txtNombre : elem.txtNombreResiduo.value,
                            txtTipoPeligro : elem.radResPeligroso.value,
                            txtTipoEstado : elem.radResEstado.value,
                            txtTipoOrganico : elem.radResOrganico.value,
                            txtEstadoOtro : 1
                        }, function(data, textStatus, xhr) {

                            if(data.resultado){
                                swal("Residuo Registrado!",'', "success");
                                dtListar.draw();
                                reset();
                                modRegistro.modal('hide');
                            }
                        },'json').error(function(e){console.log(e.responseText)});
                        break;
                    case 'actualizar':
                        console.log('actualizar');
                        $.post(BASE_URL + 'residuo/actualizar', {
                            id : elem.txtId.value,
                            txtNombre : elem.txtNombreResiduo.value,
                            txtTipoPeligro : elem.radResPeligroso.value,
                            txtTipoEstado : elem.radResEstado.value,
                            txtTipoOrganico : elem.radResOrganico.value
                        }, function(data, textStatus, xhr) {
                            console.log(data);
                            if(data.resultado){
                                opc_editar.value = 0;
                                opc_editar.is_edit = false;
                                dtListar.page(dtListar.page()).draw('page');
                                swal("Datos Actualiazados!",'', "success");
                                reset();
                                btnRegistrar.html('Guardar');
                                btnRegistrar.get(0).dataset.accion = 'guardar';
                                modRegistro.modal('hide');
                            }else{
                                swal("No se efectuaron cambios!",'', "warning");
                            }
                        },'json').fail(fnFailAjax);
                        break;
                }
              }
            });
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
          $.post(BASE_URL + 'residuo/data/' + id, {}, function(data, textStatus, xhr) {

            if(data.resultado){

                var obj = data.objRes;
                // opc_editar.is_edit = true;
                // opc_editar.value = obj.uni_id_unidad;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombreResiduo.value = obj.res_nombre;

                $(ele.radResPeligroso).each(function(e,v){
                    if(v.value == obj.res_peligro)
                        $(v).iCheck('check');
                });
                $(ele.radResOrganico).each(function(e,v){
                    if(v.value == obj.res_organico)
                        $(v).iCheck('check');
                });
                $(ele.radResEstado).each(function(e,v){
                    if(v.value == obj.res_estado)
                        $(v).iCheck('check');
                });
                // $(ele.selDepartamentoOrigen).val(obj.dep_id_departamento).trigger('change');

                ele.txtId.value = id;

                temp_serialize = $(frm.getNode()).serialize();
                btnRegistrar.html('Actualizar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnAgregarOtro(id)
    {

        console.log('agregar-otro');
          $.post(BASE_URL + 'residuo/data/' + id, {}, function(data, textStatus, xhr) {

            if(data.resultado){

                var obj = data.objRes;
                // opc_editar.is_edit = true;
                // opc_editar.value = obj.uni_id_unidad;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();


                ele.txtNombreResiduo.value = obj.res_nombre;
                $(ele.radResPeligroso).each(function(e,v){
                    if(v.value == obj.res_peligro)
                        $(v).iCheck('check');
                });
                $(ele.radResOrganico).each(function(e,v){
                    if(v.value == obj.res_organico)
                        $(v).iCheck('check');
                });
                $(ele.radResEstado).each(function(e,v){
                    if(v.value == obj.res_estado)
                        $(v).iCheck('check');
                });

                ele.txtId.value = id;

                btnRegistrar.html('Agregar');
                btnRegistrar.get(0).dataset.accion = 'agregar-otro';
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar');
        var opcs_swal = swal_option;
        opcs_swal.confirm.title = 'Eliminar Residuo';
        opcs_swal.confirm.text = '¿Desea eliminar el Residuo?';
        opcs_swal.confirm.type = 'warning';
        opcs_swal.confirm.closeOnCancel = true;

        swal(swal_option.confirm,
        function(isConfirm){
            $.post(BASE_URL + 'residuo/eliminar/' + id, {}, function(data, textStatus, xhr) {
                if(data.resultado){
                    swal("Residuo Eliminado!",'', "success");
                    // $(element).parents('tr').remove();
                    dtListar.page(dtListar.page()).draw('page');
                    // dtListar.row($(element).parents('tr')).remove().draw();
                }
            },'json').fail(fnFailAjax);
        });


    }

    var lstUniNull = true;
    var targetDep = -1;
    function fnBuscar(e){
        console.log(this);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();




        if(frmF.txtNombreResF.value.trim() != '')
            filtrosDatatable.push({
                column : 'res_nombre',
                filter : frmF.txtNombreResF.value});


        dtListar.draw();

    }

    $('#frmFiltrar').
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

            },'json');
        }
    }
    $('[name="radResPeligrosoF"]').on('ifChecked', function(event){
        filtrosDatatableDos.peligro = this.value;
               dtListar.draw();
    });
    $('[name="radResOrganicoF"]').on('ifChecked', function(event){
        filtrosDatatableDos.organico = this.value;
               dtListar.draw();
    });
    $('[name="radResEstadoF"]').on('ifChecked', function(event){
        filtrosDatatableDos.estado = this.value;
               dtListar.draw();
    });



}
