{extends $_template}
{block 'css'} 
	 <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
   
    <link href="{$public_url}views/residuos/css/reporte_general.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">    
     
{/block}
{block 'contenido'}




<div class="row">	
	<div class="col-md-12 col-sm-12 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Opciones para filtrar Listado </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">  
	    
	    <div class="clearfix"></div>
                
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Nº Incidente </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <input class="form-control" type="text" name="num_incidente" id="num_incidente" />
             </div>
        </div>
        
       <div class="form-group"> 
             <label class="control-label col-md-2 col-sm-2 col-xs-12">Tipo de Reporte </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <select  class="select-minimum" name="tipo_reporte" id="tipo_reporte" >	
	              	<option value="_todas_">Todas</option>              	
	              	<option value="0">Incidente</option>
	              	<option value="1">Accidente</option>
	              </select>
             </div>             
        </div>
        
         <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Tipo de Incidente </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <select class="select-minimum" name="tipo_incidente" id="tipo_incidente">              
	              	<option value="_todas_">Todas</option>
	              	<option value="1">Seguridad</option>
	              	<option value="2">Ambiental</option>
	              	<option value="3">Salud</option>
	              	<option value="4">Social</option>
	              </select>  
             </div>
         </div> <br><br><br>
           
         <div class="form-group">   
             <label class="control-label col-md-2 col-sm-2 col-xs-12">Causa Inmediata </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <select class="select-minimum" name="causa" id="causa" >              
	              	<option value="_todas_">Todas</option>
	              	<option value="1">Actos</option>
	              	<option value="2">Condiciones</option>	              	
	              </select>  
             </div>                   
        </div>    
        
       <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Departamento</label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <select  class="select-minimum form-control" name="selDepartamento" id="selDepartamento">	                	
	              	<option value="_todas_">Todas</option>
	              	{foreach $lstDepartamento as $obj}
	              	<option value="{$obj->idDepend}">{$obj->desDepend}</option>
	              	{/foreach}
	              </select>
             </div>
         </div>
         
        <div class="form-group">   
             <label class="control-label col-md-2 col-sm-2 col-xs-12">Unidad </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	               <select  class="select-minimum form-control" name="selUnidad" id="selUnidad" >              
	              	<option value="_todas_">Todas</option>	              
	              </select>
             </div>             
        </div>  <br><br><br>
        
         <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Fecha de Reporte </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <input  type="text" name="fecha_reporte" id="fecha_reporte" class="form-control" />  
             </div>
             
             <label class="control-label col-md-2 col-sm-2 col-xs-12">Fecha de Incidente </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <input  type="text" name="fecha_incidente" id="fecha_incidente" class="form-control" />  
             </div>             
                 
        </div>        
         
         <div class="form-group">
         <label class="control-label col-md-2 col-sm-2 col-xs-12">Estado	 </label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	              <select class="select-minimum" name="estado" id="estado" >              
	              	<option value="_todas_">Todas</option>
	              	<option value="1">Pendientes</option>
	              	<option value="2">Aprobados</option>
	              	<option value="3">Rechazados</option>	              	
	              </select>  
             </div>
         </div> <br>
          
          <div class="clearfix"></div>
        <!--
          <div class="form-group"> <br>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12 text-right">
            	<button type="button" class="btn btn-success btn-lg">Exportar&nbsp;&nbsp;&nbsp; 
            	 	<i class="fa fa-file-excel-o" style="font-size: 20px; "></i>
            	 </button>
            </label>                        
       	 </div>-->
	 	
	   </div><!-- fin  de Content -->
		</div><!-- fin  de X-Palen -->
	</div> <!-- Contenedor  de Columna 10 -->
</div><!-- Contenedor  de Fila -->

<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
				<h2> Resultado</h2>     		
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	</div>
	     	
        
	     	<div class="x_content">      		
	     		
	     		<div class="table-responsive">
		     			 <table class="table table-bordered table-striped table-hover " id="tblListar_incidencias">
	                      <thead>
	                        <tr>
	                          <th class="alineacion">Nº Incidente </th>
	                          <th class="alineacion">Tipo de Reporte</th> 
	                         <th class="alineacion">Area que reporta</th> 
	                          <th class="alineacion">Fecha de reporte</th>
	                          <th class="alineacion">Fecha de Incidente</th>  
	                         <th class="alineacion">Locacion</th> 
	                          <th class="alineacion">Tipo de Incidente</th> 
	                          <th class="alineacion">Causa </th>  
	                          <th class="alineacion">&nbsp;&nbsp;Estado &nbsp;&nbsp;</th> 
	                          <th class="alineacion">Acción </th>                        
	                        </tr>                                                                  
	                      </thead> 
	                      <tbody>
	                      	
	                      </tbody>
		     		</table>
	     		</div>
	     	</div>	
	     </div> 
	</div>	
</div>



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
    
	<script src="{$public_url}views/incidencias/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/incidencias/js/jquery-ui-timepicker-addon.js"></script>
    <script src="{$public_url}views/incidencias/js/calendario_listar.js"></script>
    
    <script src="{$public_url}views/incidencias/js/combobox_unidades_filtrado.js"></script>
    <script src="{$public_url}views/incidencias/js/listar.js"></script>
    
    <script src="{$public_url}views/incidencias/js/eliminar.js"></script>
    
   
{/block}