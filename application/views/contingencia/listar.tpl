{extends $_template}
{block 'css'} 
	 <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
   
    <link href="{$public_url}views/residuos/css/reporte_general.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui.min.css" rel="stylesheet">
    <link href="{$public_url}views/incidencias/css/jquery-ui-timepicker-addon.css" rel="stylesheet">    
     
{/block}
{block 'contenido'}


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
	     		<div  class="table-responsive">
	     			 <table class="table table-bordered table-striped table-hover" id="tblListar">
                      <thead>
                        <tr>
                          <th class="alineacion">ID </th>
                          <th class="alineacion">Descripcion</th> 
                           <th class="alineacion">Estado</th> 
                          <th class="alineacion">Fecha Aprobación </th> 
                          <th class="alineacion">Opciones</th>                                                  
                        </tr>                                                                  
                      </thead> 
                    <!--  <tfoot>
                        <tr>
                          <th class="alineacion">ID </th>
                          <th class="alineacion">Descripcion</th> 
                           <th class="alineacion">Estado</th> 
                          <th class="alineacion">Fecha Aprobación </th> 
                          <th class="alineacion" id ="opciones">Opciones</th>                                                  
                        </tr>                                                                  
                      </tfoot>      -->                
                      <tbody>
                      	{foreach  $lstContigencia  as $item} 
                      	<tr id="{$item['con_id']}">
                      	  <td>{$item['con_id']}</td>
                      	  <td>{$item['con_descripcion']}</td>
                      	  {if $item['con_estado'] == 0}
                      	  	<td>Pendiente</td>
                      	  {else }	
                      	  	<td>Publicado</td>
                      	  {/if}
                      	  	
                      	  <td>{$item['con_fecha_aprobacion']}</td>	
                      	  <td>
                      	  	<a href="../temp_contingencia/{$item['con_id']}.pdf" title="Ver" target="_blank">
                      	  		<i class="fa fa-eye" style="font-size: 20px;">
									&nbsp;
								</i>                      	  		
                      	  	</a> / &nbsp;
                      	  	<a  href="#" class="delete" title="Eliminar">
								<i class="fa fa-trash" style="font-size: 20px;">
									&nbsp;
								</i>
							</a>
							{if $item['con_estado'] == 0}
								&nbsp;&nbsp;&nbsp;
								<a  href="" class="aprobar" title="Aprobar">
									<i class="fa fa-check" style="font-size: 20px;">
										&nbsp;
									</i>
								</a>
							{/if}
						  </td>		
                      		
                      	</tr>
                      	{/foreach}
                      	                 
                      </tbody>
	     		</table>
	     		</div>
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
    
	<script src="{$public_url}views/incidencias/js/jquery-ui.min.js"></script>
	<script src="{$public_url}views/incidencias/js/jquery-ui-timepicker-addon.js"></script>
    <script src="{$public_url}views/contingencia/js/listar.js"></script>-->
    <script src="{$public_url}views/contingencia/js/eliminar.js"></script>-->
    
   
{/block}