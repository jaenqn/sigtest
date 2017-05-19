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
    var selUnidadF = $('#selUnidadF');

    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    // tblListar.on('click','.btnAcciones',fnAccionesItemTabla);


    var filtrosDatatable = [
        {
            column : 'dep_id',
            filter : -1
        },
        {
            column : 'uni_id',
            filter : -1
        },
        {
            column : 'alm_id',
            filter : -1
        },
        {
            column : 'auto_estado',
            filter : -1
        },
    ];
    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false,
        serverSide : true,
        order : [5,'desc'],
        ajax : {
            url : BASE_URL + "residuo/dt_listar_autorizaciones",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : fnFailAjax
        },
        columns: [
            { data : "rss_id" },
            { data : "res_nombre" },
            { data : "desDepend" },
            { data : "rso_nombre" },
            { data : "alm_nombre", render: function(d, t, r){
                return '<span title="'+r.alm_descripcion+'">'+ d +'</span>';
            } },
            { data : "rss_fecha_solicitud" },
            { data : "rss_autorizado", render :function(d, t, r){
                switch(+d){
                    case 0://pendiente
                        return 'Pendiente'
                        break;
                    case 1://aprobado
                        return 'Aprobado'
                        break;
                    case 2://rechazado
                        return 'Rechazado'
                        break;
                }
                return 'asd';
            } },
            { data : "rss_id" , render : function(d, t, r){
                var t = TEMPLATES.btn_accion_ver_ref_notarget;
                t = Handlebars.compile(t);
                var rss_url = BASE_URL + 'residuo/autorizar/' + d;
                switch(+r.rss_autorizado){
                    case 1: rss_url = BASE_URL + 'residuo/autorizacion/' + d; break;
                    case 2: rss_url = BASE_URL + 'residuo/solicitud/' + d; break;

                }
                return t({id : d, url : rss_url});

            }}
        ],
        columnDefs : [
            {
                targets : [ 7 ],
                orderable : false,

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

    function fnChangeDep(iddep){
        if(iddep != -1){
            $.post(BASE_URL + 'residuo/get_unidades/' + iddep, {}, function(data, textStatus, xhr) {
                console.log(data);
                if(data.length > 0){
                    var t = Handlebars.compile(TEMPLATES.option);
                    html = t({id : -1, text : 'Todos'});
                    data.forEach(function(v, e) {
                        html += t({id : v.idDepend, text : v.desDepend});
                    });
                    selUnidadF.html(html);
                    selUnidadF.prop('disabled',false);
                }
            },'json');
            filtrosDatatable[0].filter = iddep;
        }else{
            filtrosDatatable[0].filter = -1;
            selUnidadF.prop('disabled',true);
            selUnidadF.html('');
        }
        filtrosDatatable[1].filter = -1;
    }
    function fnChangeUni(iduni){

        filtrosDatatable[1].filter = iduni;
    }
    function fnBuscarDos(e){
        e.preventDefault();
        console.log(this.id);
        switch(this.id){
            case 'selDepartF':
                fnChangeDep(this.value);
                break;
            case 'selUnidadF':
                fnChangeUni(this.value);
                break;
            case 'selAlmacenF':
                filtrosDatatable[2].filter = this.value;
                break;
            case 'selEstadoF':
                filtrosDatatable[3].filter = this.value;
                break;
        }
        dtListar.draw();
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
    on('change','select.input-filter',fnBuscarDos).
    on('keyup','input[type="text"].input-filter',fnBuscarDos);

    function fnCancelar(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }




}
