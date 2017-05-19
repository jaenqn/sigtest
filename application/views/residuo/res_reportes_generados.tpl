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
                  <div class="x_content">
                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">
                      <div class="form-group">
                        <label for="selPeligro" class="control-label-left col-md-1 col-sm-1 col-xs-12">Tipo</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selPeligro" data-placeholder=" - Seleccione - " id="selPeligro">
                            <option></option>
                            <option value="-1" selected="">Ambos</option>
                            <option value="1">Peligroso</option>
                            <option value="0">No Peligroso</option>
                          </select>
                        </div>
                        <label for="selOrganico" class="control-label-left col-md-1 col-sm-1 col-xs-12">¿Orgánico?</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selOrganico" data-placeholder=" - Seleccione - " id="selOrganico">
                            <option value="-1" selected="">Ambos</option>
                            <option value="1">SI</option>
                            <option value="0">NO</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="selEstado" class="control-label-left col-md-1 col-sm-1 col-xs-12">Estado</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstado" data-placeholder=" - Seleccione - " id="selEstado">

                            <option value="-1" selected="">Ambos</option>
                            <option value="1">Sólido</option>
                            <option value="2">Líquido</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="selResiduo" class="control-label-left col-md-1 col-sm-1 col-xs-12">Residuo</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-multiple form-control input-filter" tabindex="-1" name="selResiduo" data-placeholder=" - Seleccione - " id="selResiduo" multiple="multiple">
                            <option value="-1" selected="">Todos</option>
                            {foreach $lst_residuos as $obj}
                            <option value="{$obj->res_id}">{$obj->res_nombre}</option>
                            {/foreach}
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="selArea" class="control-label-left col-md-1 col-sm-1 col-xs-12">Área</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selArea" data-placeholder=" - Seleccione - " id="selArea">
                            <option></option>
                            <option value="-1" selected="">Todos</option>
                            {foreach $lstDep as $obj}
                            <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                            {/foreach}

                          </select>
                        </div>
                        <label for="selUnidad" class="control-label-left col-md-1 col-sm-1 col-xs-12">Unidad</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                           <select class="select-minimum form-control input-filter" tabindex="-1" name="selUnidad" data-placeholder=" - Seleccione - " id="selUnidad" disabled="">
                          </select>
                        </div>
                      </div>

                        <div class="form-group">


                            <label class="control-label-left col-md-1 col-sm-1 col-xs-12 " for="selYear">Año</label>

                            <div class="col-md-3 col-sm-3 col-xs-12">
                              <select class="select-minimum form-control input-filter" tabindex="-1" name="selYear" data-placeholder=" - Seleccione - " id="selYear">
                              {foreach $lst_years as $obj}
                              <option value="{$obj->get_year}">{$obj->get_year}</option>

                              {/foreach}
                              </select>
                            </div>



                        </div>

                      <div class="clearfix"></div>













                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                <div class="col-md-12 col-sm-12 col-xs-12 col-sm-offset-2">
                                  <a href="#tblResultados" class="btn btn-primary" id="btnGenRep">Generar Reporte</a>
                                  <a  class="btn btn-success" id="btnGenerar" disabled="" target="_blank">Generar Excel</a>
                                </div>
                              </div>
                            </div>
                        </div>
                    </form>
                    <fieldset id="fResultado" class="hidden">
                      <legend>Resultado</legend>
                      <div class="col-sm-10 col-sm-offset-1">
                        <table class="table table-bordered table-hover" style="" id="tblResultados">
                        <thead>
                          <tr>

                            <th colspan="14" style="width: 780px;text-align: center">TODAS</th>

                          </tr>
                          </thead><thead>
                          <tr>
                            <th rowspan="2" style="width: 200px;text-align: center;vertical-align: middle;">Residuos</th>
                            {* <th class="rotate">E</br>n</br>e</br>r</br>o</th> *}
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Ene.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Feb.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Mar.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Abr.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">May.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Jun.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Jul.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Ago.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Sep.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Oct.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Nov.</div></th>
                            <th class="" style="width: 60px;height: 30px;border-bottom-width:2px"><div style="width: 20px;" class="">Dic.</div></th>
                            <th rowspan="2" style="width: 100px;text-align: center;vertical-align: middle;">Total</th>
                          </tr>
                        </thead>
                        <tbody id="tbodyRes">
                          <tr>
                            <td class="app-text-center" style=""><div>Batería</div></td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">10</br>Kg.</td>
                            <td class="app-text-center">12323</br> Kg.</td>
                          </tr>
                        </tbody>
                      </table>
                      </div>
                    </fieldset>




{*
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

                                        <button type="submit" id="btnE">Enviar</button>

                                </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
                          <button type="submit" class="btn btn-primary" id="btnRegistrar" data-accion="guardar">Guardar</button>
                        </div>
                        </form>
                      </div> *}
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
    <script src="{$public_url}views/residuo/js/rep_generados.js" async="async"></script>
    <script>
        $(document).ready(function() {
              $('#single_cal2').daterangepicker({
                singleDatePicker: true,
                calender_style: "picker_2"
              }, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
              });

                $(".select-multiple").select2({
                  allowClear: true
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