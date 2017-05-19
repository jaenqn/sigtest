$(document).ready(function() {
	
	$('input.flat').iCheck({		
		checkboxClass:"icheckbox_flat-green",radioClass:"iradio_flat-green"		
	});	     
       
       
     $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 4,
          placeholder: "4 opciones máximas ",
          allowClear: true
        });
        
    
     $(".select2_single").select2({
      minimumResultsForEach : Infinity,
      placeholder: "Selecciones",
      allowClear: true
    });   
	
});