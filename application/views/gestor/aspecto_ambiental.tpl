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
          <div class="col-md-10 col-sm-10 col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                <h2>Filtrar Lista</h2>

                <div class="clearfix"></div>
              </div>
              <div class="x_content">

                <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="txtNombreAspectoF"><span>Aspecto Ambiental</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                                <input type="text" id="txtNombreAspectoF" name="txtNombreAspectoF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">

                        <div class="form-group">
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selTipoCategoriaF">Categoría</label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                              <select class="select-minimum form-control input-filter" tabindex="-1" name="selTipoCategoriaF" id="selTipoCategoriaF" data-placeholder=" - Seleccione - ">
                                <option value="-1" selected="">Todos</option>
                                {foreach $lstCatAmbiental as $obj}
                                <option value="{$obj->cat_id}">{$obj->cat_nombre}</option>
                                {/foreach}
                              </select>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-sm-6">

                        <div class="form-group">
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selEstadoAspectoF">Estado</label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                              <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoAspectoF" id="selEstadoAspectoF" data-placeholder=" - Seleccione - ">
                                <option></option>
                                <option value="-1" selected="">Ambos</option>
                                <option value="1">Activo</option>
                                <option value="0">Inactivo</option>
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
          <div class="col-md-10 col-sm-10 col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                <h2>Lista de Ascpetos Ambientales</h2>
                  <ul class="nav navbar-right panel_toolbox">
                  <li><a  class="btn btn-primary" id="btnNuevo" style="float:right"  title="Agregar nuevo aspecto ambiental" >Nuevo Aspecto Ambiental</a></li>
                </ul>

                <div class="clearfix"></div>
              </div>
              <div class="x_content">
                <div class="table-responsive">
                     <table class="table table-striped" id="tblListar">
                  <thead>
                    <tr>
                      <th>ASPECTO AMBIENTAL</th>
                      <th>CATEGORÍA</th>
                      <th>ESTADO</th>
                      <th>ACCIÓN</th>
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


<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modRegistro">
  <!--##REGISTRO-->
  <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
          </button>
          <h4 class="modal-title" id="tituloModal">Agregar Aspecto Ambiental</h4>

        </div>
        <div class="modal-body">
          <!-- ##FRM REGISTRO-->
          <input type="hidden" name="txtId" value="" id="txtId">
          <div class="form-group">
            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNombreAspecto">Aspecto Ambiental
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="txtNombreAspecto" data-validate-words="2" name="txtNombreAspecto" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selTipoCategoria">Categoría
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <select class="select-default form-control" tabindex="-1" name="selTipoCategoria" id="selTipoCategoria" data-placeholder=" - Seleccione - " style="width: 100%"  required="" >
              <option></option>
                {foreach $lstCatAmbiental as $obj}
                <option value="{$obj->cat_id}">{$obj->cat_nombre}</option>
                {/foreach}
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="chkEstadoAspecto">Estado </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="checkbox" class="radio-flat flat" name="chkEstadoAspecto" id="chkEstadoAspecto"   checked="" />
              Activo
            </div>
          </div>
          {* <button type="submit" id="btnE">Enviar</button> *}
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
          <button type="submit" class="btn btn-primary" id="btnRegistrar" data-accion="guardar">Guardar</button>
        </div>
      </div>
    </div>
  </form>
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
    <script src="{$public_url}views/gestor/js/aspecto_ambiental.js" async="async"></script>
{/block}