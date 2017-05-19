$(document).ready(function() {
    TEMPLATES = {
        ModalConfigCarpetas:$('#tplModalCarpetas').html()
    }
    var selTipoCarpeta = $("#selTipoCarpeta");
    var selDepartamento = $("#selDepartamento");
    var selCategoria = $("#modalTabla .modalConfCarpeta .selCategoria");
    var objTarget = $('.obj-target');
    var tablArchivos = $('#tablArchivos');

    var selModalCrearCarpeta = $('#modalConfCarpeta-create .selCategoria');
    selModalCrearCarpeta.select2({ minimumResultsForSearch: Infinity });

    var btnOptionFiles = $('#tablArchivos .btn-option-files');
    var btnNuevaCarpeta = $('#btnNuevaCarpeta');

    btnNuevaCarpeta.on('click',fnCrearCarpeta);
    btnOptionFiles.on('click',fnConfCarpeta);
    // console.log(btnOptionFiles);


    //templates in DOM
    var tplTablaArchivosCar = $('#tpltablaArchivosCarpeta').html();
    var tplTablaArchivosDoc = $('#tpltablaArchivosDocumentos').html();
    // var tplModalCarpetas = $('#tplModalCarpetas').html();
    //end_temlates_DOM


    selTipoCarpeta.select2({ minimumResultsForSearch: Infinity });
    selDepartamento.select2();
    $('#selUnidad').select2({ minimumResultsForSearch: Infinity });
    // selCategoria.select2({ minimumResultsForSearch: Infinity });

    // eventos de caretas
    objTarget.on('dblclick',_fnVerificarDobleClick);
    // finEventoDeCarpeta

    selTipoCarpeta.on('change',fnChangeCarpeta);
    // selTipoCarpeta.on('change',fnChangeCarpeta);


    function fnChangeCarpeta(e){
        selDepartamento.val(["CA", "AL"]).trigger("change");
        var idTipoCarpeta = +this.value;
        console.log(idTipoCarpeta);
        switch(idTipoCarpeta){
            case 2:
                $.post(BASE_URL + 'ws/listar/dependencia', {}, function(data, textStatus, xhr) {
                    console.log(data);
                    var datas = {
                        'lstDep': data
                    }
             //        var source = "<p>Hello, my name is {{name}}. I am from {{hometown}}. I have " +
             // "{{kids.length}} kids:</p>" +
             // "<ul>{{#kids}}<li>{{name}} is {{age}}</li>{{/kids}}</ul>";

                var src = "{{#lstDep}}<option>{{desDepend}}</option>{{/lstDep}}";
                var template = Handlebars.compile(src);
                var result = template(datas);
                    selDepartamento.html(result);
                    selDepartamento.prop('disabled',false);
                    selDepartamento.trigger('change');
                },'json');
                break;
            case 1:

                break;
            case 3:
                break;
        }
        // console.log(e);
        // console.log($(this).val());
    }
    function fnAbrirCarpeta(){
        $.post(BASE_URL + 'ws/listar_datos_carpeta', {}, function(data, textStatus, xhr) {
            var lstCarpetas = data.lstCarpetas;
            var lstDocumentos = data.lstDocumentos;

            var src = '{{#datas}}' + tplTablaArchivosDoc + '{{/datas}}';
            // console.log(src);
            var tpl = Handlebars.compile(src);
            var r = tpl(lstDocumentos);
            // console.log(r);
            tablArchivos.html(r);

        },'json');
    }
    function fnAbrirCarpeta2(){

    }
    function _fnVerificarDobleClick(e){
        console.log(this.dataset.tipoArchivo);
        target = this;
        // definir si es archivo o carpeta
        // console.log(e.target.dataset.tipoArchivo);
        switch(+target.dataset.tipoArchivo){
            case 1:
                console.log(target.dataset.idArchivo);
                // console.log('adasd');
                window.location = BASE_URL + 'carpetas/f/' + target.dataset.idArchivo;
                fnAbrirCarpeta2();
                break;
            case 2:
                console.log('isDoc');
                break;
        }


    }


    function _fnExisteModalCarpeta(idModal){return document.getElementById(idModal)!=null?true:false;}
    var preInput = null;
    function fnConfCarpeta(e){
        console.log(this);

        var idCarpeta = +this.dataset.idArchivo;
        var objModal = new ModalConfigCarpeta();
        if(!_fnExisteModalCarpeta('modalConfCarpeta-'+idCarpeta)){
            $.post(BASE_URL + 'carpetas/get_carpeta/' + idCarpeta , {}, function(data, textStatus, xhr) {
                data.checked = '';
                data.checkedLabel = 'NO';
                if(data.estadoCarpeta) {
                    data.checked = 'checked';
                    data.checkedLabel = 'SI';
                }
                // objModal = new ModalConfigCarpeta(idCarpeta, data);
                objModal.setData(idCarpeta,data);
                $(objModal.getNameModal()).modal('show');
                preInput = objModal.getFormData();
                // console.log(preInput.values().next());
            },'json');
        }else{
            objModal = ModalConfigCarpeta.find(idCarpeta);
            $(objModal.getNameModal()).modal('show');
            preInput = objModal.getFormData();

            // $('#modalTabla #modalConfCarpeta-' + idCarpeta).modal('show');
        }
        console.log(objModal);
        // preInput = objModal.getFormData();
        // console.log(preInput.values().next());



    }
    function fnCrearCarpeta(e){
        // var objModalCP = new ModalConfigCarpeta();
        $('#modalConfCarpeta-create').modal( 'show');

    }



// GLOBALES

    $('#modalTabla').on('change','.modalConfCarpeta .txtVisible',function(e){
        var estado = $(this).next().next();
        console.log(estado);
        if(this.checked){
            estado.html('SI');
        }else estado.html('NO');
    })

    $('#modalTabla').on('click','.modalConfCarpeta .btnGuardar',function(e){
        var objM = ModalConfigCarpeta.find(this.dataset.idCarpeta);
        var frm = objM.getFormNode();
        $.post(BASE_URL + 'carpetas/update_datos',{
                txtIdCarpeta:frm.elements.txtIdCarpeta.value,
                txtTitulo:frm.elements.txtTitulo.value,
                selCategoria:frm.elements.selCategoria.value,
                txtVisible:frm.elements.txtVisible.checked
        },
        function(data, textStatus, xhr) {
            console.log(data);
            // if(data.respuesta)
            //     $(objM.getNameModal()).modal('hide');
                // console.log(objM.getNameModal());

        });
    });
    $('#modalTabla').on('click','.modalConfCarpeta .btnCancelar',function(e){
        var objM = ModalConfigCarpeta.find(this.dataset.idCarpeta);
        var frmNode = objM.getFormNode();
        frmNode.txtTitulo.value = preInput.get('txtTitulo');

        frmNode.txtVisible.value = preInput.get('txtVisible');

        frmNode.selCategoria.value = preInput.get('selCategoria');
        $(frmNode.selCategoria).trigger('change');
    });
});



