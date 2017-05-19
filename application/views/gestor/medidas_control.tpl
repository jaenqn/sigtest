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
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="txtNombreMedidaF"><span>Medida de Control</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                                <input type="text" id="txtNombreMedidaF" name="txtNombreMedidaF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-6 col-xs-12">

                        <div class="form-group">
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selJerarquiF">Jeraquía</label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                              <select class="select-minimum form-control input-filter" tabindex="-1" name="selJerarquiF" id="selJerarquiF" data-placeholder=" - Seleccione - " style="width:100%">
                              <option value="-1">Todas</option>
                              <option value="1">Eliminar</option>
                              <option value="2">Sustituir</option>
                              <option value="3">Controles de Ingeniería</option>
                              <option value="4">Controles Administrativos</option>
                              <option value="5">Equipos de Protección Personal</option>

                              </select>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-sm-6 col-md-6 col-xs-12">

                        <div class="form-group">
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selEstadoMedidaF">Estado</label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                              <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoMedidaF" id="selEstadoMedidaF" data-placeholder=" - Seleccione - " style="width:100%">
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
        <h2>Lista de Medidas de Control</h2>

        <ul class="nav navbar-right panel_toolbox">
          <li><a  class="btn btn-primary" id="btnNuevo" style="float:right"  title="Agregar nuevo medida de control" >Nueva Medida de Control</a></li>
        </ul>
        <div class="clearfix"></div>
      </div>
      <div class="x_content">
        <div class="table-responsive">
             <table class="table table-striped" id="tblListar">
          <thead>
            <tr>
              <th>MEDIDAS DE CONTROL</th>
              <th>JERARQUÍA</th>
              <th>TIPO</th>
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
        <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left" autocomplete="off">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                  </button>
                  <h4 class="modal-title " id="tituloModal" >Agregar Medida de Control</h4>
                </div>
                <div class="modal-body">
                  <!-- ##FRM REGISTRO-->

                        <input type="hidden" name="txtId" value="" id="txtId">
                        <div class="form-group">
                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNombreMedida">Medida de Control
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="txtNombreMedida" data-validate-words="2" name="txtNombreMedida" required="required" class="form-control col-md-7 col-xs-12">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selJerarquia">Jeraquía
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="select-minimum form-control" tabindex="-1" name="selJerarquia" id="selJerarquia" data-placeholder=" - Seleccione - " style="width: 100%"  required="" >
                                <option value="1">Eliminar</option>
                              <option value="2">Sustituir</option>
                              <option value="3">Controles de Ingeniería</option>
                              <option value="4">Controles Administrativos</option>
                              <option value="5">Equipos de Protección Personal</option>
                              </select>
                            </div>
                        </div>
                        <div class="form-group">
                          <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="raTipo">Tipo
                              </label>
                              <div class="col-md-9 col-sm-9 col-xs-12">
                                 <div class="radio">
                                    <label>
                                      <input type="radio" class="flat radTipoMedida"  value="1" name="radTipo" checked=""> Riesgos
                                    </label>
                                    <label>
                                      <input type="radio" class="flat radTipoMedida"  value="2" name="radTipo"> Impactos Ambientales
                                    </label>
                                  </div>
                              </div>






                        </div>
                        <div class="form-group">
                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="chkEstadoMedida">Estado </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="checkbox" class="radio-flat flat" name="chkEstadoMedida" id="chkEstadoMedida"   checked="" />
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
    <script src="{$public_url}views/gestor/js/medida_control.js" async="async"></script>
{/block}