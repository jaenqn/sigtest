$(document).ready(function() {

$(".select2_single").select2({
      minimumResultsForEach : Infinity,
      placeholder: "Selecciones",
      allowClear: true
    }); 
    
  $(".select2_group").select2({});
        $(".select2_multiple").select2({
           minimumResultsForEach : Infinity,
           
          allowClear: true
        });
        
});  