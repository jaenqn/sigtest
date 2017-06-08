{extends $_template}
{block 'css'}
     <link href="{$public_url}libs/boton.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
     <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">
{/block}
{block 'contenido'}

<!-- Formulario principal -->

<!--Pestañas -->

<!-- Contenedor de Pestañas -->
<div class="" role="tabpanel" data-example-id="togglable-tabs">
      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
        <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="false">Detalle SACP</a>
        </li>   
                            
       	 <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="true">Respuesta</a>
       	 </li>
       	                        	 
       	  <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab3" data-toggle="tab" aria-expanded="false">Seguimiento</a>
       	 </li>
       	 
       	 <li role="presentation" class=""><a href="#tab_content4_cierre" role="tab" id="profile-tab4_cierre" data-toggle="tab" aria-expanded="false">Cierre</a>
       	 </li>
       	 
      </ul>
      <div id="myTabContent" class="tab-content">

<!-- para el formulario de 10 campos, cinco por qué-->
<form id="form_cinco_porque" action="#" method="post"></form>
      	<!-- //////////////////////// Detalle /////////////////////////////////////  -->
        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
	                      
			<form id="formulario_generar" action="generar_sacp_procesa" method="post"> </form> <!-- FIn formulario principal -->
				<input type="hidden" name="id_sacp"  id="id_sacp" value="{$sacp->sacp_id}" >
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel"> 
				
			          <div class="form-group"><br>
			            <label class="control-label col-md-2 col-sm-2 col-xs-12">Dependencia</label>
			            <div class="col-md-3 col-sm-3 col-xs-12">
			              <h5>{$unidad}</h5>
			            </div>
			          </div>
			          
			          <div class="col-md-1 col-sm-1 col-xs-12 form-group">           
			          </div>
			          
			        <div class="form-group">
			            <label class="control-label col-md-2 col-sm-2 col-xs-12">Fecha</label>
			            <div class="col-md-2 col-sm-2 col-xs-6">
			              <h5>{$sacp->sacp_1_fecha}</h5>
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
				         	<h4> {$clasificacion_sacp}</h4>
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
					            <label class="control-label col-md-3 col-sm-3 col-xs-12">Nº de SACP</label>
					            <div class="col-md-4 col-sm-4 col-xs-6">
					              <h5 id="numero_sacp"> {$sacp->sacp_2_numero} </h5>
					            </div>
				            </div><br><br>
				          
				          <div class="form-group">
					            <label class="control-label col-md-3 col-sm-3 col-xs-10">Hallazgo encontrado durante: </label>				          
					          <div class="col-md-4 col-sm-4 col-xs-12">  
						          <h5> {$origen_sacp}</h5>
					           </div><!-- fin columna izquierda-->
				            </div>
				           
				             
			         	 
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
						              <h4>{$sacp->sacp_3_norma}</h4>
						            </div>
					         	 </div>
							      <div class="col-md-1 col-sm-1 col-xs-12 form-group">           
						          </div>
					          	<div class="form-group">
						         	<label class="control-label col-md-2 col-sm-2 col-xs-12">Requisito </label>
						            <div class="col-md-3 col-sm-3 col-xs-10">
						               <h4>{$sacp->sacp_3_requisito}</h4>
						            </div>
					         	 </div>
					         	 <br><div class="clearfix" ></div><br>
					         	 <div class="form-group">
						         	<label class="control-label col-md-4 col-sm-4 col-xs-12">Descripción del Hallazgo</label><br>
						            &nbsp;&nbsp;&nbsp;
						            <div class="col-md-11 col-sm-11 col-xs-10">
						              <textarea class="form-control" rows="1" name="hallazgo" readonly="">  {$sacp->sacp_3_descripcion}</textarea>	   
						            </div>
					         	 </div>
					         	<br><br><br><hr>
						       	      
							      <div class="form-group">
							     	 <div class="col-md-6 col-sm-6 col-xs-12" >     
							        <fieldset>
							        	<legend>Lider SIG de la Dependencia </legend>		           
								              <input type="input" class="form-control"  style="width: 90%; height: 40px" value="{$sacp->sacp_3_lider}" readonly="">        	
							       	</fieldset> 
							       	 </div> 		
							      </div>
							      <div class="form-group">
							     	 <div class="col-md-6 col-sm-6 col-xs-12" >  
							        <fieldset>
							        	<legend>Emisor </legend>		           
								              <input type="input" class="form-control" name="reportador_firma" style="width: 90%; height: 40px" value="{$sacp->sacp_3_emisor}" readonly="">      	
							       	</fieldset>
							       	</div>    		       	 		
							      </div>
						        
						    	 <br>&nbsp;<br>&nbsp;<br>	
						    	  
						    </div><!-- Fin del contenido -->
						</div><!-- Fin del x-Panel -->	
						 </div>	<!-- Fin de la columna Principal -->
						    	
					</div><!-- Contenedor  de 3ra Fila/row-->
					
					<br>
					<div class="col-md-4 col-sm-4 col-xs-12 center-margin text-center" >
					 <!--  <a href="#tab_content2">   <button  class="btn btn-primary" >Siguiente</button></a>
					  <a href="#tab_content2" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">Siguiente</a>-->
					  &nbsp;
					</div>
					
	              
	                                        
                </div><!-- fin contenedor pestaña detalle sacp-->
                
                 <!-- PESTAÑA RESPUESTA   -->
                <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
					<!-- Formulario principal -->
					
					
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
					    		 	<button class="btn btn-info" type="button" id="agregar_causa" data-toggle="modal" data-target=".modal_agregar_causa">Agregar</button>	    		 	
					    		  	</div> 
					    		  	
					    		  	
				<!--==================  modal para agregar causas ================================= -->
                  <div class="modal fade modal_agregar_causa" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel_causas">Agregar Causa</h4>
                        </div>
                        <div class="modal-body">
                         <!-- Pestañas de Ishikawa y Cinco Por qué -->
                         	 <div class="" role="tabpanel" data-example-id="togglable-tabs">
			                      <ul id="myTab_causas" class="nav nav-tabs bar_tabs" role="tablist">
			                        <li role="presentation" class="active"><a href="#tab_content1_ishikawa" id="home-tab_ishikawa" role="tab" data-toggle="tab" aria-expanded="true">Ishikawa</a>
			                        </li>
			                        <li role="presentation" class=""><a href="#tab_content2_cinco" role="tab" id="profile-tab_cinco" data-toggle="tab" aria-expanded="false">Cinco Por qué</a>
			                        </li>			                        
			                      </ul>
			                      <div id="myTabContent_causas" class="tab-content">
			                      	<!-- Para ishikawa-->
			                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1_ishikawa" aria-labelledby="home-tab_ishikawa">
			                        	<br>
			                          <div class="col-md-12 col-sm-12 col-xs-12">                	  
								          
								           <div class="form-group">
									         	<label class="control-label col-md-2 col-sm-2 col-xs-12">Efecto</label><br>
									            &nbsp;&nbsp;
									            <div class="col-md-9 col-sm-9 col-xs-12">
									              <textarea class="form-control" rows="1" name="hallazgo" disabled=""> {$sacp->sacp_3_descripcion}</textarea>	   
									            </div>
							         		</div> <br> <br> <div class="clearfix"></div>
							         		
							         		 <div class="form-group">
									         	<label class="control-label col-md-2 col-sm-2 col-xs-12">Causa</label><br>									            
									            <div class="col-md-3 col-sm-3 col-xs-8">
									              <select class="form-control" name="causa_tipo_ishikawa" id="causa_tipo_ishikawa">
									              	<option value="1">Material</option>
									              	<option value="2">Método</option>
									              	<option value="3">Materiales</option>
									              	<option value="4">Mano de Obra</option>
									              	<option value="5">Ambiente</option>
									              </select>
									            </div>
									            <div class="col-md-5 col-sm-5 col-xs-8">
									              <input type="text" class="form-control"  name="causa_texto_ishikawa" id="causa_texto_ishikawa" required> 
									            </div>
									            <div class="col-md-2 col-sm-2 col-xs-8">
									         	  <button type="button" class="btn btn-round btn-info" id="guardar_causa_ishikawa" >Guardar</button>
							         			</div>
							         		</div>
							         		
							         		<div class="clearfix"></div> <br><br>
							         		
							         		<table class="table table-bordered table-striped" id="tabla_ishikawa">
							         			<thead>
							         				<th style="width: 6em;">Tipo</th>
							         				<th style="width: 15em;">Causa</th>
							         				<th style="width: 20px;">Acción</th>
							         			</thead>
							         			<tbody>
							         				<tr> <td colspan="2"> <center> Sin datos</center></td></tr>
							         			</tbody>
							         		</table>
			                          	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
			                          		 <button type="button" class="btn btn-round btn-info" id="generar_diagrama" >Generar Diagrama</button>
			                          	</div>
			                          	<br>
			                          	
			                          	
			                          </div>		                          
			                        </div><!-- fin ishikawa -->
			                        
			                        
			                        <!-- PARA LAS CINCO POR QUÉ -->
			                        <div role="tabpanel" class="tab-pane fade" id="tab_content2_cinco" aria-labelledby="profile-tab_cinco">
			                         	 <div class="form-group">
									         	<label class="control-label col-md-2 col-sm-2 col-xs-12">Problema</label><br>
									            &nbsp;&nbsp;
									            <div class="col-md-9 col-sm-9 col-xs-12">
									              <textarea class="form-control" rows="1" name="hallazgo" disabled=""> {$sacp->sacp_3_descripcion}</textarea>	   
									            </div>
							         	  </div> <br> <br> <div class="clearfix"></div>
			                         	  <div class="col-md-12 col-sm-12 col-xs-12">
			                         	  	
			                         	  	<table class="table table-bordered table-striped" id="tabla_cinco_porque">
							         			<thead>							         				
							         				<th style="width: 15em;">Causa</th>
							         				<th style="width: 20px;">Acción</th>
							         			</thead>
							         			<tbody>
							         				<tr> <td colspan="2"> <center> Sin datos</center></td></tr>
							         			</tbody>
							         		</table>
			                         	  	
			                         	  	<!-- 1er POR QUE -->			                         	  	
										    <div class="x_panel">
											 	 <div class="x_title">
										     		<h2>Por qué 1 </h2>
										     		<ul class="nav navbar-right panel_toolbox">
										                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
										                  </li>                      
										                </ul>
										     		<div class="clearfix"> </div>
										     	 </div> 
										        <div class="x_content">
										        	       	
										        <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Pregunta 1 </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">										            
										             <textarea class="form-control mantener_tamano" rows="1" name="preg_1" id="preg_1" form="form_cinco_porque" required=""></textarea>
										            </div>  		       	 		
										    	 </div><br><br><br>
										    	 
										    	   <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Respuesta 1 </label><br>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="resp_1"  id="resp_1" form="form_cinco_porque" required=""> </textarea>
										            </div>  		       	 		
										    	 </div>       
										         	 
										        </div> <!-- Contenedor  de contenido-->
										        
										   	   </div> <!-- fin x panel 1ra pregunta -->
										   	   
										   	   <!-- 2DO POR QUE -->	
										   	    <div class="x_panel">
											 	 <div class="x_title">
										     		<h2>Por qué 2 </h2>
										     		<ul class="nav navbar-right panel_toolbox">
										                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
										                  </li>                      
										                </ul>
										     		<div class="clearfix"> </div>
										     	 </div> 
										        <div class="x_content">
										        	       	
										        <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Pregunta 2 </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="preg_2" id="preg_2" form="form_cinco_porque" required="" ></textarea>
										            </div>  		       	 		
										    	 </div><br><br><br>
										    	 
										    	   <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Respuesta 2 </label><br>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="resp_2" id="resp_2" form="form_cinco_porque" required="" ></textarea>
										            </div>  		       	 		
										    	 </div>       
										         	 
										        </div> <!-- Contenedor  de contenido-->
										        
										   	   </div> <!-- fin x panel 2da pregunta -->	 
										   	   
										   	   <!-- 3er POR QUE -->	
										   	    <div class="x_panel">
											 	 <div class="x_title">
										     		<h2>Por qué 3 </h2>
										     		<ul class="nav navbar-right panel_toolbox">
										                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
										                  </li>                      
										                </ul>
										     		<div class="clearfix"> </div>
										     	 </div> 
										        <div class="x_content">
										        	       	
										        <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Pregunta 3 </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="preg_3" id="preg_3" form="form_cinco_porque" required="" ></textarea>
										            </div>  		       	 		
										    	 </div><br><br><br>
										    	 
										    	   <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Respuesta 3 </label><br>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="resp_3" id="resp_3" form="form_cinco_porque" required="" ></textarea>
										            </div>  		       	 		
										    	 </div>       
										         	 
										        </div> <!-- Contenedor  de contenido-->
										        
										   	   </div> <!-- fin x panel 3er pregunta -->	 
										   	   
										   	   <!-- 4to  POR QUE -->	
										   	    <div class="x_panel">
											 	 <div class="x_title">
										     		<h2>Por qué 4 </h2>
										     		<ul class="nav navbar-right panel_toolbox">
										                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
										                  </li>                      
										                </ul>
										     		<div class="clearfix"> </div>
										     	 </div> 
										        <div class="x_content" class="collapse">
										        	       	
										        <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Pregunta 4 </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="preg_4" id="preg_4" form="form_cinco_porque" required="" ></textarea>
										            </div>  		       	 		
										    	 </div><br><br><br>
										    	 
										    	   <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Respuesta 4 </label><br>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="resp_4" id="resp_4"  form="form_cinco_porque" required=""></textarea>
										            </div>  		       	 		
										    	 </div>       
										         	 
										        </div> <!-- Contenedor  de contenido-->
										        
										   	   </div> <!-- fin x panel 4to pregunta -->	 
										   	   
										   	   <!-- 5to POR QUE -->	
										   	    <div class="x_panel">
											 	 <div class="x_title">
										     		<h2>Por qué 5 </h2>
										     		<ul class="nav navbar-right panel_toolbox">
										                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
										                  </li>                      
										                </ul>
										     		<div class="clearfix"> </div>
										     	 </div> 
										        <div class="x_content">
										        	       	
										        <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Pregunta 5 </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="preg_5" id="preg_5" form="form_cinco_porque" required=""></textarea>
										            </div>  		       	 		
										    	 </div><br><br><br>
										    	 
										    	   <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Respuesta 5 </label><br>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="resp_5" id="resp_5" form="form_cinco_porque" required=""></textarea>
										            </div>  		       	 		
										    	 </div>       
										         	 
										        </div> <!-- Contenedor  de contenido-->
										        
										   	   </div> <!-- fin x panel 5ta pregunta -->	
										   	   
										   	   
										   	   <!-- CAUSA RAIZ  -->	
										   	    <div class="x_panel">
											 	 <div class="x_title">
										     		<h2>Causa Raíz Encontrada </h2>
										     		<ul class="nav navbar-right panel_toolbox">
										                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
										                  </li>                      
										                </ul>
										     		<div class="clearfix"> </div>
										     	 </div> 
										        <div class="x_content">
										        	       	
										        <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">causa </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="causa_raiz_encontrada" id="causa_raiz_encontrada" form="form_cinco_porque" required=""></textarea>
										            </div>  		       	 		
										    	 </div><br><br>
										    	     
										         	 
										        </div> <!-- Contenedor  de contenido-->
										        
										   	   </div> <!-- fin x panel 5ta pregunta -->
										   	    	 
								   	    </div>
			                         	
			                         	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
			                          		 <input type="submit" class="btn btn-round btn-info" id="guardar_causa_cinco" form="form_cinco_porque" value="Guardar">
			                          	</div>
			                          	
			                          	
			                         	
			                        </div><!--  fin PESTAÑA  cinco por qué -->
			                        
			                      </div>
			                      
			                    </div>                       
                         
                         
                        </div><!-- Fin cuerpo de Modal -->
                       <div class="clearfix"> </div> <br><br>
                        <div class="modal-footer">
                        	<div class="col-md-12 col-sm-12 col-xs-12 text-right">
                        		<button type="button" class="btn btn-primary" id="btn_agregar_causas">Agregar Causas</button>
                          		<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>&nbsp;&nbsp;
                            </div>	                        
                        </div>

                      </div>
                    </div>
                  </div>  <!-- FIN MODAL CAUSAS-->
					    		  						    		  		      
			                 
				          <div class="table-responsive ">				          	
				          	<table class="table table-bordered table-striped" id="tbl_causas_todas">
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
					    		 	<button class="btn btn-info" type="button" id="" data-toggle="modal" data-target=".modal_acciones">Agregar</button>	    		 	
					    		  	</div> 	
					    		  	
					    		  	  <!--  ----- Inicio Modal Acciones Correctivas - Preventivas -->
					    		  	  					    		  	
					                  <div class="modal fade modal_acciones" tabindex="-1" role="dialog" aria-hidden="true">
					                    <div class="modal-dialog modal-lg">
					                      <div class="modal-content">
					
					                        <div class="modal-header">
					                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
					                          </button>
					                          <h4 class="modal-title" id="myModalLabel_acciones">Agregar acción Correctiva / Preventiva</h4>
					                        </div>
					                        <div class="modal-body">
					                          
					                          <div class="col-md-12 col-sm-12 col-xs-12">  
					                          	
					                          	 <div class="x_panel">
											 	 <div class="x_title">
										     		<h2>Agregar Acción </h2>
										     		<ul class="nav navbar-right panel_toolbox">
										                  <!-- <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
										                  </li>  -->                    
										              </ul>
										     		<div class="clearfix"> </div>
										     	 </div> 
										        <div class="x_content">
										        	       	
										        <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Descripción de la acción  </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <textarea class="form-control mantener_tamano" rows="1" name="descripcion_acciones" id="acciones_descripcion" form="form_acciones" required=""></textarea>
										            </div>  		       	 		
										    	 </div><br><br><br><br>
										    	   
										    	   <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">IPER</label> 						            		       	 		
										           <div class="col-md-9 col-sm-9 col-xs-12">							    	  
											    	  <input type="radio" class="flat" name="acciones_iper" id="iper_si_acciones"     value="1" checked="" required  form="form_acciones" />&nbsp;&nbsp;
										            	Si &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
										               	<input type="radio" class="flat" name="acciones_iper"   id="iper_no_acciones" value="0"  required form="form_acciones" />&nbsp;&nbsp;
											            No &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
											    	</div>
										       </div><br><br>
										    	 
										    	 <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Responsable </label>
										            <div class="col-md-9 col-sm-9 col-xs-12">
										             <input type="text" class="form-control mantener_tamano"  name="responsable_acciones" id="responsable_acciones"  form="form_acciones"  > 
										            </div>  		       	 		
										    	 </div><br><br>
										    	 
										    	 <div class="form-group">
										     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Plazo </label>										           
									                <div class="col-md-3 col-sm-3 col-xs-12">	
									              		<input type="text"  class="form-control" id="plazo_acciones"  name="plazo_acciones"  required value="" />
										            </div>  		       	 		
										    	 </div><br><br>
										    	 
										    	 <!-- para evidencia de Archivos -->
										    	 
										    	  <!-- evidencias de RESPUESTA --> 
										          <div class="form-group">
										          	<div id="respuesta_respuesta" class="col-md-6 col-sm-6 col-xs-12 text-center center-margin">
										          		
										          	</div>	 <br>          
											        <div class="row">                   
									                     <label class="control-label col-md-2 col-sm-2 col-xs-12"> Descripción Documento<br>
									                     	  &nbsp;&nbsp; <span style="color:red;"> {$maximo_megas} MB Máximo</span>                     	
									                     </label>
									                                     
									                   <!-- <div class="col-md-9 col-sm-9 col-xs-12" >
									                        <input type="text" name="nombre_archivo" id="nombre_archivo" />
									                   </div>-->
									                   
									                    <div class="col-md-9 col-sm-9 col-xs-12" style="display: inline-block;" >
									                    	
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
										    	 
										    	     
										         	 
										        </div> <!-- Contenedor  de contenido-->
										        
										   	   </div> <!-- fin x panel 5ta pregunta -->
					                          	
					                          </div> <!-- Fin de contenedor de modal -->	
					                          
					                          
					                          
					                          <div class="clearfix"></div>
					                          
					                        </div><!-- Fin de Cuerpo de Modal -->
					                        <div class="modal-footer">
					                          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
					                          <button type="button" class="btn btn-primary" id="guardar_accion_correctiva" >Guardar</button>
					                        </div><!-- Fin de pie de Modal -->
					
					                      </div>
					                    </div>
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
					    		 	<button class="btn btn-info" type="button" id="">Agregar</button>	    		 	
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
					     <button type="submit" class="btn btn-primary" id="btn_responder">Responder</button>
					</div>
					
                 
                </div> <!-- Fin de pestaña Respuesta Sacp-->                      
                       
                       
                 {if $tipo_usuario == 4 && $id_unidad == 17 }       
                <!-- ////////////////////  Pestaña Seguimiento /////////////////////////////////// -->
                <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">      
                   <form id="form_seguimiento" action="#" method="post"> </form> 
                    	<div class="row">
					 <!-- 1ra fila -->
					  <div class="col-md-12 col-sm-12 col-xs-12">
					    <div class="x_panel">
						 	 <div class="x_title">
					     		<h2>Registrar Seguimiento</h2>
					     		<ul class="nav navbar-right panel_toolbox">
					                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
					                  </li>                      
					                </ul>
					     		<div class="clearfix"> </div>
					     	 </div> 
					        <div class="x_content">  	       		   
					          
					          <div class="col-md-12 col-sm-12 col-xs-12">  
						          <center>
						           <div class="form-group">
							     	  <label class="control-label col-md-10 col-sm-10 col-xs-12">Se ha implementado todas las acciones Correctivas Preventivas</label> 	<br><br>						            		       	 		
							           <div class="col-md-9 col-sm-9 col-xs-12">							    	  
								    	  <input type="radio" class="flat" name="implementa_segui" id="implementa_segui_si"     value="1" checked="" required />&nbsp;&nbsp;
							            	Si &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
							               	<input type="radio" class="flat" name="implementa_segui"   id="implementa_segui_no" value="0"  required />&nbsp;&nbsp;
								            No &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
								    	</div>
							       </div><br><br>
							     </center>  
							        <input type="hidden" id="fecha_oculta" form="form_seguimiento" value="$fecha_actual"> 
							    	<div class="form-group">
							     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Fecha </label>
							            <div class="col-md-3 col-sm-3 col-xs-12">
							             <input type="text" class="form-control mantener_tamano"  form="form_seguimiento" id="fecha_segui" disabled="" value="{$fecha_actual}"> 
							            </div>  		       	 		
							    	 </div><br><br>
							    	 
							    	 <div class="form-group">
							     	  <label class="control-label col-md-2 col-sm-2 col-xs-12">Comentario </label>
							            <div class="col-md-9 col-sm-9 col-xs-12">
							             <textarea class="form-control mantener_tamano" rows="1" name="comentario_segui" id="comentario_segui" form="form_seguimiento" required="">  </textarea>
							            </div>  		       	 		
							    	 </div><br><br><br><br>
							    	 
							    	 <div class="col-md-12 col-sm-12 col-xs-12">
							    	 	<div class="col-md-4 col-sm-4 col-xs-12"></div>
							    	 	<div class="col-md-4 col-sm-4 col-xs-12"></div>
								    	 <div class="col-md-4 col-sm-4 col-xs-12 text-right">
				                          		 <input type="submit" class="btn btn-round btn-info" id="btn_agregar_segui" form="form_seguimiento" value="Agregar Seguimiento">
				                          </div>
						             </div>
						          	    <div class="clearfix"></div><br><br>
						                 
							          <div class="table-responsive ">						          	
							          	<table class="table table-bordered table-striped" id="tbl_seguimiento"> 
							          		<thead>
							          			<th>Fecha </th>
							          			<th>Cumplimiento</th>
							          			<th>Comentario</th>
							          			<th>Acción</th>
							          		</thead>
							          		<tbody>
							          			
							          		</tbody>	          		
							          	</table> 					          	
							          </div>
						               
						          
					           </div><!-- fin contenedor izquierda-->	           
					         	 
					        </div> <!-- Contenedor  de contenido-->
					        
					   	   </div> <!-- fin x panel -->	   
					  </div>	
					</div> <!-- Contenedor  de 1ra Fila/row-->
                    
                    
                                         
                </div><!-- FIN PESTAÑA SEGUIMIENTO -->
                {else} <!-- FIN comprobacion tipo usuario y unidad deso -->
                 <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">      
                	 <div class="col-md-12 col-sm-12 col-xs-12"> <br><br><br><br>
                	 	<center><h3> No tiene Permiso para ver el  Área de <br>Seguimiento</h3></center>
                	 </div>
                 </div>	
                
                {/if}
                
                
                 {if $tipo_usuario == 4 && $id_unidad == 17 }   
                 <!-- ////////////////////  Pestaña CIERRE /////////////////////////////////// -->
                <div role="tabpanel" class="tab-pane fade" id="tab_content4_cierre" aria-labelledby="profile-tab">      
                   <form action="#" method="post" id="form_cierre" > </form> 
                    	<div class="row">
					 <!-- 1ra fila -->
					  <div class="col-md-12 col-sm-12 col-xs-12">
					    <div class="x_panel">
						 	 <div class="x_title">
					     		<h2>Cerrar Sacp</h2>
					     		<ul class="nav navbar-right panel_toolbox">
					                  <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
					                  </li>                      
					                </ul>
					     		<div class="clearfix"> </div>
					     	 </div> 
					        <div class="x_content">  	       		   
					          
					          <div class="col-md-12 col-sm-12 col-xs-12">  
						         							     
							    	<div class="form-group">
							     	  <label class="control-label col-md-3 col-sm-3 col-xs-12">Firma Coordinador</label>
							            <div class="col-md-5 col-sm-5 col-xs-12">
							             <input type="text" class="form-control mantener_tamano" name="firma_cierre" id="firma_cierre" form="form_cierre" required=""> 
							            </div>  		       	 		
							    	 </div><br><br>
							    	 
							    	 <div class="form-group">
							     	  <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha</label>
							            <div class="col-md-2 col-sm-2 col-xs-12">
							             <input type="text" class="form-control mantener_tamano" name="fecha_cierre" id="fecha_cierre"  form="form_cierre" disabled="" value="{$fecha_actual}"> 
							            </div>  		       	 		
							    	 </div><br><br>
							    	 
							    	 <div class="form-group">
							     	  <label class="control-label col-md-3 col-sm-3 col-xs-12">Comentario </label>
							            <div class="col-md-8 col-sm-8 col-xs-12">
							             <textarea class="form-control mantener_tamano" rows="2" name="comentario_cierre" id="comentario_cierre" form="form_cierre" required=""></textarea>
							            </div>  		       	 		
							    	 </div><br><br><br><br>
							    	 
							    	 <div class="col-md-12 col-sm-12 col-xs-12 text-right">
							    	 		<br>
			                          		 <input type="submit" class="btn btn-round btn-info" id="btn_cerrar_cierre" form="form_cierre" value="Cerrar SACP">
			                          </div>
						          
						          	    <div class="clearfix"></div><br><br>          
							         
						          
					           </div><!-- fin contenedor izquierda-->	           
					         	 
					        </div> <!-- Contenedor  de contenido-->
					        
					   	   </div> <!-- fin x panel -->	   
					  </div>	
					</div> <!-- Contenedor  de 1ra Fila/row-->                                         
                </div><!-- FIN PESTAÑA CIERRE -->
                
                 {else} <!-- FIN comprobacion tipo usuario y unidad deso -->
                 <div role="tabpanel" class="tab-pane fade" id="tab_content4_cierre" aria-labelledby="profile-tab">     
                	 <div class="col-md-12 col-sm-12 col-xs-12"> <br><br><br><br>
                	 	<center><h3> No tiene Permiso para ver el  Área de <br>Cierre</h3></center>
                	 </div>
                 </div>	
                
                {/if}
                
                
                
                                            
      </div>
</div> <!-- FIN CONTENEDOR PESTAÑAS -->















   
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
	
	<script src="{$public_url}views/sacp/js/agregar_ishikawa.js"></script>
	<script src="{$public_url}views/sacp/js/agregar_seguimiento.js"></script>
	
	<!-- paso 6. agregar acciones correctivas - preventivas -->
	<script src="{$public_url}views/sacp/js/agregar_acciones_correctivas.js"></script>
   
   <!-- subida de ficheros de acciones correctivas -->
    <script src="{$public_url}views/sacp/js/upload.js"></script>
    <script src="{$public_url}views/sacp/js/subida_ficheros.js"></script>
   
	
	
	
	
	  
{/block}