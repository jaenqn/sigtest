window.onload = fnLoad;
var dtListarHoy;
var dtListarSemana;
var DATAS_FECHA = [];
var FECHAS_RANGO = {inicio:'',val_inicio:0,fin:'',val_fin:0,tipo : 0};
var firstPick = {a : true,b : true};
function fnLoad(){
    moment.locale('es');
    $.fn.dataTable.moment( 'DD/MM/YY' );
    var tblListar = $('#tblListar');
    var tblListarHoy = $('#tblListarHoy');
    var tblListarSemana = $('#tblListarSemana');
    var selOpcionVisitas = $('#selOpcionVisitas');
    var btnGenerarVisitasRango = $('#btnGenerarVisitasRango');

    var contenedor_tablas = $('#contenedor_tablas');
    var target_fecha = $('#target_fecha');
    var target_total_visitas = $('#target_total_visitas');
    target_fecha.text(moment().format('DD/MM/YY'));

    btnGenerarVisitasRango.on('click',function(e){
        console.log(FECHAS_RANGO);
        if(typeof(dtListarSemana) != 'undefined'){
            dtListarSemana.ajax.url(BASE_URL + "usuario/lista_visita/rango");
            dtListarSemana.ajax.reload();
        }
        else{

            initDatatableSemana('rango');
        }
        FECHAS_RANGO.tipo = 1;
        // dtListarSemana.ajax.reload();
        tblListarSemana.toParent('.tbl-container').removeClass('hidden');
    })
    $('#txtFechaInicio').daterangepicker({
        singleDatePicker : true,
        timePicker: false,
        calender_style: "picker_2",
        autoUpdateInput : true,
          "opens": "right",
        locale: {
            format: 'DD/MM/YYYY'
        }
    },function(start, end, label) {
            // console.log(start);
            // console.log(end);
            // FECHAS_RANGO.inicio = start.format('YYYY-MM-DD');
            // FECHAS_RANGO.val_inicio = +start.format('x');
            // if(FECHAS_RANGO.val_inicio < FECHAS_RANGO.val_fin)
            //     btnGenerarVisitasRango.prop('disabled',false);
            // else btnGenerarVisitasRango.prop('disabled',true);
            // this.element[0].value = start.format('DD/MM/YY');
            // target_fecha.text(FECHAS_RANGO.inicio + ' - ' + FECHAS_RANGO.fin);
    }).on('apply.daterangepicker',function(e,p){
        console.log('date picke');
        console.log(e);
        console.log(p);
        // if(firstPick.a){
            FECHAS_RANGO.inicio = p.startDate.format('YYYY-MM-DD');
            FECHAS_RANGO.val_inicio = +p.startDate.format('x');
            if(FECHAS_RANGO.val_inicio < FECHAS_RANGO.val_fin)
                btnGenerarVisitasRango.prop('disabled',false);
            else btnGenerarVisitasRango.prop('disabled',true);
            this.value = p.startDate.format('DD/MM/YY');
            target_fecha.text(FECHAS_RANGO.inicio + ' - ' + FECHAS_RANGO.fin);
            firstPick.a = false;
        // }



    });
    $('#txtFechaFinal').daterangepicker({
        singleDatePicker : true,
        timePicker: false,
        calender_style: "picker_2",
        autoUpdateInput : true,
        "opens": "left",
        // "startDate": moment().subtract(1,'day').format('DD/MM/YYYY'),
        locale: {
            format: 'DD/MM/YYYY'
        }
    },function(start, end, label) {
            // console.log(start);
            // console.log(end);
            // // console.log(start.format('YYYY-MM-DD'));
            // FECHAS_RANGO.fin = start.format('YYYY-MM-DD');
            // FECHAS_RANGO.val_fin = +start.format('x');
            // if(FECHAS_RANGO.val_inicio < FECHAS_RANGO.val_fin)
            //     btnGenerarVisitasRango.prop('disabled',false);
            // else btnGenerarVisitasRango.prop('disabled',true);
            // this.element[0].value = start.format('DD/MM/YY');
            // target_fecha.text(FECHAS_RANGO.inicio + ' - ' + FECHAS_RANGO.fin);
                // console.log(this.element[0].value);
    }).on('apply.daterangepicker',function(e,p){

        // if(firstPick.a){
            // FECHAS_RANGO.inicio = p.startDate.format('YYYY-MM-DD');
            // FECHAS_RANGO.val_inicio = +p.startDate.format('x');
            // if(FECHAS_RANGO.val_inicio < FECHAS_RANGO.val_fin)
            //     btnGenerarVisitasRango.prop('disabled',false);
            // else btnGenerarVisitasRango.prop('disabled',true);
            // this.value = p.startDate.format('DD/MM/YY');
            // target_fecha.text(FECHAS_RANGO.inicio + ' - ' + FECHAS_RANGO.fin);
            // firstPick.a = false;

            FECHAS_RANGO.fin = p.startDate.format('YYYY-MM-DD');
            FECHAS_RANGO.val_fin = +p.startDate.format('x');
            if(FECHAS_RANGO.val_inicio < FECHAS_RANGO.val_fin)
                btnGenerarVisitasRango.prop('disabled',false);
            else btnGenerarVisitasRango.prop('disabled',true);
            this.value = p.startDate.format('DD/MM/YY');
            target_fecha.text(FECHAS_RANGO.inicio + ' - ' + FECHAS_RANGO.fin);
        // }



    });
    window.DATA_USUARIOS = {
          activos : '--'
        }
    var usuariosConectado = $('#usuariosConectado');
    var usuariosEnLinea = $('#usuariosEnLinea');
    setInterval(fnLoadVisitas,500);

    function fnLoadVisitas(){

        usuariosConectado.html(DATA_USUARIOS.activos);
        usuariosEnLinea.html(DATA_USUARIOS.activos_enlinea);
    }
    selOpcionVisitas.on('change',function(e){
        // console.log(this.value);
        switch(+this.value){
            case 1://hoy
                $('.container-rango').addClass('hidden');
                tblListarHoy.toParent('.tbl-container').removeClass('hidden');
                tblListarSemana.toParent('.tbl-container').addClass('hidden');
                dtListarHoy.ajax.url(BASE_URL + "usuario/lista_visita/hoy");
                dtListarHoy.ajax.reload();
                target_fecha.text(moment().format('DD/MM/YY'));
                break;
            case 2://ayer
                $('.container-rango').addClass('hidden');
                tblListarHoy.toParent('.tbl-container').removeClass('hidden');
                tblListarSemana.toParent('.tbl-container').addClass('hidden');
                dtListarHoy.ajax.url(BASE_URL + "usuario/lista_visita/ayer");
                target_fecha.text(moment().subtract('1','day').format('DD/MM/YY'))
                dtListarHoy.ajax.reload();
                break;
            case 3://semana
                var dia_sem = +moment().format('e');
                var t = dia_sem == 0 ? 6 : (dia_sem == 1 ? 0 : (dia_sem - 1));
                var ini_sem = moment();
                ini_sem = ini_sem.subtract(t,'day');
                var fa = ini_sem.format('DD/MM/YY');
                var fin_sem = ini_sem.add(6,'day');
                var fb = fin_sem.format('DD/MM/YY');
                target_fecha.text(moment().isoWeek(+moment().format('w')).startOf("isoweek").format('DD/MM/YY') + ' - ' + moment().isoWeek(+moment().format('w')).endOf("isoweek").format('DD/MM/YY'));
                FECHAS_RANGO.tipo = 0;
                $('.container-rango').addClass('hidden');
                tblListarSemana.toParent('.tbl-container').removeClass('hidden');
                tblListarHoy.toParent('.tbl-container').addClass('hidden');
                if(typeof(dtListarSemana) == 'undefined')
                    initDatatableSemana('semana');
                else{
                    dtListarSemana.ajax.url(BASE_URL + "usuario/lista_visita/semana");
                    dtListarSemana.ajax.reload();
                }

                break;
            case 4://rango
                target_fecha.text('');
                FECHAS_RANGO.tipo = 1;
                tblListarHoy.toParent('.tbl-container').addClass('hidden');
                tblListarSemana.toParent('.tbl-container').addClass('hidden');
                $('.container-rango').removeClass('hidden');
                $('#txtFechaInicio').val('');
                $('#txtFechaFinal').val('');
                btnGenerarVisitasRango.prop('disabled',true)
                // dtListarSemana.ajax.url(BASE_URL + "usuario/lista_visita/semana");
                // DATAS_FECHA = {
                //     fecha_inicio :'asd',
                //     fecha_final :'asd'
                // }

                // if(typeof(dtListarSemana) == 'undefined')
                //     initDatatableSemana();
                    // dtListarSemana.ajax.reload();
                // else initDatatableSemana();
                target_total_visitas.text('--');
                break;

        }


    });
    // selOpcionVisitas.val(4).trigger('change');

    dtListarHoy = tblListarHoy.DataTable({
        language: lenguajeDatatable,
        scrollX : "100%",
        scrollXInner : "100%",
        lengthChange : false,
        dom : 'ltip',
        processing : false, //Feature control the processing indicator.
        serverSide : false, //Feature control DataTables' server-side processing mode.
        pageLength: 6,
        order : [], //Initial no order.
        ajax : {
            url : BASE_URL + "usuario/lista_visita/hoy",
            type : "POST",
            data : function(d){
                d.data_values = FECHAS_RANGO;
                // d.filters = filtrosDatatable;
            },
            error : function(e){console.log(e.responseText);}
        },
        // ajax : BASE_URL + "usuario/lista_visita/hoy",
        // createdRow : function ( row, data, index ) {
        //     if(data.res_es_otro == 0)
        //         $(row).addClass('tr-otro-origen');
        // },
        columns: [
            // {data : 'hora', render : function(d, t, r){
            //     return d;
            // }},
            {data : 'hora_format', render : function(d,t,r){

                return d;
            }},
            {data : 'visitas'}


        ],


        // columnDefs : [
        //     {
        //         targets : [ 4 ],
        //         orderable : false,

        //     },

        // ],
    });
    dtListarHoy.on( 'draw.dt', function (e, settings) {
        var datas = settings.json.data;
        var total = 0;
        $(datas).each(function(e,v){
            total += +v.visitas;
        })
        target_total_visitas.text(total);
        // $('#myInput').val( data.myCustomValue );
    });
    tblListarSemana.on('click','.btn-ver-fecha',function(e){
        selOpcionVisitas.val('').trigger('change');
        var fecha = this.dataset.fecha;
        console.log(fecha);
        FECHAS_RANGO.tipo = 2;
        FECHAS_RANGO.inicio = fecha;
        $('.container-rango').addClass('hidden');
        tblListarSemana.toParent('.tbl-container').addClass('hidden');
        tblListarHoy.toParent('.tbl-container').removeClass('hidden');
        dtListarHoy.ajax.url(BASE_URL + "usuario/lista_visita/dia");

        target_fecha.text(fecha);

        // target_fecha.text(moment().subtract('1','day').format('DD/MM/YY'))
        dtListarHoy.ajax.reload();
        // dtListarHoy.draw();
    })
    function initDatatableSemana(urlref = false){
        if(urlref){
            urlref = BASE_URL + "usuario/lista_visita/" + urlref;
        }
        dtListarSemana = tblListarSemana.DataTable({
            language: lenguajeDatatable,
            scrollX : "100%",
            scrollXInner : "100%",
            lengthChange : false,
            dom : 'ltip',
            processing : false, //Feature control the processing indicator.
            serverSide : false, //Feature control DataTables' server-side processing mode.
            pageLength: 7,
            order : [0,'asc'], //Initial no order.
            ajax : {
                url : urlref,
                type : "POST",
                data : function(d){
                    d.data_values = FECHAS_RANGO;
                    // d.filters = filtrosDatatable;
                },
                error : function(e){console.log(e.responseText);}
            },
            columns: [

                {data : 'fecha_semana',render : function(d,t,r){
                    return moment(d).format('DD/MM/YY');
                }},
                {data : 'num_visitas'},
                {data : 'fecha_semana', render : function(d,t,r){
                    return '<a href="#" class="btn-ver-fecha" data-fecha="'+ d+'"><i class="glyphicon glyphicon-time"></i> ver</a>'
                }}

            ]
        });

        dtListarSemana.on( 'draw.dt', function (e, settings) {
            var datas = settings.json.data;
            var total = 0;
            $(datas).each(function(e,v){
                total += +v.num_visitas;
            })
            target_total_visitas.text(total);
            // $('#myInput').val( data.myCustomValue );
        });
    }


}

