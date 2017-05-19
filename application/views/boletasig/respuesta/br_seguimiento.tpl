{if $seguimiento}


<div class="col-sm-6">



<form id="frmBoletaSeguimiento">
<input type="hidden" id="txtidbolseg" name="txtidbolseg" value="{$objBoleta->bol_id}">
                                      <fieldset>
                                        <legend>Evidencia</legend>
                                        <textarea name="txtObseSeg" id="txtObseSeg" class="form-control  resize-vertical textarea-auto" rows="1" placeholder="Observaciones" required=""></textarea>
                                        <hr>
                                        <div class="clearfix"></div>

                                        {* <div class="col-sm-12">
                                          <button style="float: right" type="button" class="btn btn-success"><i class="fa fa-plus"></i></button>
                                          <div class="clearfix"></div>
                                        </div> *}
                                        <table class="table table-bordered table-hover col-sm-12 tblFicherosX" id="tblFicherosSeguimiento">
                                          <thead>
                                            <tr>
                                              <th colspan="3">Adjuntos</th>
                                              <th style="text-align: center;width: 55px">
                                              {if $seguimiento}
                                              <label for="fileupload-seguimiento" id="prevFileUp" class="btn btn-success btn-option-files">
                                              <i class="fa fa-plus"></i>

                                                 {* <input id="fileupload" type="file" name="files[]" data-url="{$base_url}server/php/" multiple class="hidden"> *}
                                              </label>
                                              {/if}
                                              {* <button id="btnAgregarFichero" type="button" class="btn btn-success btn-option-files" data-toggle="tooltip" data-placement="left" title="" data-original-title="Agregar ficheros"><i class="fa fa-plus"></i></button> *}
                                              </th>
                                            </tr>
                                          </thead>


                                          <tbody id="lstFicherosSeguimiento" class="">
                                          {if !$seguimiento}

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


                                      {if $seguimiento}
                                          <button type="submit" class="btn btn-primary" style="">Agregar</button>
                                          <button type="button" class="btn btn-primary" style="" id="btnFinalizarSeg">Finalizar Seguimiento</button>
                                      {/if}

                                      </form>

</div>
{/if}
<div class="col-sm-6">

                <div class="dashboard-widget-content">

                    <ul class="list-unstyled timeline widget" id="lstseguimiento">
             {*        <li class="hoy">
                        <div class="block">
                            <div class="block_content">
                                <h2 class="title">
                                    <a href="">16/05/17</a>
                                </h2>

                                <div class="byline">
                                    <span class="txt-fecha"></span> por <a href="">asdasdasd</a>
                                </div>
                                <p class="excerpt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam quis nemo eius nam odio corrupti?</p>
                                <div>
                                    <ul class="showfiles">
                                        <li>
                                            <a href="">asdasdasd</a>
                                        </li>
                                        <li>
                                            <a href="">asdasdasd</a>
                                        </li>
                                        <li>
                                            <a href="">asdasdasd</a>
                                        </li>
                                        <li>
                                            <a href="">asdasdasd</a>
                                        </li>
                                        <li>
                                            <a href="">asdasdasd</a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="byline">
                                    <span class="txt-fecha"></span> por <a href="">asdasdasd</a>
                                </div>
                                <p class="excerpt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam quis nemo eius nam odio corrupti?</p>

                                <div class="byline">
                                    <span class="txt-fecha"></span> por <a href="">asdasdasd</a>
                                </div>
                                <p class="excerpt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam quis nemo eius nam odio corrupti?</p>

                            </div>
                        </div>
                    </li> *}
                    {foreach $objBoleta->fechas_seguimiento as $fecha}

                        <li class="{if $fecha@first && $targettoday == $fecha}today{/if}">
                            <div class="block">
                                <div class="block_content">
                                    <h2 class="title">
                                        <a href="">{$fecha}</a>
                                    </h2>
                                    {foreach $objBoleta->seguimiento as $seg}
                                        {if $seg->bos_fecha_format == $fecha}
                                            <div class="byline">
                                                <span class="txt-fecha" data-fecha="{$seg->bos_fecha}">-- -- --</span> por <a href="">{$seg->usu_nombre}&nbsp;{$seg->usu_apellidos}</a>
                                            </div>
                                            <p class="excerpt">{$seg->bos_observacion}</p>
                                            <div>
                                                <ul class="showfiles">
                                                    {foreach $seg->ficheros as $files}
                                                        <li>
                                                            <a href="{base_url($files->ruta_archivo)}" target="_blank">{$files->abo_nombre_fichero}</a>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </div>
                                            <hr>

                                        {/if}
                                    {/foreach}
                                </div>
                            </div>
                        </li>
                    {/foreach}
                    </ul>
                  </div>
</div>

<form action="">
  <input type="hidden" name="bol_id" value="{$objBoleta->bol_id}">
  <input type="hidden" name="bol_correlativo" value="{$objBoleta->bol_correlativo}">

  <input id="fileupload-seguimiento" type="file" name="files[]"  multiple class="hidden">
</form>