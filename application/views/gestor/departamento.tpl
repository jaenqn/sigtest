{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
     <!-- Datatables -->
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {* <link href="{$public_url}vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"> *}
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
    <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Filtrar lista<small>&nbsp;</small></h2>
                    {* <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li> *}
                 {*      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li> *}
                      {* <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li> *}
                    {* </ul> *}
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />

                    <form id="frmFiltrar" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">
                        <div class="form-group">
                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Nombre</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input id="txtNombreF" class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtNombreF" placeholder="Departamento a buscar">
                            </div>
                        </div>

                        <div class="form-group">

                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Estado
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="inputSelect2 select-minimum input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="txtEstadoF" id="txtEstadoF">
                            <option value="">&nbsp;</option>
                            <option value="-1" selected="">Todos</option>
                            <option value="1">Activo</option>
                            <option value="0">Inactivo</option>
                          </select>
                        </div>
                      </div>

                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                          {* <button  class="btn btn-success" id="btnNuevo">Nuevo</button> *}
                        </div>
                      </div>

                    </form>

                  </div>
                </div>
    </div>
</div>
<div class="row">
  <div class="col-md-8 col-sm-10 col-xs-12">
              <div class="x_panel">

                  <div class="x_title">
                    <h2>Lista de departamentos</h2>
                     <ul class="nav navbar-right panel_toolbox">
                      <li><a  class="btn btn-primary" id="btnNuevo" style="float:right"  title="Agregar Nuevo">Nuevo Departamento</a></li>

                    </ul>
{*
                    <button  class="btn btn-success" id="btnNuevo" style="float:right">Nuevo departamento</button> *}
                    <div class="clearfix"></div>
                  </div>

                <div class="x_content">


                    <div class="table-responsive">
                         <table class="table table-striped" id="tblListar">
                      <thead>
                        <tr>
                          <th>DEPARTAMENTO</th>
                          <th>ESTADO</th>
                          <th>ABBR</th>
                          <th>ACCIÓN</th>
                        </tr>
                      </thead>
                      <tbody>
                       {*  {foreach $lstDepartamentos as $obj}
                         <tr>
                            <th scope="row">{$obj->dep_id}</th>
                            <td>{$obj->dep_nombre}</td>
                            <td>{$obj->getEstado()}</td>
                            <td><a href="" data-id-causa="{$obj->dep_id}">editar</a>/<a href="" data-id-causa="{$obj->dep_id}">eliminar</a></td>
                        </tr>
                        {/foreach} *}



                      </tbody>
                    </table>
                    </div>

                </div>
              </div>
  </div>
</div>
<!-- Modal Registro Cuasas-->
<div class="modal fade bs-example-modal-lg" id="modRegistro" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog ">
  <div class="modal-content">

    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
      </button>
      <h4 class="modal-title" id="myModalLabel">Registro Departamentos</h4>
    </div>
    <div class="modal-body">
      {* <h4>Text in a modal</h4> *}
      <form id="frmRegistro" method="post" data-parsley-validate class="form-horizontal form-label-left" enctype="multipart/form-data">
        <input type="hidden" name="txtId" id="txtId" value="">

          <div class="form-group">
            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Nombre </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input id="middle-name" class="form-control col-md-7 col-xs-12" type="text" name="txtNombre" placeholder="Nombre Departamento">
            </div>
          </div>
           <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtAbbr">Abreviado
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                  <input type="text" id="txtAbbr" name="txtAbbr" required="required" class="form-control col-md-7 col-xs-12">
                     <span id="errorAbbr" class="hidden">Abbr no disponible</span>
              </div>
              <div class="col-sm-3">
                <p id="resAbbr"></p>
              </div>
            </div>
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Estado </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <input type="checkbox" class="radio-flat flat" name="chkEstado" id="chkEstado"  required="" checked=""  />
                 Estado
            </div>
          </div>
          {* <div class="ln_solid"></div> *}
          {* <div class="form-group">
            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
              <button type="submit" class="btn btn-primary">Cancel</button>
              <button type="submit" class="btn btn-success">Submit</button>
            </div>
          </div> *}

        </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
      <button type="button" class="btn btn-primary" id="btnGuardar" data-accion="guardar">Guardar</button>
    </div>

  </div>
</div>
</div>
<!-- Final Modal Registro Cuasas -->
{/block}
{block 'script'}
     <!-- Datatables -->
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
      <script src="{$public_url}views/gestor/js/departamentos.js"></script>
{/block}