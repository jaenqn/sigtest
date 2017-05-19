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
                    <h2>Filtrar Lista <small>&nbsp;</small></h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

                        <div class="col-sm-7">
                            <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12 " for="txtNombreActividadF"><span>Actividad</span></label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <input type="text" id="txtNombreActividadF" name="txtNombreActividadF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-5">
                            <div class="form-group">
                                <label class="control-label-left col-md-5 col-sm-5 col-xs-12" for="selEstadoActividadF">Estado</label>
                                <div class="col-md-7 col-sm-7 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoActividadF" id="selEstadoActividadF" data-placeholder=" - Seleccione - ">
                                    <option></option>
                                    <option value="-1" selected="">Ambos</option>
                                    <option value="1">Activo</option>
                                    <option value="0">Inactivo</option>
                                  </select>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <fieldset>
                          <legend>Procesos y Etapas</legend>
                            <div class="col-sm-7">
                            <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selDepProcesoF">Departamento</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selDepProcesoF" id="selDepProcesoF" data-placeholder=" - Seleccione - ">
                                    <option value="-1" selected="">Todos</option>
                                    {foreach $lstDepartamento as $obj}
                                    <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                                    {/foreach}
                                  </select>
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selUniProcesoF">Unidad</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selUniProcesoF" id="selUniProcesoF" data-placeholder=" - Seleccione - " disabled="">
                                  </select>

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">

                            <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selProcesoEtapaF">Proceso</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selProcesoEtapaF" id="selProcesoEtapaF" data-placeholder=" - Seleccione - " disabled>




                                  </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selEtapaActividadF">Etapa</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selEtapaActividadF" id="selEtapaActividadF" data-placeholder=" - Seleccione - " disabled="">

                                  </select>
                                </div>
                            </div>

                        </div>

                        </fieldset>







                    </form>
                    </div>
                  </div>


                  </div>
</div>


<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Lista de Actividades de Procesos <small>&nbsp;</small></h2>

            <ul class="nav navbar-right panel_toolbox">
              <li><a  class="btn btn-primary" id="btnNuevo" style="float:right"  title="Agregar nueva actividad a proceso" >Nuevo Actividad</a></li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">

            <div class="table-responsive">
                <table class="table table-striped" id="tblListar">
                  <thead>
                    <tr>
                      <th>ORDEN</th>
                      <th>ACTIVIDAD</th>
                      <th>PROCESO</th>
                      <th>ETAPA</th>
                      <th>SITUACIÓN</th>
                      <th>UBICACIÓN</th>
                      <th>TIPO DE PERSONAL</th>
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
                        <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                  </button>
                                  <h4 class="modal-title" id="tituloModal">Agregar Actividad</h4>
                                </div>
                                <div class="modal-body">
                                  <!-- ##REGISTRO-->

                                        <input type="hidden" name="txtId" value="" id="txtId">
                                        <div class="form-group">
                                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNombreActividad">Actividad
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="txtNombreActividad" data-validate-words="2" name="txtNombreActividad" required="required" class="form-control col-md-7 col-xs-12">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtOrdenActividad">Orden
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                            {* <input type="number" name="" value="" placeholder=""> *}
                                                <input type="number" id="txtOrdenActividad"  name="txtOrdenActividad" required="required" class="form-control col-md-7 col-xs-12">
                                            </div>
                                        </div>
                                        <fieldset>
                                          <legend>Proceso y Etapa</legend>
                                           <div class="form-group">
                                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selDepProceso">Departamento
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <select class="select-default form-control" tabindex="-1" name="selDepProceso" id="selDepProceso" data-placeholder=" - Seleccione - " style="width: 100%" required="">
                                                    <option></option>
                                                    {foreach $lstDepartamento as $obj}
                                                    <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                                                    {/foreach}
                                                  </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selUniProceso">Unidad
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <select class="select-default form-control" tabindex="-1" name="selUniProceso" id="selUniProceso" data-placeholder=" - Seleccione - " style="width: 100%" disabled="" required="" >
                                                  {* <option></option> *}
                                                  </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selProcesoEtapa">Proceso
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <select class="select-default form-control" tabindex="-1" name="selProcesoEtapa" id="selProcesoEtapa" data-placeholder=" - Seleccione - " style="width: 100%" disabled="" required="" >
                                                  {* <option></option> *}
                                                  </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selEtapaActividad">Etapa
                                                </label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                  <select class="select-default form-control" tabindex="-1" name="selEtapaActividad" id="selEtapaActividad" data-placeholder=" - Seleccione - " style="width: 100%" disabled="" required="" >
                                                  {* <option></option> *}
                                                  </select>
                                                </div>
                                            </div>
                                        </fieldset>

                                        <div class="form-group">
                                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtPuestoActividad">Puesto de Trabajo
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="txtPuestoActividad" data-validate-words="2" name="txtPuestoActividad" required="required" class="form-control col-md-7 col-xs-12">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="radSituacionActividad">Situación</label>
                                            <div class="col-md-10 col-sm-10 col-xs-12">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" class="flat"  value="1" name="radSituacionActividad"> Rutinario(Normal)
                                                    </label>
                                                    <label>
                                                        <input type="radio" class="flat"  value="2" name="radSituacionActividad"> No Rutinario(Anormal)
                                                    </label>
                                                    <label>
                                                        <input type="radio" class="flat"  value="3" name="radSituacionActividad"> Emergencia
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="radUbicacionActividad">Ubicación</label>
                                            <div class="col-md-10 col-sm-10 col-xs-12">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" class="flat"  value="1" name="radUbicacionActividad"> Dentro del Lugar de Trabajo
                                                    </label>
                                                    <label>
                                                        <input type="radio" class="flat"  value="2" name="radUbicacionActividad"> Fuerda del Lugar de Trabajo
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="radTipoPersonalActividad">Tipo de Personal</label>
                                            <div class="col-md-10 col-sm-10 col-xs-12">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" class="flat"  value="1" name="radTipoPersonalActividad"> Propio(PP)
                                                    </label>
                                                    <label>
                                                        <input type="radio" class="flat"  value="2" name="radTipoPersonalActividad">Contratado(PC)
                                                    </label>
                                                    <label>
                                                        <input type="radio" class="flat"  value="3" name="radTipoPersonalActividad">Visita(V)
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="chkEstadoActividad">Estado </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="checkbox" class="radio-flat flat" name="chkEstadoActividad" id="chkEstadoActividad"   checked="" />
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
    <script src="{$public_url}views/gestor/js/procesos_actividades.js" async="async"></script>
{/block}