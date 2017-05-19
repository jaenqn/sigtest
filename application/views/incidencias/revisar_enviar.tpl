{extends $_template}
{block 'css'}
     <link href="{$public_url}libs/boton.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
{/block}
{block 'contenido'}
{foreach $incidente as $item}
<!-- Formulario principal -->
<form id="formulario_reporte" action="../enviar_incidente" method="post">
<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel"> 
	<h2>Tipo de Reporte  : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <small>
       		{$tipo_reporte}
           </small>    	
   	</h2>
   	<br>
    <h2>Reporte de Incident Nº: &nbsp; <small> {$item['inc_numero']} </small>  </h2> <br>	
    
    <div class="col-md-2 col-sm-2col-xs-12">
    	<h2>Estado:</h2>   	  
    </div>
    <div  class="col-md-4 col-xs-12">
    	<h5> {$estado} </h5>
    </div>
     
    
    <input type="hidden" name="id_incidente" value="{$id_incidente}" />	
    <input type="hidden" name="estado" value="1" />	     
    <!-- estados 1 : Pendiente -->
    <!-- estados 2 : Aprobado -->
    <!-- estados 3 : Rechazado -->
    
    <input type="hidden" name="inc_tipo" value="{$inc_tipo}" />	     
    <!-- estados 1 : Pendiente -->
    <!-- estados 2 : Aprobado -->
    <!-- estados 3 : Rechazado -->
	</div><br>
</div><!-- Contenedor  de Fila -->

<div class="row">

 <!-- Inicio de columna Izquierda -->
<div class="col-md-6 col-xs-12">
   		 <div class="x_panel">
   		 	 <div class="x_title">
         		<h2>Datos de la Persona que Reporta</h2>
         		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
         		<div class="clearfix"> </div>
         	 </div> 
        <div class="x_content">        	
       
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Apellidos y Nombres: </label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <h5>{$item['inc_apellidos_reporta']}  </h5>
            </div>
          </div><br><br>
         
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Empresa</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
             <h5>{$item['inc_empresa_reporta']}  </h5>
            </div>
          </div><br><br>
          
         <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ocupación o Cargo: </label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <h5>{$item['inc_ocupacion_reporta']}  </h5>
            </div>
          </div><br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Departamento:  </label>
            <div class="col-md-9 col-sm-9 col-xs-12">              
             <h5>{$departamento}  </h5>
            </div>
          </div><br>
          
           <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Unidad:  </label>
            <div class="col-md-9 col-sm-9 col-xs-12">              
             <h5>{$unidad}  </h5>
            </div>
          </div><br><br> 
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha Reporte</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <h5>{$item['inc_fch_reporte']}  </h5>                                
            </div>
          </div><br><br>               
         
            <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ficha/DNI: </label>
            <div class="col-md-9 col-sm-9 col-xs-12">
                <h5>{$item['inc_fichaDni_reporta']}  </h5>  
            </div>
          </div><br><br>
          
           <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Edad</label>
            <div class="col-md-3 col-sm-9 col-xs-12">            
               <h5>{$item['inc_edad_reporta']}  </h5>  
            </div>
          </div><br><br>
         	 
         	 
        </div> <!-- Contenedor  de contenido-->
        	<br>&nbsp;
   	  </div>   <!-- Contenedor  de contenedor -->	   
</div>
	
 <!-- Inicio de columna Derecha-->
<div class="col-md-6 col-xs-12">
   		 <div class="x_panel">
   		 	 <div class="x_title">
         		<h2>Detalles del Incidente </h2>
         		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
         		<div class="clearfix"> </div>
         	 </div> 
        <div class="x_content">
         <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha y Hora: </label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <h5>{$item['inc_fechaHora_incidente']}  </h5>                                       
            </div>           
          </div><br><br><br>	
         
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Locación: </label>
            <div class="col-md-9 col-sm-9 col-xs-12">
               <h5>{$item['inc_locacion_incidente']}  </h5> 
            </div>
          </div><br><br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Area de Incidente:</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <h5>{$item['inc_area_incidente']}  </h5> 
            </div>
          </div><br><br><br>          
         
           <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Tipo de Incidente:</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
            	<h5>{$tipo_incidente}  </h5> 
          </div><br><br> <br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Causas Inmediatas (Sub - Estandar)</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
            	<h5>{$causa}  </h5> <br>
	            
	           <div class="col-md-9 col-sm-9 col-xs-12">
                   {foreach $lstCausas as $causa}
                   <h5> - {$causa['cau_nombre']}</h5>                   
                   {/foreach}
                </div>            
	            	                   
	           </div>
          </div><br><br>   
         	 
        </div> <!-- Contenedor  de contenido-->
   	</div>   <!-- Contenedor  de contenedor -->	
