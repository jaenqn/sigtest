var dtListar;
// var listDepartamentos;
$(document).ready(function() {
    var btnNuevo = $('#btnNuevo');
    var btnRegistrar = $('#btnRegistrar');
    var tblListar = $('#tblListar');
    var modRegistro = $('#modRegistro');
    var btnCancelar = $('#btnCancelar');
    var txtAbbr = $('#txtAbbr');
    var resAbbr = $('#resAbbr');


    // $('#chkActivo').iCheck('check');


    btnNuevo.on('click',fnAbrirModal);
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);
    txtAbbr.on('keyup',function(e){
        var keyp = this.value;
        keyp = keyp.replace(/\s/g,'');
        $(this).val(keyp);
        if(keyp.trim()!=''){
            $.post(BASE_URL + 'unidad/verificaabbr', {txtAbbr: keyp, txtId : getById('txtId').value}, function(data, textStatus, xhr) {
                console.log(data);
                if(data.respuesta)
                    $('#errorAbbr').addClass('hidden')
                else
                    $('#errorAbbr').removeClass('hidden')

            },'json');
        }
        $.post(BASE_URL + 'unidad/verificaabbr', {
            txtAbbr : keyp
        }, function(data, textStatus, xhr) {
            if(data.respuesta == true){
                $('#resAbbr').text('Disponible');
                // btnRegistrar.prop('disabled',false);
            }else{
                $('#resAbbr').text('No disponible');
                // btnRegistrar.prop('disabled',true);
            }

        },'json');


    })
    var filtrosDatatable = [];

    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [], //Initial no order.
        ajax : {
            url : BASE_URL + "unidad/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns: [
            { data : "desDepend" },
            { data : "reportaDpend", render : function(d, t, r){
                var lst = dtListar.ajax.json().lstDepartamentos;
                for (var i = lst.length - 1; i >= 0; i--) {
                    if(lst[i].idDepend == d)
                        return lst[i].desDepend;
                }
            } },
            { data : "abbr" },
            { data : "get_estado" },
            { data : "idDepend",render:function(data, type, row){
                var t = TEMPLATES.btn_acciones;
                // var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a> / <a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';
                t = Handlebars.compile(t);
                return t({id : data});
            } }

        ],


        columnDefs : [
            {
                targets : [ 4 ],
                orderable : false,
                width : '90px'

            },

        ],

    });
    function reset(){
        frmRegistro = new Form('frmRegistro');
        var el = frmRegistro.getElements();
        frmRegistro.reset();
        $(el.selDepartamento).val('').trigger('change');
        $(el.selInstalacion).val('').trigger('change');
        $(el.chkActivo).iCheck('check');
        // btnRegistrar.prop('disabled','false');
    }
    function fnAbrirModal(e){
        e.preventDefault();
        reset();
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';
        modRegistro.modal('show');
        $('#frmRegistro #txtNombre').focus();
    }

    function fnRegistrar(e)
    {

        e.preventDefault();
        var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();

        switch(this.dataset.accion){
            case 'guardar':
                console.log('registrar');
                $.post(BASE_URL + 'unidad/insertar', {
                    txtNombre : elem.txtNombre.value,
                    txtIdDepartamento : elem.selDepartamento.value,
                    txtIdInstalacion : elem.selInstalacion.value,
                    txtEstado : elem.chkActivo.checked,
                    txtAbbr : elem.txtAbbr.value
                }, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado){
                        dtListar.draw();
                        // elem.txtNombre.value = '';
                        $(elem.chkActivo).iCheck('uncheck');
                        modRegistro.modal('hide');
                        frmRegistro.reset();
                        // $(elem.txtNombre).focus();

                    }
                },'json').error(function(e){console.log(e.responseText)});
                break;
            case 'actualizar':
                $.post(BASE_URL + 'unidad/actualizar', {
                    id : elem.txtId.value,
                     txtNombre : elem.txtNombre.value,
                    txtIdDepartamento : elem.selDepartamento.value,
                    txtIdInstalacion : elem.selInstalacion.value,
                    txtEstado : elem.chkActivo.checked,
                    txtAbbr : elem.txtAbbr.value
                }, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado){
                        dtListar.draw();
                        frmRegistro.reset();
                        // elem.txtNombre.value = '';
                        // elem.txtDescripcion.value = '';

                        // $(elem.txtNombre).focus();
                        // btnCancelar.addClass('hidden');
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
    function fnEditar(id)
    {
        console.log('editar');
          $.post(BASE_URL + 'unidad/data/' + id, {}, function(data, textStatus, xhr) {

            if(data.resultado){

                var obj = data.objRes;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombre.value = obj.desDepend;
                ele.selDepartamento.value = obj.reportaDpend;
                // ele.selInstalacion.value = ;
                obj.estadoDepend == 1 ? $(ele.chkActivo).iCheck('check') : $(ele.chkActivo).iCheck('uncheck');
                $(ele.selDepartamento).trigger('change');
                $(ele.selInstalacion).val(obj.ins_id).trigger('change');
                ele.txtId.value = id;
                ele.txtAbbr.value = obj.abbr;
                btnRegistrar.html('Actualizar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';


                // $('#tituloModal').scrollTo(-30);

                $(ele.txtNombre).focus();
                 modRegistro.modal('show');
            }
        },'json');
    }

    function fnEliminar(id,element){
        console.log('eliminar')

        $.post(BASE_URL + 'unidad/eliminar/' + id, {}, function(data, textStatus, xhr) {
            if(data.resultado)
                dtListar.row($(element).toParent('tr')).remove().draw();
        },'json');
    }

    function fnBuscar(e){

        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();

        // frmF.txtNombreF.value;
        // frmF.txtEstadoF.value;

        if(frmF.selUniDepartamentoF.value != -1)
            filtrosDatatable.push({
                column : 'reportaDpend',
                filter : frmF.selUniDepartamentoF.value});

        if(frmF.selUniEstadoF.value != -1)
            filtrosDatatable.push({
                column : 'estadoDepend',
                filter : frmF.selUniEstadoF.value});

        if(frmF.txtNomUniF.value.trim() != '')
            filtrosDatatable.push({
                column : 'desDepend',
                filter : frmF.txtNomUniF.value});

        // dtListar.search( frmF.txtNombreF.value ).draw();
        dtListar.draw();
        // $(frmF.txtNombreF).focus();


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
});

