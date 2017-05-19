{extends $_template}
{block 'css'}
     <link href="{$public_url}libs/boton.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
{/block}
{block 'contenido'}

<!-- Formulario principal -->
<form id="formulario_generar" action="generar_sacp_procesa" method="post">
<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel"> 
	
          <div class="form-group"><br>
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Dependencia</label>
            <div class="col-md-3 col-sm-3 col-xs-12">
               <select class="select-default  form-control" tabindex="-1" name="selUnidad" id="selUnidad" data-placeholder="Seleccione" required >              	
              	   <option></option>
              	 {foreach $lstUnidades as $obj}
					<option value="{$obj->idDepend}">{$obj->desDepend}</option>
				 {/foreach}
              </select>
            </div>
          </div>
          
          <div class="col-md-1 col-sm-1 col-xs-12 form-group">           
          </div>
          
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Fecha</label>
            <div class="col-md-2 col-sm-2 col-xs-6">
              <input type="text" class="form-control" name="fecha_sacp"  id="fecha_sacp" placeholder="" required value="{$fecha}">
            </div>
          </div><br><br>
    
	</div><br>
</div><!-- Contenedor  de Fila -->

<div class="row">
 <!-- 1ra fila-->
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
	 	 <div class="x_title">
     		<h2>1. Clasificación</h2>
     		<ul class="nav navbar-right panel_toolbox">
                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  </li>                      
                </ul>
     		<div class="clearfix"> </div>
     	 </div> 
        <div class="x_content">       	
       
            <div class="form-group">
	         	&nbsp;&nbsp;
		          <div class="col-md-9 col-sm-9 col-xs-12">
            	<input type="radio" class="flat" name="clasificacion"  value="1" checked="" required />&nbsp;&nbsp;
            	No conformidad &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
               	<input type="radio" class="flat" name="clasificacion"  value="2"  required />&nbsp;&nbsp;
	            Observación (Potencial No conformidad)&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
	            <input type="radio" class="flat" name="clasificacion"  value="3"  required />&nbsp;&nbsp;
	            Oportunidad de Mejora &nbsp; &nbsp;&nbsp;	                             
	           </div><br>		
	    </div><br>			
         	 
        </div> <!-- Contenedor  de contenido-->
        
   	   </div> <!-- fin x panel -->	   
  </div>	
</div> <!-- Contenedor  de 1ra Fila/row-->


<div class="row">
 <!-- 2da fila -->
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
	 	 <div class="x_title">
     		<h2>2. Origen de la SACP</h2>
     		<ul class="nav navbar-right panel_toolbox">
                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  </li>                      
                </ul>
     		<div class="clearfix"> </div>
     	 </div> 
        <div class="x_content">       	
       		    <div class="form-group">
		            <label class="control-label col-md-2 col-sm-2 col-xs-12">Nº de SACP</label>
		            <div class="col-md-2 col-sm-2 col-xs-6">
		              <h5 id="numero_sacp"> {$num_sacp} </h5>
		            </div>
	          </div><br><br>
	          
	          <div class="form-group">
		            <label class="control-label col-md-4 col-sm-4 col-xs-10">Hallazgo encontrado durante: </label>		            
	          </div><br><br>
	          
	          <div class="col-md-6 col-sm-6 col-xs-12">  
		          <div class="form-group">
		         	&nbsp;&nbsp;
			          <div class="col-md-9 col-sm-9 col-xs-12">
		            	<input type="radio" class="flat" name="hallazgo_tipo"  value="1" checked="" required id="hallazgo_tipo1" />&nbsp;&nbsp;
		            	Auditoría Interna <br><br>
		               	<input type="radio" class="flat" name="hallazgo_tipo"  value="2"  required />&nbsp;&nbsp;
			            Incumplimiento Legal<br><br>
			            <input type="radio" class="flat" name="hallazgo_tipo"  value="3"  required />&nbsp;&nbsp;
			            Actividades Relacionadas al SGC / SGSST<br><br> 
			             <input type="radio" class="flat" name="hallazgo_tipo"  value="4"  required />&nbsp;&nbsp;
			            Reporte de Incidencias/ Accidentes / Emergencias<br><br>  
			             <input type="radio" class="flat" name="hallazgo_tipo"  value="5"  required />&nbsp;&nbsp;
			             Auditoría Externa<br><br>                              
		             </div><br>		
		    	  </div><br>	
	           </div><!-- fin columna izquierda-->
	           
	             <div class="col-md-5 col-sm-5 col-xs-12">  
		          <div class="form-group">
		         	&nbsp;&nbsp;
			          <div class="col-md-9 col-sm-9 col-xs-12">
		            	<input type="radio" class="flat" name="hallazgo_tipo"  value="6"  required />&nbsp;&nbsp;
		            	Comunicaciones<br><br>
		               	<input type="radio" class="flat" name="hallazgo_tipo"  value="7"  required />&nbsp;&nbsp;
			             Monitoreo Ambiental / SST<br><br>
			            <input type="radio" class="flat" name="hallazgo_tipo"  value="8"  required />&nbsp;&nbsp;
			             Quejas<br><br><br>  
			             
			            <div class="form-group">
				         	<label class="control-label col-md-2 col-sm-2 col-xs-12">Otro</label>
				            <div class="col-md-8 col-sm-8 col-xs-10">
				              <input type="text" class="form-control" name="otro_hallazgo"  id="otro_hallazgo" placeholder=""  >
				            </div>
			         	 </div><br>
			                                         
		             </div><br>		
		    	  </div><br>	
	           </div><!-- fin columna derecha-->	
         	 
        </div> <!-- Contenedor  de contenido-->
        
   	   </div> <!-- fin x panel -->	   
  </div>	
