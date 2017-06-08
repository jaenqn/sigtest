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
                    <h2>Filtrar Lista</h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="radResPeligrosoF">Peligroso</label>
                            <div class="col-md-9 col-sm-9 col-xs-12">
                                <div class="radio">
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="1" name="radResPeligrosoF" > Sí
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="0" name="radResPeligrosoF" > No
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="-1" name="radResPeligrosoF" checked=""> Ambos
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="radResOrganicoF">Orgánico</label>
                            <div class="col-md-9 col-sm-9 col-xs-12">
                                <div class="radio">
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="1" name="radResOrganicoF" > Sí
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="0" name="radResOrganicoF" > No
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="-1" name="radResOrganicoF" checked=""> Ambos
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="radResEstadoF">Estado</label>
                            <div class="col-md-9 col-sm-9 col-xs-12">
                                <div class="radio">
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="1" name="radResEstadoF" > Sólido
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="2" name="radResEstadoF" > Líquido
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="-1" name="radResEstadoF" checked=""> Ambos
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtNombreResF" class="control-label col-md-3 col-sm-3 col-xs-12">Residuo</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtNombreResF" id="txtNombreResF" placeholder="Residuo  a buscar">
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




                  {*     <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button type="submit" class="btn btn-primary">Cancel</button>
                          <button type="button" class="btn btn-success" id="btnNuevo">Nuevo</button>
                        </div>
                      </div> *}

                    </form>


                  </div>
                </div>
              </div>
    </div>
    <div class="row">
        <div class="col-sm-8 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Lista de Residuos</h2>

                    <ul class="nav navbar-right panel_toolbox app">
                        <li><a  class="btn btn-primary" id="btnNuevo">Nuevo Residuo</a></li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                        <div class="table-responsive">
                             <table class="table table-striped" id="tblListar">
                              <thead>
                                <tr>
                                  <th>RESIDUO</th>
                                  <th>PELIGROSO</th>
                                  <th>ORGÁNICO</th>
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

    <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modRegistro">
        <div class="modal-dialog">
          <div class="modal-content">

            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
              </button>
              <h4 class="modal-title" id="myModalLabel">Registro  Residuos</h4>
            </div>
            <div class="modal-body">

                <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
                    <input type="hidden" name="txtId" value="" id="txtId">
                    <div class="form-group">
                        <label for="txtNombreResiduo" class="control-label col-md-3 col-sm-3 col-xs-12">Residuo</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtNombreResiduo" id="txtNombreResiduo" placeholder="Nombre de Residuo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="radResPeligroso">Peligroso</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <div class="radio">
                                <label>
                                    <input type="radio" class="flat"  value="1" name="radResPeligroso"> Sí
                                </label>
                                <label>
                                    <input type="radio" class="flat"  value="0" name="radResPeligroso"> No
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="radResEstado">Estado</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <div class="radio">
                                <label>
                                    <input type="radio" class="flat"  value="1" name="radResEstado"> Sólido
                                </label>
                                <label>
                                    <input type="radio" class="flat"  value="2" name="radResEstado"> Líquido
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="radResOrganico">Orgánico</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <div class="radio">
                                <label>
                                    <input type="radio" class="flat"  value="1" name="radResOrganico"> Sí
                                </label>
                                <label>
                                    <input type="radio" class="flat"  value="0" name="radResOrganico"> No
                                </label>
                            </div>
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
    <script src="{$public_url}views/gestor/js/residuos.js" ></script>
{/block}