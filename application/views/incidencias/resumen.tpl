{extends $_template}
{block 'css'}    
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">	
	<div class="col-md-8 col-sm-8 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Detalles del Resumen </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>  

		    <li class="dropdown">
                        <a href="#" class="dropdown-toggle"  data-toggle="modal" data-target=".causas-bs-example-modal-lg" role="button" aria-expanded="false" id="causas-modal_boton"><i class="fa fa-wrench"></i></a>
                      </li>

                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content"> 	 
	   <!-- <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Mostrar: </label>
            <div class="col-md-9 col-sm-9 col-xs-12">
               <div class="checkbox" style="display: inline-block">
                <label>
                  <input type="checkbox" class="flat" checked="checked"> Incidentes
                </label>
              </div>
              <div class="checkbox" style="display: inline-block">
                <label>
                  <input type="checkbox" class="flat" checked="checked"> Accidentes
                </label>
              </div>
            </div>
        </div> <br><br><br>	 -->  
	   	
	  
	    <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Año</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
             	<select  class="select-minimum form-control" name="ano" id="ano">	                	
	              	<option value="_todas_">Todos</option>
	              	{foreach $lstAnos as $item}
	              	<option value="{$item['ano']}">{$item['ano']}</option>
	              	{/foreach}
	             </select>
            </div>
     </div> <br><br>
        
         <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Departamento</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
              <select  class="select-minimum form-control" name="selDepartamento" id="selDepartamento">	                	
	              	<option value="_todas_">Todas</option>
	              	{foreach $lstDepartamento as $obj}
	              	<option value="{$obj->idDepend}" >{$obj->desDepend}</option>
	              	{/foreach}
	              </select>
            </div>
        </div> <br><br>
        
             <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12">Unidad</label>
            <div class="col-md-9 col-sm-9 col-xs-12">              
               <select class="select-minimum form-control"  name="selUnidad" id="selUnidad"   required >                           	
              	<option value="_todas_">Todas</option>
              </select>
            </div>
        </div> <br>
        
          <div class="form-group"> <br>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
             <label class="control-label col-md-4 col-sm-4 col-xs-12 text-right">           	   
            		<button type="button" class="btn btn-round btn-success" id="exportar_excel" >Exportar Excel&nbsp;&nbsp;&nbsp; 
            	 	<i class="fa fa-file-excel-o" style="font-size: 20px; "></i>
            	 	</button>            	
            </label>                         
       	 </div>
	 	
	   </div><!-- fin  de Content -->
		</div>
	</div> <!-- Contenedor  de Columna 8 -->
</div><!-- Contenedor  de Fila -->

<div class="row">
	<div class="col-md-10 col-sm-10 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">	     		
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	</div>
	     	<div class="x_content"> 
	     		
     		<div class="center-margin text-center">
	     		<h3 id="titulo_resumen"></h3>	     	
	     		<h3 id="titulo_ano"></h3>
	     	</div>
	     	<div  class="table-responsive" id="contenedor_tblListar_resumen">
	     	</div>	
	     		
	     		
	     		
	     	<!--	
	     			 <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th colspan="8" class="alineacion"><h3>Reporte de Incidencias - Cuadro de resumen</h3></th>                         
                        </tr>
                         <tr>
                          <th colspan="2" rowspan="2" class="alineacion">Fecha</th>  <th colspan="3" class="alineacion" >Incidentes </th> <th colspan="3" class="alineacion">Accidentes</th>                         
                        </tr>                       
                        <tr>
                          <th rowspan="2" class="texto-vertical">pendientes</th>  <th rowspan="2" class="texto-vertical">Aprobados </th> <th rowspan="2" class="texto-vertical">Rechazados </th> <th rowspan="2" class="texto-vertical">pendientes</th>  <th rowspan="2" class="texto-vertical" >Aprobados </th> <th  rowspan="2" class="texto-vertical">Rechazados </th>                      
                        </tr>
                         <tr>
                          <th >Año </th>  <th>Mes </th>                     
                        </tr>                      
                      </thead>
                      <tbody>
                      	<tr>
                          <th rowspan="13" class="alineacion_vert" >2016 </th><td>Enero </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Febrero </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Marzo </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Abril </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                       <tr>
                          <td>Mayo </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Junio </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Julio </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Agosto </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Setiembre </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Octubre</td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Noviembre </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                        <tr>
                          <td>Diciembre </td> <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>  <td>&nbsp; </td>                   
                        </tr>
                       
                        
                                           
                         PARA EL TOTAL ACUMULADO 
                         <tr>
                          <th colspan="1">TOTAL GENERAL  <th>&nbsp; </th>  <th>&nbsp; </th>  <th>&nbsp; </th>  <th>&nbsp; </th>  <th>&nbsp; </th>  <th>&nbsp; </th>                   
                        </tr>
                        
                             
                      </tbody>
	     		</table> -->
	     		
	     	</div>	
	     </div> 
	</div>	
</div>

<!-- Para el Modal -->

  <div class="modal fade causas-bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="causas_modal_contenido">

  </div>



    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'
    -->

    <script src="{$public_url}views/incidencias/js/app.js"></script>
    <script src="{$public_url}views/incidencias/js/combobox_unidades_resumen.js"></script>
    <script src="{$public_url}views/incidencias/js/resumen.js"></script>
     <script src="{$public_url}vendors/jQuery-Smart-Wizard/js/jquery.smartWizard_modificado.js"></script>
<script src="{$public_url}views/autoayuda/incidencias/listar_resumen.js"></script>
    
{/block}