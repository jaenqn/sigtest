{extends $_template}
{block 'css'} 
	 <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
   
    <link href="{$public_url}views/residuos/css/reporte_general.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">    
     
{/block}
{block 'contenido'}
 	
        
<div class="row">	
	<div class="col-md-11 col-sm-11 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Notificaciones </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	
	     	 </div> 
	    <div class="x_content">  	    
               <input type="hidden" name="id_unidad" id="id_unidad"  value="{$id_unidad}"/>
              <div class="col-md-12 col-sm-12 col-xs-12  text-right"> 
              	{if $tipo_usuario == 3 || $tipo_usuario == 4 }
    		 	<button class="btn btn-info" type="button" id="enviar_notificacion">Enviar Notificación</button>
    		 	{/if}
    		  </div> 	
 
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">

                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">Recibidos</a>
                        </li>                       
                       	 <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">Observaciones</a>
                       	 </li>
                       	  {if $tipo_usuario == 3 || $tipo_usuario == 4 }
                       	  <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab3" data-toggle="tab" aria-expanded="false">Enviados</a>
                       	 </li>
                       	 {/if}
                      </ul>
                      <div id="myTabContent" class="tab-content">
                      	<!-- Recibidos  -->
                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
	                     <table class="table table-bordered" id="tblListar_recibidas" style="width: 100%;">
	                      <thead>
	                        <tr>
	                          <th class="alineacion">Fecha </th>
	                          <th class="alineacion">Asunto</th>
	                          <th class="alineacion">Estado</th>  
	                           <th class="alineacion">Acción</th>                                                                            
	                        </tr>                                                                  
	                      </thead>                  
	                      <tbody>  
	                      	             	                 
	                      </tbody>
		     			</table>                          
                        </div>
                        
                         <!-- observaciones  -->
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
                          
                           <table class="table table-bordered" id="tblListar_observaciones" style="width: 100%;">
	                      <thead>
	                        <tr>
	                          <th class="alineacion">Fecha </th>
	                          <th class="alineacion">Asunto</th>
	                          <th class="alineacion">Estado</th>  
	                           <th class="alineacion">Acción</th>                                                                            
	                        </tr>                                                                  
	                      </thead>                  
	                      <tbody>  
	                      	             	                 
	                      </tbody>
		     			</table>   
                        </div>                        
                        
                        <!-- Enviados  -->
                        <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">
                          
                           <table class="table table-bordered" id="tblListar_enviados" style="width: 100%;">
	                      <thead>
	                        <tr>
	                          <th class="alineacion">Fecha </th>
	                          <th class="alineacion">Asunto</th>
	                          <th class="alineacion">Estado</th>  
	                           <th class="alineacion">Acción</th>                                                                            
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
    
	
    <script src="{$public_url}views/notificaciones/js/listar_gestionar.js"></script>-->
    <script src="{$public_url}views/notificaciones/js/listar_gestionar_enviados.js"></script>-->
    <script src="{$public_url}views/notificaciones/js/listar_gestionar_observaciones.js"></script>-->
    <script src="{$public_url}views/notificaciones/js/eliminar.js"></script>-->
     <script src="{$public_url}views/notificaciones/js/eliminar_observacion.js"></script>-->
    
    
    
    
   
{/block}