</div> <!-- Contenedor  de 2da Fila/row-->



<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
	 <div class="x_panel">
		 	 <div class="x_title">
	     		<h2>3. Descripción</h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">
	    	
	    	 <div class="form-group">
	         	<label class="control-label col-md-2 col-sm-2 col-xs-12">Norma </label>
	            <div class="col-md-3 col-sm-3 col-xs-10">
	              <input type="text" class="form-control" name="norma"  id="norma"  placeholder="" required >
	            </div>
         	 </div>
		      <div class="col-md-1 col-sm-1 col-xs-12 form-group">           
	          </div>
          	<div class="form-group">
	         	<label class="control-label col-md-2 col-sm-2 col-xs-12">Requisito </label>
	            <div class="col-md-3 col-sm-3 col-xs-10">
	              <input type="text" class="form-control" name="requisito"  id="requisito" placeholder=""   required >
	            </div>
         	 </div>
         	 <br><div class="clearfix" ></div><br>
         	 <div class="form-group">
	         	<label class="control-label col-md-4 col-sm-4 col-xs-12">Descripción del Hallazgo</label><br>
	            &nbsp;&nbsp;&nbsp;
	            <div class="col-md-11 col-sm-11 col-xs-10">
	              <textarea class="form-control" rows="1" name="hallazgo" required></textarea>	   
	            </div>
         	 </div>
         	<br><br><br><hr>
	       	      
		      <div class="form-group">
		     	 <div class="col-md-6 col-sm-6 col-xs-12" >     
		        <fieldset>
		        	<legend>Lider SIG de la Dependencia </legend>		           
			              <input type="input" class="form-control" name="revisador_firma" style="width: 90%; height: 40px" >        	
		       	</fieldset> 
		       	 </div> 		
		      </div>
		      <div class="form-group">
		     	 <div class="col-md-6 col-sm-6 col-xs-12" >  
		        <fieldset>
		        	<legend>Emisor </legend>		           
			              <input type="input" class="form-control" name="reportador_firma" style="width: 90%; height: 40px" required >      	
		       	</fieldset>
		       	</div>    		       	 		
		      </div>
	        
	    	 
	    </div><!-- Fin del contenido -->
	</div><!-- Fin del x-Panel -->	
	 </div>	<!-- Fin de la columna Principal -->	    	
</div><!-- Contenedor  de 3ra Fila/row-->

<br>
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