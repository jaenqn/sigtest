{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
    <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="x_panel">
                  {* <div class="x_title">
                    <h2>Autorización de Ingreso de Resiudos a Almacenes<small>&nbsp;</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                    </ul>
                    <div class="clearfix"></div>
                  </div> *}
                  <div class="x_content">
                    <div class="row">
                      <fieldset>
                        <legend>Autorización</legend>
                      <div class="row"><div class="col-sm-12"><p><b id="dep_solicita">{$departamento_usuario}</b></p></div></div>
                      <div class="row"><div class="col-sm-12"><p><b id="textCorrelativo">{$objCorrelativo->correlativo}</b></p></div></div>
                      <div class="row"><div class="col-sm-12"><p ><b id="fecha_solicita">{$fecha_solicitud}</b></p></div></div>
                      </fieldset>
                    </div>

                    <div class="row">
                      <form id="frmIngresoResiduo" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">
                        <fieldset>
                          <legend>Datos del residuo</legend>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Tipo  </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="radio" class="flat filtro-residuo" name="radTipoPeligro" id="genderMA" value="1" required  />
                                 Peligroso&nbsp;
                                <input type="radio" class="flat filtro-residuo" name="radTipoPeligro" id="genderFA" value="0" required />
                                 No Peligroso
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Estado  </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="radio" class="flat filtro-residuo" name="radTipoEstado" id="genderMB" value="1" required  />
                                 Sólido&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="radio" class="flat filtro-residuo" name="radTipoEstado" id="genderFB" value="2" required />
                                 Líquido
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Orgánico  </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="radio" class="flat filtro-residuo" name="radTipoOrganico" id="genderMC" value="1" required  />
                                 SÍ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="radio" class="flat filtro-residuo" name="radTipoOrganico" id="genderFC" value="0" required />
                                 NO
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Residuo
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="inputSelect2 form-control select-default" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selResiduo" id="selResiduo" disabled="">
                              </select>
                            </div>
                          </div>
                          <div class="form-group">
                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Peso</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input class="form-control col-md-7 col-xs-12" type="number" name="txtPesoResiduo" id="txtPesoResiduo" placeholder="" required="" pattern="{literal}[0-9]+\.*[0-9]{0,2}{/literal}" step="any" value="0" min="0">
                            </div>
                          </div>
                          <div class="form-group">
                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Volumen</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input class="form-control col-md-7 col-xs-12" type="number" name="txtVolumenResiduo" id="txtVolumenResiduo" placeholder=""  pattern="{literal}[0-9]+\.*[0-9]{0,2}{/literal}" value="0" min="0" step="any">
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-12">
                              <select class="form-control select-minimum" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selTipoVolumen" id="selTipoVolumen">
                                <option value="1">Lt</option>
                                <option value="2">M3</option>
                                <option value="3">Galones</option>
                              </select>
                            </div>
                          </div>
                          <div class="form-group">
                            <label for="txtUnidades" class="control-label col-md-3 col-sm-3 col-xs-12">Unidades</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input  id="txtUnidades" class="form-control col-md-7 col-xs-12" type="number" name="txtUnidades" placeholder=""   value="0" required="" min="0">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Procedencia del Resiudo
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="select-default form-control" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selProcedenciaResiduo" id="selProcedenciaResiduo" required="">
                                <option value="">&nbsp;</option>
                                <option value="-1">Otro</option>
                                {foreach $lstOrigen as $obj}
                                <option value="{$obj->rso_id}">{$obj->rso_nombre}</option>
                                {/foreach}
                              </select>
                            </div>
                          </div>
                          <div class="hidden" id="otro-origen">

                            <div class="form-group">
                              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Departamento
                              </label>
                              <div class="col-md-6 col-sm-6 col-xs-12">
                                <select class="select-default form-control" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selDepOrigen" id="selDepOrigen">
                                  <option value="">&nbsp;</option>
                                  {foreach $lstDepartamento as $obj}
                                  <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                                  {/foreach}
                                </select>
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Unidad
                              </label>
                              <div class="col-md-6 col-sm-6 col-xs-12">
                                <select class="select-default form-control" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selUniOrigen" id="selUniOrigen">
                                  <option value="">&nbsp;</option>
                                </select>
                              </div>
                            </div>
                            <div class="form-group">
                              <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Procedencia</label>
                              <div class="col-md-6 col-sm-6 col-xs-12">
                                <input id="txtNameOrigen" class="form-control col-md-7 col-xs-12" type="text" name="txtNameOrigen" placeholder="">
                              </div>
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Lugar de Almacenamiento
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="select-default form-control" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selLugarAlmacenamiento" id="selLugarAlmacenamiento" required="">
                                <option value=""></option>
                                {foreach $lstAlmacen as $obj}
                                <option value="{$obj->alm_id}"><span title="adsd">{$obj->alm_nombre}</span></option>
                                {/foreach}

                              </select>
                            </div>
                          </div>
                        </fieldset>
                        <fieldset>
                          <legend>Empresa contratista que acopia y traslada el residuo</legend>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Empresa
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="inputSelect2 form-control select-default" style="width:100%" tabindex="-1" data-placeholder=" - Seleccionar - " name="selEmpresa" id="selEmpresa" required="required">
                                <option value=""></option>
                                {foreach $lstEmpresas as $obj}
                                <option value="{$obj->empc_id}">{$obj->empc_nombre}</option>
                                {/foreach}
                              </select>
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">¿Personal con EPP necesarios?  </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="radio" class="flat" name="radPersonalEPP" id="genderM" value="1" required checked="" />
                                 SI
                                <input type="radio" class="flat" name="radPersonalEPP" id="genderF" value="2" required />
                                 NO
                            </div>
                          </div>

                        </fieldset>
                        <fieldset>
                          <legend>Observaciones</legend>

                          <div class="form-group">
                            <div class="col-md-12 col-sm-12 col-xs-12">

                                <textarea name="txtObservacion" id="txtObservacion" class="form-control col-sm-12" rows="3"></textarea>
                            </div>
                          </div>
                        </fieldset>
                         <fieldset>
                          <legend>Elaborado por</legend>
                          <div class="col-sm-8">
                               <table style="margin-top:-1em;width:100%">
                                <tbody>
                                  <tr>
                                    <td>Nombre(s) y Apellidos</td>
                                    <td style="padding-left:1em"><input type="text" name="txtNombreEla" id="txtNombreEla" class="form-control" value="" required="required"  title="Nombre del elaborador"></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">Nro Ficha</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtFichaEla" id="txtFichaEla" class="form-control" value="" required="required"></td>
                                  <tr style="">
                                    <td style="padding-top:10px">DNI</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtDniEla" id="txtDniEla" class="form-control" value="" required="required"  title="Ingresar el número de DNI"   pattern="{literal}(^([0-9]{8,8})|^){/literal}" minlength="8" maxlength="8" ></td>
                                  </tr>
                                </tbody>
                              </table>
                          </div>

                        </fieldset>

                    </div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 ">
                          {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                          <button type="submit" class="btn btn-success" id="btnNotificarIngreso">Enviar notificación</button>
                        </div>
                      </div>
                    </form>


                    <!-- Modal Registro Cuasas

                    -->
                    <div class="modal fade bs-example-modal-lg" id="modalRegistroCausa" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog ">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel">Registro de Causas</h4>
                        </div>
                        <div class="modal-body">
                          {* <h4>Text in a modal</h4> *}
                          <form id="frmRegCausa" method="post" data-parsley-validate class="form-horizontal form-label-left" enctype="multipart/form-data">
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Tipo de Causa </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="radio" class="radio-flat" name="radTipoCausa" id="genderM" value="1" required checked="" />
                                     Inmediata
                                    <input type="radio" class="radio-flat" name="radTipoCausa" id="genderF" value="2" required />
                                     Básica

                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Sub Estandar </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="radio" class="radio-flat" name="radSubEstandar" id="genderM" value="1" required checked="" />
                                     Actos
                                    <input type="radio" class="radio-flat" name="radSubEstandar" id="genderF" value="2" required/>
                                     Condiciones
                                  </p>
                                </div>
                              </div>
                              <div class="form-group">
                                <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Nombre </label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                  <input id="middle-name" class="form-control col-md-7 col-xs-12" type="text" name="txtNombre" placeholder="Describa Causa">
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
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                          <button type="button" class="btn btn-primary" id="btnGuardarCausa">Guardar</button>
                        </div>

                      </div>
                    </div>
                  </div>
                    <!-- Final Modal Registro Cuasas -->

                  </div>
                </div>
    </div>
</div>
{/block}
{block 'script'}
    <script src="{$public_url}views/residuo/js/res_ingreso.js"></script>

{/block}