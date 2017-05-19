{extends $_template}
{block 'css'}
     <link href="{$public_url}libs/boton.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
     
      <link href="{$public_url}views/sacp/css/resize.css" rel="stylesheet">
{/block}
{block 'contenido'}

<!-- Formulario principal -->
<form id="formulario_generar" action="generar_sacp_procesa" method="post">

<div class="row">
 <!-- 1ra fila-->
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
	 	 <div class="x_title">
     		<h2>4. Medida de Corrección y/o Mitigación</h2>
     		<ul class="nav navbar-right panel_toolbox">
                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  </li>                      
                </ul>
     		<div class="clearfix"> </div>
     	 </div> 
        <div class="x_content">
        	       	
        <div class="form-group">
     	  <label class="control-label col-md-5 col-sm-5 col-xs-12">Descripción de la Corrección</label><br>
            <div class="col-md-11 col-sm-11 col-xs-12">
             <textarea class="form-control mantener_tamano" rows="2" name="correccion"  ></textarea>
            </div>  		       	 		
    	 </div><br><br><br><br>
    	 
    	   <div class="form-group">
     	  <label class="control-label col-md-5 col-sm-5 col-xs-12">Descripción de la Mitigación</label><br>
            <div class="col-md-11 col-sm-11 col-xs-12">
             <textarea class="form-control mantener_tamano" rows="2" name="mitigacion" ></textarea>
            </div>  		       	 		
    	 </div>       
         	 
        </div> <!-- Contenedor  de contenido-->
        
   	   </div> <!-- fin x panel -->	   
  </div>	
</div> <!-- Contenedor  de 1ra Fila/row-->


<div class="row">
 <!-- 2da fila -->
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
	 	 <div class="x_title">
     		<h2>5. Investigación de las Causas</h2>
     		<ul class="nav navbar-right panel_toolbox">
                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  </li>                      
                </ul>
     		<div class="clearfix"> </div>
     	 </div> 
        <div class="x_content">       	
       		   
          
          <div class="col-md-12 col-sm-12 col-xs-12">  
	           <div class="text-right">               	
    		 	<button class="btn btn-info" type="button" id="agregar_causa">Agregar</button>	    		 	
    		  	</div> 	      
                 
	          <div class="table-responsive ">
	          	
	          	<table class="table table-bordered table-striped">
	          		<thead>
	          			<th>Número </th>
	          			<th>Causa</th>
	          			<th>Revisión</th>
	          		</thead>
	          		<tbody>
	          			<tr>
	          				<td>1</td>
	          				<td>dasads</td>
	          				<td>veer</td>
	          			</tr>
	          		</tbody>	          		
	          	</table>    	
	          	
	          </div>     
	          
           </div><!-- fin contenedor izquierda-->	           
         	 
        </div> <!-- Contenedor  de contenido-->
        
   	   </div> <!-- fin x panel -->	   
  </div>	
</div> <!-- Contenedor  de 2da Fila/row-->



<div class="row">
 <!-- 3da fila -->
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
	 	 <div class="x_title">
     		<h2>6. Acciones Correctivas / Preventivas</h2>
     		<ul class="nav navbar-right panel_toolbox">
                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  </li>                      
                </ul>
     		<div class="clearfix"> </div>
     	 </div> 
        <div class="x_content">       	
       		   
          
          <div class="col-md-12 col-sm-12 col-xs-12">  
	           <div class="text-right">               	
    		 	<button class="btn btn-info" type="button" id="agregar_causa">Agregar</button>	    		 	
    		  	</div> 	      
                 
	          <div class="table-responsive ">
	          	
	          	<table class="table table-bordered table-striped">
	          		<thead>
	          			<th>Número </th>
	          			<th>Causa</th>
	          			<th>Revisión</th>
	          		</thead>
	          		<tbody>
	          			<tr>
	          				<td>1</td>
	          				<td>dasads</td>
	          				<td>veer</td>
	          			</tr>
	          		</tbody>	          		
	          	</table>    	
	          	
	          </div>     
	          
           </div><!-- fin contenedor izquierda-->	           
         	 
        </div> <!-- Contenedor  de contenido-->
        
   	   </div> <!-- fin x panel -->	   
  </div>	
</div> <!-- Contenedor  de 3da Fila/row-->
<br>

<div class="row">
 <!-- 4ta fila -->
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
	 	 <div class="x_title">
     		<h2>7. Evaluación de Riesgo</h2>
     		<ul class="nav navbar-right panel_toolbox">
                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  </li>                      
                </ul>
     		<div class="clearfix"> </div>
     	 </div> 
        <div class="x_content">       	
       		   
          
          <div class="col-md-12 col-sm-12 col-xs-12">  
	           <div class="text-right">               	
    		 	<button class="btn btn-info" type="button" id="agregar_causa">Agregar</button>	    		 	
    		  	</div> 	      
                 
	          <div class="table-responsive ">
	          	
	          	<table class="table table-bordered table-striped">
	          		<thead>
	          			<th>Número </th>
	          			<th>Causa</th>
	          			<th>Revisión</th>
	          		</thead>
	          		<tbody>
	          			<tr>
	          				<td>1</td>
	          				<td>dasads</td>
	          				<td>veer</td>
	          			</tr>
	          		</tbody>	          		
	          	</table>    	
	          	
	          </div>     
	          
           </div><!-- fin contenedor izquierda-->	           
         	 
        </div> <!-- Contenedor  de contenido-->
        
   	   </div> <!-- fin x panel -->	   
  </div>	
</div> <!-- Contenedor  de 4ta Fila/row-->


<div class="col-md-4 col-sm-4 col-xs-12 center-margin text-center" >
     <button type="submit" class="btn btn-primary" id="btn_generar">Generar</button>
</div>
</form> <!-- FIn formulario principal -->
   
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'
    -->
    <script src="{$public_url}tool/tools.js"></script>
	
	<script src="{$public_url}views/sacp/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/sacp/js/jquery-ui-timepicker-addon.js"></script>
	<script src="{$public_url}views/sacp/js/calendario_generar.js"></script>
	
	<script src="{$public_url}views/sacp/js/generar_sacp.js"></script>
	
	
	
	
	  
{/block}