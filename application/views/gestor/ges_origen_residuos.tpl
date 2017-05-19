{extends $_template}

{block 'css'}
    {* <link href="{$public_url}views/gestor/css/carpetas.css" rel="stylesheet"> *}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="{$public_url}views/gestor/css/origen_residuos.css">
    {* <link href="{$public_url}vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"> *}
{/block}

{block 'contenido'}
    <!--Contenido HTML-->
  <div class="row">
    <div class="col-md-8 col-sm-8 col-xs-8">
      <div class="x_panel">
        <div class="x_title">
          <h2>Filtrar Lista de Orígenes <small>&nbsp;</small></h2>

          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <br />
          <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNomOrigenF">Origen
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                  <input type="text" id="txtNomOrigenF" name="txtNomOrigenF" required="required" class="form-control col-md-7 col-xs-12 input-filter" placeholder="Nombre de Origen">
              </div>
            </div>
            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selDepOrigF">Departamento
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                <select class="select-default form-control input-filter" tabindex="-1" name="selDepOrigF" id="selDepOrigF" data-placeholder=" - Seleccione - ">
                  <option></option>
                  <option value="-1" selected="">Todos</option>
                  {foreach $lstDepartamento as $obj}
                  <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                  {/foreach}
                </select>
              </div>
            </div>
            <div class="form-group">
              <label for="selUniOrigF" class="control-label col-md-3 col-sm-3 col-xs-12">Unidad</label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                 <select class="select-default form-control input-filter" tabindex="-1" name="selUniOrigF" id="selUniOrigF" data-placeholder=" - Seleccione - " disabled="">
                  {* <option></option> *}
                  {* <option value="-1">Todos</option> *}
                  {* <option value="1">Activo</option>
                  <option value="0">Inactivo</option> *}
                </select>
              </div>
            </div>
              {* <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Otro </label>
                      <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="checkbox" class="radio-flat flat" name="chkEstado" id="chkEstado"  required  />
                           &nbsp;
                        </p>
                      </div>
              </div> *}




            <div class="form-group">
              <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                {* <button type="submit" class="btn btn-primary">Cancel</button> *}

              </div>
            </div>

          </form>


        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-8 col-sm-8 col-xs-8">
      <div class="x_panel">
        <div class="x_title">
          <h2>Lista de Orígenes de Residuo <small>&nbsp;</small></h2>
          <button type="button" class="btn btn-success" id="btnNuevo" style="float:right">Nuevo Origen</button>
          <div class="clearfix"></div>
        </div>

        <div class="x_content">
          <div class="table-responsive">
               <table class="table table-striped" id="tblListar">
            <thead>
              <tr>
                <th>ORIGEN</th>
                <th>DEPARTAMENTO</th>
                <th>UNIDAD</th>
                <th style="width:100px">ACCIÓN</th>
              </tr>
            </thead>
            <tbody>
              {foreach $lstUnidades as $obj}
               <tr>
                  <th scope="row">{$obj->uni_id}</th>
                  <td>{$obj->uni_nombre}</td>
                  <td>{$obj->dep_nombre}</td>
                  <td>{$obj->getEstado()}</td>
                  <td><a href="" data-id-causa="{$obj->uni_id}">editar</a>/<a href="" data-id-causa="{$obj->uni_id}">eliminar</a></td>
              </tr>
              {/foreach}

            </tbody>
          </table>
          </div>
        </div>
      </div>
    </div>
  </div>

<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modRegistro">
    <div class="modal-dialog">
      <div class="modal-content">

        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
          </button>
          <h4 class="modal-title" id="myModalLabel">Registro Origen de Residuos</h4>
        </div>
        <div class="modal-body">
        <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
        <input type="hidden" name="txtId" value="" id="txtId">
              <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombreOrigen">Origen
                </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <input type="text" id="txtNombreOrigen" name="txtNombreOrigen" required="required" class="form-control col-md-7 col-xs-12">
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selDepartamentoOrigen">Departamento
                </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                  <select class="select-default form-control" tabindex="-1" name="selDepartamentoOrigen" id="selDepartamentoOrigen" data-placeholder=" - Seleccione - " style="width: 100%">
                    <option></option>
                    {foreach $lstDepartamento as $obj}
                    <option value="{$obj->dep_id}">{$obj->dep_nombre}</option>
                    {/foreach}
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selUnidadOrigen">Unidad
                </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                  <select class="select-default form-control" tabindex="-1" name="selUnidadOrigen" id="selUnidadOrigen" data-placeholder=" - Seleccione - " style="width: 100%" disabled="">
                    <option></option>
                  </select>
                </div>
              </div>
            {*   <div class="form-group">
                <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Estado</label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                     <div class="checkbox">
                        <label>
                          <input type="checkbox" class="flat"  name="chkActivo" id="chkActivo"> Activo
                        </label>
                      </div>
                </div>
              </div> *}
            </form>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
          <button type="button" class="btn btn-primary" id="btnRegistrar" data-accion="guardar">Guardar</button>
        </div>
      </div>
    </div>
</div>
{/block}

{block 'script'}
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
    <script src="{$public_url}views/gestor/js/ges_origen_residuos.js"></script>
{/block}