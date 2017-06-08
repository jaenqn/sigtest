{extends $_template}
{block 'css'}
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">

<<<<<<< HEAD
	<div class="col-md-10 col-sm-10 col-xs-12 center-margin">
=======
	<div class="col-md-9 col-sm-9 col-xs-12">
>>>>>>> dev-sacp
		<div class="x_panel">
			<div class="x_title">
	     		<h2> Indicadores de Desempeño por Unidad </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
<<<<<<< HEAD
=======

                           <li class="dropdown">
                        <a href="#" class="dropdown-toggle"  data-toggle="modal" data-target=".causas-bs-example-modal-lg" role="button" aria-expanded="false" id="causas-modal_boton"><i class="fa fa-wrench"></i></a>
                      </li>

>>>>>>> dev-sacp
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div>
	    <div class="x_content">

	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Unidad "teste develop"</label>
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
                  <th class="alineacion">Indicador test </th>
                  <th class="alineacion">Estado</th>
                  <th class="alineacion">Acción "en dev-sacp otro mas, que pasa"</th>


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
<!-- Para el Modal -->

  <div class="modal fade causas-bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="causas_modal_contenido">

  </div>

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

<<<<<<< HEAD
=======
     <script  src="{$public_url}vendors/jQuery-Smart-Wizard/js/jquery.smartWizard_modificado.js"></script>
    <script src="{$public_url}views/autoayuda/indicadores/ingresar.js"></script>
>>>>>>> dev-sacp

{/block}