</div> <!-- Fin de Columna Derecha -->	
	
</div> <!-- Contenedor  de 1ra Fila/row-->


<div class="row">
 <div class="col-md-12 col-sm-12 col-xs-12">
	 <div class="x_panel">
		 	 <div class="x_title">
	     		<h2>Personas Involucradas en el Incidente </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">
	    	<div class="col-md-6 col-xs-12">
	    		<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Apellidos y Nombres</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		               <h5>{$item['inc_apellidos_involucrado']}</h5>  
		            </div>
	         	</div><br><br>
	         
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ficha/DNI</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <h5>{$item['inc_fichaDni_involucrado']}</h5> 
		            </div>
	         	</div><br><br>	
	         	
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Edad</label>
		            <div class="col-md-3 col-sm-9 col-xs-12">
		               <h5>{$item['inc_edad_involucrado']}</h5> 
		            </div>
	         	</div><br><br>	    		
	    	</div><!-- Fin de la columna Izquierda -->
	    	
	    	<div class="col-md-6 col-xs-12">
	    		<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Empresa</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <h5>{$item['inc_empresa_involucrado']}</h5> 
		            </div>
	         	</div><br><br>
	         
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ocupación o Cargo</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		               <h5>{$item['inc_ocupacion_involucrado']}</h5> 
		            </div>
	         	</div><br><br>	
	         	
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Departamento / Unidad / Area</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		             <h5>{$item['inc_departamento_involucrado']}</h5> 
		            </div>
	         	</div><br><br>	    		
	    	</div><!-- Fin de la columna derecha -->
	    <br><br><br><br><br><br><br> <hr>
	    <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Experiencia en la tarea</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
            	       <h5>{$experiencia}</h5>       
	           		</div><br>		
	    </div><br>
	    	
	      	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Testigos del Incidente</label>
		            <div class="col-md-4 col-sm-9 col-xs-12" >	           
		               <div id="contenedor_testigos">
		               	 {foreach $lstTestigos as $testigo}
		                   <h5> - {$testigo['inctes_nombre']}</h5>                   
		                 {/foreach}		               	 
		               </div>
		              
		            </div>
	         	</div><br><br>	
	    	
	    	
	    </div><!-- Fin del contenido -->
	</div><!-- Fin del x-Panel -->
 </div>	<!-- Fin de la columna Principal -->
</div><!-- Contenedor  de 2da Fila/row-->

<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
	 <div class="x_panel">
		 	 <div class="x_title">
	     		<h2>Descripción del Incidente</h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">
	    	
	    	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Dónde y cómo ocurrio el Incidente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" readonly="" >{$item['inc_dondeComo']} </textarea>	              
		            </div>
	        </div><br><br><br><br>
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Qué estaba haciendo la Persona en el Incidente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" readonly="">{$item['inc_queHaciendo']}</textarea>	              
		            </div>
	        </div><br><br><br><br>
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Qué sucedio inesperadamente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" readonly="">{$item['inc_queSucedio']}</textarea>	              
		            </div>
	        </div><br><br><br>
	     
	        
	        <fieldset>
	         <legend> Detalles Adicionales</legend>
	      			
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Detalles adicionales del Incidente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" readonly="">{$item['inc_adicionales']}</textarea>	              	              
		            </div>
	        </div><br><br><br>
	          
	          <div class="clearfix"></div>
	          <!-- evidencias de Causas --> 
	          <div class="form-group">
	          	<div id="respuesta" class="col-md-6 col-sm-6 col-xs-12 text-center center-margin">
	          		
	          	</div>	 <br>    		  
                <hr />                              
                   <div id="archivos_subidos"></div>  
		           <table id="listado_evidencia" class="table table-striped">
		           	  <thead>
		           	  	<tr>
		           	  		<th style="width: 10em;word-break:break-all">Archivo</th><th <th style="width: 25em; word-break:break-all;">Descripción</th><th>Acción</th>
		           	  	</tr>
		           	  </thead>
		           	  <tbody>
		           	  	{foreach $lstEvidencia_adicionales as $fichero}
		                    <tr> 
		                   		<td>{$fichero['incevi_nom_fichero']}</td>
		                   		<td>{$fichero['incevi_descripcion']}</td>
		                   		<td> <a href="../../docs/evidencia_incidencias/{$fichero['incevi_nom_fichero']}" target="_blank" class="btn btn-primary"> Ver  </a></td>
		                   	</tr>                   
		                 {/foreach}	
		           	  </tbody>
		           </table> 
		            
		             		          
	       	 </div><br><br>	<!--  FIN evidencias de Causas -->       	 
	       	         	    	
	    	 </fieldset>
	    	 
	    </div><!-- Fin del contenido -->
	</div><!-- Fin del x-Panel -->	
	 </div>	<!-- Fin de la columna Principal -->	    	
