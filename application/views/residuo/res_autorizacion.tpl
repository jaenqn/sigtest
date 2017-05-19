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
              <div class="col-md-8 col-sm-8 col-xs-12">
                <div class="x_panel">
                  <div class="x_content">
                  <fieldset>

                        <div class="display-label-groups">
                          <div class="display-label">
                            <div class="col-sm-12"><H2><b>{$objResiduo->rss_correlativo} </b></H2></div>
                          </div>

                          <div class="display-label">
                            <div class="col-sm-4">Departamento</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->unidad_generadora->dep_nombre}</div>
                          </div>

                          <div class="display-label">
                            <div class="col-sm-4">Unidad</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->unidad_generadora->desDepend}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Fecha Solicitado </div><div class="col-sm-8">&nbsp;:&nbsp;<span data-set-date="{$objResiduo->rss_fecha_solicitud}" data-set-format="dddd DD MMM YYYY, hh:mm a">{$objResiduo->rss_fecha_solicitud}</span></div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Fecha Autorizado </div><div class="col-sm-8">&nbsp;:&nbsp;<span data-set-date="{$objResiduo->rss_fecha_autorizado}" data-set-format="dddd DD MMM YYYY, hh:mm a">{$objResiduo->rss_fecha_autorizado}</span></div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-12"><H2><b>{$objResiduo->res_nombre}</b></H2></div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Orgánico</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->res_organico == 1}SÍ{else}NO{/if}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Tipo</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->res_peligro == 1}Peligroso{else}No Peligroso{/if}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Estado</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->res_estado == 2}Líquido{else}Sólido{/if}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Peso</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->rss_peso}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Volumen</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->rss_volumen}&nbsp;{foreach $tipos_volumen as $obj}{if $obj[1] == $objResiduo->rss_volumen_tipo}{$obj[0]}{break}{/if}{/foreach}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Unidades</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->rss_unidades}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Procedencia del Residuo</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->rso_nombre}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Lugar de Almcenamiento</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->alm_nombre}</div>
                          </div>



                        <div class="display-label">
                            <div class="col-sm-12"><H2><b>EMPRESA CONTRATISTA QUE ACOPIA Y TRASLADA EL RESIDUO X</b></H2></div>

                        </div>


                        <div class="display-label">
                          <div class="col-sm-4">Nombre</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->empc_nombre}</div>
                        </div>

                        <div class="display-label">
                          <div class="col-sm-4">¿Personal con EPP necesarios?</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->rss_epp ==  1}SÍ{else}NO{/if}</div>
                        </div>
                        <div class="display-label">
                            <div class="col-sm-12"><H2><b>OBSERVACIONES</b></H2></div>

                        </div>
                        <div class="display-label">
                          <div class="col-sm-12">
                            <p>{$objResiduo->rss_observaciones}</p>
                          </div>
                        </div>


                        <div class="display-label">
                          <div class="col-sm-6">
                            <H2><b>SOLICITA</b></H2>
                            <div class="col-sm-4">
                              Nombre
                            </div>
                            <div class="col-sm-8">
                              :&nbsp;{$objResiduo->involucrados.elaborador->rsi_nombre}
                            </div>
                            <div class="col-sm-4">
                              Ficha
                            </div>
                            <div class="col-sm-8">
                              :&nbsp;{$objResiduo->involucrados.elaborador->rsi_ficha}
                            </div>
                            <div class="col-sm-4">
                              Dni
                            </div>
                            <div class="col-sm-8">
                              :&nbsp;{$objResiduo->involucrados.elaborador->rsi_dni}
                            </div>
                          </div>
                          <div class="col-sm-6">
                            <H2><b>AUTORIZA</b></H2>

                            <div class="col-sm-4">
                              Nombre
                            </div>
                            <div class="col-sm-8">
                              :&nbsp;{$objResiduo->involucrados.autorizador->rsi_nombre}
                            </div>
                            <div class="col-sm-4">
                              Ficha
                            </div>
                            <div class="col-sm-8">
                              :&nbsp;{$objResiduo->involucrados.autorizador->rsi_ficha}
                            </div>
                            <div class="col-sm-4">
                              Dni
                            </div>
                            <div class="col-sm-8">
                              :&nbsp;{$objResiduo->involucrados.autorizador->rsi_dni}
                            </div>
                          </div>
                        </div>

                      </div>

                      </fieldset>
                      <div class="clearfix"></div>

                      <div class="col-sm-12" style="margin-top:1em">
                        <a   href="{$base_url}residuo/autorizacion/pdf?rss={$objResiduo->rss_id}"  class="btn btn-success center-block" style="width: 9em;margin-left:auto;margin-right: auto;" id="btnGenerarPDF">Descargar Word</a>

                      </div>




                    </div>
                  </div>




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
    <script src="{$public_url}views/residuo/js/res_autorizacion.js" async="async"></script>
{/block}