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
                  <div class="x_content">
                    <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
                      <div class="form-group">
                        <label for="selCiudad" class="control-label-left col-md-2 col-sm-2 col-xs-12">Peligro</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selCiudad" data-placeholder=" - Seleccione - " id="selCiudad">
                            <optgroup label="Alaskan/Hawaiian Time Zone">
                              <option value="AK">Alaska</option>
                              <option value="HI">Hawaii</option>
                            </optgroup>
                            <optgroup label="Pacific Time Zone">
                              <option value="CA">California</option>
                              <option value="NV">Nevada</option>
                              <option value="OR">Oregon</option>
                              <option value="WA">Washington</option>
                            </optgroup>
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="selCiudad" class="control-label-left col-md-2 col-sm-2 col-xs-12">Riesgo</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selCiudad" data-placeholder=" - Seleccione - " id="selCiudad">
                            <optgroup label="Alaskan/Hawaiian Time Zone">
                              <option value="AK">Alaska</option>
                              <option value="HI">Hawaii</option>
                            </optgroup>
                            <optgroup label="Pacific Time Zone">
                              <option value="CA">California</option>
                              <option value="NV">Nevada</option>
                              <option value="OR">Oregon</option>
                              <option value="WA">Washington</option>
                            </optgroup>
                          </select>
                        </div>
                      </div>


                    </form>


                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">
                      <div class="form-group">
                        <label for="selCiudad" class="control-label-left col-md-2 col-sm-2 col-xs-12">Seleccione Año</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selCiudad" data-placeholder=" - Seleccione - " id="selCiudad">
                            <option></option>
                            <option value="-1" selected="">Ambos</option>
                            <option value="1">Activo</option>
                            <option value="0">Inactivo</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="selCiudad" class="control-label-left col-md-2 col-sm-2 col-xs-12">Departamento</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selCiudad" data-placeholder=" - Seleccione - " id="selCiudad">
                            <option></option>
                            <option value="-1" selected="">Ambos</option>
                            <option value="1">Activo</option>
                            <option value="0">Inactivo</option>
                          </select>
                        </div>
                        <label for="selCiudad" class="control-label-left col-md-1 col-sm-1 col-xs-12">Unidad</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selCiudad" data-placeholder=" - Seleccione - " id="selCiudad">
                            <option></option>
                            <option value="-1" selected="">Ambos</option>
                            <option value="1">Activo</option>
                            <option value="0">Inactivo</option>
                          </select>
                        </div>
                      </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                <div class="col-md-6 col-sm-3 col-xs-12 col-sm-offset-2">
                                  {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                                  <button type="submit" class="btn btn-success" id="btnNuevo">Generar PDF</button>
                                </div>
                              </div>
                            </div>
                        </div>
                    </form>
                    <fieldset>
                      <legend>Resultado</legend>
                      <div class="col-sm-12 ">
                        <table class="table table-bordered table-hover" style="">
                        <thead>
                          <tr>
                            <th colspan="6">AREA - UNIDAD</th>
                          </tr>
                          <tr>
                            <th rowspan="4" style="width: 200px;text-align: center;vertical-align: middle;">Meses</th>
                            <th colspan="5" style="text-align: center">Peso Residuos Sólidos Generados</th>
                          </tr>
                          <tr>
                            <th colspan="3" class="app-text-center-head">No Peligroso</th>
                            <th rowspan="2" class="app-text-center-head">Peligrosos</th>
                            <th rowspan="2" class="app-text-center-head">Total</th>

                          </tr>
                          <tr>
                            <th class="app-text-center-head">Orgánicos</th>
                            <th class="app-text-center-head">Inorgánico</th>
                            <th class="app-text-center-head">Total</th>
                          </tr>


                          <tr>
                            <th class="app-text-center-head">Kg</th>
                            <th class="app-text-center-head">Kg</th>
                            <th class="app-text-center-head">Kg</th>
                            <th class="app-text-center-head">Kg</th>
                            <th class="app-text-center-head">Kg</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <th class="app-text-center" style=""><div>Enero</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>

                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Febrero</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Marzo</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Abril</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Mayo</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Junio</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Julio</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Agosto</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Septiembre</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Octubre</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Noviembre</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Diciembre</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Total</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>
                          <tr>
                            <th class="app-text-center" style=""><div>Promedio</div></th>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                            <td class="app-text-center">10 Kg.</td>
                          </tr>

                        </tbody>
                      </table>
                      </div>
                    </fieldset>



                    <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modRegistro">
                    <!--##REGISTRO-->
                        <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                  </button>
                                  <h4 class="modal-title" id="tituloModal">Agregar Riesgo</h4>
                                </div>
                                <div class="modal-body">
                                  <!-- ##FRM REGISTRO-->

                                        <input type="hidden" name="txtId" value="" id="txtId">
                                        <div class="form-group">
                                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNombreRiesgo">Riesgo
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="txtNombreRiesgo" data-validate-words="2" name="txtNombreRiesgo" required="required" class="form-control col-md-7 col-xs-12">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selPeligro">Peligro
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                              <select class="select-default form-control" tabindex="-1" name="selPeligro" id="selPeligro" data-placeholder=" - Seleccione - " style="width: 100%"  required="" >
                                                 {foreach $lstPeligros as $obj}
                                                <option value="{$obj->pel_id}">{$obj->pel_nombre}</option>
                                                {/foreach}
                                              </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="chkEstadoRiesgo">Estado </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="checkbox" class="radio-flat flat" name="chkEstadoRiesgo" id="chkEstadoRiesgo"   checked="" />
                                                 Activo
                                            </div>
                                        </div>

                                        {* <button type="submit" id="btnE">Enviar</button> *}

                                </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
                          <button type="submit" class="btn btn-primary" id="btnRegistrar" data-accion="guardar">Guardar</button>
                        </div>
                        </form>
                      </div>
                    </div>
                  </div>
                     <div class="clearfix"></div>
                    <div class="ln_solid"></div>



                  </div>
                </div>
              </div>
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
    <script src="{$public_url}views/residuo/js/listar.js" async="async"></script>
    <script>
        $(document).ready(function() {
              $('#single_cal2').daterangepicker({
                singleDatePicker: true,
                calender_style: "picker_2"
              }, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
              });
        });
        $(document).ready(function() {
              $('#single_cal3').daterangepicker({
                singleDatePicker: true,
                calender_style: "picker_2"
              }, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
              });
        });
    </script>
{/block}