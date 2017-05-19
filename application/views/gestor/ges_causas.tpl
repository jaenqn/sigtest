{extends $_template}
{block 'css'}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {* <link href="{$public_url}vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"> *}
{/block}
{block 'contenido'}
    <div class="row">
    <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Gestor de Causas<small>&nbsp;</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>

                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />

                    <form id="frmFiltrar" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">

                      <div class="form-group">

                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Tipo de causa
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="select-minimum form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selTipoCausaF" id="selTipoCausaF">
                            <option value="">&nbsp;</option>
                            <option value="-1" selected="">Ambos</option>
                            {foreach $lstTiposCausas as $t}
                            <option value="{$t.id}">{$t.nombre}</option>
                            {/foreach}
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Sub Estándar Name
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <select class="select-minimum form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selSubEstandarCausaF" id="selSubEstandarCausaF">
                            <option value="">&nbsp;</option>
                            <option value="-1" selected="">Ambos</option>
                            {foreach $lstSubEstandarCausas as $t}
                            <option value="{$t.id}">{$t.nombre}</option>
                            {/foreach}
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Nombre</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="middle-name" class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtNombreCausaF" id="txtNombreCausaF" placeholder="Causa a buscar">
                        </div>
                      </div>

                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                          <button type="button" class="btn btn-success" id="btnNuevo">Nuevo</button>
                        </div>
                      </div>

                    </form>
                    <!-- Modal Registro Cuasas

                    -->
                    <div class="modal fade bs-example-modal-lg" id="modRegistro" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog ">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel">Registro de Causas</h4>
                        </div>
                        <div class="modal-body">
                          {* <h4>Text in a modal</h4> *}
                          <form id="frmRegistro" method="post" data-parsley-validate class="form-horizontal form-label-left" enctype="multipart/form-data">
                          <input type="hidden" name="txtId" value="">
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Tipo de Causa </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="radio" class="radio-flat flat" name="radTipoCausa"  value="1" />
                                     Inmediata
                                    <input type="radio" class="radio-flat flat" name="radTipoCausa"  value="2"  />
                                     Básica

                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Sub Estandar </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="radio" class="radio-flat flat" name="radSubEstandar"  value="1"  />
                                     Actos
                                    <input type="radio" class="radio-flat flat" name="radSubEstandar"  value="2" />
                                     Condiciones
                                  </p>
                                </div>
                              </div>
                              <div class="form-group">
                                <label for="txtNombreCausa" class="control-label col-md-3 col-sm-3 col-xs-12">Nombre </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                  <input id="txtNombreCausa" class="form-control col-md-7 col-xs-12" type="text" name="txtNombreCausa" placeholder="Describa Causa">
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
                          <button type="button" class="btn btn-primary" id="btnRegistrar">Guardar</button>
                        </div>

                      </div>
                    </div>
                  </div>
                    <!-- Final Modal Registro Cuasas -->
                    <div class="clearfix"></div>
                    <div class="ln_solid"></div>
                    <div class="row">
                        <div class="col-sm-8 col-xs-12"><h2>Lista de Causas<small>&nbsp;</small></h2></div>
                        {* <div class="col-sm-4 col-xs-12 "><button type="button" class="btn btn-default btn" style="float: right;margin-left: 0px;margin-right: 0px;" id="btnAbrirModalRegCausa">Agregar</button></div> *}
                    </div>
                    <div class="table-responsive">
                         <table class="table table-striped" id="tblListar">
                      <thead>
                        <tr>
                          <th>CAUSA</th>
                          <th>TIPO</th>
                          <th>SUB ESTANDAR</th>
                          <th>ACCIÓN</th>
                        </tr>
                      </thead>
                      <tbody>
                        {foreach $lstCausas as $objC}
                         <tr>
                            <th scope="row">{$objC->cau_id}</th>
                            <td>{$objC->cau_nombre}</td>
                            <td>{$objC->getTipo()}</td>
                            <td>{$objC->getSubEstandar()}</td>
                            <td><a href="" data-id-causa="{$objC->cau_id}">editar</a>/<a href="" data-id-causa="{$objC->cau_id}">eliminar</a></td>
                        </tr>
                        {/foreach}



                      </tbody>
                    </table>
                    </div>
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
    <script src="{$public_url}views/gestor/js/causas.js" async="async"></script>
{/block}