var REVISA = 'es un revisa';

function ModalConfigCarpeta(){
    // console.log(idCarpeta);
    // this._datas = datas;
    // this._idCarpeta = idCarpeta;
    this._contenedor = '#modalTabla';
    this._nameModal = '';

    // this.create();
    // ModalConfigCarpeta.datas.push(this);

}
ModalConfigCarpeta.find = function(idCarpeta){
    for (var i = ModalConfigCarpeta.datas.length - 1; i >= 0; i--) {
        if(+ModalConfigCarpeta.datas[i]._idCarpeta == idCarpeta){
            return ModalConfigCarpeta.datas[i];
        }
    }
}
ModalConfigCarpeta.datas = [];
ModalConfigCarpeta.prototype = {
    setData: function(idC,datas){
                this._datas = datas;
                this._idCarpeta = idC;
                this._nameModal = '#modalConfCarpeta-'+ idC;
                this.create();
                ModalConfigCarpeta.datas.push(this);},
    getNameModal:function(){ return this._nameModal; },
    setNameModal:function(val){ this._nameModal = val; },
    getFormData:function(){
                // console.log(this._nameModal + ' .frmDetallesCarpeta');
                // console.log(this.getNameModal() + ' .frmDetallesCarpeta');
                var frm = new FormData($(this._nameModal + ' .frmDetallesCarpeta')[0]);
                return frm;
            },
    getFormNode:function(){
                return $(this._nameModal + ' .frmDetallesCarpeta')[0];
            }

}
ModalConfigCarpeta.prototype.configs = {
    _optionSelect2: {minimumResultsForSearch: Infinity},
    _optionSwitchery:null
}

// ModalConfigCarpeta.prototype.tpl = Handlebars.compile(TEMPLATES.ModalConfigCarpetas);
ModalConfigCarpeta.prototype.create = function(){
    var tpl = Handlebars.compile(TEMPLATES.ModalConfigCarpetas);
    var r = tpl(this._datas);
    $(this._contenedor).append(r);

    $(this._nameModal + " .selCategoria").select2(this.configs._optionSelect2);
    // console.log(this._nameModal + ' .txtVisible');
    var swtc = $(this._nameModal + ' .txtVisible');
    var f = this.getFormNode();
    f.elements.selCategoria.value = this._datas.idArchivoCarpeta;
    $(f.elements.selCategoria).trigger('change');
    new Switchery(swtc[0]);
    // swtc.on('change',this.fnChangeCheked);

    // $('#modalTabla').on('change','.modalConfCarpeta .txtVisible',function(e){console.log(e);})
}
// ModalConfigCarpeta.prototype.fnChangeCheked = function(e){
//     console.log(r);
//     // if(this.checked){
//     //      $(' .txtVisibleEstado').html('SI');
//     // }else $(' .txtVisibleEstado').html('NO');
// }



