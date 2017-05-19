window.onload = fnLoad;

var gn = {};
gn.tpl_opcion = `
<a href="{{target_url}}" target="_blank"  data-id-obj="{{id}}" class="btnAcciones btnEditar btn btn-default btn-option-files" data-accion="visitar" style="" data-toggle="tooltip" data-placement="left" title="" data-original-title="Ver"><i class="fa fa-share" style="font-size:1em"></i></a>
<a  href="{{ur_editar}}" data-id-obj="{{id}}" class="btnAcciones btnEditar btn btn-default btn-option-files" data-accion="editar" style="" data-toggle="tooltip" data-placement="left" title="" data-original-title="Editar"><i class="fa fa-pencil" style="font-size:1em"></i></a> <button type="button" data-id-obj="{{id}}" class="btnAcciones btnEliminar btn btn-default btn-option-files delete" data-accion="eliminar" style="" data-toggle="tooltip" data-placement="left" title="" data-original-title="Eliminar"><i class="fa fa-trash" style="font-size:1em"></i></button>
`;
function fnLoad(){
    gn.btnGenerarNot = $('#btnGenerarNot');
    gn.tblListar = $('#tblListar');
    var filtrosDatatable = [];

   $('#txtFechaNot').daterangepicker({
        singleDatePicker : true,
        timePicker: false,
        calender_style: "picker_2",
        autoUpdateInput : true,
        "opens": "left",
        // "startDate": moment().subtract(1,'day').format('DD/MM/YYYY'),
        locale: {
            format: 'DD/MM/YYYY'
        }
    }).val('');
    gn.btnGenerarNot.on('click',fnGenerarNot);
    gn.tblListar.on('click','.btn-visible',function(e){
        var idn = this.dataset.idObj;
        var self = this;
        switch(this.dataset.accion){
            case 'publicar':
                console.log(BASE_URL + 'noticias/publicar/' + idn);
                $.getJSON(BASE_URL + 'noticias/publicar/' + idn, {}, function(json, textStatus) {
                    console.log(json);
                    if(json.resultado){
                        self.dataset.accion = 'ocultar';
                        $(self).find('i').removeClass('fa-eye-slash').addClass('fa-eye');
                    }
                }).fail(fnFailAjax);
                break;
            case 'ocultar':
                console.log(BASE_URL + 'noticias/ocultar/' + idn);
                $.getJSON(BASE_URL + 'noticias/ocultar/' + idn, {}, function(json, textStatus) {
                    console.log(json);
                    if(json.resultado){
                        self.dataset.accion = 'publicar';
                        $(self).find('i').removeClass('fa-eye').addClass('fa-eye-slash');
                    }
                }).fail(fnFailAjax);
                break;
        }

    }).on('click','.btn-option-files.delete',function(e){
        // console.log(gn.dtListar.row(this));


        // gn.dtListar.row($(this).parents('tr')).remove().draw();
        // gn.dtListar.row($(this).parents('tr')).remove();
        var ttr = $(this).parents('tr');
        var idnot = this.dataset.idObj;
        swal_option.confirm.title = 'Eliminar Noticia';
        swal_option.confirm.text = '¿Desea eliminar  noticia?';
        swal_option.confirm.type = 'warning';
        swal_option.confirm.closeOnCancel = true;

        swal(swal_option.confirm,
            function(isConfirm){
                console.log('eliminarconfimr');
                $.getJSON(BASE_URL + 'noticias/eliminar/' + idnot, {}, function(json, textStatus) {
                    if(json.resultado){
                        swal("Noticia Eliminada!",'', "success");
                        ttr.remove();
                    }
                });

            });
    });
    gn.dtListar = gn.tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [0,'desc'], //Initial no order.
        ajax : {
            url : BASE_URL + "noticias/datatables",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        // drawCallback : function( settings ) {
        //     console.log(this);
        //     console.log(settings);
        //     console.log(settings.json.data[0]);
        //     settings.json.data = [];
        //     return false;
        //     console.log( 'DataTables has redrawn the table' );
        // },
        // preDrawCallback : function( settings ) {
        //     // console.log(settings);
        //     // console.log(redrawn);
        //     // if(redrawn)
        //     //     console.log('draw');
        //     // else
        //     //     return false;

        // },
        columns: [
            {data : 'not_titulo', render: function(d,t,r){
                return $.trim('d') != '' ? d : 'Sin título';
            }},
            { data : "not_fecha_generado" },
            { data : "not_autor", render : function(d,t,r){
               return $.trim('d') != '' ? d : '- - - - -';
            } },
            { data : "not_publico", render : function(d,t,r){
                if(d == 1) return '<button type="button" data-id-obj="'+r.not_id+'" class="btnAcciones btnEditar btn btn-default btn-option-files btn-visible" data-accion="ocultar" style="" data-toggle="tooltip" data-placement="left" title="Publicar Noticia" data-original-title="Editar"><i class="fa fa-eye" style="font-size:1em"></i></button>';
                else return '<button type="button" data-id-obj="'+r.not_id+'" class="btnAcciones btnEditar btn btn-default btn-option-files btn-visible" data-accion="publicar" style="" data-toggle="tooltip" data-placement="left" title="Ocultar Noticia" data-original-title="Editar"><i class="fa fa-eye-slash" style="font-size:1em"></i></button>'
            } },
            { data : "not_id",render:function(data, type, row){

                // console.log(row);
                // console.log(type);
                // console.log(row);
                // if(row.rso_es_otro == 0){
                //     var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnAgregarOtro" data-accion="agregar-otro">agregar</a>';
                //     t = Handlebars.compile(t);
                //     return t({id : data});
                // }else{
                    var t = gn.tpl_opcion;
                    t = Handlebars.compile(t);
                    var ref_url = BASE_URL + 'home/noticia/' + data;
                    // switch(+row.bol_estado){
                    //      case 1:
                    //         ref_url = BASE_URL + 'boletasig/aprobar/' + data;
                    //         break;
                    //     case 2:
                    //         ref_url = BASE_URL + 'boletasig/procesar/' + data;
                    //         break;
                    //     case 3:
                    //         ref_url = BASE_URL + 'boletasig/respuesta/' + data;
                    //         break;
                    //     case 4:
                    //         ref_url = BASE_URL + 'boletasig/fiscalizar/' + data;
                    //         break;
                    //     case 5:
                    //         ref_url = BASE_URL + 'boletasig/rechazada/' + data;
                    //         break;
                    // }
                    return t({
                        id : data,
                        target_url : ref_url,
                        ur_editar : BASE_URL + 'gestor/noticias/editar/' +  data
                    });
                // }

            } }

        ],


        columnDefs : [
            {
                targets : [ 4 ],
                orderable : false,
                width: '130px'

            },
            {
                className : 'td-middle', targets : [1,3]
            }

        ],
    });

}

function fnGenerarNot(e){
    $.getJSON(BASE_URL + 'noticias/generar', {}, function(json, textStatus) {
        console.log(json);
        if(json.resultado){

            gn.dtListar.page(gn.dtListar.page()).draw('page');
            // window.location = BASE_URL + 'noticias'
        }
    });
}