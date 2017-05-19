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
          <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                <h2>Filtrar Lista</h2>

                <div class="clearfix"></div>
              </div>
              <div class="x_content">

                <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

                    <div class="col-sm-4">
                        <div class="form-group">
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="txtNombreProF"><span>Proceso</span></label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                                <input type="text" id="txtNombreProF" name="txtNombreProF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                            </div>
                        </div>




                    </div>
                    {if $smarty.session.tipo_usuario == 3 || $smarty.session.tipo_usuario == 4}
                    <div class="col-sm-4">

                      <div class="form-group">
                          <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selDepPro">Departamento</label>
                          <div class="col-md-8 col-sm-8 col-xs-12">
                            <select class="select-default form-control input-filter" tabindex="-1" name="selDepPro" id="selDepPro" data-placeholder=" - Seleccione - ">
                            <option value="-1">Todas</option>
                            {foreach $lstDeps as $obj}
                            <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                            {/foreach}
                            </select>
                          </div>
                      </div>
                    </div>
                    <div class="col-sm-4">
                      <div class="form-group">
                          <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selUniF">Unidad</label>
                          <div class="col-md-8 col-sm-8 col-xs-12">
                            <select class="select-minimum form-control input-filter" tabindex="-1" name="selUniF" id="selUniF" data-placeholder=" - Seleccione - " disabled="">
                            <option value="-1">Todas</option>
                            </select>
                          </div>
                      </div>
                    </div>
                    {/if}
                    <div class="col-sm-4">
                      <div class="form-group">
                            <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selEstadoF">Estado</label>
                            <div class="col-md-8 col-sm-8 col-xs-12">
                              <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoF" id="selEstadoF" data-placeholder=" - Seleccione - ">
                              <option value="-1">Todos</option>

                              {foreach $lstEstados as $obj}
                              <option value="{$obj.id}">{$obj.nombre}</option>
                              {/foreach}

                              </select>
                            </div>
                      </div>
                    </div>
                    <div class="col-sm-4">

                      <div class="control-group">
                          <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="txtFechaAproF">Fecha última Aprobación</label>
                          <div class="controls">
                            <div class="col-md-8 xdisplay_inputx form-group has-feedback">
                              <input type="text" class="form-control has-feedback-left" name="txtFechaAproF" id="txtFechaAproF" placeholder="DD/MM/YY" aria-describedby="inputSuccess2Status2">
                              <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                              <span id="inputSuccess2Status2" class="sr-only">(success)</span>
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
        <h2>Lista de Análisis de Proceso <small>&nbsp;</small></h2>

        <ul class="nav navbar-right panel_toolbox">
        {if $smarty.session.tipo_usuario == 3 || $smarty.session.tipo_usuario == 4}
          <li><a  class="btn btn-primary" id="btnActualizarPro" style="float:right" title="Habilitar actualizacion de procesos  ">Habilitar Actualización</a></li>
        {/if}
        </ul>
        <div class="clearfix"></div>
      </div>
      <div class="x_content">
        <div class="table-responsive">
          <table class="table table-striped table-hover" id="tblListar">
            <thead>
              <tr>
                <th>PROCESO</th>
                <th>UNIDAD</th>
                <th>DEPARTAMENTO</th>
                <th>ESTADO</th>
                <th>FECHA ULT. APROBACIÓN</th>
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
{if $smarty.session.tipo_usuario == 3 || $smarty.session.tipo_usuario == 4}
          <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modRegistro">
              <!--##REGISTRO-->
              <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left" autocomplete="off">
                  <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                            </button>
                            <h4 class="modal-title" id="tituloModals">Habilitar Actualización de Análisis de Proceso</h4>
                            <h4 class="modal-title hidden" id="tituloModal" >Agregar Medida de Control</h4>
                          </div>
                          <div class="modal-body">
                            <!-- ##FRM REGISTRO-->

                                  <input type="hidden" name="txtId" value="" id="txtId">
                                  <div class="form-group">
                                      <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selAspectoAmbientalF">Departamento </label>
                                      <div class="col-md-9 col-sm-9 col-xs-12">
                                        <select class="select-default form-control input-filter" tabindex="-1" name="selAspectoAmbientalF" id="selAspectoAmbientalF" data-placeholder=" - Seleccione - "  style="width: 100%">
                                        <option value="-1">Departamento A</option>
                                        <option value="1">Departamento BB</option>
                                        <option value="2">Departamento CC</option>
                                        </select>
                                      </div>
                                  </div>

                                  <div class="form-group">
                                      <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selAspectoAmbientalF">Unidad</label>
                                      <div class="col-md-9 col-sm-9 col-xs-12">
                                        <select class="select-default form-control input-filter" tabindex="-1" name="selAspectoAmbientalF" id="selAspectoAmbientalF" data-placeholder=" - Seleccione - " style="width: 100%">
                                        <option value="-1">Unidad A</option>
                                        <option value="1">Unidad B</option>
                                        <option value="2">Unidad C</option>
                                        </select>
                                      </div>
                                  </div>
                                   <table class="table table-striped" id="tblListarX">
                                    <thead>
                                      <tr>
                                        <th>&nbsp;</th>
                                        <th>ITEM</th>
                                        <th>PROCESO</th>
                                        <th>ESTADO</th>
                                        <th>FECHA ÚLT. APROBACIÓN</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                          <td class="a-center ">
                                              <input type="checkbox" class="flat" name="table_records" checked="">
                                          </td>
                                          <td>1</td>
                                          <td>Mantenimiento de Radio Enlace</td>
                                          <td>Finalizado</td>
                                          <td>25/09/2016</td>
                                      </tr>
                                      <tr>
                                          <td class="a-center ">
                                              <input type="checkbox" class="flat" name="table_records" checked="">
                                          </td>
                                          <td>2</td>
                                          <td>Proceso 2</td>
                                          <td>Finalizado</td>
                                          <td>25/09/2016</td>
                                      </tr>
                                      <tr>
                                          <td class="a-center ">
                                              <input type="checkbox" class="flat" name="table_records" checked="">
                                          </td>
                                          <td>3</td>
                                          <td>Procso 3</td>
                                          <td>Finalizado</td>
                                          <td>25/09/2016</td>
                                      </tr>
                                    </tbody>
                                  </table>

                                  {* <button type="submit" id="btnE">Enviar</button> *}

                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
                            <button type="submit" class="btn btn-primary" id="btnRegistrarX" data-accion="guardar">Habilitar Actualización</button>
                            <button type="submit" class="btn btn-primary hidden" id="btnRegistrar" data-accion="guardar">Habilitar Actualización</button>
                          </div>

                      </div>
                  </div>
              </form>
          </div>
{/if}


{/block}

{block 'script'}
    <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    {* <script src="{$public_url}views/gestor/js/medida_control.js" async="async"></script> *}
    <script type="text/javascript">
      {if $smarty.session.tipo_usuario == 1 || $smarty.session.tipo_usuario == 2 || $smarty.session.tipo_usuario == 3}

        var opc_render = [1,2];
      {/if}

    </script>
    <script src="{$public_url}views/analisis/js/ana_listar.js"></script>

    <script>
      $(document).ready(function() {
              $('#txtFechaAproF').daterangepicker({
                singleDatePicker: true,
                calender_style: "picker_2",
                locale: {
                    format: 'DD/MM/YY'
                }
              }, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
              }).val('');
      });
    </script>
{/block}