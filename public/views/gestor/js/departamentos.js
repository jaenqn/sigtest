window.onload = fnLoad;
var dtListar;
function fnLoad() {
    $('#chkEstado').iCheck('checked');
    var btnNuevo = $('#btnNuevo');
    var btnGuardar = $('#btnGuardar');

    var modRegistro = $('#modRegistro');

    var btnCancelar = $('#btnCancelar');
    var tblListar = $('#tblListar');
    var txtNombreF = $('#txtNombreF');
    var btnBuscar = $('#btnBuscar');
    var txtAbbr = $('#txtAbbr');
    var filtrosDatatable = [];

    txtAbbr.on('keyup',function(e){
        console.log(this.value);
        if(this.value.trim()!=''){
            $.post(BASE_URL + 'unidad/verificaabbr', {txtAbbr: this.value, txtId : getById('txtId').value}, function(data, textStatus, xhr) {
                console.log(data);
                if(data.respuesta)
                    $('#errorAbbr').addClass('hidden')
                else
                    $('#errorAbbr').removeClass('hidden')

            },'json');
        }

    })
    dtListar = tblListar.DataTable({
        language : lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        // searching : false,
        dom : 'ltip',
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [], //Initial no order.

        // Load data for the table's content from an Ajax source
        ajax : {
            url : BASE_URL + "departamento/datatables_list",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error :function(e){
                console.log(e);
                console.log(e.responseText);

            }
        },
        columns : [


            { data : "desDepend" },

            { data : "get_estado" },
            { data : "abbr" },

            { data : "idDepend",render:function(data, type, row){
                var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a> / <a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';

                t = Handlebars.compile(TEMPLATES.btn_acciones);
                return t({id : data});
            } }

        ],

        //Set column definition initialisation properties.
        columnDefs : [
            {
                "targets": [ 3 ], //first column / numbering column
                "orderable": false, //set not orderable,
                'width':'90px'

            },

        ],
    });

    txtNombreF.on( 'keyup', function () {
        // dtListar.search( this.value ).draw();


    } );
    btnNuevo.on('click',fnAbrirModal);
    btnGuardar.on('click',fnRegistrar);
    btnBuscar.on('click',fnBuscar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);

    function fnCancelar(e){
        e.preventDefault();
        var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();
        elem.txtNombre.value = '';
        elem.txtAbbr.value = '';
        $(elem.chkEstado).iCheck('uncheck');
        // $(elem.txtNombre).focus();
        // btnCancelar.addClass('hidden');
        btnGuardar.html('Guardar');
        btnGuardar.get(0).dataset.accion = 'guardar';

    }

    function fnRegistrar(e){

        e.preventDefault();
        var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();

        switch(this.dataset.accion){
            case 'guardar':
                console.log('registrar');
                $.post(BASE_URL + 'departamento/insertar', {
                    txtNombre : elem.txtNombre.value,
                    txtEstado : elem.chkEstado.checked,
                    txtAbbr : elem.txtAbbr.value
                }, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado){
                        dtListar.draw();
                        elem.txtNombre.value = '';
                        $(elem.chkEstado).iCheck('uncheck');
                        modRegistro.modal('hide');
                        // $(elem.txtNombre).focus();

                    }
                },'json').fail(fnFailAjax);
                break;
            case 'actualizar':
                $.post(BASE_URL + 'departamento/actualizar', {
                    id : elem.txtId.value,
                    txtNombre : elem.txtNombre.value,
                    txtEstado : elem.chkEstado.checked,
                    txtAbbr : elem.txtAbbr.value
                }, function(data, textStatus, xhr) {
                    if(data.resultado){
                        dtListar.draw();
                        modRegistro.modal('hide');
                        frmRegistro.reset();

                        // elem.txtNombre.value = '';
                        // elem.txtDescripcion.value = '';

                        // $(elem.txtNombre).focus();
                        // btnCancelar.addClass('hidden');
                        btnGuardar.html('Guardar');
                        btnGuardar.get(0).dataset.accion = 'guardar';
                    }
                },'json').fail(fnFailAjax);
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
                fnEliminar(id,this);
                break;
        }


    }
    var targetTR;

    function fnEditar(id){
        console.log('editar');
          $.post(BASE_URL + 'departamento/data/' + id, {}, function(data, textStatus, xhr) {

            if(data.resultado){
                var obj = data.objRes;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombre.value = obj.desDepend;
                ele.txtAbbr.value = obj.abbr;
                obj.estadoDepend == 1 ? $(ele.chkEstado).iCheck('check') : $(ele.chkEstado).iCheck('uncheck')
                // ele.chkEstado.value = obj.dep_estado;
                ele.txtId.value = id;

                // btnCancelar.removeClass('hidden');
                btnGuardar.html('Actualizar');
                btnGuardar.get(0).dataset.accion = 'actualizar';


                // $('#tituloModal').scrollTo(-30);

                $(ele.txtNombre).focus();
                 modRegistro.modal('show');



            }
            /*optional stuff to do after success */
        },'json');
    }
    function fnEliminar(id,element){
        console.log('eliminar')

        $.post(BASE_URL + 'departamento/eliminar/' + id, {}, function(data, textStatus, xhr) {
            if(data.resultado)
                dtListar.row($(element).toParent('tr')).remove().draw();
            /*optional stuff to do after success */
        },'json');
    }

    function fnAbrirModal(e){
        e.preventDefault();
          var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();
        elem.txtNombre.value = '';
        elem.txtAbbr.value = '';
        $(elem.chkEstado).iCheck('check');
        modRegistro.modal('show');
    }

    function fnBuscar(e){
        e.preventDefault();
        filtrosDatatable = [];
        var frmF = new Form('frmFiltrar').getElements();

        if(frmF.txtNombreF.value != -1)
            filtrosDatatable.push({
                column : 'desDepend',
                filter : frmF.txtNombreF.value});

        if(frmF.txtEstadoF.value != -1)
            filtrosDatatable.push({
                column : 'estadoDepend',
                filter : frmF.txtEstadoF.value});
        dtListar.draw();


    }
    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);


};