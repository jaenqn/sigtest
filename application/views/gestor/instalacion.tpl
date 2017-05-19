{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
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
                    <h2>Filtrar lista</h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombreB">Nombre de Instalación
                                    </label>
                                    <div class="col-md-9 col-sm-9 col-xs-12">
                                        <input type="text" id="txtNombreB" name="txtNombreB" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtRazonSocialB">Razón Social
                                    </label>
                                    <div class="col-md-9 col-sm-9 col-xs-12">
                                        <input type="text" id="txtRazonSocialB" name="txtRazonSocialB" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtRuc">RUC
                                    </label>
                                    <div class="col-md-9 col-sm-9 col-xs-12">
                                        <input type="text" id="txtRuc" name="txtRuc" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                        <label for="selCiudad" class="control-label col-md-3 col-sm-3 col-xs-12">Ciudad</label>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selCiudad" data-placeholder=" - Seleccione - " id="selCiudad">
                                            <option></option>
                                            <option value="-1" selected="">Todos</option>
                                            <option value="1">Activo</option>
                                            <option value="0">Inactivo</option>
                                          </select>
                                        </div>
                                </div>
                                <div class="form-group">
                                        <label for="selEstadoB" class="control-label col-md-3 col-sm-3 col-xs-12">Estado</label>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoB" data-placeholder=" - Seleccione - " id="selEstadoB">
                                            <option></option>
                                            <option value="-1" selected="">Todos</option>
                                            <option value="1">Activo</option>
                                            <option value="0">Inactivo</option>
                                          </select>
                                        </div>
                                </div>


                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                <div class="col-md-6 col-sm-3 col-xs-12 col-sm-offset-3">
                                  {* <button type="submit" class="btn btn-primary">Cancel</button> *}

                                </div>
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
                    <h2>Lista de Instalaciones</h2>
                    {* <button type="submit" class="btn btn-success" id="btnNuevo" style="float:right">Nueva instalación</button> *}
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a  class="btn btn-primary" id="btnNuevo" style="float:right"  title="Agregar Nuevo">Nuevo Departamento</a></li>

                    </ul>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  <div class="clearfix"></div>
                    <div class="table-responsive">
                         <table class="table table-striped" id="tblListar">
                          <thead>
                            <tr class="headings">
                              <th class="column-title">NOMBRE INSTALACIÓN</th>
                              <th class="column-title">RAZÓN SOCIAL</th>
                              <th class="column-title">RUC</th>
                              <th class="column-title">DIRECCIÓN</th>
                              <th class="column-title">ING. RESPONSABLE</th>
                              <th class="column-title">ESTADO</th>
                              <th class="column-title" style="width: 50px">ACCIÓN</th>
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

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel">Agregar Instalación </h4>
                        </div>
                        <div class="modal-body">
                        <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
                        <input type="hidden" name="txtId" value="" id="txtId">
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombre">Nombre
                                </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <input type="text" id="txtNombre" name="txtNombre" required="required" class="form-control col-md-7 col-xs-12">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtRazonSocial">Razón Social y Siglas
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtRazonSocial" name="txtRazonSocial" required="required" class="form-control col-sm-7 col-xs-12">
                                </div>
                                <div class="col-md-3 col-sm-3 col-xs-12">
                                    <input type="text" id="txtSiglas" name="txtSiglas" required="required" class="form-control col-sm-7 col-xs-12">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtRuc">RUC
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtRuc" name="txtRuc" required="required" class="form-control col-sm-7 col-xs-12">
                                </div>

                              </div>
                               <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtEmail">Email
                                </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <input type="text" id="txtEmail" name="txtEmail" required="required" class="form-control col-sm-7 col-xs-12">
                                </div>

                              </div>
                               <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtTelefono">Teléfono
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtTelefono" name="txtTelefono" required="required" class="form-control col-sm-7 col-xs-12">
                                </div>

                              </div>

                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtAbbr">Abbr
                                </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" id="txtAbbr" name="txtAbbr" required="required" class="form-control col-sm-7 col-xs-12">
                                    <span id="errorAbbr" class="hidden">Abbr no disponible</span>
                                </div>

                              </div>
                              <div class="form-group">
                                <label for="" class="control-label col-md-3 col-sm-3 col-xs-12">Estado</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                     <div class="checkbox">
                                        <label>
                                          <input type="checkbox" class="flat"  name="chkEstado" id="chkEstado" required="" checked=""> Activo
                                        </label>
                                      </div>
                                </div>
                              </div>

                                <fieldset>
                                    <legend>Dirección de la Planta</legend>
                                        <div class="form-group">
                                            <div class="col-md-5 col-sm-5 col-xs-12">
                                                 <div class="radio">
                                                    <label>
                                                      <input type="radio" class="flat"  value="Av" name="radPreDireccion"> Av
                                                    </label>
                                                    <label>
                                                      <input type="radio" class="flat"  value="Jr" name="radPreDireccion"> Jr
                                                    </label>
                                                    <label>
                                                      <input type="radio" class="flat"  value="Calle" name="radPreDireccion"> Calle
                                                    </label>
                                                  </div>

                                            </div>

                                            <div class="col-md-7 col-sm-7 col-xs-12">
                                                <div class="col-sm-9 col-xs-12">
                                                  <input type="text" id="txtDireccion" name="txtDireccion" required="required" class="form-control col-sm-12 col-xs-12" placeholder="Dirección">
                                                </div>
                                                <div class="col-sm-3 col-xs-12">

                                                  <input type="text" id="txtDirNum" name="txtDirNum" required="required" class="form-control col-sm-12 col-xs-12" placeholder="Nro">
                                                </div>
                                            </div>



                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="txtUrbLocalidad" name="txtUrbLocalidad" required="required" class="form-control col-sm-7 col-xs-12" placeholder="Urb/Localidad">
                                            </div>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="txtDistrito" name="txtDistrito" required="required" class="form-control col-sm-7 col-xs-12" placeholder="Distrito">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-md-5 col-sm-5 col-xs-12">
                                                <input type="text" id="txtProvincia" name="txtProvincia" required="required" class="form-control col-sm-7 col-xs-12" placeholder="Provincia">
                                            </div>
                                            <div class="col-md-5 col-sm-5 col-xs-12">
                                                <input type="text" id="txtDepartamento" name="txtDepartamento" required="required" class="form-control col-sm-7 col-xs-12" placeholder="Departamento">
                                            </div>
                                            <div class="col-md-2 col-sm-2 col-xs-12">
                                                <input type="text" id="txtCodPostal" name="txtCodPostal" required="required" class="form-control col-sm-7 col-xs-12" placeholder="C. Postal">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-8 col-sm-8 col-xs-12">
                                                <input type="text" id="txtRepresentante" name="txtRepresentante" required="required" class="form-control col-sm-7 col-xs-12" placeholder="Representante Legal">
                                            </div>
                                            <div class="col-md-4 col-sm-4 col-xs-12">
                                                <input type="text" id="txtDniRepre" name="txtDniRepre" required="required" class="form-control col-sm-7 col-xs-12" placeholder="DNI" pattern="{literal}(^([0-9]{8,8})|^){/literal}" minlength="8" maxlength="8">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-8 col-sm-8 col-xs-12">
                                                <input type="text" id="txtResponsable" name="txtResponsable" required="required" class="form-control col-sm-7 col-xs-12" placeholder="Ing. Responsable">
                                            </div>
                                            <div class="col-md-4 col-sm-4 col-xs-12">
                                                <input type="text" id="txtCipResp" name="txtCipResp" required="required" class="form-control col-sm-7 col-xs-12" placeholder="CIP">
                                            </div>
                                        </div>
                                </fieldset>
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
    {* <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script> *}
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
      <script src="{$public_url}views/gestor/js/instalaciones.js" async="async"></script>
{/block}