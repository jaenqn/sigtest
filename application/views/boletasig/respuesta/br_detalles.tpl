<div class="clearfix"></div>
                    <fieldset>
                      <legend><h2>{$objBoleta->nom_area} - {$objBoleta->nom_unidad} <small></small></h2></legend>
                      <form id="frmBoletaSIGDeta" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">
                        <input type="hidden" name="txtId" value="{$objBoleta->bol_id}"/>
                        <div class="col-sm-3">
                          <input type="radio" name="radTipoBoleta" id="tbAmbiental" value="1" data-parsley-mincheck="2" required class="flat radTipoBoletaC" {if $objBoleta->bol_tipo == 1} checked="" {/if} /> Ambiental
                                  <label>&nbsp;</label>
                          <input type="radio" name="radTipoBoleta" id="tbSeguridad" value="2" class="flat radTipoBoletaC" {if $objBoleta->bol_tipo == 2} checked="" {/if} /> Seguridad
                          <br>
                          <br>
                          <input type="hidden" name="txtBolCorrelativo" id="txtBolCorrelativo" value="">
                          <p><b id="textCorrelativo">{$objBoleta->bol_correlativo}</b></p>
                        </div>
                        <div class="col-sm-6">
                           <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">De
                                </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <input type="hidden" name="txtCodUniRem" id="txtCodUniRem" value="{$objBoleta->bol_uni_remitente}">
                                  <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtNombreUnidRemi" id="txtNombreUnidRemi" placeholder="" value="{$objBoleta->nom_unidad}" disabled="">
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Para
                                </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="" id="selCorreIncUni" placeholder="" value="{$objBoleta->nom_unidad_receptor}" disabled="">
                                    {*     <select class="select-default form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Unidad - " name="selCorreIncUni" id="selCorreIncUni" required="" disabled="">
                                          <option value="1" selected="">{$objBoleta->nom_unidad_receptor}</option>

                                        </select> *}
                                </div>
                            </div>

                        </div>
                        <div class="col-sm-3">
                          <p><b><span id="fecha_solicita" data-set-date="{$objBoleta->bol_fecha_generado}" data-set-format="dddd DD MMM YYYY, hh:mm a" ></span></b></p>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-sm-6">

                          <fieldset>
                            <legend>Descripción de la observación</legend>
                            <blockquote>
                              <p name="txtDesObserva" id="txtDesObserva" class=" resize-vertical "   style="font-size: 0.7em;">{$objBoleta->bol_observacion|nl2br}</p>
                            </blockquote>
                          </fieldset>
                        </div>
                        <div class="col-sm-6">

                          <fieldset>
                            <legend>Recomendaciones para corregir la observación</legend>
                            <blockquote>
                              <p name="txtDesCorregir" id="txtDesCorregir" class=" resize-vertical "   style="font-size: 0.7em;">{$objBoleta->bol_corregir|nl2br}</textarea>
                            </blockquote>
                          </fieldset>
                        </div>
                        <div class="col-sm-12">
                            <div class="col-sm-6">
                              <fieldset>
                                <legend>Elaborado por</legend>
                               <div class="row invo-separate">
                                <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">Nombre(s) y Apellidos</label></div>
                                <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$objBoleta->involucrados.elaborador->usu_nombre}&nbsp;{$objBoleta->involucrados.elaborador->usu_apellidos}</label></div>
                              </div>
                              <div class="row invo-separate">
                                <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">DNI</label></div>
                                <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$objBoleta->involucrados.elaborador->usu_dni}</label></div>
                              </div>
                              <div class="row invo-separate">
                                <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">Ficha</label></div>
                                <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$objBoleta->involucrados.elaborador->usu_ficha}</label></div>
                              </div>

                              </fieldset>
                            </div>
                            <div class="col-sm-6">
                              <fieldset>
                                <legend>Aprobado por</legend>
                                <div class="row invo-separate">
                                  <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">Nombre(s) y Apellidos</label></div>
                                  <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$objBoleta->involucrados.aprobador->usu_nombre}&nbsp;{$objBoleta->involucrados.aprobador->usu_apellidos}</label></div>
                                </div>
                                <div class="row invo-separate">
                                  <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">DNI</label></div>
                                  <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$objBoleta->involucrados.aprobador->usu_dni}</label></div>
                                </div>
                                <div class="row invo-separate">
                                  <div class="col-xs-12 col-sm-5"><label for="txtNombreEla">Ficha</label></div>
                                  <div class="col-xs-12 col-sm-7"><label for="txtNombreEla">:&nbsp;&nbsp;{$objBoleta->involucrados.aprobador->usu_ficha}</label></div>
                                </div>
                              </fieldset>
                            </div>
                            <div class="clearfix"></div>
                            {if count($objBoleta->ficheros_evidencia) > 0}

                              <fieldset>
                                <legend>Evidencia</legend>
                                <table class="table table-bordered table-hover" id="tblFicheros">
                                  <thead>
                                    <tr>
                                      <th colspan="2">Fichero</th>
                                      <th>{* <button  type="button" class="btn btn-success btn-option-files" data-toggle="tooltip" data-placement="left" title="" data-original-title="Agregar ficheros"><i class="fa fa-plus"></i></button> *}</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                  {foreach $objBoleta->ficheros_evidencia as $files}
                                    <tr>
                                        <td style="width: 40px" class="icon-files"><img src="{$base_url}public/app/img/iconos/{$files->ico_img[1]}" title="{$files->ico_img[2]}"></td>
                                        <td><a href="{$base_url}{$files->ruta_archivo}" target="_blank">{$files->abo_nombre_fichero}</a></td>
                                        <td style="width: 40px;text-aling:center;vertical-aling:middle">
                                          <a  class="btn btn-default  btn-option-files loading" title="Cancelar subida"  ><span class="fa fa-eye"></span></a>

                                        </td>
                                    </tr>
                                  {/foreach}

                                  </tbody>
                                </table>

                              </fieldset>
                            {/if}
                        </div>
                      </form>

                    </fieldset>