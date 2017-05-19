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
                    <h2>Reporte de peligros y aspectos significativos <small>&nbsp;</small></h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

                        <div class="col-sm-9">
                            <div class="form-group">
                                <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="txtNombreImpactoF"><span>Proceso</span></label>
                                <div class="col-md-8 col-sm-8 col-xs-12">
                                    <input type="text" id="txtNombreImpactoF" name="txtNombreImpactoF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                </div>
                            </div>
                            {if $smarty.session.tipo_usuario == 3}
                            <div class="form-group">
                                <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selAspectoAmbientalF">Departamento</label>
                                <div class="col-md-8 col-sm-8 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selAspectoAmbientalF" id="selAspectoAmbientalF" data-placeholder=" - Seleccione - ">
                                  <option value="-1">Todas</option>
                                  <option value="1">Departamento AA</option>
                                  <option value="2">Departmaneto BB</option>
                                  <option value="3">Departmaneto cc</option>
                                  <option value="4">Departmaneto DD</option>
                                  <option value="5">Departmaneto EE</option>


                                  </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selAspectoAmbientalF">Unidad</label>
                                <div class="col-md-8 col-sm-8 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selAspectoAmbientalF" id="selAspectoAmbientalF" data-placeholder=" - Seleccione - ">
                                  <option value="-1">Todas</option>
                                  <option value="1">Unidad A</option>
                                  <option value="2">Unidad B</option>
                                  <option value="3">Unidad C</option>
                                  <option value="4">Unidad D</option>


                                  </select>
                                </div>
                            </div>
                            {/if}
                            <div class="form-group">
                                <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selAspectoAmbientalF">Estado</label>
                                <div class="col-md-8 col-sm-8 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selAspectoAmbientalF" id="selAspectoAmbientalF" data-placeholder=" - Seleccione - ">
                                  <option value="-1">Todos</option>
                                  <option value="1">Actualizable</option>
                                  <option value="2">Elaborado</option>
                                  <option value="3">Revisado</option>
                                  <option value="4">Aprobado</option>
                                  <option value="5">Finalizado</option>

                                  </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="selAspectoAmbientalF">Fecha última Aprobación</label>
                                <div class="controls">
                                  <div class="col-md-8 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left" id="single_cal2" placeholder="" aria-describedby="inputSuccess2Status2">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>
                              </div>
                        </div>

                        <div class="col-sm-9">
                        {if $smarty.session.tipo_usuario == 3}

                            <div class="form-group">
                                <div class="col-md-6 col-sm-6 col-xs-12 col-sm-offset-4">
                                  {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                                  <button type="submit" class="btn btn-success" id="btnNuevo">Habilitar Actualización</button>
                                </div>
                            </div>
                        {/if}

                        </div>




                    </form>
                    {if $smarty.session.tipo_usuario == 3}
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
                     <div class="clearfix"></div>
                    <div class="ln_solid"></div>
                    <div class="row">
                        <div class="col-sm-8 col-xs-12"><h2>Lista de Procesos<small>&nbsp;</small></h2></div>
                        {* <div class="col-sm-4 col-xs-12 "><button type="button" class="btn btn-default btn" style="float: right;margin-left: 0px;margin-right: 0px;" id="btnAbrirModRegUni">Agregar</button></div> *}
                    </div>
                    <div class="table-responsive">
                         <table class="table table-striped" id="tblListarX">
                      <thead>
                        <tr>
                          <th>ITEM</th>
                          <th>PROCESO</th>
                          {if $smarty.session.tipo_usuario == 3}
                          <th>UNIDAD</th>
                          <th>DEPARTAMENTO</th>
                          {/if}
                          <th>ESTADO</th>
                          <th>FECHA ULT. APROBACIÓN</th>
                          <th>ACCIÓN</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                            <td>1</td>
                          <td>Mantenimiento de Radio de Enlace</td>
                            {if $smarty.session.tipo_usuario == 3}
                          <td>Unidad A</td>
                          <td>Departamento C</td>
                          {/if}
                          <td>Aprobado</td>
                          <td>05/08/2015</td>
                          <td><a href="">Ver</a>&nbsp;&nbsp;/&nbsp;&nbsp;<a href="{$base_url}analisis_proceso/editar/1000">Editar</a></td>
                        </tr
                        <tr>
                        <td>2</td>
                          <td>Proceso</td>
                            {if $smarty.session.tipo_usuario == 3}
                          <td>Unidad A</td>
                          <td>Departamento C</td>
                          {/if}
                          <td>Aprobado</td>
                          <td>05/08/2015</td>
                          <td><a href="">Ver</a>&nbsp;&nbsp;/&nbsp;&nbsp;<a href="{$base_url}analisis_proceso/editar/1000">Editar</a></td>
                        </tr
                        <tr>
                        <td>3</td>
                          <td>Proceso 4</td>
                          {if $smarty.session.tipo_usuario == 3}
                          <td>Unidad A</td>
                          <td>Departamento C</td>
                          {/if}
                          <td>Aprobado</td>
                          <td>05/08/2015</td>
                          <td><a href="">Ver</a>&nbsp;&nbsp;/&nbsp;&nbsp;<a href="{$base_url}analisis_proceso/editar/1000">Editar</a></td>
                        </tr>
                      </tbody>
                    </table>
                    </div>

                  </div>
                </div>
              </div>
            </div>
{/block}

{block 'script'}

    <script src="{$public_url}views/gestor/js/medida_control.js" async="async"></script>
    <script>
      $(document).ready(function() {
              $('#single_cal2').daterangepicker({
                singleDatePicker: true,
                calender_style: "picker_2"
              }, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
              });
      });
    </script>
{/block}