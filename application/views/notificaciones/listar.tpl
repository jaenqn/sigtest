{extends $_template}
{block 'css'} 
	 <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
   
    <link href="{$public_url}views/residuos/css/reporte_general.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">    
     
{/block}
{block 'contenido'}

    {if $mensaje != '' }
          <div class="alert alert-success alert-dismissible fade in" role="alert">
	        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
	        </button>
	       <center> El <strong>Se subió</strong> se subió Exitosamente </center>  
	       </div>    	
		  {/if}		
        
<div class="row">	
	<div class="col-md-11 col-sm-11 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Listado de Notificaciones Automaticas </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">  
	    
                
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Proceso</label>
             <div class="col-md-3 col-sm-3 col-xs-12">	              
	              <select  class="select2_single form-control" name="proceso" id="proceso"  tabindex="-1" data-placeholder="seleccione">
	              <option value="0">Todas</option>              
	              {foreach $lstProcesos as $item}
	              <option value="{$item['pro_id']}">{$item['pro_nombre']}</option>
	              {/foreach}	              	             	
	              </select>
             </div> 
             
            <!--  <label class="control-label col-md-2 col-sm-2 col-xs-12">Asunto</label>
             <div class="col-md-5 col-sm-5 col-xs-12">
	               <input class="form-control" type="text" name="Asunto" />
             </div>  --> 
                                 
        </div>   
        
        <div class="clearfix"></div> <br><br> <br>  
        
      <!--  <a href="exportar"> <button id="excel" class="excel">Exportar Excel</button> </a> --> 
          
    	 <table class="table table-bordered" id="tblListar" style="width: 100%;">
                      <thead>
                        <tr>
                          <th class="alineacion">Origen </th>
                          <th class="alineacion">Asunto</th> 
                           <th class="alineacion">Acción</th>                                                                            
                        </tr>                                                                  
                      </thead> 
                               
                      <tbody>
                    	              	                 
                      </tbody>
	     		</table> 	
	   </div><!-- fin  de Content -->
		</div><!-- fin  de X-Palen -->
	</div> <!-- Contenedor  de Columna 10 -->
</div><!-- Contenedor  de Fila -->







    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'
    -->
    <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    
	
    <script src="{$public_url}views/notificaciones/js/listar_edicion.js"></script>-->
    <script src="{$public_url}views/notificaiones/js/eliminar.js"></script>-->
    
   
{/block}