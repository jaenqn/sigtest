window.onload = fnLoad;
function fnLoad(){
    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var btnCancelar = $('#btnCancelar');

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
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [], //Initial no order.
        ajax : {
            url : BASE_URL + "causa/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "cau_nombre" },
            { data : "cau_get_tipo" },
            { data : "cau_get_sub_estandar" },
            { data : "cau_id",render:function(data, type, row){
                var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a>/<a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';
                t = Handlebars.compile(t);
                return t({id : data});
            } }

        ],


        columnDefs : [
            {
                targets : [ 3 ],
                orderable : false,

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        $(el.radSubEstandar).iCheck('uncheck');
        $(el.radTipoCausa).iCheck('uncheck');
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
                $.post(BASE_URL + 'causa/insertar', {
                    txtNombre : elem.txtNombreCausa.value,
                    txtIdTipo : elem.radTipoCausa.value,
                    txtIdSubEstandar : elem.radSubEstandar.value
                }, function(data, textStatus, xhr) {
                    // console.log(data);
                    if(data.resultado){
                        dtListar.draw();
                        reset();
                        modRegistro.modal('hide');

                    }
                },'json').error(function(e){console.log(e.responseText)});
                break;
            case 'actualizar':
                $.post(BASE_URL + 'causa/actualizar', {
                    id : elem.txtId.value,
                    txtNombre : elem.txtNombreCausa.value,
                    txtIdTipo : elem.radTipoCausa.value,
                    txtIdSubEstandar : elem.radSubEstandar.value
                }, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado){
                        dtListar.draw();
                        reset();
                        btnRegistrar.html('Guardar');
                        btnRegistrar.get(0).dataset.accion = 'guardar';
                        modRegistro.modal('hide');
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
    function fnEditar(id)
    {
        console.log('editar');
          $.post(BASE_URL + 'causa/data/' + id, {}, function(data, textStatus, xhr) {

            if(data.resultado){
                var obj = data.objRes;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombreCausa.value = obj.cau_nombre;
                $(ele.radTipoCausa).each(function(e,v){
                    if(v.value.toLowerCase() == obj.cau_tipo.toLowerCase())
                        $(v).iCheck('check');
                });
                $(ele.radSubEstandar).each(function(e,v){
                    if(v.value.toLowerCase() == obj.cau_sub_estandar.toLowerCase())
                        $(v).iCheck('check');
                });
                ele.txtId.value = id;

                btnRegistrar.html('Actualizar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';
                 modRegistro.modal('show');
            }
        },'json');
    }

    function fnEliminar(id,element){
        console.log('eliminar')

        $.post(BASE_URL + 'causa/eliminar/' + id, {}, function(data, textStatus, xhr) {
            if(data.resultado)
                dtListar.row($(element).toParent('tr')).remove().draw();
        },'json');
    }

    function fnBuscar(e){

        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();


        if(frmF.selTipoCausaF.value > 0)
            filtrosDatatable.push({
                column : 'cau_tipo',
                filter : frmF.selTipoCausaF.value});

        if(frmF.selSubEstandarCausaF.value > 0)
            filtrosDatatable.push({
                column : 'cau_sub_estandar',
                filter : frmF.selSubEstandarCausaF.value});

        if(frmF.txtNombreCausaF.value.trim() != '')
            filtrosDatatable.push({
                column : 'cau_nombre',
                filter : frmF.txtNombreCausaF.value});


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
