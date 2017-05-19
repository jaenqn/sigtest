window.onload = fnLoad;
function fnLoad(){
      $('input').focus(function(){
          this.select();
        })
    var filter_residuo = {
        f_tipo : -1,
        f_estado : -1,
        f_organico : -1
    };

    var frmIngresoResiduo = $('#frmIngresoResiduo');
    var selLugarAlmacenamiento = $('#selLugarAlmacenamiento');
    var selProcedenciaResiduo = $('#selProcedenciaResiduo');
    var selDepOrigen = $('#selDepOrigen');
    var selUniOrigen = $('#selUniOrigen');
    var divOtroOrigen = $('#otro-origen');
    var selResiduo = $('#selResiduo');
    frmIngresoResiduo.on('submit',fnEnviarIngreso);
    moment.locale('es');
    var fecha_solicita = $('#fecha_solicita');
    fecha_solicita.text(moment().format('dddd DD MMM YYYY'));
    setInterval(function(){
        fecha_solicita.text(moment().format('dddd DD MMM YYYY'));
        updateCorrelativo();
    },1000)
     function updateCorrelativo(){
         $.post(BASE_URL + 'correlativos/solicitar_correlativo/residuo/1', {}, function(data, textStatus, xhr) {
            // console.log(data);
            $('#textCorrelativo').text(data.correlativo);
        },'json').fail(fnFailAjax);
    }
    selProcedenciaResiduo.on('change',fnchangeProcencia);
    selDepOrigen.on('change',fnChangeDep);
    $('.filtro-residuo').on('ifChecked',function(e){
        console.log(this);
        switch(this.name){
            case 'radTipoPeligro':
                filter_residuo.f_tipo = this.value;
                break;
            case 'radTipoEstado':
                filter_residuo.f_estado = this.value;
                break;
            case 'radTipoOrganico':
                filter_residuo.f_organico = this.value;
                break;
        }

        $.post(BASE_URL + 'residuo/lista_by_opciones', filter_residuo , function(data, textStatus, xhr) {
            console.log(data);
            var html_option = '';
            selResiduo.html('');

            $(data).each(function(e,v){
                html_option += '<option value="'+ v.res_id +'">'+ v.res_nombre +'</option>'
            });
            selResiduo.html(html_option);
            if(selResiduo.prop('disabled') == true)
                selResiduo.prop('disabled',false);
        },'json').fail(fnFailAjax);
    });

    function fnEnviarIngreso(e){
        console.log(this);
        e.preventDefault(e);
        var frm = new Form(this);
        var datpost = frm.getNameValue();
        $.post(BASE_URL + 'residuo/registrar_solicitud', datpost , function(data, textStatus, xhr){
            console.log(data);
            if(data.resultado){
                  swal({
                        title : 'Boleta  generada',
                        text : '',
                        type : 'success',
                        showCancelButton: false,
                        closeOnConfirm: false,
                        showLoaderOnConfirm: true,
                        closeOnConfirm : false,

                    },function(isConfirm){
                        console.log(isConfirm);
                        setTimeout(function(){
                            window.location = BASE_URL + 'residuo/listar' ;
                        }, 1000)

                    })
                // swal('Solicitud Enviada','','success');

            }
        },'json').fail(fnFailAjax);
    }

    function fnchangeProcencia(e){
        var tv = this.value;
        if(tv == -1)
            divOtroOrigen.removeClass('hidden');
        else divOtroOrigen.addClass('hidden');

    }
    function fnChangeDep(e){
        var tv = this.value;
        $.post(BASE_URL + 'unidad/listar_by_dep/' + tv, {param1: 'value1'}, function(data, textStatus, xhr) {
            console.log(data);
            var t = TEMPLATES.option;
            t = Handlebars.compile(t);
            selUniOrigen.html('');
            $(data).each(function(e,v){
                selUniOrigen.append($(t({
                    id : v.idDepend,
                    text : v.desDepend
                })))
            })

        },'json');
    }

}
