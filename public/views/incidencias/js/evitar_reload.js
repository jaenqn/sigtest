$(document).ready(function() {
	
	/*$(window).on('beforeunload', function(){   
		
	window.location.href =  BASE_URL + "Incidencias/reportar";	
		
	});	*/
	
	function disableF5(e) { 
		if ((e.which || e.keyCode) ==116) {
			 e.preventDefault();
		}
	};
	
	 $(document).on("keydown", disableF5);	
	
});