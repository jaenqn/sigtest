$(document).ready(function() {
    moment.locale('es');
    $('select.select-minimum').select2({ minimumResultsForSearch: Infinity , width : '100%'});
    $('select.select-default').select2({width : '100%'});

    $('input.flat').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
    });
    $('[data-validation="on"]').each(function(e,v){
        console.log(this.dataset.message);
        if(typeof(this.dataset.message).toLowerCase() != 'undefined'){
                // this.setCustomValidity(this.dataset.message);
        }
        // $(v).on(this.dataset.event,function(ee){
        //         ee.stopPropagation();
        //     var targetv = this;
        //     console.log(ee);
        //     if(!this.reportValidity()){
        //         // return false;
        //         console.log('invalid');
        //         // this.setCustomValidity('asdasd');
        //     // $('#txtDniEla').get(0).reportValidity();
        //     // setTimeout(function(e){
        //         targetv.reportValidity();
        //         return false;
        //     //     clearTimeout(this);
        //     // },200)

        //     }
        //     return false;
        //     // console.log(ee);
        //     // switch(ee.type){
        //     //     case 'keypress':

        //     //         break;
        //     // }
        //     // this.reportValidity();
        //     // console.log(this.checkValidity());
        //     // if(!this.checkValidity())
        //     //     console.log('Mostrar mensaje de validación');
        //         // console.log(this.validationMessage);
        // })
    })
    // $('[data-validation="on"]').on('change',function(){
    //     this.reportValidity();
    // });
    $('[data-set-date]').text(function(e){
        return moment(this.dataset.setDate).format(this.dataset.setFormat);

    })
    $('[data-set-date-input]').val(function(e){
        return moment(this.dataset.setDateInput).format(this.dataset.setFormat);

    })


});