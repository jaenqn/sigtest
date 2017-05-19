window.onload = fnLoad;
var dtListar;
var temp_serialize;
function fnLoad() {

    var btnRegistrar = $('#btnRegistrar');
    var btnNuevo = $('#btnNuevo');
    var btnCancelar = $('#btnCancelar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var myModalLabel = $('#myModalLabel');

    var filtrosDatatable = [];
    dtListar = tblListar.DataTable({
        language : lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange  : false,
        dom : 'ltip',
        processing : false,
        serverSide : true,
        order : [0,'asc'],
        ajax : {
            url : BASE_URL + "almacen/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns : [
            { data : "alm_nombre" },
            { data : "alm_id",render:function(data, type, row){
                var t = TEMPLATES.btn_acciones;
                // var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a>/<a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';
                t = Handlebars.compile(t);
                return t({id : data});
            } }

        ],

        //Set column definition initialisation properties.
        columnDefs : [
            {
                "targets": [ 1 ],
                "orderable": false,
                width : '65px'

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
        frmRegistro.reset();

    }

    function fnCancelar(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }

    function fnRegistrar(e){
        e.preventDefault();
        var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();


        var opcs_swal = swal_option;
        var pross_continue = true;
        switch(this.dataset.accion){
            case 'guardar':
                opcs_swal.confirm.title = 'Guardar Almacén';
                opcs_swal.confirm.text = '¿Desea guardar los datos del Almacén?';
                opcs_swal.confirm.type = 'warning';
                opcs_swal.confirm.closeOnCancel = true;
                break;
            case 'actualizar':
                if(temp_serialize == $(frmRegistro.getNode()).serialize())
                    pross_continue = false;
                opcs_swal.confirm.title = 'Actualizar  Almacén';
                opcs_swal.confirm.text = '¿Desea guardar los cambios  del Almacén?';
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
                            $.post(BASE_URL + 'almacen/insertar', {
                                txtNombre : elem.txtNombreAlm.value,
                                txtDescripcion : elem.txtDescripcionAlm.value
                            }, function(data, textStatus, xhr) {
                                // console.log(data);
                                if(data.resultado){
                                    swal("Almacén Registrado!",'', "success");
                                    dtListar.draw();
                                    modRegistro.modal('hide');
                                    frmRegistro.reset();
                                }
                            },'json');
                            break;
                        case 'actualizar':
                            $.post(BASE_URL + 'almacen/actualizar', {
                                id : elem.txtId.value,
                                txtNombre : elem.txtNombreAlm.value,
                                txtDescripcion : elem.txtDescripcionAlm.value
                            }, function(data, textStatus, xhr) {
                                if(data.resultado){
                                    swal("Datos Actualizados!",'', "success");
                                    dtListar.draw();
                                    modRegistro.modal('hide');
                                    reset();
                                    btnRegistrar.html('Guardar');
                                    btnRegistrar.get(0).dataset.accion = 'guardar';
                                }
                            },'json');
                            break;
                    }
                }
            });
        }
        // switch(this.dataset.accion){
        //     case 'guardar':
        //         $.post(BASE_URL + 'almacen/insertar', {
        //             txtNombre : elem.txtNombreAlm.value,
        //             txtDescripcion : elem.txtDescripcionAlm.value
        //         }, function(data, textStatus, xhr) {
        //             // console.log(data);
        //             if(data.resultado){
        //                 dtListar.draw();
        //                 modRegistro.modal('hide');
        //                 frmRegistro.reset();
        //             }
        //         },'json');
        //         break;
        //     case 'actualizar':
        //         $.post(BASE_URL + 'almacen/actualizar', {
        //             id : elem.txtId.value,
        //             txtNombre : elem.txtNombreAlm.value,
        //             txtDescripcion : elem.txtDescripcionAlm.value
        //         }, function(data, textStatus, xhr) {
        //             if(data.resultado){
        //                 dtListar.draw();
        //                 modRegistro.modal('hide');
        //                 reset();
        //                 btnRegistrar.html('Guardar');
        //                 btnRegistrar.get(0).dataset.accion = 'guardar';
        //             }
        //         },'json');
        //         break;
        // }




    }

    function fnAbrirModal(e)
    {
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        myModalLabel.text('Registro de Almacén')
        btnRegistrar.get(0).dataset.accion = 'guardar';
        modRegistro.modal('show');
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
                fnEliminar(id,this);
                break;
        }


    }
    var targetTR;

    function fnEditar(id){
        console.log('editar');
          $.post(BASE_URL + 'almacen/data/' + id, {}, function(data, textStatus, xhr) {

            if(data.resultado){
                var obj = data.objRes;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombreAlm.value = obj.alm_nombre;
                ele.txtDescripcionAlm.value = obj.alm_descripcion;
                ele.txtId.value = id;
                modRegistro.modal('show');
                myModalLabel.text('Actualizar Almacén');
                btnRegistrar.html('Actualizar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';

                temp_serialize = $(frm.getNode()).serialize();
            }
            /*optional stuff to do after success */
        },'json').fail(function(e){console.log(e.responseText)});
    }
    function fnEliminar(id,element){
        console.log('eliminar')

        var opcs_swal = swal_option;
        opcs_swal.confirm.title = 'Eliminar Alamacén';
        opcs_swal.confirm.text = '¿Desea eliminar el Alamacén?';
        opcs_swal.confirm.type = 'warning';
        opcs_swal.confirm.closeOnCancel = true;

        swal(swal_option.confirm,
        function(isConfirm){
            if(isConfirm){
                $.post(BASE_URL + 'almacen/eliminar/' + id, {}, function(data, textStatus, xhr) {
                    if(data.resultado)
                        swal("Alamacén Eliminado!",'', "success");
                        dtListar.page(dtListar.page()).draw('page');

                },'json');
            }

        });

    }

    function fnBuscar(e){
        e.preventDefault();
        filtrosDatatable = [];
        var frmF = new Form('frmFiltrar').getElements();
        if(frmF.txtNombreAlmF.value.trim() != '')
            filtrosDatatable.push({
                column : 'alm_nombre',
                filter : frmF.txtNombreAlmF.value});
        dtListar.draw();
    }
    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);


};