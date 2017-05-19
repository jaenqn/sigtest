window.onload = fnLoad;

function fnLoad(){
    var btnIngreso = $('#btnIngreso');

    btnIngreso.on('submit',fnIngreso);


    function fnIngreso(e){
        e.preventDefault();


    }

}

