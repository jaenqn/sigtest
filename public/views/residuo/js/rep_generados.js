var rg = {
    filtroResiduo : {
        f_tipo        : -1,
        f_organico    : -1,
        f_estado      : -1
    },
    opcReporte : {
        residuos    : [],
        unidad      : -1,
        date        : -1,
        t           : 'rep',
        res_tipos   : []
    },
    tpltrres :      `
                    <tr>
                        <td class="app-text-center" style=""><div>{{nombre}}</div></td>
                        <td class="app-text-center">{{val_1}}</td>
                        <td class="app-text-center">{{val_2}}</td>
                        <td class="app-text-center">{{val_3}}</td>
                        <td class="app-text-center">{{val_4}}</td>
                        <td class="app-text-center">{{val_5}}</td>
                        <td class="app-text-center">{{val_6}}</td>
                        <td class="app-text-center">{{val_7}}</td>
                        <td class="app-text-center">{{val_8}}</td>
                        <td class="app-text-center">{{val_9}}</td>
                        <td class="app-text-center">{{val_10}}</td>
                        <td class="app-text-center">{{val_11}}</td>
                        <td class="app-text-center">{{val_12}}</td>
                        <td class="app-text-center">{{val_total}}</td>
                    </tr>
                    `

};
var nf = new Intl.NumberFormat("de-DE", {minimumFractionDigits : 2, maximumFractionDigits : 2});
$(document).ready(function() {
    rg.selArea = $('#selArea');
    rg.selUnidad = $('#selUnidad');
    rg.selResiduo = $('#selResiduo');
    rg.selYear = $('#selYear');
    rg.tbodyRes = $('#tbodyRes');
    rg.opcReporte.date = rg.selYear.val();
    rg.opcReporte.residuos = rg.selResiduo.val();

    rg.btnGenRep = $('#btnGenRep');
    rg.btnGenerar = $('#btnGenerar');
    rg.fResultado = $('#fResultado');

    rg.selPeligro = $('#selPeligro');
    rg.selOrganico = $('#selOrganico');
    rg.selEstado = $('#selEstado');


    rg.btnGenRep.on('click',fnGenClick);

    rg.selArea.on('change', fnSelAreaChange);
    rg.selUnidad.on('change', fnSelUniChange);
    rg.selResiduo.on('select2:select', fnSelResChange);
    rg.selYear.on('change', fnSelYearChange);

    rg.selPeligro.on('change', fnSelPelChange);
    rg.selOrganico.on('change', fnSelOrgChange);
    rg.selEstado.on('change', fnSelEstChange);

    var ta = [];
    rg.selResiduo.find('option').each(function(e,v){
        ta.push(v.value);
    });
    ta = ARRAY.removeNum(ta, -1);
    rg.opcReporte.residuos = ta;
});

