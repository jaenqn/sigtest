{extends $_template}

{block 'css'}    
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">	
	<div class="col-md-8 col-sm-8 col-xs-12 center-margin">
		
	<h2>{$verifica}</h2>
    
          {if $mensaje_reload == '' }
          <div class="alert alert-success alert-dismissible fade in" role="alert">
	        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
	        </button>
	       <center> Su <strong>Notificacion</strong> se actualizó correctamente </center>  
	       </div>    	
		  {/if}		   	   
		   <center> 
      	  		<a href="listar" class="btn btn-default btn-sm">
      	  			Listar
      	  		</a>
      	  </center>		 
	   </div><!-- fin  de Content -->
		
	</div> <!-- Contenedor  de Columna 8 -->
</div><!-- Contenedor  de Fila -->







    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'
    -->
    
    <script src="{$public_url}views/incidencias/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/incidencias/js/jquery-ui-timepicker-addon.js"></script>

    <script src="{$public_url}views/contingencia/js/calendario.js"></script>
     <script src="{$public_url}views/contingencia/js/subir.js"></script>
{/block}