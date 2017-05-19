{extends $_template}

{block 'css'}
    {* <link href="{$public_url}views/gestor/css/carpetas.css" rel="stylesheet"> *}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {* <link href="{$public_url}vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"> *}
    <style type="text/css">
        .invo-separate{
          margin-bottom:1em;
        }

    </style>
{/block}

{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
              <div class="col-md-8 col-sm-8 col-xs-12">
                <div class="x_panel">
                    {* <div class="x_title">
                      <h2>Solicitud : {$objResiduo->rss_correlativo}<small>&nbsp;</small></h2>

                      <div class="clearfix"></div>
                    </div> *}
                  <div class="x_content">
                    <fieldset>
                      <legend>Solicitud : {$objResiduo->rss_correlativo}<small>&nbsp;</small></legend>
                    </fieldset>


                      <div class="col-sm-5">
                        <h4><b>{$objResiduo->unidad_generadora->dep_nombre}</b></h4>
                        <h4><b>{$objResiduo->unidad_generadora->desDepend}</b></h4>
                        <h5><b id="txtFechaSolicitud" data-fecha="{$objResiduo->rss_fecha_solicitud}">&nbsp;</b></h5>
                      </div>
                      <div class="clearfix"></div>



                      <fieldset>
                        <legend>Datos del Residuo</legend>
                        <div class="display-label-groups">
                          <div class="display-label">
                            <div class="col-sm-12"><H2><b><u>{$objResiduo->res_nombre|upper}</u></b></H2></div>
                          </div>
                          <div class="clearfix"></div>
                          <div class="display-label">
                            <div class="col-sm-4">Orgánico</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->res_organico == 1}SI{else}NO{/if}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Tipo</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->res_peligro == 1}Peligroso{else}No Peligroso{/if}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Estado</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->res_estado == 1}SÓLIDO{else}LÍQUIDO{/if}</div>
                          </div>
                          <div class="display-label">
                            <div class="col-sm-4">Peso</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->rss_peso}&nbsp;Kg.</div>
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
                        </div>


                      </fieldset>
                      <fieldset>
                        <legend>Empresa Contratista que Acopia y Traslada el Residuo</legend>

                        <div class="display-label">
                          <div class="col-sm-4">Nombre</div><div class="col-sm-8">&nbsp;:&nbsp;{$objResiduo->empc_nombre}</div>
                        </div>

                        <div class="display-label">
                          <div class="col-sm-4">¿Personal con EPP necesarios?</div><div class="col-sm-8">&nbsp;:&nbsp;{if $objResiduo->rss_epp ==  1}SI{else}NO{/if}</div>
                        </div>
                      </fieldset>
                      <fieldset>
                        <legend>Observaciones</legend>

                        <div class="display-label">
                          <div class="col-sm-12">
                            <p>{$objResiduo->rss_observaciones}</p>
                          </div>
                        </div>


                      </fieldset>
                         <form action="" method="get" accept-charset="utf-8" id="frmAutorizar">
                          <input type="hidden" name="txtId" value="{$objResiduo->rss_id}" id="txtId">
                      <fieldset>
                          <legend>Autorizado por</legend>

                      <div class="invo-separate row">
                        <div class="col-sm-5"><label for="txtNombreAuto">Nombre(s) y Apellidos</label></div>
                        <div class="col-sm-7"><input type="text" name="txtNombreAuto" id="txtNombreAuto" class="form-control" value="" required="required"  title="Nombre"></div>
                      </div>
                      <div class="invo-separate row">
                          <div class="col-sm-5"><label for="txtFichaAuto">Nro Ficha</label></div>
                          <div class="col-sm-7"><input type="text" name="txtFichaAuto" id="txtFichaAuto" class="form-control" value="" required="required"></div>
                      </div>
                      <div class="invo-separate row">
                        <div class="col-sm-5"><label for="txtDniAuto">DNI</label></div>
                        <div class="col-sm-7"><input type="text" name="txtDniAuto" id="txtDniAuto" class="form-control" value="" required="required"  title="Nro de DNI"  pattern="{literal}(^([0-9]{8,8})|^){/literal}" minlength="8" maxlength="8"></div>
                      </div>
                        {*   <div class="col-sm-8">
                               <table style="margin-top:-1em;width:100%">
                                <tbody>
                                  <tr>
                                    <td>Nombre(s) y Apellidos</td>
                                    <td style="padding-left:1em"><input type="text" name="txtNombreAuto" id="txtNombreAuto" class="form-control" value="" required="required"  title="Nombre del elaborador"></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">Nro Ficha</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtFichaAuto" id="txtFichaAuto" class="form-control" value="" required="required"></td>
                                  <tr style="">
                                    <td style="padding-top:10px">DNI</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtDniAuto" id="txtDniAuto" class="form-control" value="" required="required"  title="Ingresar el número de DNI"   pattern="{literal}(^([0-9]{8,8})|^){/literal}" minlength="8" maxlength="8"></td>
                                  </tr>
                                </tbody>
                              </table>
                          </div> *}
                            <div class="col-sm-12" style="margin-top:1em">




                            <button type="button" class="btn btn-success">Generar Notificación</button>
                            <button type="submit" class="btn btn-success"> Autorizar </button>
                            {* <a href="{$base_url}residuo/autorizacion/1" class="btn btn-success" id="btnAutorizar" data-id-solicitud="{$objResiduo->rss_id}">Autorizar</a> *}





                          </div>

                        </fieldset>
                      </form>



                    </div>
                  </div>
                     <div class="clearfix"></div>
                    <div class="ln_solid"></div>



                  </div>
                </div>
              </div>
            </div>
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
    <script src="{$public_url}views/residuo/js/res_autorizar.js" async="async"></script>
{/block}