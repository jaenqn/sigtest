{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
        <div class="col-md-8 col-sm-8 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2 id="">Filtrar categorias de carpeta <small>&nbsp;</small></h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left" enctype=""  method="post">
                        <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombreCateF">Nombre
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtNombreCateF" name="txtNombreCateF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Estado
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="select-minimum input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="txtEstadoF" id="txtEstadoF">
                                <option value="">&nbsp;</option>
                                <option value="-1" selected="">Todos</option>
                                <option value="1">Activo</option>
                                <option value="0">Inactivo</option>
                              </select>
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
                  <h2 id="">Lista de Categorías</h2>

                  <ul class="nav navbar-right panel_toolbox">
                    <li>
                            <button  class="btn btn-primary" id="btnNuevo" style="float:right" data-toggle="tooltip" data-placement="left" title="" data-original-title="Agregar nuevo categoría"><i class="fa fa-plus" ></i>&nbsp;Nueva Categoría&nbsp;</button></li>
                  </ul>
                  <div class="clearfix"></div>
              </div>
              <div class="x_content">
                <div class="table-responsives ">
                     <table class="table table-striped" id="tblListar">
                      <thead>
                        <tr>
                          <th>NOMBRE</th>
                          <th>URL</th>
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
      <div class="modal-dialog">
        <div class="modal-content">
        <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span></button>
            <h4 class="modal-title" id="tituloModal">Registro Categorías</h4>
          </div>
          <div class="modal-body">

              <input type="hidden" name="txtId" value="" id="txtId">
              <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombreCategoria">Categoría</label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <input type="text" id="txtNombreCategoria" name="txtNombreCategoria" required="required" class="form-control col-md-7 col-xs-12" placeholder="" autofocus="">
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtUrlCategoria">Url</label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <input type="text" id="txtUrlCategoria" name="txtUrlCategoria" required="required" class="form-control col-md-7 col-xs-12">
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Estado </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <input type="checkbox" class="radio-flat flat" name="chkEstado" id="chkEstado"   checked="" />
                     Estado
                </div>
              </div>
              <input type="submit" name="btnGuardar" id="btnGuardar" value="asdasd" class="hidden" >


          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
            <button type="submit" class="btn btn-primary" id="btnRegistrar" data-accion="guardar">Guardar</button>
          </div>
          </form>
        </div>
      </div>
    </div>
{/block}
{block 'script'}
    <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="{$public_url}views/carpetas/js/car_categorias.js"></script>
{/block}