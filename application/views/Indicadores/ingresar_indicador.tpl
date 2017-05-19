{extends $_template}
{block 'css'}    
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">	
	
	<div class="col-md-10 col-sm-10 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Indicadores de Desempeño por Unidad </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 
	    <div class="x_content"> 
	 	 
	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Unidad</label>
            <div class="col-md-8 col-sm-8 col-xs-12">
              <!-- imprimira automaticamente la unidad del usuario logeado en el sistema -->
              <h4>{$unidad->desDepend}</h4>
            </div>
        </div> 
        <div class="clearfix"></div> <br>
        
         <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Año</label>
            <div class="col-md-2 col-sm-2 col-xs-12">
              {$select_anos}
            </div>
        </div> 
        <div class="clearfix"></div><br><br>
        
          <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Mes</label>
            <div class="col-md-2 col-sm-2 col-xs-12">
              {$select_meses}
            </div>
        </div> <br><br><br><br>
       
        <div class="col-md-10 col-sm-10 col-xs-12 center-margin" > 
      <table class="table table-bordered" id="tblListar_xUnidad">
              <thead>
                <tr>
                  <th class="alineacion">Indicador </th>
                  <th class="alineacion">Estado</th> 
                  <th class="alineacion">Acción</th> 
                                                                      
                </tr>                                                                  
              </thead>
              <tbody>                      	
              	
                 
                      	                 
               </tbody>
	     </table> 
        </div>
       
        
		
	   </div><!-- fin  de Content -->
		</div>
	</div> <!-- Contenedor  de Columna 8 -->
</div><!-- Contenedor  de Fila -->


    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'   -->
    <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="{$public_url}app/js/app.js"></script>-->

      <script src="{$public_url}views/indicadores/js/listar_ingresarIndicador.js"></script>
     
       
{/block}