{extends $_template}
{block 'css'}
     <link href="{$public_url}libs/boton.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
{/block}
{block 'contenido'}

<!-- Formulario principal -->
<form action="">
<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel"> 
	<h2>Tipo de Reporte <span class="required">*</span> : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <small>
       		Incidente:
            <input type="radio" class="flat" name="gender" id="genderM" value="M" checked="" required />&nbsp;&nbsp;
             Accidente:
            <input type="radio" class="flat" name="gender" id="genderF" value="F" />
           </small>    	
   	</h2>
   	<br>
    <h2>Reporte de Incident Nº: &nbsp; <small> RI-USI-001-2016  </small>  </h2>	
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
              <input type="text" class="form-control" placeholder="">
            </div>
          </div><br><br>
         
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Empresa</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" placeholder="">
            </div>
          </div><br><br>
          
         <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ocupación o Cargo</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" placeholder="">
            </div>
          </div><br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Departamento /Unidad / Area</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <select class="select2_single form-control" tabindex="-1" name="selDepartamento" data-placeholder="Seleccione" >              	
              	<option value="1">Departamento 1</option>
              	<option value="2">Departamento 2</option>
              </select> <br><br>
              
              <select class="select2_single form-control" tabindex="-1" name="selUnidad" data-placeholder="Seleccione" >
              	<option value="0"> Seleccione</option>
              	<option value="1">Unidad 1</option>
              	<option value="2">Unidad 2</option>
              </select>
              <br><br>
            </div>
          </div><br><br> <br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha Reporte</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" id="fecha_reporte"  >                                 
            </div>
          </div><br><br><br> <br>  	               
         
            <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ficha/DNI</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" placeholder="">
            </div>
          </div><br><br>
          
           <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Edad</label>
            <div class="col-md-3 col-sm-9 col-xs-12">            
              <input type="text" class="form-control" placeholder="">
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
              <input type="text"  class="form-control" id="fecha_incidente"  name="fecha_incidente"  />                                       
            </div>           
          </div><br><br><br>	
         
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Locación</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="locacion" placeholder="">
            </div>
          </div><br><br><br>
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Area de Incidente</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <input type="text" class="form-control" name="area_incidente" placeholder="">
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
          </div><br><br> <br><br> 
          
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Causas Inmediatas</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
            	<input type="radio" class="flat" name="causas"  value="1" checked="" required />&nbsp;&nbsp;
            	Actos Inseguros <br> <br>
               	<input type="radio" class="flat" name="causas"  value="2" checked="" required />&nbsp;&nbsp;
	            Condiciones Inseguras <br><br>
	            
	           <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="select2_multiple form-control" multiple="multiple">
                    <option>Elija una opción</option>
                    <option>Opción 1 </option>
                    <option>Opción 2 </option>
                    <option>Opción 3 </option>
                    <option>Opción 4 </option>
                    <option>Opción 5 </option>
                    <option>Opción 6</option>
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
		              <input type="text" class="form-control" name="apel_nombres_involucrado" placeholder="">
		            </div>
	         	</div><br><br>
	         
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ficha/DNI</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" placeholder="">
		            </div>
	         	</div><br><br>	
	         	
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Edad</label>
		            <div class="col-md-3 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" placeholder="">
		            </div>
	         	</div><br><br>	    		
	    	</div><!-- Fin de la columna Izquierda -->
	    	
	    	<div class="col-md-6 col-xs-12">
	    		<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Empresa</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" placeholder="">
		            </div>
	         	</div><br><br>
	         
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ocupacióno o Cargo</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" placeholder="">
		            </div>
	         	</div><br><br>	
	         	
	         	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Departamento / Unidad / Area</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
		              <input type="text" class="form-control" placeholder="">
		            </div>
	         	</div><br><br>	    		
	    	</div><!-- Fin de la columna derecha -->
	    <br><br><br><br><br><br><br> <hr>
	    <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Experiencia en la tarea</label>
		            <div class="col-md-9 col-sm-9 col-xs-12">
            	<input type="radio" class="flat" name="expeciencia" id="causa1" value="1" checked="" required />&nbsp;&nbsp;
            	Menos de 6 Meses &nbsp; &nbsp;&nbsp;
               	<input type="radio" class="flat" name="expeciencia" id="causa2" value="2"  required />&nbsp;&nbsp;
	            6 Meses - 1 Año &nbsp; &nbsp;&nbsp;
	            <input type="radio" class="flat" name="expeciencia" id="causa2" value="3"  required />&nbsp;&nbsp;
	            1 Año - 5 Años &nbsp; &nbsp;&nbsp;  
	             <input type="radio" class="flat" name="expeciencia" id="causa2" value="3"  required />&nbsp;&nbsp;
	            Más de 5 Años <br>                     
	           </div><br>		
	    </div><br>
	    	
	      	<div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Testigos del Incidente</label>
		            <div class="col-md-4 col-sm-9 col-xs-12" >
		              <input type="text" class="form-control" style="width:16em; display: inline-block;" placeholder="">&nbsp;&nbsp;
		              <button type="button" class="btn btn-primary ">+</button>
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
		              <textarea class="form-control" rows="1" placeholder=''></textarea>	              
		            </div>
	        </div><br><br><br><br>
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Qué estaba haciendo la Persona en el Incidente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" placeholder=''></textarea>	              
		            </div>
	        </div><br><br><br><br>
	        
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Qué sucedio inesperadamente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" placeholder=''></textarea>	              
		            </div>
	        </div><br><br><br>
	        
	        
	        <fieldset>
	         <legend> Detalles Adicionales</legend>
	      			
	        <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">¿Detalles adicionales del Incidente?</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <textarea class="form-control" rows="1" placeholder=''></textarea>	              	              
		            </div>
	        </div><br><br><br>
	        
	          <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Foto 1</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <input type="file" class="form-control"  style="border: 0px solid;">&nbsp;&nbsp;              
		            </div> 		          
	       	 </div><br><br>
	       	 
	       	  <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Foto 2</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <input type="file" class="form-control"  style="border: 0px solid;">&nbsp;&nbsp;              
		            </div> 		          
	       	 </div><br><br>	        	    	
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
		              <textarea class="form-control" rows="1" placeholder=''>Identifique los causantes....</textarea>	              	              
		            </div>
	        </div><br><br><br>
	        
	          <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Foto 1</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <input type="file" class="form-control"  style="border: 0px solid;">&nbsp;&nbsp;              
		            </div> 		          
	       	 </div><br><br>
	       	 
	       	  <div class="form-group">
	            <label class="control-label col-md-3 col-sm-3 col-xs-12">Foto 2</label>
		            <div class="col-md-9 col-sm-9 col-xs-12" >
		              <input type="file" class="form-control"  style="border: 0px solid;">&nbsp;&nbsp;              
		            </div> 		          
	       	 </div><br><br>	        	    	
	    
	    	 
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
		              <input type="input" class="form-control" style="width: 100%; height: 40px" >&nbsp;&nbsp;        	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	      
	        <div class="form-group">
	     	 <div class="col-md-6 col-sm-6 col-xs-12" >     
	        <fieldset>
	        	<legend>Revisado  por </legend>		           
		              <input type="input" class="form-control" style="width: 100%; height: 40px"  >&nbsp;&nbsp;        	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	      <div class="clearfix"></div>
	       <div class="form-group">
	     	 <div class="col-md-6 col-sm-6 col-xs-12 center-margin" >     
	        <fieldset>
	        	<legend>Aprobado USEG / UDES </legend>		           
		              <input type="input" class="form-control" style="width: 100%; height: 40px"  >&nbsp;&nbsp;        	
	       	</fieldset> 
	       	 </div> 		
	      </div>
	       	   	    	
	    
	    	 
	    </div><!-- Fin del contenido -->
	</div><!-- Fin del x-Panel -->	
	 </div>	<!-- Fin de la columna Principal -->	    	
</div><!-- Contenedor  de 5ta Fila/row-->

<br><br>
<div class="col-md-6 col-sm-6 col-xs-12 center-margin" >
	<button type="submit" class="btn btn-primary">Rechazar Incidente</button>
     <button type="submit" class="btn btn-success">Aprobar Incidente</button>
</div>
</form> <!-- FIn formulario principal -->
   
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'
    -->
	<script src="{$public_url}views/incidencias/js/incidencias.js"></script>
	<script src="{$public_url}views/incidencias/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/incidencias/js/jquery-ui-timepicker-addon.js"></script>
	<script src="{$public_url}views/incidencias/js/calendario.js"></script>
	<script src="{$public_url}views/incidencias/js/resumen.js"></script>
  
{/block}