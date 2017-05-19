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
	     		<h2> Opciones para filtrar Reporte </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content">  
	    
                
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Unidad</label>
             <div class="col-md-4 col-sm-4 col-xs-12">	                          
	              	<select class="select-default form-control" tabindex="-1" name="unidad"  id="unidad" data-placeholder="Seleccione" required >              	
              		 <option></option>
	              	 {foreach $lstUnidades as $obj}
						<option value="{$obj->idDepend}">{$obj->desDepend}</option>
					 {/foreach}
				   </select>	                
             </div>                                  
        </div>
        
                 
        <div class="form-group">
              <label class="control-label col-md-2 col-sm-2 col-xs-12">Tipo</label>
             <div class="col-md-4 col-sm-4 col-xs-12">
	               <select   name="tipo"  id="tipo" >                 
	              	<option value="_todas_">Todas</option>
	              	<option value="SGC">SGC</option>
	              	<option value="SGA">SGA</option>
	              	<option value="SGSST">SGSST</option>	              	
	              </select>
             </div>                                
        </div>      
        
        <div class="clearfix"></div> <br>     
        
       <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Mes</label>
            
	             <div class="col-md-2 col-sm-2 col-xs-12" id="contenedor_mes">
		              {$select_meses}
	             </div> 
                    
        </div>  <br><br>     
          
          <div class="clearfix"></div>
        
         <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Año</label>
             <div class="col-md-2 col-sm-2 col-xs-12">
	             {$select_anos} 
             </div>           
        </div>  <br><br><br><br>
        
          <div class="form-group" id="contenedor_fechas">
          
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Mostrar por:</label>
            <div class="col-md-3 col-sm-3 col-xs-12">
            	<input type="radio"    name="tiempo"  value="1" checked="" id="tiempo_mes" />&nbsp;&nbsp;
            	Mes <br> <br>
               	<input type="radio"    name="tiempo"  value="2"  id="tiempo_trime" />&nbsp;&nbsp;
	            Trimestre <br><br> 
	            <input type="radio"    name="tiempo"  value="3" id="tiempo_ano" />&nbsp;&nbsp;
	            Año <br><br>             	                   
	        </div>
	        
	        <label class="control-label col-md-5 col-sm-5 col-xs-12 text-right">
            	<!-- <button type="button" class="btn btn-default btn-lg" id="btn_imprimir" >Imprimir 
            	 	<i class="fa fa-sign-out" style="font-size: 20px; "></i>
            	</button>-->
            	   
            	     <button type="button" class="btn btn-round btn-danger" id="exportar_pdf" >Exportar PDF&nbsp;&nbsp;&nbsp; 
            	 	<i class="fa fa-file-pdf-o" style="font-size: 20px; "></i>
            	   </button>            	
            </label> 
	        
	        
	        
	        
	        
	         <label class="control-label col-md-5 col-sm-5 col-xs-12 text-right">
            	        	 
            	   
            		<button type="button" class="btn btn-round btn-success" id="exportar_excel" >Exportar Excel&nbsp;&nbsp;&nbsp; 
            	 	<i class="fa fa-file-excel-o" style="font-size: 20px; "></i>
            	   </button>
            	
            </label> 
	        
	        
	        
          </div><br>
          
          <!--   <div class="form-group"> <br>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">	  </label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">
            	<!-- <button type="button" class="btn btn-default btn-lg" id="btn_imprimir" >Imprimir 
            	 	<i class="fa fa-sign-out" style="font-size: 20px; "></i>
            	</button>
            	<button type="button" class="btn  btn-lg" style="background-color: ">Exportar&nbsp;&nbsp;&nbsp; 
            	 	<i class="fa fa-file-excel-o" style="font-size: 20px; "></i>
            	 </button>
            </label>                        
       	 </div>    -->         
             
	 	
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
	     	
	     	<div class="x_content"  id="imprimeme">      		
	     		<div class="col-md-12 col-sm-12 col-xs-12 text-center">
	     			<h3 id="nombre_unidad"></h3>
	     			<h4 id="nombre_fecha"></h4>
	     		</div>
	     			 <table class="table table-bordered" id="tblListar_reporte"  >
                     <!-- <thead>
                        <tr>                          
                          <th class="alineacion">Indicador </th>
                          <th class="alineacion">Tipo</th> 
                           <th class="alineacion">Medida</th> 
                          <th class="alineacion">Consumo</th>                                                                                                 
                        </tr>                                                                  
                      </thead>                                      
                      <tbody>-->
                      <!--	<tr id="{$item['ind_id']}">
                      	  
                      	  <td>Consumo de Papel</td>
                      	  <td>SGA</td>	
                      	  <td>RM</td>	
                      	  <td>Compras y Contrataciones</td>
                      	  <td>10</td>                      	 
                      		
                      	</tr>
                      	
                      		<tr id="{$item['ind_id']}">
                      	  
                      	  <td>Consumo de toners</td>
                      	  <td>SGA</td>	
                      	  <td>UN</td>	
                      	  <td>Compras y Contrataciones</td>
                      	  <td>13</td>                      		
                      	</tr>-->                     	                 
                      
	     		</table>
	     		
	     	</div>	
	     </div> 
	</div>	
</div>


<div class="row" id="reporte_pie">
	<div class="col-md-12 col-sm-12 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
				<h2> Gráfico</h2>
				     		
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	</div>
	     	
	     	<div class="x_content"  id="imprimeme">      	     	
	     	 <div class="col-md-10 col-sm-10 col-xs-12 center-margin" >
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Circular</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                       
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <div id="echart_pie" style="height:350px;"></div>

                  </div>
                </div>
              </div>
	     	
	     		
	     	</div>	
	     </div> 
	</div>	
</div>

 <!--Modal -->




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
    
    
     <script src="{$public_url}/vendors/echarts/dist/echarts.min.js"></script>
     <script src="{$public_url}/vendors/echarts/map/js/world.js"></script>
    
    
	
    <script src="{$public_url}views/indicadores/js/reporte.js"></script>
     <script src="{$public_url}views/indicadores/js/pie.js"></script>
    
    
   
{/block}