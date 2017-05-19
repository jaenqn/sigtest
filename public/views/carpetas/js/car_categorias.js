window.onload = fnLoad;
var dtListar;
function fnLoad(e){
    var tblListar = $('#tblListar');
    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var btnCancelar = $('#btnCancelar');
    var modRegistro = $('#modRegistro');
    var tituloModal = $('#tituloModal');
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
            url : BASE_URL + "carpeta/datatables_categorias",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "nomArchivo" },
            { data : "url", render : function(d,t,r){
                return 'home/document/' + d;
            }},
            { data : "estadoArchivo", render : function(d, t, r){
                return +d == 1 ? 'Activo' : 'Inactivo';

            } },
            { data : "idArchivo", render : function(data, type, row){
                    var t = TEMPLATES.btn_acciones;
                    t = Handlebars.compile(t);
                    return t({id : data});
            } }

        ],
        columnDefs : [
            {
                targets : [ 3 ],
                orderable : false,
                width : '100px'

            },

        ],

    });
    dtListar.on('draw.dt',function(e){
        $('[data-toggle="tooltip"]').tooltip({
            container: '#tblListar'
        });
    })
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        // frmRegistro.reset();
        $(el.chkEstado).iCheck('check');
        tituloModal.html('Agregar Peligro');


    }
    btnNuevo.on('click',fnAbrirModal);
    btnCancelar.on('click',fnCancelar);

    function fnAbrirModal(){
        e.preventDefault();
        reset();
        // $('#txtNombreCategoria').focus();
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
                swal_option.confirm.title = 'Guardar Categoría';
                swal_option.confirm.text = '¿Desea guardar los datos para esta Categoría?';
                swal_option.confirm.type = 'warning';
                swal_option.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                swal_option.confirm.title = 'Actualizar  Categoría';
                swal_option.confirm.text = '¿Desea guardar los cambios  de esta Categoría?';
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
                    $.post(BASE_URL + 'carpeta/insertar_categoria', {
                        txtNombre : elem.txtNombreCategoria.value,
                        txtUrl : elem.txtUrlCategoria.value,
                        txtEstado : elem.chkEstado.checked
                    }, function(data, textStatus, xhr) {

                        if(data.resultado){
                            dtListar.draw();
                            modRegistro.modal('hide');
                            swal("Categoría Registrada!",'', "success");
                            reset();
                        }
                    },'json').error(function(e){console.log(e.responseText)});
                    break;
                case 'actualizar':
                    console.log('actualizar');
                    $.post(BASE_URL + 'carpeta/actualizar_categoria', {
                        id : elem.txtId.value,
                        txtNombre : elem.txtNombreCategoria.value,
                        txtUrl : elem.txtUrlCategoria.value,
                        txtEstado : elem.chkEstado.checked
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
     function fnCancelar(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }
    function fnBuscar(e){
        // console.log(this.value);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();

        if(frmF.txtEstadoF.value >= 0)
            filtrosDatatable.push({
                column : 'estadoArchivo',
                filter : +frmF.txtEstadoF.value});


        if(frmF.txtNombreCateF.value.trim() != '')
            filtrosDatatable.push({
                column : 'nomArchivo',
                filter : frmF.txtNombreCateF.value});


        dtListar.draw();

    }

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
    function fnEditar(id)
    {

        console.log('editar');
          $.post(BASE_URL + 'carpeta/data_categoria/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);
            if(data.obj != null){
                var obj = data.obj;
                var frm = new Form('frmRegistro');
                var elem = frm.getElements();
                elem.txtNombreCategoria.value = obj.nomArchivo;
                elem.txtUrlCategoria.value = obj.url;
                +obj.estadoArchivo == 1 ? $(elem.chkEstado).iCheck('check') : $(elem.chkEstado).iCheck('uncheck');
                elem.txtId.value = obj.idArchivo;
                btnRegistrar.html('Actualizar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                tituloModal.html('Modificar Categoría');
                modRegistro.modal('show');
            }else{
                swal("Categoría no encontrada!",'', "warning");
                dtListar.page(dtListar.page()).draw('page');
            }
        },'json').fail(fnFailAjax);
    }

    function fnEliminar(id,element){
        console.log('eliminar')
        swal({
            title: "Eliminar Categoría",
            text: "¿Desea eliminar esta Categoría?",
            type: "warning",
            showCancelButton: true,
            animation: "slide-from-top",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Eliminar",
            cancelButtonText: "Cancelar!",
            closeOnConfirm: false,
            closeOnCancel: true,
            showLoaderOnConfirm: true
        },
        function(isConfirm){
          if (isConfirm) {
            $.post(BASE_URL + 'carpeta/eliminar_categoria/' + id, {}, function(data, textStatus, xhr) {
                console.log(data);
                if(data.resultado == true){
                    swal("Eliminado!", "La categoría fue eliminada", "success");
                    // dtListar.row($(element).toParent('tr')).remove().draw();
                    dtListar.page(dtListar.page()).draw('page');
                }else{
                    swal("Cancelado!", "La Categoría no se puede eliminar", "error");
                }

            },'json').fail(fnFailAjax);
          }
        });
        // $.post(BASE_URL + 'usuario/eliminar/' + id, {}, function(data, textStatus, xhr) {
        //     if(data.resultado)
        //         dtListar.row($(element).toParent('tr')).remove().draw();
        // },'json').fail(fnFailAjax);
    }
}