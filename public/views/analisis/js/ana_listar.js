var ap = {};
var dtListar;
var filtrosDatatable;
$(document).ready(function() {
    ap.modRegistro = $('#modRegistro');
    ap.btnActualizarPro = $('#btnActualizarPro');

    ap.btnActualizarPro.on('click', fnAbrirModal);
    ap.tblListar = $('#tblListar');
    filtrosDatatable = [];
    dtListar = ap.tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false,
        autoWidth: true,
        responsive: true,
        serverSide : true,
        fixedHeader: true,
        order : [0,'asc'],
        ajax : {
            "url": BASE_URL + "analisis_proceso/datatables_list",
            "type": "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        columns : [

            { data : "pro_nombre" },
            { data : "uni_nombre"},
            { data : "dep_nombre" },
            { data : "apr_estado", render : function(d, t, r){
                switch(+d){
                    case 1: return 'Actualizable'; break;
                    case 2: return 'Elaborado'; break;
                    case 3: return 'Revisado'; break;
                    case 4: return 'Aprobado'; break;
                    case 5: return 'Finalizado'; break;
                    default: return '----';
                }

            } },
            { data : "apr_fecha_apr", render : function(d, t, r){
                console.log(d);
                if(is.null(d)){
                    return '-- -- --';
                }else{
                    var g = moment(d);
                    if(g.isValid()) return g.format('DD/MM/YY');

                }
            } },
            { data : "apr_id",render:function(data, type, row){
                var t = '<a href="{{urla}}"   class="btnAcciones btnEditar btn btn-default btn-option-files"   title="Ver" ><i class="fa fa-eye" style="font-size:1em"></i></a><a href="{{urlb}}"  class="btnAcciones btnEditar btn btn-default btn-option-files" title="Editar"><i class="fa fa-pencil" style="font-size:1em"></i></a>';
                t = Handlebars.compile(t);
                return t({
                    urla : BASE_URL + 'analisis_proceso/ver/' +data,
                    urlb : BASE_URL + 'analisis_proceso/editar/' + data
                });
            } }

        ],


        columnDefs : [
            {
                targets : [ 5 ],
                orderable : false,
                width : '66px',
                createdCell : function (td, cellData, rowData, row, col) {
                    $(td).css({
                        'text-align' : 'center',
                        'vertical-align' : 'middle'
                    });

                }


            },
            {
                targets : [ 3, 4 ],
                createdCell : function (td, cellData, rowData, row, col) {
                    $(td).css({
                        'text-align' : 'center',
                        'vertical-align' : 'middle'
                    });

                },
                width : '100px'
            }

        ],

    });
    dtListar.column(opc_render[0]).visible(false);
    dtListar.column(opc_render[1]).visible(false);

});

function fnAbrirModal(){
    ap.modRegistro.modal('show');
}