window.onload = fnload;
function fnload ()
{	
	$('#otro_hallazgo').on('keyup', function() {		
		 
		 valor = $(this).val();
		 caracteres = valor.length;
		 //console.log(valor);
		 //console.log(caracteres);
		 if(caracteres > 0) {		 	
		 	console.log('quitar');
		 	
		 	$('[name=hallazgo_tipo]').iCheck('uncheck');
		 	$('[name=hallazgo_tipo]').iCheck( "disable" );		 	
		 	//$('#hallazgo_tipo1').removeAttr( "checked" );
		 }
		 
		 if(caracteres == 0) {		 	
		 	console.log('Volver a activar');
		 	
		 	
		 	$('[name=hallazgo_tipo]').iCheck( "enable" );
		    $('#hallazgo_tipo1').iCheck("check");	 	
		 	//$('#hallazgo_tipo1').removeAttr( "checked" );
		 }
		 
	});
	
	$('[name=hallazgo_tipo]').on('ifChecked', function() {			 		
		 	$('#otro_hallazgo').val('');
	 });
	
	
	$('#btn_generar').on('click', function(e) {
				
		return confirm("¿Seguro que desea Generar Nueva SACP?");		
	});
			
} // document end
