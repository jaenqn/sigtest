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
              <h2>Gestor Unidades <small>&nbsp;</small></h2>
              <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">
              <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNomUniF">Unidad
                  </label>
                  <div class="col-md-6 col-sm-6 col-xs-12">
                      <input type="text" id="txtNomUniF" name="txtNomUniF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                  </div>
              </div>
              <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selUniDepartamentoF">Departamento
                </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                  <select class="select-default form-control input-filter" tabindex="-1" name="selUniDepartamentoF" id="selUniDepartamentoF" data-placeholder=" - Seleccione - ">
                    <option></option>
                    <option value="-1" selected="">Todos</option>
                    {foreach $lstDepartamento as $obj}
                    <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                    {/foreach}
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label for="selUniEstadoF" class="control-label col-md-3 col-sm-3 col-xs-12">Estado</label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                   <select class="select-minimum form-control input-filter" tabindex="-1" name="selUniEstadoF" id="selUniEstadoF" data-placeholder=" - Seleccione - ">
                    <option></option>
                    <option value="-1" selected="">Todos</option>
                    <option value="1">Activo</option>
                    <option value="0">Inactivo</option>
                  </select>
                </div>
              </div>
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
  <div class="col-md-8 col-sm-8 col-xs-12">
      <div class="x_panel">
        <div class="x_title">
            <h2>Lista de Unidades <small>&nbsp;</small></h2>

             <ul class="nav navbar-right panel_toolbox">

            <li><a  class="btn btn-primary" id="btnNuevo" style="float:right" title="Agrega nueva unidad">Agregar Unidad</a></li>

          </ul>

            <div class="clearfix"></div>
        </div>
        <div class="x_content">

                {* <div class="col-sm-12 col-xs-12"><div><h2>Lista de Unidades<small>&nbsp;</small></h2></div> *}


                {* <div class="col-sm-4 col-xs-12 "><button type="button" class="btn btn-default btn" style="float: right;margin-left: 0px;margin-right: 0px;" id="btnAbrirModRegUni">Agregar</button></div> *}

          <div class="table-responsive">
            <table class="table table-striped" id="tblListar">
              <thead>
                <tr>
                  <th>UNIDAD</th>
                  <th>DEPARTAMENTO</th>
                  <th>ABBR</th>
                  <th>ESTADO</th>
                  <th>ACCIÓN</th>
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


<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modRegistro" >
      <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Registro Unidades</h4>
      </div>
      <div class="modal-body">
      <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left" autocomplete="off">
      <input type="hidden" name="txtId" value="" id="txtId">
            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombre">Unidad
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                  <input type="text" id="txtNombre" name="txtNombre" required="required" class="form-control col-md-7 col-xs-12">
              </div>
            </div>
            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selDepartamento">Departamento
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                <select class="select-default form-control " tabindex="-1" name="selDepartamento" id="selDepartamento" data-placeholder=" - Seleccione - " style="width: 100%">
                  <option></option>
{* <option value="-1" selected="">Todos</option> *}
                  {foreach $lstDepartamento as $obj}
                  <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                  {/foreach}
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selInstalacion">Instalación
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                <select class="select-default form-control" tabindex="-1" name="selInstalacion" id="selInstalacion" data-placeholder=" - Seleccione - " style="width: 100%">
                  <option></option>
                  {foreach $lstInstalacion as $obj}
                  <option value="{$obj->ins_id}">{$obj->ins_nombre}</option>
                  {/foreach}
                </select>
              </div>
            </div>

            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtAbbr">Abreviado
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                  <input type="text" id="txtAbbr" name="txtAbbr" required="required" class="form-control col-md-7 col-xs-12">
                   <span id="errorAbbr" class="hidden">Abbr no disponible</span>

              </div>
          {*     <div class="col-sm-3">
                <p id="resAbbr"></p>
              </div> *}
            </div>
            <div class="form-group">
              <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Estado</label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                   <div class="checkbox">
                      <label>
                        <input type="checkbox" class="flat"  name="chkActivo" id="chkActivo" checked=""> Activo
                      </label>
                    </div>
              </div>
            </div>
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
    <script src="{$public_url}views/gestor/js/unidades.js" async="async"></script>
{/block}