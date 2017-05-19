{extends $_template}

{block 'css'}
    {* <link href="{$public_url}views/gestor/css/carpetas.css" rel="stylesheet"> *}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {* <link href="{$public_url}vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"> *}
{/block}

{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
              <div class="col-md-8 col-sm-8 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Filtrar Declaraciones</h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

                        <div class="col-sm-9">

                            <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtInstalacionF">Instalación</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <input id="txtInstalacionF" class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtInstalacionF" placeholder="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selResiduoF">Residuo</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selResiduoF" id="selResiduoF" data-placeholder=" - Seleccione - ">
                                    <option value="-1" selected="">Todos</option>
                                    {foreach $lstResiduos as $obj}
                                    <option value="{$obj->res_id}">{$obj->res_nombre}</option>
                                    {/foreach}
                                  </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selYearF">Año</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selYearF" id="selYearF" data-placeholder=" - Seleccione - ">
                                    <option value="-1" selected="">Todas</option>
                                    {foreach $lstYear as $obj}
                                    <option value="{$obj->rd_year}">{$obj->rd_year}</option>
                                    {/foreach}
                                  </select>
                                </div>
                            </div>

                            <div class="form-group">
                              <div class="col-md-6 col-sm-6 col-xs-12 col-sm-offset-3">
                                {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                                {* <button type="submit" class="btn btn-success">Nueva Declaración</button> *}
                                {* <a href="{$base_url}residuo/generar_declaracion" target="_blank" class="btn btn-success">Nueva Declaración</a> *}
                              </div>
                            </div>
                        </div>





                    </form>

                    </div>
                  </div>
                     <div class="clearfix"></div>

                  </div>
                </div>


      <div class="row">
        <div class="col-md-8 col-sm-8 col-xs-12">
          <div class="x_panel">
            <div class="x_title">
                <h2>Lista de Declaración de Manejo de Residuos Sólidos <small>&nbsp;</small></h2>
                <ul class="nav navbar-right panel_toolbox">
                  <li><a href="{$base_url}residuo/generar_declaracion"  class="btn btn-primary" id="" style="float:right"  title="Agregar nueva declaración">Nueva Declaración</a></li>

                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                    <div class="table-responsive">
                         <table class="table table-striped" id="tblListar">
                      <thead>
                        <tr>
                          <th>INSTALACIÓN</th>
                          <th>RESIDUO</th>
                          <th>AÑO</th>
                          <th>ACCIÓN</th>
                        </tr>
                      </thead>
                      <tbody></tbody>
                    </table>
                    </div>
            </div>
          </div>
        </div>
      </div>
{/block}

{block 'script'}
  <script src="{$public_url}vendors/validator/validator.js"></script>
  <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    {* <script src="{$public_url}vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="{$public_url}vendors/datatables.net-scroller/js/datatables.scroller.min.js"></script>
    <script src="{$public_url}vendors/jszip/dist/jszip.min.js"></script>
    <script src="{$public_url}vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="{$public_url}vendors/pdfmake/build/vfs_fonts.js"></script> *}
    {* <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script> *}
    <script src="{$public_url}views/residuo/js/res_declaracion_manejo.js" async="async"></script>


{/block}