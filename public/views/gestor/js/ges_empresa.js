window.onload = fnLoad;
var dtListar;
function fnLoad() {

    var btnRegistrar = $('#btnRegistrar');
    var btnCancelar = $('#btnCancelar');
    var btnNuevo = $('#btnNuevo');
    var btnGuardar = $('#btnGuardar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var frmRegistroX = $('#frmRegistro');


    var filtrosDatatable = [];
    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX: "100%",
        scrollXInner: "100%",
        lengthChange : false,
        dom : 'ltip',
        processing: false,
        serverSide: true,
        order: [],
        ajax : {
            url : BASE_URL + "empresas/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns : [
            { data : "empc_nombre" },
            { data : "empc_direccion" },
            { data : "empc_telefono" },
            { data : "empc_id",render:function(data, type, row){
                var t = TEMPLATES.btn_acciones;
                // var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a>/<a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';
                t = Handlebars.compile(t);
                return t({id : data});
            } }

        ],
        columnDefs : [
            {
                "targets": [ 3 ],
                "orderable": false

            },

        ],
    });
    dtListar.on('draw.dt',function(e){
         $('[data-toggle="tooltip"]').tooltip({
            container: '#tblListar'
        });
    })
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    btnNuevo.on('click',fnAbrirModal);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    function reset()
    {
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        frmRegistro.reset();

    }
    function fnCancelar(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }
    frmRegistroX.on('submit',function(e){
        e.preventDefault();
        console.log('trigger');
    })
    function fnRegistrar(e){
        e.preventDefault();
        btnGuardar.trigger('click');
        var frmRegEmpresas = new Form('frmRegistro');
        var elem = frmRegEmpresas.getElements();

        switch(this.dataset.accion){
            case 'guardar':
                $.post(BASE_URL + 'empresas/insertar', {
                    txtNombre : elem.txtNombreEmp.value,
                    txtDireccion : elem.txtDireccionEmp.value,
                    txtTelefono : elem.txtTelefonoEmp.value
                }, function(data, textStatus, xhr) {

                    if(data.resultado){
                        modRegistro.modal('hide');
                        dtListar.draw();
                    }
                },'json').fail(function(e){ console.log(e.responseText); });
                break;
            case 'actualizar':
                $.post(BASE_URL + 'empresas/actualizar', {
                    id : elem.txtId.value,
                    txtNombre : elem.txtNombreEmp.value,
                    txtDireccion : elem.txtDireccionEmp.value,
                    txtTelefono : elem.txtTelefonoEmp.value
                }, function(data, textStatus, xhr) {
                    if(data.resultado){
                        dtListar.draw();
                        modRegistro.modal('hide');
                        btnRegistrar.html('Guardar');
                        btnRegistrar.get(0).dataset.accion = 'guardar';
                    }
                },'json');
                break;
        }




    }

    function fnAccionesItemTabla(e){
        // console.log('acciones');
        // console.log(this);
        e.preventDefault();
        // console.log($(this).toParent('tr'));
        // console.log($(this).parent('td'));
        var id = this.dataset.idObj;
        switch(this.dataset.accion){
            case 'editar':
                targetTR = $(this).toParent('tr');
                fnEditar(id);
                break;
            case 'eliminar':
                // fnEliminar(id,this);
                swal({
                        title: "Eliminar Empresa",
                        text: "¿Desea eliminar esta empresa?",
                        type: "warning",
                        showCancelButton: true,
                        animation: "slide-from-top",
                        confirmButtonText: "Eliminar",
                        cancelButtonText: "Cancelar",
                        closeOnConfirm: false,
                        closeOnCancel: true,
                        showLoaderOnConfirm: true
                    },
                    function(isConfirm){
                        if (isConfirm) {
                            $.post(BASE_URL + 'empresas/eliminar/' + id, {}, function(data, textStatus, xhr) {
                                console.log(data);
                                if(data.resultado == true){
                                    swal("Eliminado!", "La empresa fue eliminada", "success");

                                    dtListar.page(dtListar.page()).draw('page');
                                    // dtListar.draw();
                                }else{
                                    swal("Cancelado!", "La empresa no se puede eliminar", "error");
                                }



                            },'json').fail(fnFailAjax);
                      }
                });

                break;
        }


    }
    var targetTR;

    function fnEditar(id)
    {
        console.log('editar');
          $.post(BASE_URL + 'empresas/data/' + id, {}, function(data, textStatus, xhr) {
            if(data.resultado){
                var obj = data.objEmpresa;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombreEmp.value = obj.empc_nombre;
                ele.txtDireccionEmp.value = obj.empc_direccion;
                ele.txtTelefonoEmp.value = obj.empc_telefono;
                ele.txtId.value = id;

                btnRegistrar.html('Actualizar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                modRegistro.modal('show');
            }
        },'json');
    }

    function fnEliminar(id,element)
    {
        console.log('eliminar')

        $.post(BASE_URL + 'empresas/eliminar/' + id, {}, function(data, textStatus, xhr) {
            if(data.resultado)
                dtListar.draw('page');
                // dtListar.row($(element).toParent('tr')).remove().draw();

        },'json');
    }

    function fnAbrirModal(e)
    {
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';
        modRegistro.modal('show');
    }

    function fnBuscar(e){
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();

        // frmF.txtNombreF.value;
        // frmF.txtEstadoF.value;

        if(frmF.txtNombreEmpF.value.trim() != '')
            filtrosDatatable.push({
                column : 'empc_nombre',
                filter : frmF.txtNombreEmpF.value});
        if(frmF.txtDireccionEmpF.value.trim() != '')
            filtrosDatatable.push({
                column : 'empc_direccion',
                filter : frmF.txtDireccionEmpF.value});
        if(frmF.txtTelefonoEmpF.value.trim() != '')
            filtrosDatatable.push({
                column : 'empc_telefono',
                filter : frmF.txtTelefonoEmpF.value});

        // dtListar.search( frmF.txtNombreF.value ).draw();
        dtListar.draw();
        // $(frmF.txtNombreF).focus();


    }
    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);


};