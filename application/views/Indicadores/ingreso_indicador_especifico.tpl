{extends $_template}
{block 'css'}    
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">	
	
	<div class="col-md-10 col-sm-10 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Resumen de Indicador</h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content"> 
	 	{foreach  $dtsIndicador as $obj} 
	    <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Indicador de Desempeño:</label>
            <div class="col-md-8 col-sm-8 col-xs-12" >              
             <span style="font-size: 1.2em;">{$obj->ind_indicador}</span>
            </div>
        </div> 
        <div class="clearfix"></div> <br>
        
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Tipo:</label>
            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-top: 0px;padding-top: 0px;">              
             <span style="font-size: 1.2em;">{$obj->ind_tipo}</span>
            </div>
        </div> 
        <div class="clearfix"></div> <br>
        
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Unidad de Medida:</label>
            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-top: 0px;padding-top: 0px;">              
             <span style="font-size: 1.2em;">{$obj->med_nombre}</span>
            </div>
        </div> 
        <div class="clearfix"></div> <br>
        
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Formula Medición:</label>
            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-top: 0px;padding-top: 0px;">              
             <span style="font-size: 1.2em;">{$obj->ind_formula}</span>
            </div>
        </div> 
        <div class="clearfix"></div> <br>
        
       <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Nivel de Gestión:</label>
            <div class="col-md-8 col-sm-8 col-xs-12" style="margin-top: 0px;padding-top: 0px;">              
             <span style="font-size: 1.2em;">{$obj->ind_nivel}</span>
            </div>
        </div> 
        <div class="clearfix"></div> <br>

       <hr>
       
        <div class="col-md-10 col-sm-10 col-xs-12 " > 
      		<form enctype="multipart/form-data"  method="POST" action="../ingreso_indicador_procesa">
      		<input type="hidden" value="{$obj->induni_id}" name="induni_id" />
      		 <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha Ingreso:</label>
	            <div class="col-md-3 col-sm-3 col-xs-12">              
	             <input type="text" class="form-control" value="{$fecha}" name="fcha_ingreso" readonly="" />
	            </div>
             </div> <br><br><br>
            
            <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Consumo de Mes:</label>
	            <div class="col-md-5 col-sm-5 col-xs-12">              
	             <input type="number" class="form-control"  name="consumo" required="" placeholder="5.79"   autocomplete="off" step="any" min="0"  style="width: 6em; display: inline-block;" />
	              <span style="font-size: 1.2em;">{$obj->med_nombre}</span>
	            </div>
            </div> <br><br><br>
            {if $obj->ind_evidencia == 1 }            
             <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Adjuntar Documento <br>
	           <!-- &nbsp;&nbsp; <span style="color:red;"> *pdf </span><br>--></br>
	             &nbsp;&nbsp; <span style="color:red;"> {$maximo_megas} MB Máximo</span></label>
	            <div class="col-md-5 col-sm-5 col-xs-12">               
	             <input type="file" name="userfile" id="userfile" placeholder="Buscar Archivo"   required="">   
	             <!-- accept="image/*, application/pdf, application/msword, application/msexcel "-->          
	            </div>
              </div><br><br><br>             
      		{/if}
      		
      		<div class="form-group"> 
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">
            	<button type="submit" class="btn btn-success" id="btn_subir">Guardar</button>
            </label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;  </label>                        
       	 </div>	
      		</form>
        </div>
       
        {/foreach}
		
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
    <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="{$public_url}app/js/app.js"></script>-->

      <script src="{$public_url}views/indicadores/js/ingreso_indicador.js"></script>
     
       
{/block}