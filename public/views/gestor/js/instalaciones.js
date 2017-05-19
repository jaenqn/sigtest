window.onload = fnLoad;
function fnLoad() {
    // $('#chkEstado').iCheck('check');
    var btnRegistrar = $('#btnRegistrar');
    var btnNuevo = $('#btnNuevo');
    var btnCancelar = $('#btnCancelar');
    var txtAbbr = $('#txtAbbr');

    var modRegistro = $('#modRegistro');


    var tblListar = $('#tblListar');
    var txtNombreF = $('#txtNombreF');

    // var btnBuscar = $('#btnBuscar');

    var filtrosDatatable = [];
    txtAbbr.on('keyup',function(e){
        var keyp = this.value;
        keyp = keyp.replace(/\s/g,'');
        $(this).val(keyp.toUpperCase());
        if(keyp.trim()!=''){
            $.post(BASE_URL + 'instalacion/verificaabbr', {txtAbbr: keyp, txtId : getById('txtId').value}, function(data, textStatus, xhr) {

                if(data.respuesta)
                    $('#errorAbbr').addClass('hidden')
                else
                    $('#errorAbbr').removeClass('hidden')

            },'json').fail(fnFailAjax);
        }
        // $.post(BASE_URL + 'instalacion/verificaabbr', {
        //     txtAbbr : keyp
        // }, function(data, textStatus, xhr) {
        //     if(data.respuesta == true){
        //         $('#resAbbr').text('Disponible');
        //         // btnRegistrar.prop('disabled',false);
        //     }else{
        //         $('#resAbbr').text('No disponible');
        //         // btnRegistrar.prop('disabled',true);
        //     }

        // },'json');
    });

    btnNuevo.on('click',fnAbrirModal);
    var dtListar = tblListar.DataTable({
        language : lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        // searching : false,
        dom : 'ltip',
        processing : false,
        serverSide : true,
        order : [0,'asc'],
        autoWidth: true,
        responsive: true,
        fixedHeader: true,
        ajax : {
            "url": BASE_URL + "instalacion/datatables_list",
            "type": "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns : [

            { data : "ins_nombre" },
            { data : "rz_total"},
            { data : "ins_ruc" },
            // { data : "ins_direccion" ,render : function(data,type,row){ return row.ins_attr_direccion + ' ' + data} },
            { data : "dir_total" },
            { data : "ins_ing_responsable" },
            { data : "get_estado" },
            { data : "ins_id",render:function(data, type, row){
                var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar">editar</a>/<a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a>';
                t = Handlebars.compile(TEMPLATES.btn_acciones);
                return t({id : data});
            } }

        ],

        //Set column definition initialisation properties.
        columnDefs : [
            {
                "targets": [ 6 ], //first column / numbering column
                "orderable": false, //set not orderable
                width : '66px',
                createdCell : function (td, cellData, rowData, row, col) {
                        // tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"
                        // var x = td;
                        // console.log(td);
                    $(td).css({
                        'text-align' : 'center',
                        'vertical-align' : 'middle'
                    });

                }

            },

        ],

    });
    $('#menu_toggle').on('click',function(){dtListar.columns.adjust()});

     txtNombreF.on( 'keyup', function () {
        // dtListar.search( this.value ).draw();


    } );
    btnRegistrar.on('click',fnRegistrar);
    btnCancelar.on('click',fnCancelar);
    tblListar.on('click','.btnAcciones',fnAccionesItemTabla);

    function fnCancelar(e){
        e.preventDefault();
        var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();
        $(elem.chkEstado).iCheck('check');
        $(elem.radPreDireccion).iCheck('uncheck');
        frmRegistro.reset();
        // elem.txtNombre.value = '';

        // $(elem.radPreDireccion).iCheck('uncheck');
        // $(elem.txtNombre).focus();
        // btnCancelar.addClass('hidden');
        btnRegistrar.html('Guardar');
        btnRegistrar.get(0).dataset.accion = 'guardar';

    }

    function fnRegistrar(e){

        e.preventDefault();
        var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();

        switch(this.dataset.accion){
            case 'guardar':
                console.log('registrar');
                $.post(BASE_URL + 'instalacion/insertar', {
                    txtNombre : elem.txtNombre.value,
                    txtRazonSocial : elem.txtRazonSocial.value,
                    txtSiglas : elem.txtSiglas.value,
                    txtRuc : elem.txtRuc.value,
                    txtEmail : elem.txtEmail.value,
                    txtTelefono : elem.txtTelefono.value,
                    txtAbbr : elem.txtAbbr.value,
                    txtEstado : elem.chkEstado.checked,
                    txtPreDireccion : elem.radPreDireccion.value,
                    txtDireccion : elem.txtDireccion.value,
                    txtUrbLocalidad : elem.txtUrbLocalidad.value,
                    txtDistrito : elem.txtDistrito.value,
                    txtProvincia : elem.txtProvincia.value,
                    txtDepartamento : elem.txtDepartamento.value,
                    txtCodPostal : elem.txtCodPostal.value,
                    txtRepresentante : elem.txtRepresentante.value,
                    txtDniRepre : elem.txtDniRepre.value,
                    txtResponsable : elem.txtResponsable.value,
                    txtCipResp : elem.txtCipResp.value,
                    txtDirNum : elem.txtDirNum.value,
                }, function(data, textStatus, xhr) {
                    console.log(data);
                    if(data.resultado){
                        dtListar.draw();
                        // elem.txtNombre.value = '';
                        $(elem.chkEstado).iCheck('uncheck');
                        modRegistro.modal('hide');
                        frmRegistro.reset();
                        // $(elem.txtNombre).focus();

                    }
                },'json');
                break;
            case 'actualizar':
                $.post(BASE_URL + 'instalacion/actualizar', {
                    id                  : elem.txtId.value,
                    txtNombre           : elem.txtNombre.value,
                    txtRazonSocial      : elem.txtRazonSocial.value,
                    txtSiglas           : elem.txtSiglas.value,
                    txtRuc              : elem.txtRuc.value,
                    txtEmail            : elem.txtEmail.value,
                    txtTelefono         : elem.txtTelefono.value,
                    txtAbbr             : elem.txtAbbr.value,
                    txtEstado           : elem.chkEstado.checked,
                    txtPreDireccion     : elem.radPreDireccion.value,
                    txtDireccion        : elem.txtDireccion.value,
                    txtUrbLocalidad     : elem.txtUrbLocalidad.value,
                    txtDistrito         : elem.txtDistrito.value,
                    txtProvincia        : elem.txtProvincia.value,
                    txtDepartamento     : elem.txtDepartamento.value,
                    txtCodPostal        : elem.txtCodPostal.value,
                    txtRepresentante    : elem.txtRepresentante.value,
                    txtDniRepre         : elem.txtDniRepre.value,
                    txtResponsable      : elem.txtResponsable.value,
                    txtCipResp          : elem.txtCipResp.value,
                    txtDirNum           : elem.txtDirNum.value
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
                fnEliminar(id,this);
                break;
        }


    }
    var targetTR;

    function fnEditar(id){
        console.log('editar');
          $.post(BASE_URL + 'instalacion/data/' + id, {}, function(data, textStatus, xhr) {
            console.log(data);

            if(data.resultado){
                var obj = data.objRes;
                var frm = new Form('frmRegistro');
                var ele = frm.getElements();
                ele.txtNombre.value = obj.ins_nombre;
                ele.txtRazonSocial.value = obj.ins_razon_social;
                ele.txtSiglas.value = obj.ins_rz_siglas;
                ele.txtRuc.value = obj.ins_ruc;
                ele.txtEmail.value = obj.ins_email;
                ele.txtAbbr.value = is.null(obj.ins_abbr) ? '' : obj.ins_abbr;
                ele.txtTelefono.value = obj.ins_telefono;
                // ele.chkEstado.checked = obj.ins_;
                obj.ins_estado == 1 ? $(ele.chkEstado).iCheck('check') : $(ele.chkEstado).iCheck('uncheck')
                // ele.radPreDireccion.value = obj.ins_;
                $(ele.radPreDireccion).iCheck('uncheck');
                $(ele.radPreDireccion).each(function(e,v){
                    console.log(v.value.toLowerCase());
                    console.log(obj.ins_attr_direccion.toLowerCase());
                    console.log(v.value.toLowerCase() == obj.ins_attr_direccion.toLowerCase());
                    if(v.value.toLowerCase() == obj.ins_attr_direccion.toLowerCase())
                        $(v).iCheck('check');
                })
                ele.txtDireccion.value = obj.ins_direccion;
                ele.txtUrbLocalidad.value = obj.ins_urb_localidad;
                ele.txtDistrito.value = obj.dis_id_distrito;
                ele.txtProvincia.value = obj.pro_id_provincia;
                ele.txtDepartamento.value = obj.dep_id_departamento;
                ele.txtCodPostal.value = obj.ins_cod_postal;
                ele.txtRepresentante.value = obj.ins_representante;
                ele.txtDniRepre.value = obj.ins_dni_representante;
                ele.txtResponsable.value = obj.ins_ing_responsable;
                ele.txtCipResp.value = obj.ins_cip_responsable;
                ele.txtDirNum.value = obj.ins_dir_num;

                // ele.txtNombre.value = obj.dep_nombre;
                // obj.dep_estado == 1 ? $(ele.chkEstado).iCheck('check') : $(ele.chkEstado).iCheck('uncheck')
                // ele.chkEstado.value = obj.dep_estado;
                ele.txtId.value = id;
                // btnCancelar.removeClass('hidden');
                btnRegistrar.html('Actualizar');
                btnRegistrar.get(0).dataset.accion = 'actualizar';


                // $('#tituloModal').scrollTo(-30);

                $(ele.txtNombre).focus();
                 modRegistro.modal('show');



            }
        },'json').fail(fnFailAjax);
    }
    function fnEliminar(id,element){
        console.log('eliminar')

        $.post(BASE_URL + 'instalacion/eliminar/' + id, {}, function(data, textStatus, xhr) {
            if(data.resultado)
                dtListar.row($(element).toParent('tr')).remove().draw();
        },'json');
    }

    function fnAbrirModal(e){
        e.preventDefault();
         var frmRegistro = new Form('frmRegistro');
        var elem = frmRegistro.getElements();
        frmRegistro.reset();
        $(elem.radPreDireccion).iCheck('uncheck');
        $(elem.chkEstado).iCheck('check');
        modRegistro.modal('show');
    }
    function fnBuscarChange(){

    }
    function fnBuscar(e){
        // console.log(e);
        e.preventDefault();
        filtrosDatatable = [];


        var frmF = new Form('frmFiltrar').getElements();

        // frmF.txtNombreF.value;
        // frmF.txtEstadoF.value;

        if(frmF.selEstadoB.value != -1)
            filtrosDatatable.push({
                column : 'ins_estado',
                filter : frmF.selEstadoB.value});

        if(frmF.txtNombreB.value.trim() != '')
            filtrosDatatable.push({
                column : 'ins_nombre',
                filter : frmF.txtNombreB.value});

        if(frmF.txtRazonSocialB.value.trim() != '')
            filtrosDatatable.push({
                column : 'ins_razon_social',
                filter : frmF.txtRazonSocialB.value});

        if(frmF.txtRuc.value.trim() != '')
            filtrosDatatable.push({
                column : 'ins_ruc',
                filter : frmF.txtRuc.value});

        // dtListar.search( frmF.txtNombreF.value ).draw();
        dtListar.draw();
        // $(frmF.txtNombreF).focus();
    }
    $('#frmFiltrar').
    on('change','select.input-filter',fnBuscar).
    on('keyup','input[type="text"].input-filter',fnBuscar);



};