function fnGenClick(){
    //getdatos de filtro
    //verificar que se seleccione una unidad
    rg.opcReporte.res_tipos = rg.filtroResiduo;
    // rg.opcReporte.residuos = rg.selResiduo.val();
    if(rg.selUnidad.val() == null)
        rg.opcReporte.unidad = -1;
        var pase = false;
    if(rg.selResiduo.val() != null){
        if(rg.selArea.val() != -1){
            if(rg.selUnidad.val() != null){
                pase = true;
            }
        }else{
           pase = true;
        }
        if(pase){
            $.post(BASE_URL + 'residuo/reportes_generados', rg.opcReporte, function(data, textStatus, xhr) {
                    console.log(data);
                    // var datares = data.data;
                    if(data.resultado){
                        var idres =rg.opcReporte.residuos;
                        var tempres = rg.selResiduo.find('option').toArray();
                        var t = Handlebars.compile(rg.tpltrres);
                        var html = '';
                        var fortotal = {
                            v1 : 0,
                            v2 : 0,
                            v3 : 0,
                            v4 : 0,
                            v5 : 0,
                            v6 : 0,
                            v7 : 0,
                            v8 : 0,
                            v9 : 0,
                            v10 : 0,
                            v11 : 0,
                            v12 : 0,
                            t: 0
                        }
                        idres.forEach(function(idr,i){
                            var targetR = data.data.find(function(e, v){
                                return +e.res_id_residuo == idr;
                            });

                            if(targetR != undefined){
                                fortotal.v1 += +targetR.res_1;
                                fortotal.v2 += +targetR.res_2;
                                fortotal.v3 += +targetR.res_3;
                                fortotal.v4 += +targetR.res_4;
                                fortotal.v5 += +targetR.res_5;
                                fortotal.v6 += +targetR.res_6;
                                fortotal.v7 += +targetR.res_7;
                                fortotal.v8 += +targetR.res_8;
                                fortotal.v9 += +targetR.res_9;
                                fortotal.v10 += +targetR.res_10;
                                fortotal.v11 += +targetR.res_11;
                                fortotal.v12 += +targetR.res_12;
                                fortotal.t += +targetR.res_peso;
                                html += t({
                                    nombre : targetR.res_nombre,
                                    val_1 : nf.format(targetR.res_1),
                                    val_2 : nf.format(targetR.res_2),
                                    val_3 : nf.format(targetR.res_3),
                                    val_4 : nf.format(targetR.res_4),
                                    val_5 : nf.format(targetR.res_5),
                                    val_6 : nf.format(targetR.res_6),
                                    val_7 : nf.format(targetR.res_7),
                                    val_8 : nf.format(targetR.res_8),
                                    val_9 : nf.format(targetR.res_9),
                                    val_10 : nf.format(targetR.res_10),
                                    val_11 : nf.format(targetR.res_11),
                                    val_12 : nf.format(targetR.res_12),
                                    val_total : nf.format(targetR.res_peso)

                                });
                            }else{
                                var tartt = tempres.find(function(e,i){
                                    return e.value == idr;
                                });
                                // html += t({
                                //     nombre : tartt.text,
                                //     val_1 : nf.format(0),
                                //     val_2 : nf.format(0),
                                //     val_3 : nf.format(0),
                                //     val_4 : nf.format(0),
                                //     val_5 : nf.format(0),
                                //     val_6 : nf.format(0),
                                //     val_7 : nf.format(0),
                                //     val_8 : nf.format(0),
                                //     val_9 : nf.format(0),
                                //     val_10 : nf.format(0),
                                //     val_11 : nf.format(0),
                                //     val_12 : nf.format(0),
                                //     val_total : nf.format(0)

                                // });
                            }


                        });
                        html += t({
                                    nombre : 'Total',
                                    val_1 : nf.format(fortotal.v1),
                                    val_2 : nf.format(fortotal.v2),
                                    val_3 : nf.format(fortotal.v3),
                                    val_4 : nf.format(fortotal.v4),
                                    val_5 : nf.format(fortotal.v5),
                                    val_6 : nf.format(fortotal.v6),
                                    val_7 : nf.format(fortotal.v7),
                                    val_8 : nf.format(fortotal.v8),
                                    val_9 : nf.format(fortotal.v9),
                                    val_10 : nf.format(fortotal.v10),
                                    val_11 : nf.format(fortotal.v11),
                                    val_12 : nf.format(fortotal.v12),
                                    val_total : nf.format(fortotal.t)
                                });
                        rg.tbodyRes.html(html);
                        rg.btnGenerar.removeAttr('disabled');
                        rg.btnGenerar.attr('href', BASE_URL + 'residuo/get_reporte_generados?' + $.param(rg.opcReporte));
                        rg.fResultado.removeClass('hidden');
                    }
            },'json').fail(fnFailAjax);
        }

    }

}
function fnSelYearChange(){
    rg.opcReporte.date = this.value;
}
function fnSelAreaChange(){

    if(this.value != -1){
        $.getJSON(BASE_URL + 'unidad/listar_by_dep/' + this.value, {}, function(json, textStatus) {
            console.log(json);
            var t = Handlebars.compile(TEMPLATES.option);
            var html = '';
            for (var i = 0; i < json.length; i++) {
                html += t({id : json[i].idDepend, text : json[i].desDepend});
            };

            if(json.length != 0) rg.selUnidad.prop('disabled', false);

            rg.selUnidad.html(html);
            rg.opcReporte.unidad = rg.selUnidad.val();
        });
    }else{
        rg.selUnidad.val('-1').trigger('change');
        rg.selUnidad.prop('disabled', true);
        rg.opcReporte.unidad = -1;
    }
}

function fnSelUniChange(){

    rg.opcReporte.unidad = this.value;
}
function removeInArray(){

}
function fnSelResChange(evt){
    console.log('change res');
    var tvalues = rg.selResiduo.val();
    if(tvalues != null){
        console.log('dif null');
        if(ARRAY.existNum(tvalues, -1)){
            console.log('whir values');
            if(+evt.params.data.id == -1){
                console.log('asdsd');
                rg.selResiduo.val('-1').trigger('change');
                var ta = [];
                rg.selResiduo.find('option').each(function(e,v){
                    ta.push(v.value);

                });
                console.log(ta);
                ta = ARRAY.removeNum(ta, -1);
                console.log(ta);


                rg.opcReporte.residuos = ta;
                console.log('finish');
            }
            else{
                rg.selResiduo.val(ARRAY.removeNum(tvalues, -1)).trigger('change');
                rg.opcReporte.residuos = rg.selResiduo.val();

            }
        }else{

            rg.opcReporte.residuos = rg.selResiduo.val();
        }
    }else{
        console.log('is null');
        // rg.opcReporte.residuos = rg.selResiduo.val();
    }
    // if(+idr == -1){
    //     rg.selResiduo.val('-1').trigger('change');
    // }


}
//filtros para residuo
function fnSelPelChange(){

    rg.filtroResiduo.f_tipo = this.value;
    loadResiduos();
}
function fnSelOrgChange(){

    rg.filtroResiduo.f_organico = this.value;
    loadResiduos();
}
function fnSelEstChange(){

    rg.filtroResiduo.f_estado = this.value;
    loadResiduos();
}

function loadResiduos(){
    $.post(BASE_URL + 'residuo/lista_by_opciones', rg.filtroResiduo, function(data, textStatus, xhr) {
        console.log(data);
        var t = Handlebars.compile(TEMPLATES.option);
        var html = t({id : -1, text : 'Todos'});
        for (var i = 0; i < data.length; i++) {
            html += t({id : data[i].res_id, text : data[i].res_nombre});
        };
        rg.selResiduo.html(html);
        rg.opcReporte.residuos = [];
        // rg.selResiduo.val('-1').trigger('change');

    },'json');
}
//end filtros residuo

