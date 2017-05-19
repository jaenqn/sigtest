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
        
         <div class="col-md-12 col-sm-12 col-xs-12 row"> 
         	  <div class="clearfix"></div>      
	        <div class="form-group">
	            <label class="control-label col-md-2 col-sm-2 col-xs-12">Nº SACP </label>
	             <div class="col-md-2 col-sm-2 col-xs-12">
		              <input class="form-control" type="text" name="num_sacp" id="num_sacp" />
	             </div>
	        </div>
           
	        <div class="form-group">
	            <label class="control-label col-md-1 col-sm-2 col-xs-12">Hallazgo</label>
	             <div class="col-md-3 col-sm-3 col-xs-12">
		              <input class="form-control" type="text" name="hallazgo" id="hallazgo" />
	             </div>
	        </div>
	        
	         <div class="form-group">
	            <label class="control-label col-md-2 col-sm-2 col-xs-12">Clasificación</label>
	             <div class="col-md-2 col-sm-2 col-xs-12">
		              <select  class="select-minimum" name="clasificacion" id="clasificacion" >	
		              	<option value="_todas_">Todas</option>              	
		              	<option value="0">Incidente</option>
		              	<option value="1">Accidente</option>
	                 </select>
	             </div>
	        </div>
         </div> <br><br><br><br>
         
          <div class="col-md-12 col-sm-12 col-xs-12 row"> 
         	  <div class="clearfix"></div>   		            
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
	            <label class="control-label col-md-1 col-sm-1 col-xs-12">Unidad</label>
	             <div class="col-md-3 col-sm-3 col-xs-12">
		              <select  class="select-minimum" name="clasificacion" id="clasificacion" >	
		              	<option value="_todas_">Todas</option>              	
		              	<option value="0">Incidente</option>
		              	<option value="1">Accidente</option>
	                 </select>
	             </div>
            </div>
	        
	         <div class="form-group">
	            <label class="control-label col-md-2 col-sm-2 col-xs-12">Origen</label>
	             <div class="col-md-2 col-sm-2 col-xs-12">
		              <select  class="select-minimum" name="clasificacion" id="clasificacion" >	
		              	<option value="_todas_">Todas</option>              	
		              	<option value="0">Incidente</option>
		              	<option value="1">Accidente</option>
	                 </select>
	             </div>
	        </div>
         </div> <br><br><br>     
      
      
    
          
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
	     			 <table class="table table-bordered table-striped table-hover " id="tblListar_sacp">
                      <thead>
                        <tr>
                          <th class="alineacion">Nº SACP </th>
                          <th class="alineacion">Norma</th> 
                         <th class="alineacion">Requisito</th> 
                          <th class="alineacion">Fecha Emisión</th>
                          <th class="alineacion">Fecha Respuesta</th>
                          <th class="alineacion">Plazo de Ejecución</th>  
                         <th class="alineacion">Fecha Verificacion</th> 
                          <th class="alineacion">Estado</th>                                                     
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
    
	<script src="{$public_url}views/sacp/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/sacp/js/jquery-ui-timepicker-addon.js"></script>
    <script src="{$public_url}views/sacp/js/calendario_listar.js"></script>
    
    <script src="{$public_url}views/sacp/js/combobox_unidades_filtrado.js"></script>
    <script src="{$public_url}views/sacp/js/listar.js"></script>
    
   
{/block}