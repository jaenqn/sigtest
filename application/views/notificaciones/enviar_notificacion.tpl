{extends $_template}
{block 'css'}    
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">	
	<div class="col-md-9 col-sm-9 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2>Detalle de  Notificacion </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content"> 
	    	
	
	 <form   method="POST" action="enviar_notificacion_personalizada" id="formulario" >
	 	<input type="hidden" value="{$item['not_id']}" name="id_notificacion" />		 
	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Para</label>
            <div class="col-md-3 col-sm-3 col-xs-12">
           		 <select class="select-minimum form-control" tabindex="-1" name="selDepartamento"  id="selDepartamento" data-placeholder="Seleccione" required >              	
              	 <option></option>
              	 {foreach $lstDepartamento as $obj}
					<option value="{$obj->idDepend}">{$obj->desDepend}</option>
				 {/foreach}
				  </select> 
            </div>
            <div class="col-md-3 col-sm-3 col-xs-12">
           		  <select class="select-minimum form-control" name="selUnidad"  id="selUnidad" data-placeholder="Seleccione" required >              	
              	 <option></option>              	
				  </select> 
				  <div id="listado_unidades">
				  	
				  </div>
            </div>
        </div> <br><br><br>	 
	  
	
      <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Asunto</label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <input type="text" class="form-control" name="asunto"  placeholder="Ingrese Asunto" autocomplete="off" required> 
            </div>
        </div> <br><br><br>	
        
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Mensaje</label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <textarea name="mensaje" style="width: 100%;" required></textarea>
            </div>
        </div> <br><br><br><br>	 <br>	 	 
        
      <div class="clearfix"></div>
        
          <div class="form-group"> 
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">
            	<button type="submit" class="btn btn-success" id="btn_subir">Enviar</button>
            </label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;  </label>                        
       	 </div>
	 </form>	
	   </div><!-- fin  de Content -->
		</div>
	</div> <!-- Contenedor  de Columna 8 -->
</div><!-- Contenedor  de Fila -->







    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'   -->

    <script src="{$public_url}app/js/app.js"></script>   
    <script src="{$public_url}views/notificaciones/js/combobox_unidades.js"></script>
{/block}