var TEMPLATES = {

    option : '<option value="{{id}}">{{text}}</option>',
    btn_accion_ver : '<button type="button" data-id-obj="{{id}}" class="btnAcciones btnEditar btn btn-default btn-option-files" data-accion="editar" style=""  title="Ver" ><i class="fa fa-eye" style="font-size:1em"></i></button>',
    ref_accion: '<a href="{{target_url}}" data-id-obj="{{id}}" class="btnAcciones  btn btn-default btn-option-files" data-accion="{{accion}}" style=""  title="{{title}}" ><i class="{{icon}}" style="font-size:1em"></i></a>',
    btn_accion: '<button type="button" data-id-obj="{{id}}" class="btnAcciones  btn btn-default btn-option-files" data-accion="{{accion}}" style=""  title="{{title}}" ><i class="{{icon}}" style="font-size:1em"></i></button>',
    btn_accion_ver_ref : '<a href="{{url}}" target="_blank" data-id-obj="{{id}}" class="btnAcciones btnEditar btn btn-default btn-option-files" data-accion="editar" style=""  title="Ver" ><i class="fa fa-eye" style="font-size:1em"></i></a>',
    btn_accion_ver_ref_notarget : '<a href="{{url}}"  data-id-obj="{{id}}" class="btnAcciones btnEditar btn btn-default btn-option-files" data-accion="editar" style=""  title="Ver" ><i class="fa fa-eye" style="font-size:1em"></i></a>',
    // btn_acciones : '<a href="" data-id-obj="{{id}}" class="btnAcciones btnEditar" data-accion="editar"><i class="fa fa-pencil" style="font-size:1em"></i></a> <a href="" data-id-obj="{{id}}" class="btnAcciones btnEliminar" data-accion="eliminar"><i class="fa fa-trash" style="font-size:1em"></i></a>',
    btn_acciones : '<button type="button" data-id-obj="{{id}}" class="btnAcciones btnEditar btn btn-default btn-option-files" data-accion="editar" style=""  title="Editar" ><i class="fa fa-pencil" style="font-size:1em"></i></button> <button type="button" data-id-obj="{{id}}" class="btnAcciones btnEliminar btn btn-default btn-option-files" data-accion="eliminar" style=""  title="Eliminar" ><i class="fa fa-trash" style="font-size:1em"></i></button>'
}
var ARRAY = {
    existNum :      function(a, v){

                        var r = a.find(function(e,i){
                            return +e == v;
                        });
                        return r == undefined ? false : true;

                    },
    removeNum :     function(a,v){
                        var r = a.filter(function(e,i){
                            return e != v;
                        });

                        return r;
                    }
}
var swal_option = {
    confirm : {
            title: " ",
            text: "",
            type: "",
            showCancelButton: true,
            animation: "slide-from-top",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "",
            cancelButtonText: "",
            closeOnConfirm: false,
            closeOnCancel: false,
            showLoaderOnConfirm: false
    }
}
function get_swaloption(){
    return {
            title: " ",
            text: "",
            type: "",
            showCancelButton: true,
            animation: "slide-from-top",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "",
            cancelButtonText: "",
            closeOnConfirm: false,
            closeOnCancel: false,
            showLoaderOnConfirm: false
    }
}

var lenguajeDatatable = {
            search : "",
            searchPlaceholder :'Buscar',
             paginate : {
                first :      "Primero",
                last :       "Último",
                next :       "Siguiente",
                previous :   "Anterior"
            },
            emptyTable :     "No existen datos disponibles en la tabla",
            info :           "Mostrando _START_ a _END_ de _TOTAL_ entradas",
            infoEmpty :      "Mostrando 0 a 0 de 0 entradas",
            infoFiltered :   "(filtrado de _MAX_ total de entradas)",
            zeroRecords :    "No se encontraron registros coincidentes",
        };
// var casitemp;
function fnFailAjax(e){
    // console.log(typeof(e));
    // console.log(e);
    // console.log(typeof(e));
    // casitemp = e;
    if(typeof(e.responseText) != 'undefined'){
        $('#show-error').find('.message').html(e.responseText);
        $('#show-error').removeClass('hidden');
        $('#casoT').addClass('hidden');
        console.log(e.responseText);
    }
}

