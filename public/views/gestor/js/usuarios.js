window.onload = fnLoad;
var dtListar;
function fnLoad(){
    getById('menu_toggle').click();
    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var btnCancelar = $('#btnCancelar');
    var selDepUsuario = $('#selDepUsuario');
    var selUniUsuario = $('#selUniUsuario');
    $('#chkEstadoUsuario').iCheck('check');
    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    selDepUsuario.on('change',fnChangeDepartamento);
    var txtCuentaUsuario = $('#txtCuentaUsuario');
    txtCuentaUsuario.on('keyup',function(e){
        $.post(BASE_URL + 'usuario/validar_usuario', {txtUsuario: this.value, txtIdUsu : getById('txtId').value}, function(data, textStatus, xhr) {
            if(data.resultado)
                $('#erroUsuario').removeClass('hidden')
            else
                $('#erroUsuario').addClass('hidden')

        },'json').fail(fnFailAjax);
    })

    var filtrosDatatable = [];
    if(noadmin){
        filtrosDatatable.push({
                column : 'dep_id_departamento',
                filter : predata[0]
        });
        filtrosDatatable.push({
                column : 'uni_id_unidad',
                filter : predata[1]
        });
    }
    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltp',
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [0,'asc'], //Initial no order.
        ajax : {
            url : BASE_URL + "usuario/datatables_list",
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
            { data : "usu_nombre", render : function(d, t, r){
                return d + (is.null(r.usu_apellidos) ? '' : r.usu_apellidos);
            }},
            { data : "usu_cargo" },
            { data : "usu_ficha" },
            { data : "uni_nombre" },
            { data : "dep_nombre" },
            { data : "usu_usuario" },
            { data : "get_tipo_usuario" },
            { data : "get_estado" },
            { data : "usu_id",render:function(data, type, row){
                // console.log(row);
                // console.log(type);
                // console.log(row);
                // if(row.rso_es_otro == 0){
                //     var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnAgregarOtro" data-accion="agregar-otro">agregar</a>';
                //     t = Handlebars.compile(t);
                //     return t({id : data});
                // }else{
                    var t = TEMPLATES.btn_acciones;
                    t = Handlebars.compile(t);
                    return t({id : data});
                // }

            } }

        ],


        columnDefs : [
            {
                targets : [ 8 ],
                orderable : false,
                width: '66px'

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        if(!noadmin){
            $(el.selDepUsuario).val('').trigger('change');
            $(el.selUniUsuario).html('').trigger('change');
        }
        $(el.chkEstadoUsuario).iCheck('check');
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
                $.post(BASE_URL + 'usuario/insertar', {
                    txtNombre : elem.txtNombreUsuario.value,
                    txtApellidos : elem.txtApellidosUsuario.value,
                    txtDNI : elem.txtDniUsuario.value,
                    txtCargo : elem.txtCargoUsuario.value,
                    txtFicha : elem.txtFichaUsuario.value,
                    txtIdUnidad : elem.selUniUsuario.value,
                    txtUsuario : elem.txtCuentaUsuario.value,
                    txtPass : elem.txtPassUsuario.value,
                    txtTipoUsuario : elem.selTipoUsuario.value,
                    txtEstado : elem.chkEstadoUsuario.checked
                }, function(data, textStatus, xhr) {

                    if(data.resultado){
                        dtListar.draw();
                        modRegistro.modal('hide');
                        swal("Usuario Registrado!",'', "success");
                        reset();
                    }
                },'json').error(function(e){console.log(e.responseText)});
                break;
            case 'actualizar':
                console.log('actualizar');
                $.post(BASE_URL + 'usuario/actualizar', {
                    id : elem.txtId.value,
                    txtNombre : elem.txtNombreUsuario.value,
                    txtApellidos : elem.txtApellidosUsuario.value,
                    txtDNI : elem.txtDniUsuario.value,
                    txtCargo : elem.txtCargoUsuario.value,
                    txtFicha : elem.txtFichaUsuario.value,
                    txtIdUnidad : elem.selUniUsuario.value,
                    txtUsuario : elem.txtCuentaUsuario.value,
                    txtPass : elem.txtPassUsuario.value,
                    txtTipoUsuario : elem.selTipoUsuario.value,
                    txtEstado : elem.chkEstadoUsuario.checked
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
          $.post(BASE_URL + 'usuario/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.resultado){

                var obj = data.objRes;
                opc_editar.is_edit = true;
                opc_editar.value = obj.uni_id_unidad;
                var frm = new Form('frmRegistro');
                frm.reset();
                var elem = frm.getElements();

                elem.txtNombreUsuario.value = obj.usu_nombre;
                elem.txtApellidosUsuario.value = obj.usu_apellidos;
                elem.txtDniUsuario.value = obj.usu_dni;
                elem.txtCargoUsuario.value = obj.usu_cargo;
                elem.txtFichaUsuario.value = obj.usu_ficha;
                // elem.selUniUsuario.value = obj[4];


                elem.txtCuentaUsuario.value = obj.usu_usuario;
                elem.txtPassUsuario.value = '';
                // elem.selTipoUsuario.value = obj[7];
                $(elem.selTipoUsuario).val(obj.usu_tipo_usuario).trigger('change');
                obj.usu_estado == 1 ? $(elem.chkEstadoUsuario).iCheck('check') : $(elem.chkEstadoUsuario).iCheck('uncheck');

                if(!noadmin)
                    $(elem.selDepUsuario).val(obj.dep_id_departamento).trigger('change');
                // $(elem.selUniUsuario).val(obj[4]).trigger('change');
                elem.txtId.value = id;


                btnRegistrar.html('Guardar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                 modRegistro.modal('show');
            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Usuario",
            text: "¿Desea eliminar este usuario?",
            type: "warning",
            showCancelButton: true,
            animation: "slide-from-top",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Sí, Eliminar!",
            cancelButtonText: "No, Cancelar!",
            closeOnConfirm: false,
            closeOnCancel: false,
            showLoaderOnConfirm: true
        },
        function(isConfirm){
          if (isConfirm) {
            $.post(BASE_URL + 'usuario/eliminar/' + id, {}, function(data, textStatus, xhr) {

                if(data.resultado){
                    swal("Eliminado!", "El usuario fue eliminado", "success");
                    dtListar.row($(element).toParent('tr')).remove().draw();
                }
            },'json').fail(fnFailAjax);
          } else {
            swal("Cancelado", "El usuario no será eliminado", "error");
          }
        });
        // $.post(BASE_URL + 'usuario/eliminar/' + id, {}, function(data, textStatus, xhr) {
        //     if(data.resultado)
        //         dtListar.row($(element).toParent('tr')).remove().draw();
        // },'json').fail(fnFailAjax);
    }

    var lstUniNull = true;
    var targetDep = -1;
    function fnBuscarDos(){

    }
    function fnBuscar(e){
        console.log(this.value);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();


        if(frmF.selDepUsuarioF.value > 0 && frmF.selDepUsuarioF.value != targetDep){
            console.log('change DepUsuario');
            if(!noadmin){
                  $.post(BASE_URL + 'unidad/listar_by_dep/' + frmF.selDepUsuarioF.value, {}, function(data, textStatus, xhr) {
                    console.log(data);

                    var r = null;

                    console.log(data);
                    if(data.length > 0){
                        targetDep = frmF.selDepUsuarioF.value;
                        $(frmF.selUniUsuarioF).prop('disabled',false).html('');
                        var t = TEMPLATES.option;
                        t = Handlebars.compile(t);


                        $(frmF.selUniUsuarioF).append(t({id : -1, text : 'Todos'}));
                        for (var i = data.length - 1; i >= 0; i--) {

                            $(frmF.selUniUsuarioF).append(t({
                                id : data[i].uni_id,
                                text : data[i].uni_nombre
                            }))
                        }



                    }else{
                        targetDep = -1;
                        $(frmF.selUniUsuarioF).prop('disabled',true).html('');
                    }

                },'json');
            }



            lstUniNull = false;
            filtrosDatatable.push({
                column : 'dep_id_departamento',
                filter : frmF.selDepUsuarioF.value
            });
        }else if(frmF.selDepUsuarioF.value == -1){
            // $(frmF.selUniUsuarioF).trigger('change');
            if(!noadmin)
                $(frmF.selUniUsuarioF).prop('disabled',true).html('');
        }


        if(frmF.selUniUsuarioF.value > 0)
            filtrosDatatable.push({
                column : 'uni_id_unidad',
                filter : frmF.selUniUsuarioF.value});

        if(frmF.selTipoUsuarioF.value > 0)
            filtrosDatatable.push({
                column : 'usu_tipo_usuario',
                filter : frmF.selTipoUsuarioF.value});

        if(frmF.selEstadoUsuarioF.value >= 0)
            filtrosDatatable.push({
                column : 'usu_estado',
                filter : +frmF.selEstadoUsuarioF.value});

        if(frmF.txtNombreUsuarioF.value.trim() != '')
            filtrosDatatable.push({
                column : 'usu_nombre',
                filter : frmF.txtNombreUsuarioF.value});


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
                console.log(data);
                var r = null;
                if(data.length > 0){
                    $(selUniUsuario).prop('disabled',false).html('');
                    var t = TEMPLATES.option;
                    t = Handlebars.compile(t);
                    for (var i = data.length - 1; i >= 0; i--) {
                        $(selUniUsuario).append(t({
                            id : data[i].uni_id,
                            text : data[i].uni_nombre
                        }))
                    }
                    if(opc_editar.is_edit){
                         $(selUniUsuario).val(opc_editar.value).trigger('change');
                    }
                }else{
                    $(selUniUsuario).prop('disabled',true).html('');
                }

            },'json');
        }
    }



}
