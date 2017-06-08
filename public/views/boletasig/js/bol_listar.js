window.onload = fnLoad;
var dtListar;
var redrawn = true;
var predata = [];
var tpl_btn_opc_ver = `<a href="{{target_url}}"  data-id-obj="{{id}}" class="btnAcciones btnEditar btn btn-default btn-option-files" data-accion="editar" style="" data-toggle="tooltip" data-placement="left" title="" data-original-title="Ver"><i class="fa fa-eye" style="font-size:1em"></i></a>`;
function fnLoad(e){

    setInterval(function(){
        // if(redrawn)
            // dtListar.draw('page').page(dtListar.page());
            // redrawn = true;
            revisar();
    },1200);
    // $('#txtFechaInicio').daterangepicker({
    //     singleDatePicker : true,
    //     timePicker: false,
    //     calender_style: "picker_2",
    //     autoUpdateInput : false,
    //     "opens": "right",
    //     locale: {
    //         format: 'DD/MM/YYYY'
    //     }
    // }).val('');
    function revisar(){
        if((typeof(dtListar)).toLowerCase() != 'undefined'){
            $.post(BASE_URL + 'boletasig/reviewdata', dtListar.ajax.params(), function(json, textStatus) {
                        if(!(JSON.stringify(dtListar.ajax.json().data) === JSON.stringify(json.data)))
                            dtListar.draw('page').page(dtListar.page());
            },'json').fail(fnFailAjax);
        }
    }
    var filtrosDatatable = [];
    var tblListar = $('#tblListar');
    $('#menu_toggle').on('click',function(){dtListar.columns.adjust()})
    dtListar = tblListar.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",

            buttons: [
                {extend : 'print', className : 'btn btn-primary', text:'</span>Imprimir<span>', exportOptions: {
                    columns: [ 0, 1, 2,3,4,5 ,6]
                }}
            ],
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'Bltip',
        processing : false, //Feature control the processing indicator.
        serverSide : true, //Feature control DataTables' server-side processing mode.
        order : [4,'desc'], //Initial no order.
        ajax : {
            url : BASE_URL + "boletasig/datatables",
            type : "POST",
            data : function(d){
                d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        createdRow : function ( row, data, index ) {
            if(data.rso_es_otro == 0)
                $(row).addClass('tr-otro-origen');
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
            { data : "bol_correlativo" },
            { data : "bol_tipo", render : function(d,t,r){
                if(d == 2) return 'Seguridad';
                else return 'Ambiental';
            } },
            { data : "uni_rem_nombre" },
            { data : "uni_rec_nombre" },
            { data : "bol_fecha_generado", render : function(d,t,r){
                var g = moment(d);
                return g.format('DD/MM/YYYY');
            } },
            { render : function(d, t, r){
                if(r.bol_estado == 3){
                    fpro = moment();
                    fexp = moment(r.bol_expire);
                    var dife = fexp.diff(fpro, 'minutes');
                    return  dife < 0 ? 'Exedido : ' + dife : dife;
                }else return '-- --';

            } },
            { data : "bol_plazo_establecido" , render : function(d,t,r){
                // return '<p style="font-size:20px">😊</p>';
                switch(+d){
                    case 0:
                        switch(+r.bol_estado){
                            case 4:
                                return '<p style="font-size:20px">No</p>';
                                break;
                        }
                        return '<p style="font-size:20px">--</p>';
                        break;
                    case 1:
                        if(+r.bol_fin_seg == 0){

                            // verificar cuánto tiempo le queda para ejecutar las acciones posteriores
                            ffin = moment(moment(r.bol_fecha_plazo_fin).format('Y-MM-DD'));
                            fini = moment(moment(r.bol_fecha_plazo_ini).format('Y-MM-DD'));
                            fnow = moment(moment().format('Y-MM-DD'));
                            var dife = ffin.diff(fnow, 'days');
                            return '<p style="font-size:20px" title="'+fini.format('DD/MM/YY') +' al '+ ffin.format('DD/MM/YY') +'">Si ('+dife+')</p>';
                        }else{
                            return '<p style="font-size:20px">FIN</p>';
                        }
                    break;


                }
                return '<p style="font-size:20px">😊</p>';
            }},
            { data : "bol_estado" , render : function(d,t,r){
                var t = `<h2><span class="label lbl-est-{{tipo}}">{{tipo_l}}</span></h2>`;
                t = Handlebars.compile(t);
                // var h = '';
            switch(+d){
                    case 1: return t({tipo : 'elaborado', tipo_l : 'Elaborado'}); break;
                    case 2: return t({tipo : 'aprobado', tipo_l : 'Aprobado'}); break;
                    case 3: return t({tipo : 'procesado', tipo_l : 'Procesado'}); break;
                    case 4: return t({tipo : 'respondido', tipo_l : 'Respondido'}); break;
                    case 5: return t({tipo : 'rechazado', tipo_l : 'Rechazado'}); break;
                    case 6: return t({tipo : 'cerrado', tipo_l : 'Cerrado'}); break;
                    case 7: return t({tipo : 'sacp', tipo_l : 'Sacp'}); break;
                    case 8: return t({tipo : 'rechazado', tipo_l : 'Rechaza Elaborado'}); break;
                    case 9: return t({tipo : 'rechazado', tipo_l : 'Rechaza Procesado'}); break;
                    case 10: return t({tipo : 'respondido', tipo_l : 'Seguimiento'}); break;
                    case 11: return t({tipo : 'respondido', tipo_l : 'Seg. Respondido'}); break;
                    default: return t({tipo : 'rechazado', tipo_l : 'No definido'}); break;
                }
                // return h;

            }},
            { data : "bol_id",render:function(data, type, row){

                // console.log(row);
                // console.log(type);
                // console.log(row);
                // if(row.rso_es_otro == 0){
                //     var t = '<a href="" data-id-obj="{{id}}" class="btnAcciones btnAgregarOtro" data-accion="agregar-otro">agregar</a>';
                //     t = Handlebars.compile(t);
                //     return t({id : data});
                // }else{
                    var t = TEMPLATES.ref_accion;
                    t = Handlebars.compile(t);

                    var ref_url,title,icon;

                    ref_url = BASE_URL + 'boletasig/ver/' + data;
                    title = 'Ver';
                    icon = 'fa fa-eye';

                    switch(+row.bol_estado){
                        case 1:
                            if(ent_usuarios.isUsuario(+row.tipo_usuario, ['revisador', 'jefe'])){
                                ref_url = BASE_URL + 'boletasig/aprobar/' + data;
                                title = 'Aprobar';
                                icon = 'fa fa-check';
                            }

                            break;
                        case 2:
                        if(ent_usuarios.isUsuario(+row.tipo_usuario, ['administrador']) && ent_boleta.getRespondeBoleta(+row.bol_tipo) == +row.uni_activa){
                            ref_url = BASE_URL + 'boletasig/procesar/' + data;
                            title = 'Procesar';
                            icon = 'fa fa-retweet';
                        }else{
                            ref_url = BASE_URL + 'boletasig/ver/' + data;
                            title = 'Ver';
                            icon = 'fa fa-eye';
                        }


                            break;
                        case 3:


                            if(row.uni_activa == row.bol_uni_receptor){
                                ref_url = BASE_URL + 'boletasig/respuesta/' + data;
                                title =  'Responder';
                                icon = 'fa fa-bullhorn';

                            }else{
                                ref_url = BASE_URL + 'boletasig/ver/' + data;
                                title =  'Ver';
                                icon = 'fa fa-eye';
                            }
                            break;
                        case 4:
                            if(ent_usuarios.isUsuario(+row.tipo_usuario, ['administrador']) && ent_boleta.getRespondeBoleta(+row.bol_tipo) == +row.uni_activa){
                                if(+row.bol_plazo_establecido != 1){
                                    ref_url = BASE_URL + 'boletasig/fiscalizar/' + data;
                                    title = 'Fizcalizar';
                                    icon = 'fa fa-legal';
                                }

                            }
                            // else{
                            //     if(row.uni_activa == row.bol_uni_receptor){
                            //         ref_url = BASE_URL + 'boletasig/seguimiento/' + data;
                            //         title = 'Seguimiento';
                            //         icon = 'fa fa-eye';
                            //     }
                            // }
                            // if(+row.bol_plazo_establecido == 1){
                            //     ref_url = BASE_URL + 'boletasig/seguimiento/' + data;
                            //     title = 'Seguimiento';
                            // }else{

                            // }

                            break;
                        case 5:
                            ref_url = BASE_URL + 'boletasig/rechazada/' + data;
                            title = 'Rechazado';
                            icon = 'fa fa-eye';
                            break;
                        case 8:
                            ref_url = BASE_URL + 'boletasig/rechazada/' + data;
                            title = 'Rechazado';
                            icon = 'fa fa-eye';
                            break;
                        case 10:
                            if(row.uni_activa == row.bol_uni_receptor){
                                ref_url = BASE_URL + 'boletasig/seguimiento/' + data;
                                title = 'Seguimiento';
                                icon = 'fa fa-history';
                            }
                            break;
                        case 11:
                            if(ent_usuarios.isUsuario(+row.tipo_usuario, ['administrador']) && ent_boleta.getRespondeBoleta(+row.bol_tipo) == +row.uni_activa){
                                if(+row.bol_plazo_establecido == 1 && +row.bol_fin_seg == 1){
                                    ref_url = BASE_URL + 'boletasig/fiscalizar/' + data;
                                    title = 'Fizcalizar';
                                    icon = 'fa fa-legal';
                                }

                            }
                            break;
                    }
                    return t({
                        id : data,
                        target_url : ref_url,
                        accion : 'ver',
                        title : title,
                        icon : icon
                    }) + t({
                        id : data,
                        target_url : BASE_URL + 'boletasig/bitacora/' + data,
                        accion : 'bitacora',
                        title : 'Bitacora',
                        icon : 'fa fa-list-alt'
                    });
                // }

            } }

        ],


        columnDefs : [
            {
                targets : [ 8 ],
                orderable : false,
                width: '100px'

            },
            {
                className : 'td-middle', targets : [5,6,7,8]
            }

        ],
    });
    dtListar.buttons().container().find('a').appendTo('#imprimirLista');
    if(ocultar_columna){
        dtListar.column(ocultar_columna).visible(false);
    }
    // dtListar.on( 'draw.dt', function (e) {
    //     // console.log(dtListar);
    //     // console.log(e);
    //     // console.log(this);
    //     // console.log( 'Redraw occurred at: '+new Date().getTime() );
    //     // return false;
    // }).on( 'stateLoaded.dt', function (e, settings, data) {
    //     console.log(data);
    // } ).on('xhr.dt', function ( e, settings, json, xhr ) {
    //     //verificaer si los elementos cambiaron


    //     console.log(settings);
    //     if(!(JSON.stringify(predata) === JSON.stringify(json.data))){
    //         redrawn = true;

    //     }else{
    //         // settings.aoPreDrawCallback[0] = function(e){return false;};
    //         redrawn = false;
    //     }
    //     predata = json.data;



    //     // console.log(json);
    //     // console.log(xhr);
    //     // for ( var i=0, ien=json.aaData.length ; i<ien ; i++ ) {
    //     //     json.aaData[i].sum = json.aaData[i].one + json.aaData[i].two;
    //     // }
    //     // Note no return - manipulate the data directly in the JSON object.
    // } );
}