(function( $ ) {
     $('#show-error').on('click','[data-errors="on"]',function(e){
        e.preventDefault();
        $('#show-error').addClass('hidden');
        $('#casoT').removeClass('hidden');
    })
    $.fn.modal.Constructor.prototype.enforceFocus = function() {};
    $.fn.toParent = function(selector = false) {
        var target = this;
        var tmp;
        if(selector){
            do{
                tmp = target.parent(selector);
                if(tmp.length == 0)
                    target = target.parent();
                else break;
            }while(!jQuery.nodeName( target.get(0), "body" ))
        }else{
            tmp = this.parent();
        }
        return tmp;

    };

    $.fn.scrollTo = function(selector = false){
        // $.fn.scrollTo()
        // $.fn.scrollTo('13')
        // $('#asdasd').scrollTo()
        var num = 0;
        if(this.length > 0){
            if(!isNaN(parseInt(selector)))
                num = +selector;
            num = $(this).offset().top + num;
        }else{
            if(selector){
                if(isNaN(parseInt(selector)))
                    num = $(selector).offset().top;
                else num = +selector;
            }
        }
        $('html, body').animate({
                scrollTop: num
            }, 400);
    }
    // function test(datavalues, nameobject){
    //     $('[data-object="'+ nameobject +'"]').each(function(e,v){
    //                 console.log(v);
    //                 switch(v.tagName.toLowerCase()){
    //                     case 'span':
    //                         v.textContent = 'adasdasdasd';
    //                         break;
    //                 }
    //     })
    // }
    $.fn.setObjectValues = function(nameobject){
        console.log(this.get(0));
        var dataval = this.get(0);
          $('[data-object="'+ nameobject +'"]').each(function(e,v){
                    // console.log(v);
                    switch(v.tagName.toLowerCase()){
                        case 'span':
                            v.textContent = dataval[v.dataset.name];
                            break;
                    }
        })
    }
    $.fn.setDataSelect = function(data, all = false){
        var t = Handlebars.compile(TEMPLATES.option);
        $(this).html('');
        if(all)
            $(this).append(t({id : -1, text : all}));
        for (var i =  0; i <data.values.length ; i++) {

            $(this).append(t({
                id : data.values[i][data.id],
                text : data.values[i][data.text]
            }))
        }
    }
    $.fn.setDataSelectGroup = function(data, nuevo = false){
        var t = Handlebars.compile(TEMPLATES.option);

        var f = [];
        if(nuevo){

            var op = document.createElement('option');
            op.value = nuevo.value;
            op.text = nuevo.text;
            f.push(op);
        }

        data.values.forEach(function(v, i){
            var og = document.createElement('optgroup');
            og.label = v.categoria;
            v.elementos.forEach(function(vv, ii){
                var op = document.createElement('option');
                op.value = vv[data.id];
                op.text = vv[data.text];
                og.appendChild(op);
            });
            f.push(og);
        });
        $(this).html(f);
    }

    $.fn.getNameValue = function(){
        console.log(this);
        // var x = new FormData(this._node);
        // var a = [];
        // x.forEach(function(v, e){
        //     a.push({
        //         name : e,
        //         value : v
        //     });
        // })
        // if(!opc) return a;
        // else return a;
    }

}( jQuery ));

function getFormRegCausa(frm){
    return document.getElementById('frm');
}


/**
 * [Form description]
 * @param {[type]} nameFrm [description]
 */
function Form(nameFrm){
    if(typeof(nameFrm) == 'string'){
        this._name = nameFrm||undefined;
        this._node = document.getElementById(nameFrm);
    }else{
        this._node = nameFrm;
    }


}
Form.prototype.getNode = function(){
    return this._node;
    // return document.getElementById(this._name);
}

Form.prototype.getElements = function(){
    return this._node.elements;
    // return document.getElementById(this._name);
}
Form.prototype.reset = function(){
    this._node.reset();
}
Form.prototype.getNameValue = function(opc = false){
    var x = new FormData(this._node);
    var a = [];
    x.forEach(function(v, e){
        a.push({
            name : e,
            value : v
        });
    })
    if(!opc) return a;
    else return a;

}

function getById(idname){
    return document.getElementById(idname);
}