</div><!-- Contenedor  de 3ra Fila/row-->

<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
	 <div class="x_panel">
		 	 <div class="x_title">
	     		<h2>Respuestas al incidente y acciones correctivas</h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">      			
	        <div class="form-group">	           
		            <div class="col-md-12 col-sm-12 col-xs-12" >
		              <textarea class="form-control" rows="1" readonly="">{$item['inc_respuesta']}</textarea>            	              
		            </div>
	        </div><br><br><br>
	        
	      <!-- evidencias de RESPUESTA --> 
	          <div class="form-group">
	          	<div id="respuesta_respuesta" class="col-md-6 col-sm-6 col-xs-12 text-center center-margin">
	          		
	          	</div>	 <br>         
		     
                <hr />                              
                   <div id="archivos_subidos_respuesta"></div>  
		           <table id="listado_evidencia_respuesta" class="table table-striped">
		           	  <thead>
		           	  	<tr>
		           	  		<th style="width: 10em;word-break:break-all">Archivo</th> <th style="width: 25em; word-break:break-all;">Descripción</th><th>Acción</th>
		           	  	</tr>
		           	  </thead>
		           	  <tbody>
		           	  	{foreach $lstEvidencia_respuesta as $fichero}
		                    <tr> 
		                   		<td>{$fichero['incevi_nom_fichero']}</td>
		                   		<td>{$fichero['incevi_descripcion']}</td>
		                   		<td> <a href="../../docs/evidencia_incidencias/{$fichero['incevi_nom_fichero']}" target="_blank" class="btn btn-primary"> Ver  </a></td>
		                   	</tr>                   
		                 {/foreach}	
		           	  </tbody>
		           </table> 
		            
		             		          
	       	 </div><br><br>	<!--  FIN evidencias de RESPUESTA -->     	    	
	    
	    	 
	    </div><!-- Fin del contenido -->
	</div><!-- Fin del x-Panel -->	
	 </div>	<!-- Fin de la columna Principal -->	    	
</div><!-- Contenedor  de 4ta Fila/row-->

	
<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
	 <div class="x_panel">
		 	 <div class="x_title">
	     		<h2>Firmas Digitales </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	     <div class="content">	 
	     <div class="form-group">
	     	 <div class="col-md-6 col-sm-6 col-xs-12" >     
	        <fieldset>
	        	<legend>Reportado por </legend>		           
		             <h5>{$item['inc_reportador_firma']}</h5>        	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	      
	        <div class="form-group">
	     	 <div class="col-md-6 col-sm-6 col-xs-12" >     
	        <fieldset>
	        	<legend>Revisado  por </legend>		           
		            {if $inc_estado_firma_aprobador == 1  && ($tipo_usuario == 2  || $tipo_usuario == 3|| $tipo_usuario == 4|| $tipo_usuario == 0)}		           
		              <input type="input" class="form-control" name="revisador_firma" style="width: 100%; height: 40px"  required=""  autocomplete="off">&nbsp;&nbsp;
		              {else}
		               {$item['inc_aprobador_firma']}
		              {/if}            	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	      <div class="clearfix"></div>
	       <div class="form-group">
	     	 <div class="col-md-6 col-sm-6 col-xs-12 center-margin" >     
	        <fieldset>
	        	<legend>Aprobado USEG / UDES </legend>
	        		  {if $inc_estado_firma_aprobador == 1 && ( $tipo_usuario == 4|| $tipo_usuario == 0) }		           
		              <input type="input" class="form-control" name="aprobador_firma" style="width: 100%; height: 40px"  required=""  autocomplete="off">&nbsp;&nbsp;
		              {else}
		               {$item['inc_aprobador_firma']}
		              {/if}            	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	       	   	    	
	    
	    	 
	    </div><!-- Fin del contenido -->
	</div><!-- Fin del x-Panel -->	
	 </div>	<!-- Fin de la columna Principal -->	    	
</div><!-- Contenedor  de 5ta Fila/row-->

<br><br>
	{if $inc_estado_firma_aprobador == 1  && ($tipo_usuario == 2  || $tipo_usuario == 3|| $tipo_usuario == 4|| $tipo_usuario == 0)}		
	<div class="col-md-4 col-sm-4 col-xs-12 center-margin text-center" >
		  <button type="submit" class="btn btn-primary" id="btn_enviar">Enviar Incidente</button>  
	</div>
	{/if} 
</form> <!-- FIn formulario principal -->
{/foreach}
  
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'
    -->
    <script src="{$public_url}tool/tools.js"></script>
	
	<script src="{$public_url}views/incidencias/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/incidencias/js/jquery-ui-timepicker-addon.js"></script>
	<script src="{$public_url}views/incidencias/js/calendario.js"></script>
	
	
	  
{/block}