{extends $_template}

{block 'css'}    
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">	
	
	<div class="col-md-8 col-sm-8 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Detalles del Documento</h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle"  data-toggle="modal" data-target=".bs-example-modal-lg" role="button" aria-expanded="false" id="modal_boton"><i class="fa fa-wrench"></i></a>
                      </li>                      
                </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">
	     {if $error != ''}	
	   		 <center> 
      	  		<div class="alert alert-danger alert-dismissible fade in" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                    </button>
                    <strong>{$error}</strong> 
                  </div>
      	  	</center>	    	 
	   	 {/if}
	     {if $mensaje_reload != '' }	     
	     <div class="alert alert-warning alert-dismissible fade in" role="alert">
	        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
	        </button>
	       <center>El Plan de Contingencia ya fue subido </center>
	       </div>     		  	
		  {/if }		
	   <form enctype="multipart/form-data"  method="POST" action="do_upload">
	   	 <input type="hidden" name="MAX_FILE_SIZE" value="{$max_post}" />
		    <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Descripción del Archivo</label>
	            <div class="col-md-9 col-sm-9 col-xs-12">
	              <input type="text" class="form-control" name="descripcion"  placeholder="" required value="">
	            </div>
	          </div><br><br><br>
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha de Aprobacion</label>
	            <div class="col-md-3 col-sm-3 col-xs-12">
	              <input type="text" class="form-control" name="fecha_aprobacion" id="fecha_aprobacion"  placeholder="" required value="">
	            </div>
	        </div><br><br><br> 
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Adjuntar Documento <br><br>
	             &nbsp;&nbsp; <span style="color:red;"> *pdf </span><br>
	             &nbsp;&nbsp; <span style="color:red;"> {$maximo_megas} MB Máximo</span>
	            </label>
	            <div class="col-md-9 col-sm-9 col-xs-12">
	              <input type="file"  accept="application/pdf" name="userfile"  id="userfile"  placeholder="Buscar Archivo"   required> 
	            </div>
	        </div><br><br><br> <br>  
	        
	        <div class="col-md-3 col-sm-3 col-xs-12 center-margin" >				
		     <button type="submit" class="btn btn-success" id="btn_subir">Subir</button>
			</div>
	                
	 	</form>
	   </div><!-- fin  de Content -->
		</div>
	</div> <!-- Contenedor  de Columna 8 -->
</div><!-- Contenedor  de Fila -->


<!-- Para el Modal -->

  <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="modal_contenido">

  </div>




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
     
    
      <script src="{$public_url}vendors/jQuery-Smart-Wizard/js/jquery.smartWizard_modificado.js"></script>
     <script src="{$public_url}views/autoayuda/contingencia/ayuda_subir.js"></script>
{/block}