{extends $_template}

{block 'css'}
    {* <link href="{$public_url}views/gestor/css/carpetas.css" rel="stylesheet"> *}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {* <link href="{$public_url}vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"> *}
    <style type="text/css" media="screen">
      .tbl-lista-blanco tbody tr td:nth-child(1), .tbl-lista-blanco tbody tr td:nth-child(2) {
        vertical-align: middle;
        text-align: justify;
        width: 45%;
      }
      .tbl-lista-blanco tbody tr td:nth-child(3){
        vertical-align: middle;
        text-align: center;
      }
      ul.lista-calculo{
        margin:0px;
        padding:0px;
        list-style-type: none;
      }
      .lista-calculo li{
        display: flex;
      }
      .lista-calculo li > span{
        margin-left:5px;
      }
      .to_do.lista-medidas > li{
        display: flex;
      }
      .to_do.lista-medidas > li >b >span{
        margin-right: 8px;
        cursor:pointer;
      }
      td.nom-sec ul{
        padding: 3px 3px 3px 10px;

      }
      .padding-top-7{
        padding-top:7px;
      }
      .padding-bottom-7{
        padding-bottom:7px;
      }
      .label-anapro{
        font-size: 13px;
        padding-left:20px;
        padding-right:20px;

      }

    </style>
{/block}

