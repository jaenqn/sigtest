{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
    <style type="text/css">
      button.btn-option-files{
        width: 32px;
      }
      .icon-files img {
              width: 16px;
              margin-top: auto;
              margin-bottom: auto;
      }
      #tblFicheros thead > tr > th:nth-child(2) {
        border-left:none;
      }
      #tblFicheros thead > tr > th:nth-child(1) {
        border-right:none;
      }

      #tblFicheros tbody  tr > td:nth-child(1){
        border-right:none;
      }
      #tblFicheros tbody  tr > td:nth-child(2){
        border-right:none;
        border-left:none;
      }
      #tblFicheros tbody  tr > td:nth-child(3){
        border-right:none;
        border-left:none;
        width:40%;

      }
      #tblFicheros tbody  tr > td:nth-child(4){
        border-left:none;
      }
      .btn-option-files span.fa{
        display: inherit;
      }
      #textCorrelativo{
        font-size:2em;
      }
        #fecha_solicita{
        font-size:1.2em;
        }
        .invo-separate{
          margin-bottom:1em;
        }
    </style>
    <script type="text/javascript">
      var ICONS = {$ref_icons};
    </script>
{/block}
{block 'contenido'}

    <!--Contenido HTML-->

<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
           {*  <div class="x_title">
                <h2>{$objBoleta->nom_area} <small></small></h2>
                <div class="clearfix"></div>
            </div> *}
            <div class="x_content">
              <div class="" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab1" class="nav nav-tabs bar_tabs left" role="tablist">
                  <li role="presentation" class=""><a href="#tab_content11" id="home-tabb" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">Detalles de Boleta</a>
                  </li>
                  <li role="presentation" class=""><a href="#tab_content22" role="tab" id="profile-tabb" data-toggle="tab" aria-controls="profile" aria-expanded="false">Respuesta Boleta</a>
                  </li>
                  <li role="presentation" class="active"><a href="#tab_content33" role="tab" id="profile-tabb3" data-toggle="tab" aria-controls="profile" aria-expanded="false">Fiscalizar Boleta</a>
                  </li>
                </ul>
                <div id="myTabContent2" class="tab-content">
                  <!--##DETALLES-->
                  <div role="tabpanel" class="tab-pane fade  " id="tab_content11" aria-labelledby="home-tab">
                    <div class="clearfix"></div>
                    <fieldset>
                      <legend><h2>{$objBoleta->nom_area} <small></small></h2></legend>
                      <form id="frmBoletaSIG" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">
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
                                        <select class="select-default form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Unidad - " name="selCorreIncUni" id="selCorreIncUni" required="" disabled="">
                                          <option value=""></option>
                                          {foreach $lstunidades as $obj}
                                          <option value="{$obj->idDepend}" {if $objBoleta->bol_uni_receptor == $obj->idDepend} selected="" {/if}>{$obj->desDepend}</option>
                                          {if $objBoleta->bol_uni_receptor == $obj->idDepend}
                                            {break}
                                          {/if}

                                          {/foreach}
                                        </select>
                                </div>
                            </div>

                        </div>
                        <div class="col-sm-3">
                          <p><b><span id="fecha_solicita"></span></b></p>
                        </div>
                        <div class="col-sm-6">

                          <fieldset>
                            <legend>Descripción de la observación</legend>
                            <textarea name="txtDesObserva" id="txtDesObserva" class="form-control" rows="4" required="required" disabled="">{$objBoleta->bol_observacion}</textarea>
                          </fieldset>
                        </div>
                        <div class="col-sm-6">

                          <fieldset>
                            <legend>Recomendaciones para corregir la observación</legend>
                            <textarea name="txtDesCorregir" id="txtDesCorregir" class="form-control" rows="4" required="required" disabled="">{$objBoleta->bol_corregir}</textarea>
                          </fieldset>
                        </div>
                        <div class="col-sm-12">
                            <div class="col-sm-6">
                              <fieldset>
                                <legend>Elaborado por</legend>
                                 <table style="margin-top:-1em;width:100%">
                                  <tbody>
                                    <tr>
                                      <td>Nombre(s) y Apellidos</td>
                                      <td style="padding-left:1em"><input type="text" name="txtNombreEla" id="txtNombreEla" class="form-control" value="{$objBoleta->involucrados.elaborador->ibo_nombre}" required="required"  title="Nombre de elaborador" disabled="" /></td>
                                    </tr>
                                    <tr style="">
                                      <td style="padding-top:10px">Nro Ficha</td>
                                      <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtFichaEla" id="txtFichaEla" class="form-control" value="{$objBoleta->involucrados.elaborador->ibo_ficha}" required="required" disabled="" title="Ficha de elaborador"/></td>
                                    <tr style="">
                                      <td style="padding-top:10px">DNI</td>
                                      <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtDniEla" id="txtDniEla" class="form-control" value="{$objBoleta->involucrados.elaborador->ibo_dni}" required="required"  title="DNI de elaborador" disabled=""/></td>
                                    </tr>
                                  </tbody>
                                </table>
                              </fieldset>
                            </div>
                            <div class="col-sm-6">
                              <fieldset>
                                <legend>Aprobado por</legend>
                                 <table style="margin-top:-1em;width:100%" >
                                  <tbody>
                                    <tr>
                                      <td>Nombre(s) y Apellidos</td>
                                      <td style="padding-left:1em"><input type="text" name="txtNombreRevisa" id="txtNombreRevisa" class="form-control" value="{$objBoleta->involucrados.aprobador->ibo_nombre}" required="required"  title="Nombre de aprobador" disabled=""/></td>
                                    </tr>
                                    <tr style="">
                                      <td style="padding-top:10px">Nro Ficha</td>
                                      <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtFichaRevisa" id="txtFichaRevisa" class="form-control" value="{$objBoleta->involucrados.aprobador->ibo_ficha}" required="required" disabled="" tile="Ficha aprobador"></td>
                                    <tr style="">
                                      <td style="padding-top:10px">DNI</td>
                                      <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtDnRevisa" id="txtDnRevisa" class="form-control" value="{$objBoleta->involucrados.aprobador->ibo_dni}" required="required"  title="DNI aprobador" disabled=""/></td>
                                    </tr>
                                  </tbody>
                                </table>
                              </fieldset>
                            </div>
                            <div class="clearfix"></div>
                          <fieldset>
                            <legend>Archivos adjuntos</legend>
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
                                        <a href="{$base_url}{$files->ruta_archivo}" target="_blank" class="btn btn-default  btn-option-files loading" title="Cancelar subida"  ><span class="fa fa-eye"></span></a>
                                    </td>
                                </tr>
                              {/foreach}

                              </tbody>
                            </table>

                          </fieldset>
                        </div>
                      </form>

                    </fieldset>
                  </div>
                  <!--##RESPUESTAS-->
                  <div role="tabpanel" class="tab-pane fade " id="tab_content22" aria-labelledby="profile-tab">
                    <form id="frmBoletaSIGRes" data-parsley-validate class="form-horizontal form-label-left">
                      <input type="hidden" id="txtId" name="txtId" value="{$objBoleta->bol_id}">
                      <input type="hidden" id="txtRechazado" name="txtRechazado" value="{$objBoleta->bol_rechazado}">
                        <div class="col-sm-6">
                            <fieldset>
                                <legend>Acciones inmediatas tomadas</legend>
                                <div class="">
                                    <ul class="to_do">
                                        {foreach $lstAccInme as $obj}
                                        <li>

                                            <p><input type="checkbox" class="flat chkAccInme" name="txtAccInme[]"  value="{$obj->aci_id}" id="" {foreach $objBoleta->respuestas.inmediatas as $objR}{if $objR->aci_id_accion_inmedita == $obj->aci_id}checked=""{/if}{/foreach} > {$obj->aci_des}</p>
                                        </li>
                                        {/foreach}
                                    </ul>
                                </div>

                            </fieldset>

                            <fieldset>
                                <legend>Otras acciones inmediatas tomadas</legend>
                                {$tempi = true }
                                {foreach $objBoleta->respuestas.inmediatas as $obj}
                                  {if $obj->aci_otro == 1}

                                    <input type="hidden" name="txtIdResAccInm" id="txtIdResAccInm" value="{$obj->aci_id_accion_inmedita}">
                                    <textarea name="txtAccionInmediataOtro" id="txtAccionInmediata" class="form-control" rows="3" disabled="">{$obj->aci_des}</textarea>
                                    {$tempi = false}
                                  {break}
                                  {/if}
                                {/foreach}
                                {if $tempi}
                                  <textarea name="txtAccionInmediataOtro" id="txtAccionInmediata" class="form-control" rows="3" placeholder="Definir otra acción inmediata" disabled=""></textarea>
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
                                            <p><input type="checkbox" class="flat " name="txtAccPost[]" value="{$obj->aci_id}" {foreach $objBoleta->respuestas.posteriores as $objR}{if $objR->aci_id_accion_posterior == $obj->aci_id}checked=""{/if}{/foreach} > {$obj->aci_des}</p>
                                        </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </fieldset>
                            <fieldset>
                                <legend>Otras acciones posteriores tomadas</legend>
                                {$tempp = true }
                                {foreach $objBoleta->respuestas.posteriores as $obj}
                                  {if $obj->aci_otro == 1}

                                    <input type="hidden" name="txtIdResAccPost" id="txtIdResAccPost" value="{$obj->aci_id_accion_posterior}">
                                    <textarea name="txtAccionPosteriorOtro" id="txtAccionPosterior" class="form-control" rows="3" disabled="">{$obj->aci_des}</textarea>
                                    {$tempp = false}
                                  {break}
                                  {/if}
                                {/foreach}
                                {if $tempp}
                                  <textarea name="txtAccionPosteriorOtro" id="txtAccionPosterior" class="form-control" rows="3" placeholder="Definir otra acción posterior"></textarea>
                                {/if}
                            </fieldset>

                            <div class="form-group" style="margin-top:1em">
                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="selMes"><span>Plazo de ejecución</span></label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selMes" id="selMes" data-placeholder=" - Mes - " style="width: 100%" disabled="">
                                    <option></option>
                                    {foreach $lstmeses as $obj}
                                    <option  value="{$obj.num}" {if $obj.num == $objBoleta->bol_mes}selected=""{/if}>{$obj.mes}</option>
                                    {/foreach}
                                    {* {foreach from=collection item=item key=key name=name}
                                    <option value="1">asdasd</option>
                                    {/foreach} *}

                                  </select>
                                </div>
                                {* <div class="col-md-1 col-sm-1 col-xs-12">
                                </div> *}
                                <div class="col-md-4 col-sm-4 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selYear" id="selYear" data-placeholder=" - Año - " style="width: 100%" disabled="">
                                    <option></option>
                                    <option value="{$objBoleta->bol_year}" selected="">{$objBoleta->bol_year}</option>

                                  </select>
                                </div>
                            </div>
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

                                        <textarea name="txtObservaciones" id="txtObservaciones" class="form-control col-sm-6 col-xs-12" rows="3" disabled>{$objBoleta->bol_observacion_respuesta}</textarea>

                                {* </div> *}

                            </fieldset>
                        </div>
                        <div class="col-sm-6 col-xs-12">

                                      <fieldset>
                                        <legend>Archivos adjuntos</legend>
                                        {* <div class="col-sm-12">
                                          <button style="float: right" type="button" class="btn btn-success"><i class="fa fa-plus"></i></button>
                                          <div class="clearfix"></div>
                                        </div> *}
                                        <table class="table table-bordered table-hover" id="tblFicheros">
                                          <thead>
                                            <tr>
                                              <th colspan="2">Ficheros</th>
                                              {* <th style="text-align: center;width: 55px">
                                              <label for="fileupload" id="prevFileUp" class="btn btn-success btn-option-files">
                                              <i class="fa fa-plus"></i>
                                              </label>
                                              </th> *}
                                            </tr>
                                          </thead>


                                          <tbody id="lstFicheros">
                                          {foreach $objBoleta->ficheros_evidencia_res as $obj}
                                            <tr>
                                              <td style="width: 40px;vertical-align:middle" class="icon-files"><img src="{$public_url}app/img/iconos/{$obj->ico_img[1]}" title="{$obj->ico_img[2]}"></td>
                                              <td><span style="word-break: break-all;line-height: 0px"><a href="{$base_url}{$obj->ruta_archivo}" target="_blank">{$obj->abo_nombre_fichero}</a></span></td>
                                            {*   <td style="padding:2px;vertical-align:middle"><div class="progress" style="margin-top: auto;margin-bottom: auto;">
                                                              <div class="progress-bar progress-bar-striped " data-transitiongoal="100"></div>
                                                  </div>
                                              </td> *}
                                            {*   <td style="width: 40px;text-aling:center;vertical-align:middle">
                                                  <button type="button" class="btn btn-default  btn-option-files loaded" title="Cancelar subida" data-alojado="1" data-id-fichero="{$obj->abo_id}"><span class="fa fa-trash"></span></button>
                                              </td> *}
                                          </tr>
                                          {/foreach}

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
                               <table style="margin-top:-1em;width:100%">
                                <tbody>
                                  <tr>
                                    <td>Nombre(s) y Apellidos</td>
                                    <td style="padding-left:1em"><input type="text" name="txtNombreSuper" id="txtNombreSuper" class="form-control" value="{$objBoleta->involucrados.supervisor->ibo_nombre}" required="required"  title="Nombre del elaborador" disabled=""></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">Nro Ficha</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtFichaSuper" id="txtFichaSuper" class="form-control" value="{$objBoleta->involucrados.supervisor->ibo_ficha}" required="required" disabled=""></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">DNI</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtDniSuper" id="txtDniSuper" class="form-control" value="{$objBoleta->involucrados.supervisor->ibo_dni}" required="required"  title="" disabled=""></td>
                                  </tr>
                                  <tr style="">
                                    <td style="padding-top:10px">Fecha</td>
                                    <td style="padding-left:1em;padding-top:10px"><input type="text" name="fecha_solicita_res" id="fecha_solicita_res" class="form-control" value="" required="required"  title="" disabled=""></td>
                                  </tr>
                                </tbody>
                              </table>
                          </div>
                          {* <div class="col-sm-6">
                              <p><b><span id="fecha_solicita">--</span></b></p>
                          </div> *}

                        </fieldset>
                    </div>

                    {* <div class="col-sm-12">
                        <div>
                            <button type="submit" class="btn btn-success">Guardar</button>
                            <button type="button" class="btn btn-danger">Cancelar</button>
                        </div>
                    </div> *}
                    </form>
                  </div>
                  <!--##FISCALIZAR-->
                  <div role="tabpanel" class="tab-pane fade active in" id="tab_content33" aria-labelledby="profile-tab">
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

                          <div class="form-group">
                            <div class="col-md-6 col-sm-6 col-xs-12 ">
                              {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                              <button type="button" class="btn btn-success" id="btnRechazarRespuesta">Rechazar Respuesta</button>
                              <button type="submit" class="btn btn-success" id="btnCerrarBoleta">Cerrar Boleta</button>
                            </div>
                          </div>



                    </form>
                  </div>
                </div>
              </div>
            </div>
        </div>
    </div>
</div>
{/block}
{block 'script'}
<script type="text/javascript">
  var boleta_data = {
    fecha_respuesta : '{$objBoleta->bol_fecha_respondido}',
    fecha_generado : '{$objBoleta->bol_fecha_generado}'
  }
</script>
    <script src="{$public_url}vendors/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.iframe-transport.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.fileupload.js"></script>
    <script src="{$public_url}views/boletasig/js/bol_fiscalizar.js"></script>
{/block}