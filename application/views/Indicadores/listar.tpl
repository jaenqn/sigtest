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
	     		<h2> Opciones para filtrar Listado </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">  
	    
                
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Indicador de Desempeño</label>
             <div class="col-md-5 col-sm-5 col-xs-12">
	              <input class="form-control" type="text" name="indicador" id="indicador" />
             </div> 
             
              <label class="control-label col-md-2 col-sm-2 col-xs-12">Tipo</label>
             <div class="col-md-3 col-sm-3 col-xs-12">
	               <select  class="select-minimum form-control" name="tipo" id="tipo" tabindex="-1" data-placeholder="seleccione">              
	              	<option value="_todas_">Todas</option>
	              	<option value="SGC">SGC</option>
	              	<option value="SGA">SGA</option>
	              	<option value="SGSST">SGSST</option>	              	
	              </select>
             </div>  
                                 
        </div>   
        
        <div class="clearfix"></div> <br>     
        
       <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12" >Responsables</label>
             <div class="col-md-4 col-sm-4 col-xs-12" id="unidades_div">
             	  <select  class="select-default form-control" name="unidades"  id="unidades" tabindex="-1" data-placeholder="-Seleccione-">              
	             	 <option value="_todas_">Todas</option>	
	           		{foreach $lstUnidades as $obj}
	              	<option value="{$obj->idDepend}">{$obj->desDepend}</option>
	              	{/foreach}	              		              	
	              </select> 
             </div>
             
             <label class="control-label col-md-1 col-sm-1 col-xs-12">Medida</label>
             <div class="col-md-2 col-sm-2 col-xs-12">             	 
	               <select  class="select-minimum form-control" name="unidad_medida" id="unidad_medida" tabindex="-1" data-placeholder="-Seleccione-">              
	             	 <option value="_todas_">Todas</option>	
	           		{foreach $lstUnidades_medidas as $item}
	              	<option value="{$item['med_id']}">{$item['med_nombre']}</option>
	              	{/foreach}	              		              	
	              </select> 
	             
             </div>  
             
              <label class="control-label col-md-1 col-sm-1 col-xs-12">Estado</label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	               <select  class="select-minimum form-control" name="estado" id="estado"  tabindex="-1" data-placeholder="-Seleccione-">              
	              	<option value="_todas_">Todas</option>
	              	<option value="1">Activo</option>
	              	<option value="0">Inactivo</option>	              	
	              </select>
             </div>           
        </div>  <br><br>     
          
          <div class="clearfix"></div>
         <div class="form-group"> <br>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12 text-right">
            	 <a href="agregar" class="btn btn-info btn-lg">
            	 	<i class="fa fa-plus" style="font-size: 20px; "></i>
            	 	Nuevo 
            	 </a>
            </label>                        
    </div>
         
	 	
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
	     		
	     			 <table class="table table-bordered" id="tblListar_indicadores">
                      <thead>
                        <tr>
                          <th class="alineacion">Indicador de Desempeño </th>
                          <th class="alineacion">Tipo</th> 
                           <th class="alineacion">Medida</th> 
                          <th class="alineacion">Formula de Medicion</th> 
                          <th class="alineacion">Nivel de Gestion</th> 
                          <th class="alineacion">&nbsp;&nbsp;&nbsp;&nbsp;Responsables&nbsp;&nbsp;&nbsp;&nbsp;</th> 
                          <th class="alineacion">Estado</th>   
                          <th class="alineacion">Accion</th>                                                      
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
    <script src="{$public_url}app/js/app.js"></script>-->
	
    <script src="{$public_url}views/indicadores/js/listar.js"></script>-->
    <script src="{$public_url}views/indicadores/js/eliminar.js"></script>-->
    
   
{/block}