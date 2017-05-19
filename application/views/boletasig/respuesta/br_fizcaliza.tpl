
                    <div class="clearfix"></div>
                    <form id="frmFiscalizarBoleta" data-parsley-validate class="form-horizontal form-label-left">
                    <input type="hidden" name="txtIdBoleta" id="txtIdBoleta" value="{$objBoleta>bol_id}">
                      <fieldset>
                        {* <legend>asdasd</legend> *}
                        <br><br><br>
                       <div class="col-sm-10">
                          <div class="form-group">
                          <div class="col-sm-4">
                              <label class="control-label " for="first-name">Boleta derivó en SACP : </label>
                                 <input type="radio" class="flat filtro-residuo" name="radTipoPeligro" id="genderMA" value="1" required  />
                               SI&nbsp;
                              <input type="radio" class="flat filtro-residuo" name="radTipoPeligro" id="genderFA" value="0" required />
                               NO
                          </div>
                          <div class="col-sm-5">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Nro SACP </label>
                          <div class="col-md-9 col-sm-9 col-xs-12">

                            <select class="select-minimum form-control input-filter" tabindex="-1" name="selSacp" id="selSacp" data-placeholder=" - Seleccionar - " style="width: 100%">
                              <option></option>
                              {foreach $lstyears as $obj}
                              <option value="{$obj}">{$obj}</option>
                              {/foreach}
                            </select>
                          </div>
                          </div>
                        </div>
                       </div>
                      </fieldset>
                      <div class="clearfix"></div>
                      <hr>


                      <div class="col-sm-6">
                      <div class="form-group">
                            <label for="middle-name" class="control-label col-md-2 col-sm-2 col-xs-12">Nombre</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input class="form-control col-md-7 col-xs-12" type="text" name="txtNombreFiscaliza" id="txtNombreFiscaliza" placeholder="" required="required" >
                            </div>
                          </div>
                        <div class="form-group">
                            <label for="middle-name" class="control-label col-md-2 col-sm-2 col-xs-12">Fecha</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input class="form-control col-md-7 col-xs-12" type="text" name="txtFechaFiscaliza" id="txtFechaFiscaliza" placeholder="" required="" disabled="">
                            </div>
                          </div>
                      </div>
                      <div class="clearfix"></div>
                      <hr>

                          <div class="form-group">
                            <div class="col-md-6 col-sm-6 col-xs-12 ">
                              {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                              <button type="button" class="btn btn-success" id="btnRechazarRespuesta">Rechazar Respuesta</button>
                              <button type="submit" class="btn btn-success" id="btnCerrarBoleta">Cerrar Boleta</button>
                            </div>
                          </div>



                    </form>
