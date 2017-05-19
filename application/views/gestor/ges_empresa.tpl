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
              <div class="col-md-8 col-sm-8 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2 id="tituloModal">Filtrar lista de  empresas contratistas <small>&nbsp;</small></h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                     <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left" enctype=""  method="post">

                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombreEmpF">Nombre
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtNombreEmpF" name="txtNombreEmpF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtDireccionEmpF">Dirección
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtDireccionEmpF" name="txtDireccionEmpF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtTelefonoEmpF">Teléfono
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtTelefonoEmpF" name="txtTelefonoEmpF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                </div>
                              </div>
                               <div class="form-group">

                                  </div>

                            </form>
                    <div class="clearfix"></div>
                    <div class="ln_solid"></div>
                    <div class="row">
                        <div class="col-sm-8 col-xs-12"><h2>Lista de Empresas<small>&nbsp;</small></h2></div>
                        <div class="col-sm-4 col-xs-12">
                            <button  class="btn btn-success" id="btnNuevo" style="float:right" data-toggle="tooltip" data-placement="left" title="" data-original-title="Agregar nuevo elemento">Agregar Empresa</button>
                        </div>
                        {* <div class="col-sm-4 col-xs-12 "><button type="button" class="btn btn-default btn" style="float: right;margin-left: 0px;margin-right: 0px;" id="btnAbrirModRegUni">Agregar</button></div> *}
                    </div>
                    <div class="table-responsives ">
                         <table class="table table-striped" id="tblListar">
                      <thead>
                        <tr>
                          <th>NOMBRE</th>
                          <th>DIRECCIÓN</th>
                          <th>TELÉFONO</th>
                          <th>ACCIÓN</th>
                        </tr>
                      </thead>
                      <tbody>
                       {*  {foreach $lstEmpresa as $obj}
                         <tr>
                            <th scope="row">{$obj->empc_id}</th>
                            <td class="txtNombre">{$obj->empc_nombre}</td>
                            <td class="txtDireccion">{$obj->empc_direccion}</td>
                            <td class="txtTelefono">{$obj->empc_telefono}</td>
                            <td><a href="" data-id-obj="{$obj->empc_id}" class="btnAcciones btnEditar" data-accion="editar">editar</a>/<a href="" data-id-obj="{$obj->empc_id}" class="btnAcciones btnEliminar" data-accion="eliminar">eliminar</a></td>
                        </tr>
                        {/foreach} *}

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
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">Registro Empresa</h4>
      </div>
      <div class="modal-body">
        <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
          <input type="hidden" name="txtId" value="" id="txtId">
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombreEmp">Empresa</label>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <input type="text" id="txtNombreEmp" name="txtNombreEmp" required="required" class="form-control col-md-7 col-xs-12" placeholder="">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtDireccionEmp">Dirección</label>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <input type="text" id="txtDireccionEmp" name="txtDireccionEmp" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtTelefonoEmp">Teléfono</label>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <input type="text" id="txtTelefonoEmp" name="txtTelefonoEmp" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>
          <input type="submit" name="btnGuardar" id="btnGuardar" value="asdasd" class="hidden" >
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
    <script src="{$public_url}views/gestor/js/ges_empresa.js" async="async"></script>

{/block}