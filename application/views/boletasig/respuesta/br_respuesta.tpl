  <form id="frmBoletaSIG" data-parsley-validate class="form-horizontal form-label-left">
                      <input type="hidden" id="txtId" name="txtId" value="{$objBoleta->bol_id}">
                      <input type="hidden" id="txtRechazado" name="txtRechazado" value="{$objBoleta->bol_rechazado}">
                        <div class="col-sm-6">
                            <fieldset>
                                <legend>Acciones inmediatas tomadas</legend>
                                <div class="">
                                    <ul class="to_do">
                                        {foreach $lstAccInme as $obj}
                                        <li>

                                            <p><input type="checkbox" class="flat chkAccInme" name="txtAccInme[]"  value="{$obj->aci_id}" id="" {foreach $objBoleta->respuestas.inmediatas as $objR}{if $objR->aci_id_accion_inmedita == $obj->aci_id}checked=""{/if}{/foreach}> {$obj->aci_des}</p>
                                        </li>
                                        {/foreach}
                                    </ul>
                                </div>

                            </fieldset>

                            <fieldset style="padding-bottom:20px">
                                <legend>Otras acciones inmediatas tomadas</legend>
                                {$tempi = true }
                                {foreach $objBoleta->respuestas.inmediatas as $obj}
                                  {if $obj->aci_otro == 1}

                                    <input type="hidden" name="txtIdResAccInm" id="txtIdResAccInm" value="{$obj->aci_id_accion_inmedita}">
                                    <textarea name="txtAccionInmediataOtro" id="txtAccionInmediata" class="form-control resize-vertical textarea-auto" rows="1" disabled="">{$obj->aci_des}</textarea>
                                    {$tempi = false}
                                  {break}
                                  {/if}
                                {/foreach}
                                {if $tempi}
                                  <textarea name="txtAccionInmediataOtro" id="txtAccionInmediata" class="form-control  resize-vertical textarea-auto" rows="1" placeholder="Definir otra acción inmediata" ></textarea>
                                {/if}

                            </fieldset>
                        </div>
                        {* <div class="col-sm-6">
                        </div> *}
                        {* <div class="clearfix"></div> *}
                        <div class="col-sm-6">
                            <fieldset>
                                <legend>Acciones posteriores tomadas</legend>
                                <div class="">
                                    <ul class="to_do">
                                        {foreach $lstAccPost as $obj}
                                        <li>
                                            <p><input type="checkbox" class="flat acciones-posteriores" {if $obj->aci_id == 9 && $responde}checked=""{/if} name="txtAccPost[]" value="{$obj->aci_id}" {foreach $objBoleta->respuestas.posteriores as $objR}{if $objR->aci_id_accion_posterior == $obj->aci_id}checked=""{/if}{/foreach}> {$obj->aci_des}</p>
                                        </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </fieldset>
                            <fieldset style="padding-bottom:20px">
                                <legend>Otras acciones posteriores tomadas</legend>
                                {$tempp = true }
                                {foreach $objBoleta->respuestas.posteriores as $obj}
                                  {if $obj->aci_otro == 1}

                                    <input type="hidden" name="txtIdResAccPost" id="txtIdResAccPost" value="{$obj->aci_id_accion_posterior}">
                                    <textarea name="txtAccionPosteriorOtro" id="txtAccionPosterior" class="form-control resize-vertical textarea-auto" rows="1" disabled="">{$obj->aci_des}</textarea>
                                    {$tempp = false}
                                  {break}
                                  {/if}
                                {/foreach}
                                {if $tempp}
                                  <textarea name="txtAccionPosteriorOtro" id="txtAccionPosterior" class="form-control resize-vertical textarea-auto" rows="1" placeholder="Definir otra acción posterior" {if ent_boleta::inEstado($objBoleta->bol_estado, 'respondido')}disabled=""{/if}></textarea>
                                {/if}
                            </fieldset>

                            <fieldset style="padding-bottom:20px">
                                <legend>Plazo de ejecución</legend>

                                  <input type="text" name="txtplazo" id="txtplazo" class="form-control txtfechas-datapicker col-md-6 col-sm-6 col-xs-12" value="{if !$responde}{date('d/m/Y',strtotime($objBoleta->bol_fecha_plazo_ini))}&nbsp;-&nbsp;{date('d/m/Y',strtotime($objBoleta->bol_fecha_plazo_fin))}{/if}"   title="Seleccionar fechas" placeholder="Seleccionar fechas">

                            </fieldset>

                        {*     <div class="form-group" style="margin-top:1em">
                                <label class="col-md-12 col-sm-12 col-xs-12" for="selMes"><span>Plazo de ejecución</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" name="txtplazo" id="txtplazo" class="form-control txtfechas-datapicker" value=""   title="Seleccionar fechas" placeholder="Seleccionar fechas"> *}
                                {*   <select class="select-minimum form-control input-filter" tabindex="-1" name="selMes" id="selMes" data-placeholder=" - Mes - " style="width: 100%">
                                    <option></option>
                                    {foreach $lstmeses as $obj}
                                    <option  value="{$obj.num}">{$obj.mes}</option>
                                    {/foreach}

                                  </select> *}
                                {* </div> *}

                                {* <div class="col-md-6 col-sm-6 col-xs-12"> *}
                              {*   <input type="text" name="txtFechaFinal" id="txtFechaFinal" class="form-control txtfechas-datapicker" value=""   title="Fecha Final" placeholder="dd/mm/yy"> *}
                                {*   <select class="select-minimum form-control input-filter" tabindex="-1" name="selYear" id="selYear" data-placeholder=" - Año - " style="width: 100%">
                                    <option></option>
                                    {foreach $lstyears as $obj}
                                    <option value="{$obj}">{$obj}</option>
                                    {/foreach}
                                  </select> *}
                         {*        </div>
                            </div> *}
                        </div>
                       {*  <div class="col-sm-6">
                        </div> *}
                        <div class="clearfix"></div>
                        <div class="col-sm-12 " >

                        </div>

                        <div class="clearfix"></div>

                        <div class="col-sm-6 col-xs-12">
                            <fieldset>
                                <legend>Observaciones</legend>
                                {* <div class="form-group"> *}

                                        <textarea name="txtObservaciones" id="txtObservaciones" placeholder="Escriba Observaciones" class="form-control col-sm-6 col-xs-12 resize-vertical textarea-auto" rows="1" {if ent_boleta::inEstado($objBoleta->bol_estado, 'respondido')}disabled=""{/if}>{$objBoleta->bol_observacion_respuesta}</textarea>

                                {* </div> *}

                            </fieldset>
                        </div>

                        <div class="col-sm-6 col-xs-12">

                                      <fieldset>
                                        <legend>Evidencia</legend>
                                        {* <div class="col-sm-12">
                                          <button style="float: right" type="button" class="btn btn-success"><i class="fa fa-plus"></i></button>
                                          <div class="clearfix"></div>
                                        </div> *}
                                        <table class="table table-bordered table-hover tblFicherosX" id="tblFicheros">
                                          <thead>
                                            <tr>
                                              <th colspan="3">Adjuntos</th>
                                              <th style="text-align: center;width: 55px">
                                              {if $responde}
                                              <label for="fileupload" id="prevFileUp" class="btn btn-success btn-option-files">
                                              <i class="fa fa-plus"></i>

                                                 {* <input id="fileupload" type="file" name="files[]" data-url="{$base_url}server/php/" multiple class="hidden"> *}
                                              </label>
                                              {/if}
                                              {* <button id="btnAgregarFichero" type="button" class="btn btn-success btn-option-files" data-toggle="tooltip" data-placement="left" title="" data-original-title="Agregar ficheros"><i class="fa fa-plus"></i></button> *}
                                              </th>
                                            </tr>
                                          </thead>


                                          <tbody id="lstFicheros" class="">
                                          {if !$responde}

                                            {if count($objBoleta->ficheros_evidencia_res) > 0}

                                              {foreach $objBoleta->ficheros_evidencia_res as $obj}
                                                <tr>
                                                  <td style="width: 40px;vertical-align:middle" class="icon-files"><img src="{$public_url}app/img/iconos/{$obj->ico_img[1]}" title="{$obj->ico_img[2]}"></img></td>
                                                  <td {if ent_boleta::inEstado($objBoleta->bol_estado,array('respondido'))}colspan="3"{/if}><span style="word-break: break-all;line-height: 0px"><a href="{base_url('')}{$obj->ruta_archivo}">{$obj->abo_nombre_fichero}</a></span></td>

                                                  {if ent_boleta::inEstado($objBoleta->bol_estado,array('procesado'))}
                                                    <td style="padding:2px;vertical-align:middle"><div class="progress" style="margin-top: auto;margin-bottom: auto;">
                                                                    <div class="progress-bar progress-bar-striped " data-transitiongoal="100"></div>
                                                        </div>
                                                    </td>
                                                    <td style="width: 40px;text-aling:center;vertical-align:middle">
                                                        <button type="button" class="btn btn-default  btn-option-files loaded" title="Cancelar subida" data-alojado="1" data-id-fichero="{$obj->abo_id}"><span class="fa fa-trash"></span></button>
                                                    </td>
                                                  {/if}
                                              </tr>
                                              {/foreach}
                                            {else}
                                              <tr><td colspan="4">Sin evidencias</td></tr>
                                            {/if}
                                          {/if}


                                          </tbody>
                                        </table>

                                      </fieldset>
                                    </div>



                    <div class="clearfix"></div>
                    <div class="col-sm-12">

                        <fieldset>
                          <legend>Supervisor dependencia obsevada</legend>
                          <input type="hidden" name="txtIdInvolucrado" id="txtIdInvolucrado" value="{$objBoleta->involucrados.supervisor->ibo_id}">
                          <div class="col-sm-6">
                            <div class="row invo-separate">
                              <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">Nombre(s) y Apellidos</label></div>
                              <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$smarty.session.nombre_usuario}&nbsp;{$smarty.session.apellido_usuario}</label></div>
                            </div>
                            <div class="row invo-separate">
                              <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">DNI</label></div>
                              <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$smarty.session.dni_usuario}</label></div>
                            </div>
                            <div class="row invo-separate">
                              <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">Ficha</label></div>
                              <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$smarty.session.ficha_usuario}</label></div>
                            </div>

                             {*   <table style="margin-top:-1em;width:100%">
                                <tbody>
                                  <tr>
                                    <td>Nombre(s) y Apellidos</td>
                                    <td style="padding-left:1em"><input type="text" name="txtNombreSuper" id="txtNombreSuper" class="form-control" value="{$objBoleta->involucrados.supervisor->ibo_nombre}" required="required"  title="Nombre del elaborador"></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">Nro Ficha</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtFichaSuper" id="txtFichaSuper" class="form-control" value="{$objBoleta->involucrados.supervisor->ibo_ficha}" required="required"></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">DNI</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtDniSuper" id="txtDniSuper" class="form-control" value="{$objBoleta->involucrados.supervisor->ibo_dni}" required="required"  title=""></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">Fecha</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="fecha_solicita_res" id="fecha_solicita_res" class="form-control" value="" required="required"  title="" disabled=""></td>
                                  </tr>
                                </tbody>
                              </table> *}
                          </div>
                          {* <div class="col-sm-6">
                              <p><b><span id="fecha_solicita">--</span></b></p>
                          </div> *}

                        </fieldset>
                    </div>
                    <div class="clearfix"></div>
                    <hr>



                    {if AppSession::get('id_unidad') == $objBoleta->bol_uni_receptor && $responde}
                    <div class="col-sm-12">
                        <div class="">
                            <button type="submit" class="btn btn-success" data-accion="guardar">Enviar Respuesta</button>
                            {* <button type="button" class="btn btn-success" data-accion="actualizar" id="btnActualizarRes">Guardar</button> *}
                            {* <button type="button" class="btn btn-danger">Cancelar</button> *}
                        </div>
                    </div>
                    {/if}
                    </form>
                    <form action="">
                      <input type="hidden" name="bol_id" value="{$objBoleta->bol_id}">
                      <input type="hidden" name="bol_correlativo" value="{$objBoleta->bol_correlativo}">

                      <input id="fileupload" type="file" name="files[]"  multiple class="hidden">
                    </form>