$(document).ready(function() {
	
	$('input.flat').iCheck({		
		checkboxClass:"icheckbox_flat-green",radioClass:"iradio_flat-green"		
	});	
	
	 
    $(".select2_multiple").select2({
       minimumResultsForEach : Infinity     
    });
	
	

	
        
   //Causas inmediatas Dínamicas
   
   
   var  num = 1 ; //para el numero de testigo dinamico   
   //input testigos Dínamicos 
   $('#btn_agregar_testigos').on('click' , function () {   	    
   	    var txt_testigo = $('#testigo_'+num).val();
   	    var cant_caracteres = txt_testigo.length;     	 
   	   if (cant_caracteres > 3 ) {   	  
   	   	num++; 
   	   	$('#contenedor_testigos').append('<input type="text" class="form-control"  name="testigo['+num+']"" id="testigo_'+num +'"  style="width:16em; display: inline-block;" placeholder="Testigo Nº'+num+'"  ><br><br>' );
   	    } else {
   	   	 alert ('Ingrese más de  3 Caracteres en la  Caja de Texto Nº' +  num);  	   	
   	   }
   });
   
   
   
   //para el envio de datos al controlador
   $('#btn_reportar').on('click', function() {
   	
   	console.log("enviar reporte");
   	
   });
   
   function fnRegistrarReporte(e) {
   	
  	 e.preventDefault();

  	
   	var frmRegReporte = new Form('formulario_reporte');
   	var frmElementos = frmRegReporte.getElements();
   	
   	 
   	
   	$.post(BASE_URL + 'Incidencias/registrar_reporte' , {
   		   	  
   	  numero_incidente: frmElementos.numero_incidente.value ,
   	  tipo_reporte: frmElementos.tipo_reporte.value ,
   	  
   	  apellidos_reporta: frmElementos.apellidos_reporta.value ,
   	  empresa_reporta : frmElementos.empresa_reporta.value , 
   	  ocupacion_reporta : frmElementos.ocupacion_reporta.value, 
   	  unidad_reporta : frmElementos.unidad_reporta.value, 
   	  fecha_reporte : frmElementos.fecha_reporte.value, 
	  fichaDni_reporta : frmElementos.fichaDni_reporta.value, 
	  edad_reporta : frmElementos.edad_reporta.value, 
	  
	  fechaHora_incidente : frmElementos.fechaHora_incidente.value, 
	  locacion_incidente : frmElementos.locacion_incidente.value, 
	  area_incidente : frmElementos.area_incidente.value, 
	  tipo_incidente : frmElementos.tipo_incidente.value,
	  causas : frmElementos.causas.value, 
	  
	  apellidos_involucrado : frmElementos.apellidos_involucrado.value, 
	  fichaDni_involucrado : frmElementos.fichaDni_involucrado.value, 
	  edad_involucrado : frmElementos.edad_involucrado.value, 
	  empresa_involucrado : frmElementos.empresa_involucrado.value, 
	  ocupacion_involucrado : frmElementos.ocupacion_involucrado.value,  
	  departamento_involucrado : frmElementos.departamento_involucrado.value, 
	  experiencia_involucrado : frmElementos.experiencia_involucrado.value,     
   	  
   	  //para los testigos 
   	   
   	   
   	  dondeComo : frmElementos.dondeComo.value,
   	  queHaciendo : frmElementos.queHaciendo.value,
   	  queSucedio : frmElementos.queSucedio.value,
   	  adicionales : frmElementos.adicionales.value,
   	  
   	  respuesta : frmElementos.respuesta.value,
   	  
   	  reportador_firma : frmElementos.reportador_firma.value,
   	  revisador_firma : frmElementos.revisador_firma.value,
   	  aprobador_firma : frmElementos.aprobador_firma.value,
   	        
   	   
   	
   	
   	} , 
   	
   	
   	function (data, textStatus, xhr) {
   		console.log(data);
   		
   		if (data.resultado) {
   			console.log('Registrado');
   			//alert('Reporte Registrado Correctamente');   			
   		} else  {
   			alert('No se pudo Registrar Reporte');  
   		}
   		
   		   		   		 
   	}, 'json').fail(function (e) {   		
   		console.log(e.responseText);
   		
   	} )   ;
   	
   
   	
   }
        
        
       
	
});
