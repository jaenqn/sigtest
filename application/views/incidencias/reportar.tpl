{extends $_template}
{block 'css'}
     <link href="{$public_url}libs/boton.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
{/block}
{block 'contenido'}

<!-- Formulario principal -->
<form id="formulario_reporte" action="registrar_reporte" method="post">
<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel"> 
	<h2>Tipo de Reporte <span class="required">*</span> : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <small>
       		Incidente:
            <input type="radio" class="flat" name="tipo_reporte"  value="0" checked="" required />&nbsp;&nbsp;
             Accidente:
            <input type="radio" class="flat" name="tipo_reporte"  value="1" />
           </small>    	
   	</h2>
   	<br>
    <h2>Reporte de Incident Nº: &nbsp; <small> {$num_incidencia} </small>  </h2>
    <input type="hidden" name="numero_incidente" value="{$num_incidencia}" />	
    <input type="hidden" name="estado" value="1" />	 
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
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Apellidos y Nombres</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="apellidos_reporta"  id="apellidos_reporta" placeholder="" required value="">
            </div>
          </div><br><br>
         
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Empresa</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="empresa_reporta"  id="empresa_reporta" placeholder="" required value="">
            </div>
          </div><br><br>
          
         <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ocupación o Cargo</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="ocupacion_reporta"  id="ocupacion_reporta" placeholder="" required  value="">
            </div>
          </div><br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Departamento /Unidad </label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <select class="select-minimum  form-control" tabindex="-1" name="selDepartamento" id="selDepartamento" data-placeholder="Seleccione" required >              	
              	   <option></option>
              	 {foreach $lstDepartamento as $obj}
					<option value="{$obj->idDepend}">{$obj->desDepend}</option>
				 {/foreach}
              </select> <br><br>
              
              <select class="select-minimum form-control"  name="selUnidad" id="selUnidad"  data-placeholder="Seleccione" required >
                           	
              </select>
              <br><br>
            </div>
          </div><br><br> <br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha Reporte</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="fecha_reporte" id="fecha_reporte"  required value="{$fecha_reporte}" disabled="" >                                 
            </div>
          </div><br><br><br> <br>  	               
         
            <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ficha/DNI</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="fichaDni_reporta" placeholder="" required value="">
            </div>
          </div><br><br>
          
           <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Edad</label>
            <div class="col-md-3 col-sm-9 col-xs-12">            
              <input type="text" class="form-control" name="edad_reporta" placeholder="" required value="">
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
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha y Hora</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text"  class="form-control" id="fechaHora_incidente"  name="fechaHora_incidente"  required value="" />                                       
            </div>           
          </div><br><br><br>	
         
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Locación</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="locacion_incidente" placeholder="" required value="">
            </div>
          </div><br><br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Area de Incidente</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="area_incidente" placeholder="" required value="">
            </div>
          </div><br><br><br>          
         
           <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Tipo de Incidente</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
            	Seguridad:
               <input type="radio" class="flat" name="tipo_incidente"  value="1" checked="" required />&nbsp;&nbsp;&nbsp;&nbsp;
	             Salud:
	            <input type="radio" class="flat" name="tipo_incidente"  value="2" /> <br><br>
	            Ambiente:
	            <input type="radio" class="flat" name="tipo_incidente"  value="3" />&nbsp;&nbsp;&nbsp;&nbsp;
	            Social:
	            <input type="radio" class="flat" name="tipo_incidente"  value="4" />
	            </div>
          </div><br><br> <br><br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Causas Inmediatas (Sub - Estandar)</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
            	<input type="radio" class="flat filtro_causa" name="causas"  value="1" checked="" required />&nbsp;&nbsp;
            	Actos Inseguros <br> <br>
               	<input type="radio" class="flat filtro_causa" name="causas"  value="2"  required />&nbsp;&nbsp;
	            Condiciones Inseguras <br><br>
	            
	           <div class="col-md-9 col-sm-9 col-xs-12">
                   <select class="select2_multiple form-control" multiple="multiple"  name="causas_subEstandar[]" id="causas_subEstandar" tabindex="-1" data-placeholder="Seleccione" required>              
                    {foreach $lstCausas as $item}
                     <option value="{$item['cau_id']}"> {$item['cau_nombre']}</option>
                    {/foreach}
                  </select>
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
		              <input type="text" class="form-control" name="apellidos_involucrado" placeholder="" value="" required>
		            </div>
	         	</div><br><br>
	         
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ficha/DNI</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" name="fichaDni_involucrado" placeholder="" required value="">
		            </div>
	         	</div><br><br>	
	         	
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Edad</label>
		            <div class="col-md-3 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" name="edad_involucrado" placeholder="" required value="">
		            </div>
	         	</div><br><br>	    		
	    	</div><!-- Fin de la columna Izquierda -->
	    	
	    	<div class="col-md-6 col-xs-12">
	    		<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Empresa</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" name="empresa_involucrado" placeholder="" required value="">
		            </div>
	         	</div><br><br>
	         
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ocupación o Cargo</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" name="ocupacion_involucrado" placeholder="" required value="">
		            </div>
	         	</div><br><br>	
	         	
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Departamento / Unidad / Area</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control"  name="departamento_involucrado" placeholder="" required value="" >
		            </div>
	         	</div><br><br>	    		
	    	</div><!-- Fin de la columna derecha -->
	    <br><br><br><br><br><br><br> <hr>
	    <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Experiencia en la tarea</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
            	<input type="radio" class="flat" name="experiencia_involucrado"  value="1" checked="" required />&nbsp;&nbsp;
            	Menos de 6 Meses &nbsp; &nbsp;&nbsp;
               	<input type="radio" class="flat" name="experiencia_involucrado"  value="2"  required />&nbsp;&nbsp;
	            6 Meses - 1 Año &nbsp; &nbsp;&nbsp;
	            <input type="radio" class="flat" name="experiencia_involucrado"  value="3"  required />&nbsp;&nbsp;
	            1 Año - 5 Años &nbsp; &nbsp;&nbsp;  
	             <input type="radio" class="flat" name="experiencia_involucrado"  value="4"  required />&nbsp;&nbsp;
	            Más de 5 Años <br>                     
	           </div><br>		
	    </div><br>
	    	
	      	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Testigos del Incidente</label>
		            <div class="col-md-4 col-sm-9 col-xs-12" >		             
		              <input type="text" class="form-control" name="testigo[1]" id="testigo_1"   style="width:16em; display: inline-block;" placeholder="">&nbsp;&nbsp;
		                <button type="button" class="btn btn-primary " id="btn_agregar_testigos">+</button> <br>
		               <div id="contenedor_testigos">		               	 
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
		              <textarea class="form-control" rows="1" name="dondeComo" required ></textarea>	              
		            </div>
	        </div><br><br><br><br>
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Qué estaba haciendo la Persona en el Incidente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" name="queHaciendo" required></textarea>	              
		            </div>
	        </div><br><br><br><br>
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Qué sucedio inesperadamente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" name="queSucedio" required></textarea>	              
		            </div>
	        </div><br><br><br>
	     
	        
	        <fieldset>
	         <legend> Detalles Adicionales</legend>
	      			
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Detalles adicionales del Incidente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" name="adicionales"></textarea>	              	              
		            </div>
	        </div><br><br><br>
	          
	          <div class="clearfix"></div>
	          <!-- evidencias de Causas --> 
	          <div class="form-group">
	          	<div id="respuesta" class="col-md-6 col-sm-6 col-xs-12 text-center center-margin">
	          		
	          	</div>	 <br>          
		        <div class="row">                   
                     <label class="control-label col-md-3 col-sm-3 col-xs-12"> Descripción Documento<br>
                     	  &nbsp;&nbsp; <span style="color:red;"> {$maximo_megas} MB Máximo</span>                     	
                     </label>
                                     
                   <!-- <div class="col-md-9 col-sm-9 col-xs-12" >
                        <input type="text" name="nombre_archivo" id="nombre_archivo" />
                   </div>-->
                   <input type="hidden" name="identificador_reporte"  id="identificador_reporte" value="{$identificador_reporte}" />
                    <div class="col-md-9 col-sm-9 col-xs-12" style="display: inline-block;" >
                    	 <input type="text" name="descripcion_documento" id="descripcion_documento" style="width: 15em;" placeholder="Descripción de Documento" autocomplete="off" /> &nbsp;&nbsp;
                        <input type="file" name="archivo" id="archivo" style="display: inline-block;"  class="btn btn-default" /><br><br>
                       
                         <div  id="boton_subir" value="Subir" class="btn btn-info" />
                           <i class="fa fa-plus" style="font-size: 20px; "></i> SUBIR 
                         </div>                       
                         <progress id="barra_de_progreso" value="0" max="100" style="width: 16em; "  ></progress>
                    </div>                                
                </div>
                <hr />                              
                   <div id="archivos_subidos"></div>  
		           <table id="listado_evidencia" class="table table-striped">
		           	  <thead>
		           	  	<tr>
		           	  		<th style="width: 10em;word-break:break-all">Archivo</th><th <th style="width: 25em; word-break:break-all;">Descripción</th><th>Acción</th>
		           	  	</tr>
		           	  </thead>
		           	  <tbody>
		           	  	
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
		              <textarea class="form-control" rows="1" name="respuesta"> </textarea>	              	              
		            </div>
	        </div><br><br><br>
	        
	      <!-- evidencias de RESPUESTA --> 
	          <div class="form-group">
	          	<div id="respuesta_respuesta" class="col-md-6 col-sm-6 col-xs-12 text-center center-margin">
	          		
	          	</div>	 <br>          
		        <div class="row">                   
                     <label class="control-label col-md-3 col-sm-3 col-xs-12"> Descripción Documento<br>
                     	  &nbsp;&nbsp; <span style="color:red;"> {$maximo_megas} MB Máximo</span>                     	
                     </label>
                                     
                   <!-- <div class="col-md-9 col-sm-9 col-xs-12" >
                        <input type="text" name="nombre_archivo" id="nombre_archivo" />
                   </div>-->
                   
                    <div class="col-md-9 col-sm-9 col-xs-12" style="display: inline-block;" >
                    	 <input type="text" name="descripcion_documento_respuesta" id="descripcion_documento_respuesta" style="width: 15em;" placeholder="Descripción de Documento" autocomplete="off" /> &nbsp;&nbsp;
                        <input type="file" name="archivo_respuesta" id="archivo_respuesta" style="display: inline-block;"  class="btn btn-default" /><br><br>
                       
                         <div  id="boton_subir_respuesta" value="Subir" class="btn btn-info" />
                           <i class="fa fa-plus" style="font-size: 20px; "></i> SUBIR 
                         </div>                       
                         <progress id="barra_de_progreso_respuesta" value="0" max="100" style="width: 16em; "  ></progress>
                    </div>                                
                </div>
                <hr />                              
                   <div id="archivos_subidos_respuesta"></div>  
		           <table id="listado_evidencia_respuesta" class="table table-striped">
		           	  <thead>
		           	  	<tr>
		           	  		<th style="width: 10em;word-break:break-all">Archivo</th> <th style="width: 25em; word-break:break-all;">Descripción</th><th>Acción</th>
		           	  	</tr>
		           	  </thead>
		           	  <tbody>
		           	  	
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
		              <input type="input" class="form-control" name="reportador_firma" style="width: 100%; height: 40px" required autocomplete="off">&nbsp;&nbsp;        	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	      
	        <div class="form-group">
	     	 <div class="col-md-6 col-sm-6 col-xs-12" >     
	        <fieldset>
	        	<legend>Revisado  por </legend>		           
		              <input type="input" class="form-control" name="revisador_firma" style="width: 100%; height: 40px" required="" autocomplete="off">&nbsp;&nbsp;        	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	      <div class="clearfix"></div>
	       <div class="form-group">
	     	 <div class="col-md-6 col-sm-6 col-xs-12 center-margin" >     
	        <fieldset>
	        	<legend>Aprobado USEG / UDES </legend>		           
		              <input type="input" class="form-control" name="aprobador_firma" style="width: 100%; height: 40px"  disabled="">&nbsp;&nbsp;        	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	       	   	    	
	    
	    	 
	    </div><!-- Fin del contenido -->
	</div><!-- Fin del x-Panel -->	
	 </div>	<!-- Fin de la columna Principal -->	    	
</div><!-- Contenedor  de 5ta Fila/row-->

<br><br>
<div class="col-md-4 col-sm-4 col-xs-12 center-margin text-center" >
     <button type="submit" class="btn btn-primary" id="btn_enviar">Enviar Reporte</button>
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
	
	<script src="{$public_url}views/incidencias/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/incidencias/js/jquery-ui-timepicker-addon.js"></script>
	<script src="{$public_url}views/incidencias/js/calendario.js"></script>
	
	<script src="{$public_url}views/incidencias/js/incidencias.js"></script>
	<script src="{$public_url}views/incidencias/js/combobox_unidades.js"></script>
	<script src="{$public_url}views/incidencias/js/causas_inmediatas.js"></script>
	
	
	<script src="{$public_url}views/incidencias/js/upload.js"></script>
	<script src="{$public_url}views/incidencias/js/subida_ficheros.js"></script>
    <script src="{$public_url}views/incidencias/js/subida_ficheros_respuesta.js"></script>
	  
{/block}