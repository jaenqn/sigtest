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
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title">
          <h2>Filtrar Lista<small>&nbsp;</small></h2>

          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">
              <div class="col-sm-9">

                  <div class="form-group">
                      <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selDepartF">Departamento</label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <select class="select-default form-control input-filter" tabindex="-1" name="selDepartF" id="selDepartF" data-placeholder=" - Seleccione - ">
                          <option value="-1" selected="">Todos</option>
                          {foreach $lst_deps as $obj}
                          <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                          {/foreach}
                        </select>
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selUnidadF">Unidad</label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <select class="select-minimum form-control input-filter" tabindex="-1" name="selUnidadF" id="selUnidadF" data-placeholder=" - Seleccione - " disabled="">
                        </select>
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selAlmacenF">Almacen</label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <select class="select-minimum form-control input-filter" tabindex="-1" name="selAlmacenF" id="selAlmacenF" data-placeholder=" - Seleccione - ">
                          <option></option>
                          <option value="-1" selected="">Todos</option>
                          {foreach $lst_alm as $obj}
                          <option value="{$obj->alm_id}">{$obj->alm_nombre}</option>
                          {/foreach}
                        </select>
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selEstadoF">Estado</label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoF" id="selEstadoF" data-placeholder=" - Seleccione - ">
                          <option></option>
                          <option value="-1" selected="">Todos</option>
                          <option value="0">Por Autorizar</option>
                          <option value="1">Autorizados</option>
                          <option value="2">Rechazados</option>
                        </select>
                      </div>
                  </div>
              </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title">
          <h2>Lista de Autorizaciones <small>&nbsp;</small></h2>
          {if $smarty.session.tipo_usuario == 1}
           <li><a  href="{$base_url}residuo/ingreso" class="btn btn-primary" id="" style="float:right" title="Generar nueva solicitud">Crear Autorización</a></li>
          {/if}
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <div class="table-responsive">
            <table class="table table-striped" id="tblListar">
              <thead>
                <tr>
                  <th>NRO</th>
                  <th>RESIDUO</th>
                  <th>UNIDAD</th>
                  <th>ORIGEN</th>
                  <th>ALMACEN</th>
                  <th>FECHA</th>
                  <th>ESTADO</th>
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
    <script src="{$public_url}views/residuo/js/res_listar.js" async="async"></script>
{/block}