{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
              <div class="col-md-10 col-sm-10 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Lista de Análisis de Proceso <small>&nbsp;</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <form id="frmAnalisidProceso" class="form-horizontal form-label-left">
                    <input type="hidden" name="txtModProceso" id="txtModProceso" value="{$modPro}">
                    <input type="hidden" name="txtModjs" id="txtModjs" value="{$modProDos}">

                      <input type="hidden" name="txtIDProceso" id="txtIDProceso" value="{$objA->apr_id}">



                        <div class="col-sm-12">
                          <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtSede">Sede</label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                      <input type="text" id="txtSede" name="txtSede"  class="form-control col-md-12 col-xs-12 input-filter" placeholder="Nombre de Sede" value="{$objA->apr_sede}" required=""></div>
                          </div>
                          {if $is_edit}
                          <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selDepartamento">Departamento</label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selDepartamento" id="selDepartamento" data-placeholder=" - Seleccione - " disabled="">
                                  <option value="{$objA->dep_id}">{$objA->dep_nombre}</option>

                                  </select>
                                </div>
                          </div>
                          {/if}
                          <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selUnidad">Unidad/ Área</label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selUnidad" id="selUnidad" data-placeholder=" - Seleccione - " disabled="">
                                  <option value="{$objA->uni_id}">{$objA->uni_nombre}</option>
                                  </select>
                                </div>
                          </div>
                          <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selProceso">Procesos</label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selProceso" id="selProceso" data-placeholder=" - Seleccione - " disabled="">
                                  <option value="{$objA->pro_id}">{$objA->pro_nombre}</option>
                                  </select>
                                </div>
                                <div class="col-md-4 col-sm-4 col-xs-12 hidden">
                                    <input type="text" id="txtNuevoProceso" name="txtNuevoProceso"  class="form-control col-md-12 col-xs-12 input-filter" placeholder="Escribir Nuevo Proceso" disabled="">
                                </div>
                          </div>
                          <div class="form-group">
                                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selEtapas">Etapa del Proceso</label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                  <select class="select-default form-control " tabindex="-1" name="selEtapas" id="selEtapas" data-placeholder=" - Seleccione - " >
                                  <option></option>
                                  <option value="-1">Nuevo</option>
                                  {foreach $lstEtapas as $obj}
                                  <option value="{$obj->pet_id}">{$obj->pet_orden}&nbsp;-&nbsp;{$obj->pet_nombre}</option>
                                  {/foreach}

                                  </select>
                                </div>
                                <div class=" new-etapa">
                                </div>
                          </div>
                          <div class="form-group hidden" id="frm-newetapa">

                            <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selEtapas">Nueva Etapa</label>
                            <div class="col-md-5 col-sm-5 col-xs-12">
                                <input type="text" id="txtNombreEtapaNew" name="txtNombreEtapaNew"  class="form-control col-md-12 col-xs-12 input-filter datos-newetapa" placeholder="Escribir nueva Etapa" value="" title="Nombre de la nueva Etapa">
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-12">
                                <input type="number" id="txtOrdenEtapaNew" name="txtOrdenEtapaNew"  class="form-control col-md-12 col-xs-12 input-filter datos-newetapa" placeholder="Orden" value="1" title="Nro de Orden de la Etapa del Proceso" min="1" step="1">
                            </div>{*
                            <div class="col-md-3 col-sm-3 col-xs-12">
                            </div> *}
                          </div>
                        </div>
                        <div class="col-sm-12">
                          <fieldset>
                            <legend>Actividad</legend>

                            <div class="form-group">
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <select class="select-default form-control input-filter" tabindex="-1" name="selActividad" id="selActividad" data-placeholder=" - Seleccione - " disabled="">
                                    <option></option>
                                    <option value="-1">Nuevo</option>
                                    </select>
                                  </div>
                            </div>
                            <div class="new-actividad hidden" id="frm-newactividad">
                              <!--#NEW-ACTIVIDAD-->

                                <div class="form-group">

                                  <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtNomActiNew">Nueva Actividad</label>
                                  <div class="col-md-5 col-sm-5 col-xs-12">
                                      <input type="text" id="txtNomActiNew" name="txtNomActiNew"  class="form-control col-md-12 col-xs-12 input-filter datos-newetapa" placeholder="Escribir nueva Actividad" value="" title="Nombre de la nueva Actividad">
                                  </div>
                                  <div class="col-md-2 col-sm-2 col-xs-12">
                                      <input type="number" id="txtOrdenActiNew" name="txtOrdenActiNew"  class="form-control col-md-12 col-xs-12 input-filter datos-newetapa" placeholder="Orden" value="1" title="Nro de Orden de la Etapa del Proceso" min="1" step="1">
                                  </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtPuestoActiNew"><span>Puesto de Trabajo</span></label>
                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                        <input type="text" id="txtPuestoActiNew" name="txtPuestoActiNew"  class="form-control col-md-7 col-xs-12 input-filter" value="Escriba puesto de Trabajo" title="Nombre del puesto de Trabajo">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="radSituacionActividad">Situación</label>
                                    <div class="col-md-10 col-sm-10 col-xs-12">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" class="flat radSituacionActividad"  value="1" name="radSituacionActividad" checked="" title="Normal"> Rutinario(Normal)
                                            </label>
                                            <label>
                                                <input type="radio" class="flat radSituacionActividad"  value="2" name="radSituacionActividad" title="Anormal"> No Rutinario(Anormal)
                                            </label>
                                            <label>
                                                <input type="radio" class="flat radSituacionActividad"  value="3" name="radSituacionActividad"> Emergencia
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="radUbicacionActividad">Ubicación</label>
                                    <div class="col-md-10 col-sm-10 col-xs-12">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" class="flat radUbicacionActividad"  value="1" name="radUbicacionActividad" checked=""> Dentro del Lugar de Trabajo
                                            </label>
                                            <label>
                                                <input type="radio" class="flat radUbicacionActividad"  value="2" name="radUbicacionActividad"> Fuerda del Lugar de Trabajo
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="radTipoPersonalActividad">Tipo de Personal</label>
                                    <div class="col-md-10 col-sm-10 col-xs-12">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" class="flat radTipoPersonalActividad"  value="1" name="radTipoPersonalActividad" checked=""> Propio(PP)
                                            </label>
                                            <label>
                                                <input type="radio" class="flat radTipoPersonalActividad"  value="2" name="radTipoPersonalActividad">Contratado(PC)
                                            </label>
                                            <label>
                                                <input type="radio" class="flat radTipoPersonalActividad"  value="3" name="radTipoPersonalActividad">Visita(V)
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                  <div class="col-sm-12">
                                    <button type="button" class="btn btn-primary" id="btnGuardarNewAct">Guardar</button>
                                  </div>
                                </div>

                            </div>

                            <div class="form-group">
                                <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="">Blanco:</label>

                            </div>
                            <div class="form-group">
                              <div class="col-sm-12 col-md-12">
                                 <div class="" role="tabpanel" data-example-id="togglable-tabs">
                                  <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                    <li role="presentation" class="active"><a href="#tab_content1" id="peligro-tab" role="tab" data-toggle="tab" aria-expanded="true">Peligro</a>
                                    </li>
                                    <li role="presentation" class=""><a href="#tab_content2" role="tab" id="aspecto-tab" data-toggle="tab" aria-expanded="false">Aspecto Ambiental</a>
                                    </li>
                                  </ul>
                                  <div id="myTabContent" class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="peligro-tab">
                                      <a href="#" class="pull-right btn-agregar" data-add-tipo="peligro" id="btnAddPeligro" disabled=""><i class="fa fa-plus-circle " style="font-size: 1.5em;margin-right:1em;margin-bottom:10px;" ></i></a>
                                      <table class="table table-hover table-striped tbl-lista-blanco" id="lstPeligrosActi">
                                        <tbody>
                                        <tr>
                                          <td colspan="3">Agregue Elementos</td>
                                        </tr>
                                        </tbody>
                                      </table>

                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="aspecto-tab">
                                      <a href="#" class="pull-right btn-agregar" data-add-tipo="aspecto" id="btnAddAspecto" disabled=""><i class="fa fa-plus-circle " style="font-size: 1.5em;margin-right:1em;margin-bottom:10px;" ></i></a>
                                      <table class="table table-hover tbl-lista-blanco" id="lstAspectosActi">
                                        <tbody>
                                        <tr>
                                          <td colspan="3">Agregue Elementos</td>
                                        </tr>
                                        </tbody>
                                      </table>
                                    </div>
                                  </div>
                                </div>
                              </div>

                            </div>

                          </fieldset>
                          <hr>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtNomElabora"><span>Elaborado Por</span></label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                    <input type="text" id="txtNomElabora" name="txtNomElabora"  class="form-control col-md-7 col-xs-12 input-filter txt-nom" {if $smarty.session.tipo_usuario != 4 }{if $smarty.session.tipo_usuario != 1}disabled=""{/if}{/if} value="{$objA->apr_invo_ela}" {if $smarty.session.tipo_usuario != 4 && $smarty.session.tipo_usuario != 5}required=""{/if}>
                                </div>
                                <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtFechaElaboracion"><span>Fecha Elaboración</span></label>
                                <div class="controls">
                                  <div class="col-md-3 col-sm-3 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left txt-fechas {if $objA->apr_fecha_ela != ''}active{/if}" id="txtFechaElaboracion" name="txtFechaElaboracion" placeholder="" aria-describedby="inputSuccess2Status2" value="{$objA->apr_fecha_ela}"  {if $smarty.session.tipo_usuario != 4  }{if $smarty.session.tipo_usuario != 1}disabled=""{else}{if $objA->apr_invo_ela == ''}disabled=""{/if}{/if}{else}{if $objA->apr_invo_ela == ''}disabled=""{/if}{/if} required="">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true" ></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtNomRevisa"><span>Revisado Por</span></label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                    <input type="text" id="txtNomRevisa" name="txtNomRevisa"  class="form-control col-md-7 col-xs-12 input-filter txt-nom" {if $smarty.session.tipo_usuario != 4 }{if $smarty.session.tipo_usuario != 2}disabled=""{/if}{/if} value="{$objA->apr_invo_rev}" {if $smarty.session.tipo_usuario != 4 && $smarty.session.tipo_usuario != 5}required=""{/if}>
                                </div>
                                <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtFechaRevisado"><span>Fecha Revisión</span></label>
                                <div class="controls">
                                  <div class="col-md-3 col-sm-3 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left txt-fechas {if $objA->apr_fecha_rev != ''}active{/if}" id="txtFechaRevisado" name="txtFechaRevisado" placeholder="" aria-describedby="inputSuccess2Status2" value="{$objA->apr_fecha_rev}"
                                    {if $smarty.session.tipo_usuario != 4  }
                                      {if $smarty.session.tipo_usuario != 2}
                                          disabled=""
                                      {else}
                                        {if $objA->apr_invo_rev == ''}disabled=""{/if}
                                      {/if}
                                    {else}
                                      {if $objA->apr_invo_rev == ''}disabled=""{/if}
                                    {/if} required="">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtNomAprueba"><span>Aprobado Por</span></label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                    <input type="text" id="txtNomAprueba" name="txtNomAprueba"  class="form-control col-md-7 col-xs-12 input-filter txt-nom" {if $smarty.session.tipo_usuario != 4  }{if $smarty.session.tipo_usuario != 3}disabled=""{/if}{/if} value="{$objA->apr_invo_apr}" {if $smarty.session.tipo_usuario != 4 && $smarty.session.tipo_usuario != 5}required=""{/if}>
                                </div>
                                <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="txtFechaAprobacion"><span>Fecha Aprobación</span></label>
                                <div class="controls">
                                  <div class="col-md-3 col-sm-3 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left txt-fechas {if $objA->apr_fecha_apr != ''}active{/if}" id="txtFechaAprobacion" name="txtFechaAprobacion" placeholder="" aria-describedby="inputSuccess2Status2" value="{$objA->apr_fecha_apr}" {if $smarty.session.tipo_usuario != 4  }{if $smarty.session.tipo_usuario != 3}disabled=""{else}{if $objA->apr_invo_apr == ''}disabled=""{/if}{/if}{else}{if $objA->apr_invo_apr == ''}disabled=""{/if}{/if} required="" >
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true" ></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-9">


                            <div class="form-group">
                                <div class="col-md-6 col-sm-6 col-xs-12 ">
                                  {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                                  <button type="submit" class="btn btn-success" id="btnGuardarAnalisiProceso">Guardar</button>
                                </div>
                            </div>
                        </div>
                    </form>
                  </div>
                </div>
              </div>
    </div>

    <div class="modal fade modal-blancos" tabindex="-1" role="dialog" aria-hidden="true" id="modAddPeligro" data-mod-tipo="peligro" data-modo-modal="registrar">
      <!--##REGISTRO-->
      <form id="frmRegistroPeligro" data-parsley-validate class="form-horizontal form-label-left" data-accion="registrar">
        <input type="hidden" name="txtIdAnalisis" value="{$objA->apr_id}" id="txtIdAnalisis">
        <input type="hidden" name="txtIdActividad" value="" class="txtIdActividad">
        <input type="hidden" name="txtIdBlanco" value="" class="txtIdBlanco">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="tituloModalPel">Agregar Peligro a Actividad</h4>
            </div>
            <div class="modal-body">
            <!-- ##FRM REGISTRO-->
              <input type="hidden" name="txtId" value="" id="txtId">
              <div class="form-group">
                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selPeligro">Peligro
                </label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="select-default form-control" tabindex="-1" name="selPeligro" id="selPeligro" data-placeholder=" - Seleccione - " style="width: 100%"  required="" >
                  <option></option>
                  {foreach $lstPeligros as $obj}
                  <optgroup label="{$obj.categoria}">
                    {foreach $obj.elementos as $ele}
                      <option value="{$ele->pel_id}">{$ele->pel_nombre}</option>
                    {/foreach}
                  </optgroup>
                  {/foreach}
                  </select>
                </div>
              </div>
              <fieldset id="frmNewPel" class="hidden">
                <legend>Nuevo Peligro</legend>

                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selCategoriaPeligroNew">Categoría
                  </label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                    <select class="select-default form-control" tabindex="-1" name="selCategoriaPeligroNew" id="selCategoriaPeligroNew" data-placeholder=" - Seleccione - " style="width: 100%" >
                    <option></option>
                    <option value="-1">Nuevo</option>
                    {foreach $lstCatePel as $obj}
                        <option value="{$obj->cat_id}">{$obj->cat_nombre}</option>
                    {/foreach}
                    </select>
                  </div>
                </div>
                <div class="form-group hidden" id="frmNewCatPel">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNomNewCatePel">Nueva Categoría</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                            <input type="text" class="form-control txt-newpel pelcate" id="txtNomNewCatePel" name="txtNomNewCatePel" placeholder="Escribir nueva Categoría" title="Nombre de la nueva Categoría">
                            <span class="input-group-btn">
                                              <button type="button" class="btn btn-primary btn-guardar-pel pelcate"  title="Guardar nueva Categoría de Peligro"><i class="fa fa-save"></i></button>
                                          </span>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNomNewPel">Peligro</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                            <input type="text" class="form-control txt-newpel peligro" id="txtNomNewPel" name="txtNomNewPel" placeholder="Escribir  nuevo Peligro" title="Nombre del nuevo Peligro">
                            <span class="input-group-btn">
                                              <button type="button" class="btn btn-primary btn-guardar-pel peligro"  title="Guardar nuevo Peligro"><i class="fa fa-save"></i></button>
                                          </span>
                    </div>
                  </div>
                </div>
                <hr>
              </fieldset>

              <div class="form-group">
                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selRiesgo">Riesgo</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="select-default form-control"  style="width: 100%" id="selRiesgo" name="selRiesgo"  data-placeholder=" - Seleccione - " multiple="" disabled="">
                  </select>
                </div>
              </div>
              <fieldset id="frmNewRiesgo" class="hidden">
                <legend>Nuevo Riesgo</legend>

                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNomNewRiesgo">Riesgo</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                            <input type="text" class="form-control pelcate" id="txtNomNewRiesgo" name="txtNomNewRiesgo" placeholder="Escribir nuevo Riesgo" title="Nombre del nuevo Riesgo">
                            <span class="input-group-btn">
                                              <button type="button" class="btn btn-primary" id="btnGuardarNewRies" title="Guardar nuevo Riesgo"><i class="fa fa-save"></i></button>
                                          </span>
                    </div>
                  </div>
                </div>
                <hr>
              </fieldset>
              <div class="clearfix"></div>
              <fieldset>
                <legend>Evaluación de Riesgos de Seguridad y Trabajo</legend>
                <fieldset>
                  <legend>Cálculo de Probabilidad</legend>
                  <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel">
                      <a class="panel-heading" role="tab" id="headingOne" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne"><b>Índice de exposición (IE)</b></a>
                      <div id="collapseOne" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">

                        <div class="panel-body">

                          <ul class="lista-calculo">
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIEP"  value="1" name="radIEP" checked="">
                              </label>
                              <span>1 - Ninguna persona expuesta.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIEP"  value="2" name="radIEP">
                              </label>
                              <span>2 - Una persona expuesta.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIEP"  value="3" name="radIEP">
                              </label>
                              <span>3 -  De 2 a 3 personas.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIEP"  value="4" name="radIEP">
                              </label>
                              <span>4 - De 4 a 10 personas.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIEP"  value="5" name="radIEP">
                              </label>
                              <span>5 - Más de 10 personas.</span>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="panel">
                      <a class="panel-heading" role="tab" id="headingOne2" data-toggle="collapse" data-parent="#accordion" href="#collapseOne2" aria-expanded="false" aria-controls="collapseOne2"><b>Índice de frecuencia (IF)</b></a>
                      <div id="collapseOne2" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne2">
                        <div class="panel-body">
                          <ul class="lista-calculo">
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIFP"  value="1" name="radIFP" checked="">
                              </label>
                              <span>1 - Es practicamente imposible que ocurra el próximo año.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIFP"  value="2" name="radIFP">
                              </label>
                              <span>2 - Por lo menos una vez al año.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIFP"  value="3" name="radIFP">
                              </label>
                              <span>3 - Por lo menos una vez al mes.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIFP"  value="4" name="radIFP">
                              </label>
                              <span>4 - Por lo menos una vez a la semana.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIFP"  value="5" name="radIFP">
                              </label>
                              <span>5 - Por los menos una vez al día.</span>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="panel">
                      <a class="panel-heading" role="tab" id="headingOne3" data-toggle="collapse" data-parent="#accordion" href="#collapseOne3" aria-expanded="false" aria-controls="collapseOne3"><b>Índice de procedimiento (IP)</b></a>
                      <div id="collapseOne3" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne3">
                        <div class="panel-body">

                          <ul class="lista-calculo">
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIPP"  value="1" name="radIPP" checked="">
                              </label>
                              <span>1 - No es necesario contar con procedimientos documentados ya que se evidencia su cumplimiento como práctica habitual del personal.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIPP"  value="2" name="radIPP">
                              </label>
                              <span>2 - Existen procesdimientos documentados, y se evidencia su cumplimiento y/o la supervición es permanente.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIPP"  value="3" name="radIPP">
                              </label>
                              <span>3 - Existen procedimientos no documentados y se evidencia su cumplimiento y/o la supervisión es programada.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIPP"  value="4" name="radIPP">
                              </label>
                              <span>4 - Existen procedimientos documentado, sin embargo no se evidencia su cumplimiento y/o existe poca supervisión o es aleatorio.</span>
                            </li>
                            <li>
                              <label class="">
                                  <input type="radio" disabled="" class="flat radCalProb radIPP"  value="5" name="radIPP">
                              </label>
                              <span>5 - No existen procedimientos documentados o aun cuando existen procedimientos no documentados estos no se cumplen y/o no existe supervisión.</span>
                            </li>
                          </ul>


                        </div>
                      </div>
                    </div>
                    <div class="panel">
                      <a class="panel-heading" role="tab" id="headingOne4" data-toggle="collapse" data-parent="#accordion" href="#collapseOne4" aria-expanded="false" aria-controls="collapseOne4"><b>Índice de capacitación (IC)</b></a>
                      <div id="collapseOne4" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne4">
                        <div class="panel-body">

                          <ul class="" style="margin:0px;padding:0px;list-style-type: none;">
                            <li>
                              <label class=""><input type="radio" disabled="" class="flat radCalProb radICP"  value="1" name="radICP" checked=""></label>
                              <span>1 - El personal conoce :</span>
                            </li>
                            <li style="margin-left:40px">
                              <ul class="" style="list-style-type: square !important;">

                                        <li> Los Peligros y riesgos</li>
                                        <li> Procedimiento(s) para realizar el trabajo de manera segura</li>
                                        <li> Normas de seguridad</li>
                                        <li> Existen registros de capacitación</li>
                                        <li> El personal reporta activamente lo incidentes</li>



                              </ul>
                            </li>
                            <li>
                              <label class=""><input type="radio" disabled="" class="flat radCalProb radICP"  value="2" name="radICP"></label>
                              <span>2 - El personal conoce :</span>
                            </li>
                            <li style="margin-left:40px">
                              <ul class="" style="list-style-type: square !important;">



                                    <li> Los peligros y riesgos</li>
                                    <li> Procedimiento(s) para realizar el trabajo de manera segura</li>
                                    <li> Normas de seguridad</li>
                                    <li> Existen registros de capacitación</li>
                                    <li> Normas de seguridad</li>
                                    <li> Existen registros de capacitación</li>




                              </ul>
                            </li>
                            <li>
                              <label class=""><input type="radio" disabled="" class="flat radCalProb radICP"  value="3" name="radICP"></label>
                              <span>3 - El personal conoce :</span>
                            </li>
                            <li style="margin-left:40px">
                              <ul class="" style="list-style-type: square !important;">




                                    <li> Los peligros y riesgos</li>
                                    <li> Procedimiento(s) para realizar el trabajo de manera segura</li>
                                    <li> Normas de seguridad</li>
                                    <li> Existen parcialmente registros de capacitación</li>



                              </ul>
                            </li>
                            <li>
                              <label class=""><input type="radio" disabled="" class="flat radCalProb radICP"  value="4" name="radICP"></label>
                              <span>4 - El personal conoce :</span>
                            </li>
                            <li style="margin-left:40px">
                              <ul class="" style="list-style-type: square !important;">


                                    <li> Los peligros y riesgos</li>
                                    <li> Procedimiento(s) para realizar el trabajo  de manera segura</li>
                                    <li> Normas de seguridad</li>
                                    <li> No existen registros de capacitación</li>


                              </ul>
                            </li>
                            <li>
                              <label class=""><input type="radio" disabled="" class="flat radCalProb radICP"  value="5" name="radICP"></label>
                              <span>5 - El personal conoce :</span>
                            </li>
                            <li style="margin-left:40px">
                              <ul class="" style="list-style-type: square !important;">



                                    <li> Los peligros y riesgos</li>
                                    <li> Procedimiento(s) para realizar el trabajo de manera segura</li>
                                    <li> Normas de seguridad</li>
                                    <li> No existen registros de capacitación</li>

                              </ul>
                            </li>
                          </ul>


                        </div>
                      </div>
                    </div>
                  </div>

              {*     <div class="form-group">
                    <label class="control-label-left col-md-3 col-sm-3 col-xs-12 " for="txtSumaPrPel">Suma Pr
                    </label>
                    <div class="col-md-9 col-sm-9 col-xs-12 padding-top-7">
                        <span  id="txtSumaPrPel" name="txtSumaPrPel" class="label label-primary label-anapro" ></span>
                    </div>
                  </div> *}
                </fieldset>
                <div class="display-label-groups">
                  <div class="display-label">
                    <div class="col-sm-4"><b>Surma Pr</b></div>
                    <div class="col-sm-8 padding-bottom-7">: <span id="txtSumaPrPel" class="label label-primary label-anapro">0</span></div>
                  </div>
                  <div class="display-label">
                    <div class="col-sm-4"><b>Probabilidad</b></div>
                    <div class="col-sm-8 padding-bottom-7">: <span id="txtProbPel" class="label label-primary label-anapro">0</span></div>
                  </div>

                  <div class="display-label">
                    <div class="col-sm-4"><b>Severidad (Se)</b></div>
                    <div class="col-md-8 col-sm-6 col-xs-12">
                        <div class="radio radio-apr-editar">
                            <label>
                                <input type="radio" class="flat radSevP"  value="1" name="radSevP" checked=""> <span   title="Incidente que no ocasiona lesión alguna">1 - Insignificante</span>
                            </label>
                            <br>
                            <label>
                                <input type="radio" class="flat radSevP"  value="2" name="radSevP"><span   title="Lesión sin incapacidad o enfermedad cuyo resultado de la evaluación médica, genera en el accidente o paciente un descanso breve con retorno máximo al día siguiente a sus labores"> 2 - Leve </span>
                            </label>
                            <br>
                            <label>
                                <input type="radio" class="flat radSevP"  value="3" name="radSevP"><span   title="Lesión con incapacidad temporal o enfermedad cuyo resultado de la evaluación médica, da lugar  o descanso o ausencia justificada al trabajo y tratamiento"> 3 - Moderado</span>
                            </label>
                            <br>
                            <label>
                                <input type="radio" class="flat radSevP"  value="4" name="radSevP"><span   title="Lesión o enfermedad cuyo resultado  de la evaluación médica determina incapacidad laboral permanente (excluyendo la muerte del trabajador), tales como amputaciones, enfermedades, etc."> 4 - Grave</span>
                            </label>
                            <br>
                            <label>
                                <input type="radio" class="flat radSevP"  value="5" name="radSevP"><span   title="Lesión que ocasiona la muerte del trabajador o enfermedad cuyo resultado de la evaluación médica determina incapacidad laboral permanente (enfermedades profesionales terminales)"> 5 - Catastrófico</span>
                            </label>

                        </div>
                    </div>
                  </div>

                  <div class="display-label">
                    <div class="col-sm-4"><b>Puntaje (Pr x Se)</b></div>
                    <div class="col-sm-8 padding-bottom-7">: <span id="txtPuntajePrxSePel" class="label label-primary label-anapro"></span></div>
                  </div>

                  <div class="display-label">
                    <div class="col-sm-4"><b>Nivel de Riesgo</b></div>
                    <div class="col-sm-8 padding-bottom-7">: <span id="txtNivelRiesgoPel" class="label label-primary label-anapro"> - - - - - </span></div>
                  </div>
                  <div class="display-label">
                    <div class="col-sm-4"><b>Riesgo Significativo</b></div>
                    <div class="col-sm-8 padding-bottom-7">: <span id="txtRiesgoSigPel" class="label label-primary label-anapro"> - - </span></div>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend>Medidas de control de riesgo</legend>
                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selJerarquiaRiesgo">Jerarquía</label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                    <select class="select-default form-control input-filter" tabindex="-1" data-jerar-tipo="riesgo" name="selJerarquiaRiesgo" id="selJerarquiaRiesgo" data-placeholder=" - Seleccione - " style="width: 100%" disabled="">
                    <option></option>
                    {foreach $lstMCRiesgos as $obj}
                    <option value="{$obj->jmc_id}">{$obj->jmc_nombre}</option>
                    {/foreach}
                    </select>
                  </div>
                </div>
                <div class="form-group">


                  <div class="col-md-12 col-sm-12 col-xs-12">
                  <label class="control-label-left " for="selMedidaRiesgo">Medida de Control</label>
                    <select class="select-default form-control"  style="width: 100%" id="selMedidaRiesgo" name="selMedidaRiesgo" disabled="" data-placeholder=" - Seleccione - " >

                    </select>
                  </div>
                </div>
                <div class="form-group">
                <div class="col-sm-12 text-right">
                  <button type="button" class="btn btn-primary right btnAddMControl" id="btnAddMCRiesgo" data-mco-tipo="riesgo" disabled="">Agregar Medida</button>
                </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-12">
                    <label>Lista de Medidas</label>

                    <ul class="to_do lista-medidas" id="lstMedidasRiesgo">

                      <li data-id-medida=""><p>Sin Medidas de Control</p></li>
                    </ul>
                  </div>
                </div>

              </fieldset>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
              <button type="submit" class="btn btn-primary btnGuardarBlanco" id="btnGuardarPeligro" data-accion="guardar" data-tipo-blanco="peligro">Guardar</button>
            </div>
          </div>
        </div>
      </form>
    </div>
    <div class="modal fade modal-blancos" tabindex="-1" role="dialog" aria-hidden="true" id="modAddAspecto" data-mod-tipo="ambiental" data-modo-modal="registrar">
      <!--##REGISTRO-->
      <form id="frmRegistroAmbiental" data-parsley-validate class="form-horizontal form-label-left" data-accion="registrar">
        <input type="hidden" name="txtIdAnalisis" value="{$objA->apr_id}" id="txtIdAnalisis">
        <input type="hidden" name="txtIdActividad" value="" class="txtIdActividad">
        <input type="hidden" name="txtIdBlanco" value="" class="txtIdBlanco">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="tituloModalAmb">Agregar Aspecto Ambiental a Actividad</h4>
            </div>
            <div class="modal-body">
            <!-- ##FRM REGISTRO-->
              <input type="hidden" name="txtId" value="" id="txtId">
              <div class="form-group">
                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selAspectoAmbiental">Aspecto Ambiental
                </label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="select-default form-control" tabindex="-1" name="selAspectoAmbiental" id="selAspectoAmbiental" data-placeholder=" - Seleccione - " style="width: 100%"  required="" >

                  </select>
                </div>
              </div>

              <fieldset id="frmNewAaspecto" class="hidden">
                <legend>Nuevo Aspecto Ambiental</legend>

                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selCategoriaAspectoNew">Categoría
                  </label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                    <select class="select-default form-control" tabindex="-1" name="selCategoriaAspectoNew" id="selCategoriaAspectoNew" data-placeholder=" - Seleccione - " style="width: 100%" >
                    <option></option>
                    <option value="-1">Nuevo</option>
                    {foreach $lstCateAmb as $obj}
                        <option value="{$obj->cat_id}">{$obj->cat_nombre}</option>
                    {/foreach}
                    </select>
                  </div>
                </div>
                <div class="form-group hidden" id="frmNewCatAsp">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNomNewCateAsp">Nueva Categoría</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                            <input type="text" class="form-control ref-new-ambiental" data-proceso="categoria" id="txtNomNewCateAsp" name="txtNomNewCateAsp" placeholder="Escribir nueva Categoría" title="Nombre de la nueva Categoría">
                            <span class="input-group-btn">
                                              <button type="button" class="btn btn-primary ref-new-ambiental" data-proceso="categoria"  title="Guardar nueva Categoría de Peligro"><i class="fa fa-save"></i></button>
                                          </span>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNomNewAsp">Aspecto Ambiental</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                            <input type="text" class="form-control ref-new-ambiental" data-proceso="ambiental" id="txtNomNewAsp" name="txtNomNewAsp" placeholder="Escribir  nuevo Aspecto Ambiental" title="Nombre del nuevo Aspecto Ambiental">
                            <span class="input-group-btn">
                                              <button type="button" class="btn btn-primary ref-new-ambiental" data-proceso="ambiental"  title="Guardar nuevo Aspecto Ambiental"><i class="fa fa-save"></i></button>
                                          </span>
                    </div>
                  </div>
                </div>
                <hr>
              </fieldset>
              <div class="form-group">
                <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selImpacto">Impacto Ambiental
                </label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="select-default form-control" name="selImpacto" id="selImpacto" style="width: 100%" data-placeholder=" - Seleccione - " disabled="" multiple="">

                  </select>
                </div>
              </div>

              <fieldset id="frmNewImpacto" class="hidden">
                <legend>Nuevo Impacto Ambiental</legend>

                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNomNewImpacto">Impacto Ambiental</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                            <input type="text" class="form-control ref-new-ambiental" data-proceso="impacto" id="txtNomNewImpacto" name="txtNomNewImpacto" placeholder="Escribir nuevo Impacto Ambiental" title="Nombre del nuevo Impacto Ambiental">
                            <span class="input-group-btn">
                                              <button type="button" class="btn btn-primary ref-new-ambiental" data-proceso="impacto" id="" title="Guardar nuevo Impacto Ambiental"><i class="fa fa-save"></i></button>
                                          </span>
                    </div>
                  </div>
                </div>
                <hr>
              </fieldset>
              <div class="clearfix"></div>
              <fieldset>
                <legend>Evaluación de Aspectos Ambientales</legend>
                <fieldset>
                  <legend>Cálculo de Probabilidad</legend>
                  <div class="accordion" id="accordion2" role="tablist" aria-multiselectable="true">
                    <div class="panel">
                      <a class="panel-heading" role="tab" id="headingOneAA" data-toggle="collapse" data-parent="#accordion2" href="#collapseOneAAAA" aria-expanded="false" aria-controls="collapseOneAAAA"><b>Probabilidad (Pr)</b></a>
                      <div id="collapseOneAAAA" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOneAA">
                        <div class="panel-body">
                          <div class="col-md-12 col-sm-12 col-xs-12">
                              <div class="radio">
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radIPR"  value="1" name="radIPR" checked="">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="1">
                                      <li>Ninguna Persona Expuesta</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radIPR"  value="2" name="radIPR">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="2">
                                      <li>Una persona Expuesta</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radIPR"  value="3" name="radIPR">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="3">
                                      <li>De 2 a 3 personas</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radIPR"  value="4" name="radIPR">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="4">
                                      <li>De 4 a 10 personas</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radIPR"  value="5" name="radIPR">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="5">
                                      <li>Más de 10 personas</li>
                                    </ol>
                                  </div>
                              </div>
                          </div>

                        </div>
                      </div>
                    </div>
                    <div class="panel">
                      <a class="panel-heading" role="tab" id="headingOneBB" data-toggle="collapse" data-parent="#accordion2" href="#collapseOneBBBB" aria-expanded="false" aria-controls="collapseOneBBBB"><b>Severidad (Se)</b></a>
                      <div id="collapseOneBBBB" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOneBB">
                        <div class="panel-body">
                          <div class="col-md-12 col-sm-12 col-xs-12">
                              <div class="radio">
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radISEV"  value="1" name="radISEV" checked="">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="1">
                                      <li>Es practicamente imposible que ocurra el próximo año</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radISEV"  value="2" name="radISEV">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="2">
                                      <li>Por lo menos una vez al año</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radISEV"  value="3" name="radISEV">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="3">
                                      <li>Por lo menos una vez al mes</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radISEV"  value="4" name="radISEV">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="4">
                                      <li>Por lo menos una vez a la semana</li>
                                    </ol>
                                  </div>
                                  <label class="col-sm-1">
                                      <input type="radio" class="flat radCalProbAm radISEV"  value="5" name="radISEV">
                                  </label>
                                  <div class="col-sm-11">
                                    <ol start="5">
                                      <li>Por los menos una vez al día</li>
                                    </ol>
                                  </div>
                              </div>
                          </div>

                        </div>
                      </div>
                    </div>
                  </div>
                </fieldset>

                <div class="display-label-groups">
                  <div class="display-label">
                    <div class="col-sm-5"><b>Puntaje (Pr x Se)</b></div>
                    <div class="col-sm-7 padding-bottom-7"><span id="txtPuntajePrxSeImp" class="label label-primary label-anapro">0</span></div>
                  </div>
                  <div class="display-label">
                    <div class="col-sm-5"><b>Nivel de Impacto Ambiental</b></div>
                    <div class="col-sm-7 padding-bottom-7"><span id="txtNivelRiesgoImp" class="label label-primary label-anapro"> - - - - - </span></div>
                  </div>
                  <div class="display-label">
                    <div class="col-sm-5"><b>Impacto Ambiental Significativo </b></div>
                    <div class="col-sm-7 padding-bottom-7"><span id="txtImpAmbSig" class="label label-primary label-anapro"> - - </span></div>
                  </div>
                </div>
                <div class="clearfix"></div>
              </fieldset>
              <fieldset>
                <legend>Medidas de control de impacto ambiental</legend>
                <div class="form-group">
                  <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selJerarquiaImpacto">Jerarquía</label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                    <select class="select-default form-control input-filter" tabindex="-1" data-jerar-tipo="impacto" name="selJerarquiaImpacto" id="selJerarquiaImpacto" data-placeholder=" - Seleccione - " style="width: 100%" disabled="">

                    <option></option>
                    {foreach $lstMCImpactos as $obj}
                    <option value="{$obj->jmc_id}">{$obj->jmc_nombre}</option>
                    {/foreach}
                    </select>
                  </div>
                </div>
                <div class="form-group">


                  <div class="col-md-12 col-sm-12 col-xs-12">
                  <label class="control-label-left " for="selMedidaAmbiental">Medida de Control</label>
                    <select class="select-default form-control" name="selMedidaAmbiental" id="selMedidaAmbiental"  style="width: 100%" data-placeholder=" - Seleccione - " disabled="">
                    </select>
                  </div>
                </div>

                <div class="form-group">
                <div class="col-sm-12 text-right">
                  <button type="button" class="btn btn-primary right btnAddMControl" id="btnAddMCImpacto" data-mco-tipo="impacto" disabled="">Agregar Medida</button>
                </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-12">
                    <label>Lista de Medidas</label>

                    <ul class="to_do lista-medidas" id="lstMedidasAmbiental">

                      <li data-id-medida=""><p>Sin Medidas de Control</p></li>
                    </ul>
                  </div>
                </div>

              </fieldset>
            </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
            <button type="submit" class="btn btn-primary btnGuardarBlanco" id="btnGuardarAmbiental" data-accion="guardar" data-tipo-blanco="ambiental">Guardar</button>
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
    <!-- bootstrap-daterangepicker -->

    <script src="{$public_url}views/templates/gentelella/js/datepicker/daterangepicker.js"></script>
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

    <script>
        var fechas_estado = {
          elaborado : true,
          elaborado : '',
          elaborado : ''
        }
    </script>
    <script src="{$public_url}views/analisis/js/ana_editar.js" async="async"></script>
    <script>

</script>
{/block}