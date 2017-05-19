{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
    <style type="text/css">
        .stepContainer{
            overflow-y: hidden;
        }
        .control-label-left span{
          font-weight: 100;
          background-color: rgba(33, 95, 143, 0.07);
          padding-left: 0.5em;
          padding-right: 0.5em;
          padding-top: 0.2em;
          padding-bottom: 0.2em;
        }
        #tblFuenteResiduo{
          width:100%;
        }
        #tblFuenteResiduo thead th:nth-child(1){
          width:42%;
        }

        #tblFuenteResiduo thead th:nth-child(2){
          width:42%;
        }

        #tblFuenteResiduo thead th:nth-child(3){
          width:16%;
        }
         #tblFuenteResiduo tbody tr td:nth-child(1){
          /*width:42%;*/

        }

        #tblFuenteResiduo tbody tr td:nth-child(2){
          /*width:42%;*/
        }

        #tblFuenteResiduo tbody tr td:nth-child(3){
          /*width:16%;*/
        }
        #tblFuenteResiduo tbody tr td input{

          width:100%;
          border:0px;
          margin:0px;
          padding:5px;
        }
        #tblFuenteResiduo tbody tr td:nth-child(n+1) {
          border-left:1px solid;
          border-top:1px solid;

        }
        #tblFuenteResiduo tbody tr td:nth-last-child(1) {
          border-right:1px solid;
        }
        #tblFuenteResiduo tbody tr:nth-last-child(1) {
          border-bottom:1px solid;
        }
        #tblResumenResiduo{
          text-align:center;
        }
        .woborder-rigth{
          border-right:0px !important;
        }


        #tblAlmacenamiento{
          width: 100%;

        }
        #tblAlmacenamiento thead tr th{
          text-align: center;
        }
        #tblAlmacenamiento tbody tr td{
          padding: 0px;
          vertical-align: middle;

        }

        #tblAlmacenamiento tbody tr td:nth-child(2){
          padding: 10px;
        }
        #tblAlmacenamiento tbody tr td:nth-child(n+3) input{
          width: 80px;
          margin-left:auto;
          margin-right:auto;
        }
        #tblAlmacenamiento tbody tr td input{
          position:relative;
          border:0px;
          width: 100%;
          display: block;

          text-align: center;
          /*border-bottom:1px solid;*/
          vertical-align: middle;

        }
        #tblAlmacenamiento tbody tr td textarea{
          border:0px;
        }
        .tblTratamiento tbody tr td{
          padding: 0px;
        }
        .tblTratamiento tbody tr td input{
          border: 0px;
          width: 100%;
          padding: 5px;
          text-align: center;
        }
        textarea:focus{
          outline-width: 1xp !important;
          outline-style: inherit;
        }
  .formtest{
    font-size:12px
  }
  .formtest fieldset legend{
    font-size:12px
  }
  .formtest textarea,.formtest input{
    font-size:11px;
  }
    </style>
{/block}
{block 'contenido'}

<!--Contenido HTML-->
<div class="row">
    <div class="col-sm-12 col-xs-12">

        <div class="x_panel formtest">
      {*       <div class="x_title">
                <h2>Crear Carpeta</h2>
                <div class="clearfix"></div>
            </div> *}
            <div class="x_content ">
              <form  method="POST" class="form-horizontal" role="form" id="frmDeclara">
              {if isset($objDec)}
                <input type="hidden" name="txtIdDec" id="txtIdDec" value="{$objDec->rd_id}">
              {/if}
                <div id="wizard" class="form_wizard wizard_horizontal">
                                  <ul class="wizard_steps">
                                    <li>
                                      <a href="#step-1">
                                        <span class="step_no">1</span>
                                        <span class="step_descr">
                                                          Paso 1<br />
                                                          <small>DATOS GENERALES</small>
                                                      </span>
                                      </a>
                                    </li>
                                    <li>
                                      <a href="#step-2">
                                        <span class="step_no">2</span>
                                        <span class="step_descr">
                                                          Paso 2<br />
                                                          <small>CARACTERÍSTICAS DEL RESIDUO</small>
                                                      </span>
                                      </a>
                                    </li>
                                    <li>
                                      <a href="#step-3">
                                        <span class="step_no">3</span>
                                        <span class="step_descr">
                                                          Paso 3<br />
                                                          <small>MANEJO DEL RESIDUO</small>
                                                      </span>
                                      </a>
                                    </li>
                                  </ul>
                                  <div id="step-1" class="steps-form">
                                  <!--#DATOSGENERALES-->
                                      <div class="row">
                                          <div class="col-sm-12">
                                            <fieldset>
                                                <legend>DATOS GENERALES</legend>
                                                {* <form action="" method="POST" class="form-horizontal" role="form"> *}

                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-2 col-sm-2 col-xs-12" for="first-name"> Instalación
                                                    </label>

                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                      <select name="selInstalacion" id="selInstalacion" class="form-control select-default" required="required" data-placeholder=" - Seleccionar - " {if isset($objDec->ins_id_instalacion) && $objDec->ins_id_instalacion != 0} disabled=""{/if}>
                                                      <option value=""></option>
                                                      {foreach $lstInstalacion as $obj}
                                                      {if $obj->ins_id == $objDec->ins_id_instalacion}
                                                      <option value="{$obj->ins_id}" selected="">{$obj->ins_nombre}</option>
                                                      {else}
                                                      <option value="{$obj->ins_id}">{$obj->ins_nombre}</option>
                                                      {/if}
                                                      {/foreach}
                                                      </select>
                                                    </div>
                                                  </div>
                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-12 col-sm-12 col-xs-12" for="first-name">Razón Social y Siglas : <span  data-object="objIns" data-name="nombre_siglas"></span>
                                                    </label>

                                                  </div>
                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-4 col-sm-4 col-xs-12" >Nro RUC : <span  data-object="objIns" data-name="ins_ruc"></span>
                                                    </label>
                                                    <label class="control-label-left col-md-4 col-sm-4 col-xs-12" >E-mail : <span id="" data-object="objIns" data-name="ins_email"></span>
                                                    </label>
                                                    <label class="control-label-left col-md-4 col-sm-4 col-xs-12" >Teléfono (s) : <span id="" data-object="objIns" data-name="ins_telefono"></span>
                                                    </label>

                                                  </div>

                                                {* </form> *}
                                            </fieldset>
                                            <fieldset>
                                                <legend>DIRECCIÓN DE LA PLANTA <small>( Fuente de generación )</small></legend>
                                                {* <form class="form-horizontal form-label-left"> *}

                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">Dirección : <span  data-object="objIns" data-name="ins_direccion_format"></span>
                                                    </label>
                                                     <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">Nro : <span  data-object="objIns" data-name="ins_dir_num"></span>
                                                    </label>
                                                  </div>
                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">Urbanización / Localidad : <span  data-object="objIns" data-name="ins_urb_localidad"></span>
                                                    </label>
                                                    <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">Distrito : <span  data-object="objIns" data-name="dis_id_distrito"></span>
                                                    </label>
                                                  </div>
                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="first-name">Provincia : <span  data-object="objIns" data-name="pro_id_provincia"></span>
                                                    </label>
                                                    <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="first-name">Departamento : <span  data-object="objIns" data-name="dep_id_departamento"></span>
                                                    </label>
                                                    <label class="control-label-left col-md-4 col-sm-4 col-xs-12" for="first-name">C. Postal : <span  data-object="objIns" data-name="ins_cod_postal"></span>
                                                    </label>
                                                  </div>
                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">Representante Legal : <span  data-object="objIns" data-name="ins_representante"></span>
                                                    </label>
                                                    <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">D.N.I. / L.E. : <span  data-object="objIns" data-name="ins_dni_representante"></span>
                                                    </label>

                                                  </div>
                                                  <div class="form-group">
                                                    <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">Ingeniero Responsable : <span  data-object="objIns" data-name="ins_ing_responsable"></span>
                                                    </label>
                                                    <label class="control-label-left col-md-6 col-sm-6 col-xs-12" for="first-name">C.I.P. : <span  data-object="objIns" data-name="ins_cip_responsable"></span>
                                                    </label>

                                                  </div>

                                                {* </form> *}
                                            </fieldset>
                                          </div>
                                      </div>
                                  </div>
                                  <div id="step-2" class="steps-form">
                                  <!--#CARACTERISTICAS-->
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <fieldset>
                                          <legend>FUENTE DE GENERACIÓN</legend>
                                          <table id="tblFuenteResiduo">
                                            <thead>
                                              <tr>
                                                <th>Actividad generadora del residudo</th>
                                                <th>Insumos utilizados en el proceso</th>
                                                <th> Tipo Res <span data-toggle="tooltip" data-placement="top" data-html="true" title=""
                                                 data-title="ES-P = Establecimiento de Salud - PELIGROSO
                                                 IN = Industrial">(?)</span><button type="button" class="btn btn-primary" style="width:35px;float:right;padding: 1px 5px;" id="btnAgregarFuente" title="Agregar Actividad Generadora"><i class="fa fa-plus"></i></button></th>


                                              </tr>
                                            </thead>
                                            <tbody>
                                            {if isset($objDec) && count($objDec->rd_fuentes) > 1}

                                              {foreach $objDec->rd_fuentes as $objF}
                                              <tr>
                                                <input type="hidden" name="txtFuenteId[]" value="{$objF->rdf_id}">
                                                <td><input type="text" name="txtFuenGenAGDR[]" value="{$objF->rdf_actividad}" placeholder=""></td>
                                                <td><input type="text" name="txtFuenGenIUEEP[]" value="{$objF->rdf_insumos}" placeholder="" class=""></td>
                                                <td style="display:flex"  class="fuenteGenTR"><input type="text" class="txtFuenGenTR woborder-rigth" name="txtFuenGenTR[]" value="{$objF->rdf_tipo}" placeholder=""><button type="button" class="btn-option-files btnEliminarAccion" data-id-obj="{$objF->rdf_id}" style="width:35px;background: inherit;border-top: 0px solid rgb(115, 135, 156);border-bottom: 0px solid rgb(115, 135, 156);border-right: 0px solid rgb(115, 135, 156);border-left: 0px;" title="Eliminar Actividad"><i class="fa fa-trash" style="font-size:1.2em"></i></button></td>

                                              </tr>
                                              {/foreach}
                                            {else}
                                              {if count($objDec->rd_fuentes) == 1}
                                              <tr>
                                                <input type="hidden" name="txtFuenteId[]" value="{$objDec->rd_fuentes[0]->rdf_id}">
                                                <td><input type="text" name="txtFuenGenAGDR[]" value="{$objDec->rd_fuentes[0]->rdf_actividad}" placeholder=""></td>
                                                <td><input type="text" name="txtFuenGenIUEEP[]" value="{$objDec->rd_fuentes[0]->rdf_insumos}" placeholder=""></td>
                                                <td style="display:flex" class="fuenteGenTR"><input type="text" class="txtFuenGenTR" name="txtFuenGenTR[]" value="{$objDec->rd_fuentes[0]->rdf_tipo}" placeholder=""></td>
                                              </tr>
                                              {else}
                                              <tr>
                                                <td><input type="text" name="txtFuenGenAGDR[]" value="" placeholder=""></td>
                                                <td><input type="text" name="txtFuenGenIUEEP[]" value="" placeholder=""></td>
                                                <td style="display:flex" class="fuenteGenTR"><input type="text" class="txtFuenGenTR" name="txtFuenGenTR[]" value="" placeholder=""></td>
                                              </tr>
                                              {/if}
                                            {/if}
                                            </tbody>
                                          </table>




                                        </fieldset>
                                        <fieldset>
                                          <legend>CANTIDAD DE RESIDUO <small>(Volumen total o acumulado del residuo en el periodo anterior a la declaración TM/año)</small></legend>
                                          <div class="form-group">
                                            <label class="col-sm-2 control-label" for="selResiduo">Residuo </label>
                                            <div class="col-sm-5">
                                              <select {if isset($objDec)}disabled=""{/if} name="selResiduo" id="selResiduo" class="form-control select-default" required="required" data-placeholder=" - Seleccionar - ">
                                                      <option value=""></option>
                                                      {foreach $lstResiduos as $obj}
                                                      <option value="{$obj->res_id}" selected="">{$obj->res_nombre}</option>
                                                      {/foreach}
                                              </select>
                                            </div>
                                            <label class="col-sm-2 control-label" for="selResiduoYear">Año </label>
                                            <div class="col-sm-3">
                                              <select {if isset($objDec)}disabled=""{/if} name="selResiduoYear" id="selResiduoYear" class="form-control select-minimum" required="required" data-placeholder=" - Seleccionar - ">

                                                      {if isset($objDec)}
                                                      {foreach $lst_years as $obj}
                                                      <option value="{$obj.get_year}" selected="">{$obj.get_year}</option>
                                                      {/foreach}
                                                      {/if}
                                              </select>
                                            </div>


                                          </div>

                                          <div class="form-group">
                                            <div class="col-sm-2">&nbsp;</div>
                                            <div class="col-sm-6">
                                              <table class="table table-bordered table-hover">
                                                <thead>
                                                  <tr>
                                                    <th colspan="2">Detalles de Residuo</th>
                                                  </tr>
                                                </thead>
                                                <tbody id="tbodyDetaRes">
                                                  <tr>
                                                    <td>Cantidad</td>
                                                    <td class="res-deta-cantidad">0</td>
                                                  </tr>
                                                  <tr>
                                                    <td>Peso Total</td>
                                                    <td class="res-deta-peso">0</td>
                                                  </tr>
                                                  <tr>
                                                    <td>Volumen Total</td>
                                                    <td class="res-deta-volumen">0</td>
                                                  </tr>
                                                </tbody>
                                              </table>
                                            </div>
                                          </div>

                                          <div class="form-group">
                                            <label for="txtDescripcionRes" class="col-sm-2 control-label">Descripción del Residuo</label>
                                            <div class="col-sm-10">
                                              <textarea name="txtDescripcionRes" id="txtDescripcionRes" class="form-control resize-vertical" rows="3" required="required">{$objDec->rd_des_res}</textarea>
                                            </div>

                                          </div>

                                          <div class="form-group">
                                           <div class="col-sm-12">

                                           </div>
                                          </div>

                                        </fieldset>
                                         <table class="table table-bordered" id="tblResumenResiduo">
                                              <thead>
                                                <tr>
                                                  <th colspan="12" style="text-align: center">Volumen Generado (TM/mes)</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <td colspan="2"><b>Enero</b></td>
                                                  <td colspan="2"><b>Febrero</b></td>
                                                  <td colspan="2"><b>Marzo</b></td>
                                                  <td colspan="2"><b>Abril</b></td>
                                                  <td colspan="2"><b>Mayo</b></td>
                                                  <td colspan="2"><b>Junio</b></td>
                                                </tr>
                                                <tr >
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                </tr>
                                                <tr>
                                                  <td data-tipo="pel" data-num="1" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="1"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="2" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="2"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="3" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="3"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="4" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="4"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="5" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="5"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="6" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="6"  class="datos-meses">-</td>
                                                </tr>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <td colspan="2"><b>Julio</b></td>
                                                  <td colspan="2"><b>Agosto</b></td>
                                                  <td colspan="2"><b>Septiembre</b></td>
                                                  <td colspan="2"><b>Octubre</b></td>
                                                  <td colspan="2"><b>Noviembre</b></td>
                                                  <td colspan="2"><b>Diciembre</b></td>
                                                </tr>
                                                <tr>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                  <td>Peligroso</td>
                                                  <td>Otros</td>
                                                </tr>
                                                <tr>
                                                  <td data-tipo="pel" data-num="7" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="7"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="8" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="8"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="9" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="9"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="10" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="10"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="11" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="11"  class="datos-meses">-</td>
                                                  <td data-tipo="pel" data-num="12" class="datos-meses">-</td>
                                                  <td data-tipo="otr" data-num="12"  class="datos-meses">-</td>
                                                </tr>
                                              </tbody>
                                            </table>
                                        <fieldset>
                                          <legend>PELIGROSIDAD</legend>
                                          <div class="row">
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="1" {if $objDec->rd_peligrosidad == 1}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> Auto combustibilidad</div>
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="2" {if $objDec->rd_peligrosidad == 2}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> Reactividad</div>
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="3" {if $objDec->rd_peligrosidad == 3}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> Patogenicidad</div>
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="4" {if $objDec->rd_peligrosidad == 4}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> Explosividad</div>
                                          </div>
                                          <br>
                                          <div class="row">
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="5" {if $objDec->rd_peligrosidad == 5}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> Toxicidad</div>
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="6" {if $objDec->rd_peligrosidad == 6}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> Corrosividad</div>
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="7" {if $objDec->rd_peligrosidad == 7}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> Radiactividad</div>
                                            <div class="col-sm-3"><input type="radio" name="radTipoPeligrosidad" id="" value="8" {if $objDec->rd_peligrosidad == 8}checked=""{/if} data-parsley-mincheck="2" required class="flat radPeligrosidad"  /> <input type="text" name="txtOtraPeligrosidad" value="Otros" id="txtOtraPeligrosidad" placeholder="" style="    border: 1px solid;
                                              padding: 0px 2px 0px 2px;
                                              border-radius: 1px;
                                              border-left: 0px;
                                              border-right: 0px;
                                              border-top: 0px;"></div>
                                          </div>
                                        </fieldset>
                                      </div>
                                    </div>
                                  </div>
                                  <div id="step-3" class="steps-form">
                                  <!--#MANEJODELRESIUDO-->
                                    <div class="row">
                                    <div class="col-sm-12">
                                      <fieldset>
                                        <legend>ALMACENAMIENTO <small>(En la Fuente de Generación)</small></legend>
                                        <table class="table table-bordered" id="tblAlmacenamiento">
                                          <thead>
                                            <tr>
                                              <th>Recipiente</th>
                                              <th>Material</th>
                                              <th>Volumen (m3)</th>
                                              <th>Nro de Recipientes</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td>
                                              <textarea name="txtAlmacRecipiente" id="txtAlmacRecipiente" class="form-control textarea-auto size-vertical" rows="3" required="required">{if isset($objDec)}{$objDec->rd_alm_recip}{else}Los residuos sólidos no peligrosos son colocados en el almacén central de residuos no peligrosos{/if}</textarea>
                                              </td>
                                              <td><input type="text" name="txtAlmacMaterial" id="txtAlmacMaterial" value="{$objDec->rd_alm_material}" placeholder="Escribir"></td>
                                              <td><input type="number" step="any" min="0" name="txtAlmacVolumen" value="{$objDec->rd_alm_volumen|default:0}" id="txtAlmacVolumen" placeholder=""></td>
                                              <td><input type="number" name="txtAlmacNroRec" id="txtAlmacNroRec" min="0" value="{$objDec->rd_alm_num_recip|default:0}" placeholder=""></td>
                                            </tr>
                                          </tbody>
                                        </table>

                                      </fieldset>
                                    </div>
                                    </div>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <fieldset>
                                          <legend>TRATAMIENTO <div style="float:right">
                                            <input type="radio" name="radTipoTratamiento"  id="" value="2" {if isset($objDec) && $objDec->rd_tra_mod == 2}checked=""{/if} data-parsley-mincheck="2" required class="flat radTipoTratamiento"  /> Tercero (EPS-RS)&nbsp;&nbsp;&nbsp;
                                          </div><div style="float:right">
                                            <input type="radio" name="radTipoTratamiento"  id="" value="1" {if isset($objDec) && $objDec->rd_tra_mod == 1}checked=""{/if} data-parsley-mincheck="2" required class="flat radTipoTratamiento"  /> Directo (Generador)&nbsp;&nbsp;&nbsp;
                                          </div></legend>
                                        </fieldset>
                                        <table class="table table-bordered tblTratamiento" style="margin-bottom:0px">
                                          <thead>
                                            <tr style="background-color: rgb(192, 192, 192);">
                                              <th>Nro Registro EPS-RS</th>
                                              <th>Fecha de Vencimiento Registro EPS-RS</th>
                                              <th>Nro Autorización Municipal</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td><input type="text" name="txtTrataRegistro" value="{$objDec->rd_tra_reg_eps|default:'-'}" placeholder=""></td>
                                              <td><input type="text" name="txtTrataFechaVenc" value="{$objDec->rd_tra_fv_eps|default:'-'}" placeholder=""></td>
                                              <td><input type="text" name="txtTrataAutoriza" value="{$objDec->rd_tra_nram|default:'-'}" placeholder=""></td>
                                            </tr>
                                          </tbody>
                                        </table>
                                        <table class="table table-bordered tblTratamiento">
                                          <thead>
                                            <tr style="background-color: rgb(192, 192, 192);">
                                              <th>Descripción del Método</th>
                                              <th>Cantidad (TM/mes)</th>

                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td><input type="text" name="txtTrataDescripcion" value="{$objDec->rd_tra_desmetodo|default:'-'}" placeholder=""></td>
                                              <td><input type="text" name="txtTrataCantidad" value="{$objDec->rd_tra_cantidad|default:'-'}" placeholder=""></td>
                                            </tr>
                                          </tbody>
                                        </table>
                                      </div>
                                    </div>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <fieldset>
                                          <legend>REAPROVECHAMIENTO</legend>
                                        </fieldset>
                                        <table class="table table-bordered tblTratamiento">
                                          <thead>
                                            <tr style="background-color: rgb(192, 192, 192);">
                                              <th>Reciclaje</th>
                                              <th>Recuperación</th>
                                              <th>Reutilización</th>
                                              <th>Cantidad (TM/mes)</th>

                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td><input type="text" name="txtReaproReciclaje" value="{$objDec->rd_rea_reci|default:'-'}" placeholder=""></td>
                                              <td><input type="text" name="txtReaproRecupera" value="{$objDec->rd_rea_recu|default:'-'}" placeholder=""></td>
                                              <td><input type="text" name="txtReaproReutiliza" value="{$objDec->rd_rea_reu|default:'-'}" placeholder=""></td>
                                              <td><input type="text" name="txtReaproCantidad" value="{$objDec->rd_rea_cantidad|default:'-'}" placeholder=""></td>
                                            </tr>
                                          </tbody>
                                        </table>
                                      </div>
                                    </div>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <fieldset>
                                          <legend>MINIMIZACIÓN Y SEGREGACIÓN</legend>
                                        </fieldset>
                                        <table class="table table-bordered tblTratamiento">
                                          <thead>
                                            <tr style="background-color: rgb(192, 192, 192);">
                                              <th>Descripción de la Actividad de Segregación y Minimización</th>
                                              <th>Cantidad (TM/mes)</th>

                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td><textarea name="txtMinimiDescripcion" id="txtMinimiDescripcion" class="form-control textarea-auto" rows="3" required="required" style="border:0px">{if isset($objDec)}{$objDec->rd_mise_desc}{else}La minimización y segregación se efectúan en la fuente de generación en todas las áreas de Refinería Selva, mediante la aplicación de procedimientos, instructivo de trabajo y Cartillas de manejo de cada residuo sólido.{/if}</textarea></td>

                                              <td style="vertical-align: middle;width:150px"><input type="text" name="txtMinimiCantidad" value="{$objDec->rd_mise_cantidad|default:'-'}" placeholder=""></td>
                                            </tr>
                                          </tbody>
                                        </table>
                                      </div>
                                    </div>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <fieldset>
                                          <legend>TRASPORTE <small>(Empresa Prestadora de Servicios de Residuos Sólidos - EP-RS)</small></legend>
                                          {* <div> *}
                                            <div class="col-sm-12">
                                              <p><b>a) Razón Social y siglas de la EPS-RS: </b></p>
                                            </div>
                                             <table class="table table-bordered tblTratamiento" style="margin-bottom:0px;boder-bottom:0px">
                                              <thead>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <th colspan="2">Nº Registro EPS-RS y Fecha de Vencimiento</th>
                                                  <th>Nº Autorización Municipal</th>
                                                  <th>Nº Aprobación de Ruta (<span>*</span>)</th>

                                                </tr>
                                              </thead>
                                              <tbody>
                                                <tr>
                                                  <td style=""><input type="text" name="txtTransNroRegistro" value="{$objDec->rd_trana_nreg|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransFechaVenci" value="{$objDec->rd_trana_fv|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransAutoriMuni" value="{$objDec->rd_trana_nram|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransAprobacion" value="{$objDec->rd_trana_nrar|default:'-'}" placeholder=""></td>
                                                </tr>
                                              </tbody>
                                            </table>
                                             <table class="table table-bordered tblTratamiento" style="border-top:0px;margin-bottom:0px">
                                              <tbody>
                                                <tr><th colspan="3" style="border-top:0px">INFORMACIÓN DEL SERVICIO</th></tr>
                                                <tr>
                                                  <th style="background-color: rgb(192, 192, 192);">Total de Servicios Realizados en el año con la EPS-RS</th>
                                                  <td style="vertical-align: middle;padding:0px 5px 0px 5px"><span style="width:120px"> Nº Servicios: </span><input type="text" name="txtTransNroServicios" value="{$objDec->rd_trana_isnrs|default:'-'}" placeholder="" style="display:inline-block;width:120px"></td>
                                                  <td style="vertical-align: middle;padding:0px 5px 0px 5px"><span style="width:120px"> Volumen (TM): </span><input type="text" name="txtTransVolumen" value="{$objDec->rd_trana_isvol|default:'-'}" placeholder="" style="display:inline-block;width: 80px"></td>
                                                </tr>
                                              </tbody>
                                            </table>
                                            <table class="table table-bordered tblTratamiento" style="border-top:0px;margin-bottom:0px">
                                              <tbody>
                                                <tr>
                                                  <th colspan="2"  style="border-top:0px;margin-bottom:0px">Almacenamiento del Vehículo</th>
                                                  <th rowspan="2" style="width: 150px;vertical-align: middle;background-color: rgb(192, 192, 192);border-top:0px">Volumen promedio transportado por mes (TM)</th>
                                                  <th rowspan="2" style="width: 150px;vertical-align: middle;background-color: rgb(192, 192, 192);border-top:0px">Frecuencia de viajes por día</th>
                                                  <th rowspan="2" style="width: 150px;vertical-align: middle;background-color: rgb(192, 192, 192);border-top:0px">Volumen de carga por viaje (TM)</th>

                                                </tr>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <th>Tipo</th>
                                                  <th>Capacidad (TM)</th>

                                                </tr>

                                                <tr>
                                                  <td style=""><input type="text" name="txtTransInfoTipo" value="{$objDec->rd_trana_istipo|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransInfoCapacidad" value="{$objDec->rd_trana_iscapacidad|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransInfoVPTM" value="{$objDec->rd_trana_isvptm|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransInfoFV" value="{$objDec->rd_trana_isfvd|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransInfoVCXP" value="{$objDec->rd_trana_isvcv|default:'-'}" placeholder=""></td>
                                                </tr>
                                              </tbody>
                                            </table>
                                             <table class="table table-bordered tblTratamiento" style="border-top:0px;margin-bottom:0px">
                                              <tbody>
                                                <tr><th colspan="6" style="border-top:0px">CARACTERÍSTICAS DEL VEHÍCULO <div style="float:right">
                                              <input type="radio" name="radTransCaract" id="" value="3" {if isset($objDec) && $objDec->rd_trana_cvmodo == 3}checked=""{/if} data-parsley-mincheck="2" required class="flat radTransCaract"  /> Otro&nbsp;&nbsp;&nbsp;
                                            </div><div style="float:right">
                                              <input type="radio" name="radTransCaract" id="" value="2" {if isset($objDec) && $objDec->rd_trana_cvmodo == 2}checked=""{/if} data-parsley-mincheck="2" required class="flat radTransCaract"  /> Alquilado&nbsp;&nbsp;&nbsp;
                                            </div><div style="float:right">
                                              <input type="radio" name="radTransCaract" id="" value="1" {if isset($objDec) && $objDec->rd_trana_cvmodo == 1}checked=""{/if} data-parsley-mincheck="2" required class="flat radTransCaract"  /> Propio&nbsp;&nbsp;&nbsp;
                                            </div></th></tr>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <th>Tipo de Vehículo</th>
                                                  <th>Nº de Placa</th>
                                                  <th>Capacidad Promedio (TM)</th>
                                                  <th>Año de Fabricación</th>
                                                  <th>Color</th>
                                                  <th>Número de Ejes</th>
                                                </tr>
                                                <tr>
                                                  <td style=""><input type="text" name="txtTransCaractTV" value="{$objDec->rd_trana_cvtipo|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransCaractNroP" value="{$objDec->rd_trana_cvnplaca|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransCaractCP" value="{$objDec->rd_trana_cvcpro|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransCaractAF" value="{$objDec->rd_trana_cvafab|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransCaractColor" value="{$objDec->rd_trana_cvcolor|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransCaractNroE" value="{$objDec->rd_trana_cvnrejes|default:'-'}" placeholder=""></td>
                                                </tr>

                                              </tbody>
                                            </table>
                                          {* </div> *}
                                          {* <div> *}
                                            <div class="col-sm-12">
                                              <p><b>b) Razón Social y siglas de la EPS-RS:</b></p>
                                            </div>
                                             <table class="table table-bordered tblTratamiento" style="margin-bottom:0px;boder-bottom:0px">
                                              <thead>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <th colspan="2">Nº Registro EPS-RS y Fecha de Vencimiento</th>
                                                  <th>Nº Autorización Municipal</th>
                                                  <th>Nº Aprobación de Ruta (<span>*</span>)</th>

                                                </tr>
                                              </thead>
                                              <tbody>
                                                <tr>
                                                  <td style=""><input type="text" name="txtTransBNroRegistro" value="{$objDec->rd_tranb_nreg|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBFechaVenci" value="{$objDec->rd_tranb_fv|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBAutoriMuni" value="{$objDec->rd_tranb_nram|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBAprobacion" value="{$objDec->rd_tranb_nrar|default:'-'}" placeholder=""></td>
                                                </tr>
                                              </tbody>
                                            </table>
                                             <table class="table table-bordered tblTratamiento" style="border-top:0px;margin-bottom:0px">
                                              <tbody>
                                                <tr><th colspan="3" style="border-top:0px">INFORMACIÓN DEL SERVICIO</th></tr>
                                                <tr>
                                                  <th style="background-color: rgb(192, 192, 192);">Total de Servicios Realizados en el año con la EPS-RS</th>
                                                  <td style="vertical-align: middle;padding:0px 5px 0px 5px"><span style="width:120px"> Nº Servicios: </span><input type="text" name="txtTransBNroServicios" value="{$objDec->rd_tranb_isnrs|default:'-'}" placeholder="" style="display:inline-block;width:120px"></td>
                                                  <td style="vertical-align: middle;padding:0px 5px 0px 5px"><span style="width:120px"> Volumen (TM): </span><input type="text" name="txtTransBVolumen" value="{$objDec->rd_tranb_isvol|default:'-'}" placeholder="" style="display:inline-block;width: 80px"></td>
                                                </tr>
                                              </tbody>
                                            </table>
                                            <table class="table table-bordered tblTratamiento" style="border-top:0px;margin-bottom:0px">
                                              <tbody>
                                                <tr>
                                                  <th colspan="2"  style="border-top:0px;margin-bottom:0px">Almacenamiento del Vehículo</th>
                                                  <th rowspan="2" style="width: 150px;vertical-align: middle;background-color: rgb(192, 192, 192);border-top:0px">Volumen promedio transportado por mes (TM)</th>
                                                  <th rowspan="2" style="width: 150px;vertical-align: middle;background-color: rgb(192, 192, 192);border-top:0px">Frecuencia de viajes por día</th>
                                                  <th rowspan="2" style="width: 150px;vertical-align: middle;background-color: rgb(192, 192, 192);border-top:0px">Volumen de carga por viaje (TM)</th>

                                                </tr>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <th>Tipo</th>
                                                  <th>Capacidad (TM)</th>

                                                </tr>

                                                <tr>
                                                  <td style=""><input type="text" name="txtTransBInfoTipo" value="{$objDec->rd_tranb_istipo|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBInfoCapacidad" value="{$objDec->rd_tranb_iscapacidad|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBInfoVPTM" value="{$objDec->rd_tranb_isvptm|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBInfoFV" value="{$objDec->rd_tranb_isfvd|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBInfoVCXP" value="{$objDec->rd_tranb_isvcv|default:'-'}" placeholder=""></td>
                                                </tr>
                                              </tbody>
                                            </table>
                                             <table class="table table-bordered tblTratamiento" style="border-top:0px;margin-bottom:0px">
                                              <tbody>
                                                <tr><th colspan="6" style="border-top:0px">CARACTERÍSTICAS DEL VEHÍCULO <div style="float:right">
                                              <input type="radio" name="radTransBCaract" id="" {if isset($objDec) && $objDec->rd_tranb_cvmodo == 3}checked=""{/if} value="3" data-parsley-mincheck="2" required class="flat radTransCaract"  /> Otro&nbsp;&nbsp;&nbsp;
                                            </div><div style="float:right">
                                              <input type="radio" name="radTransBCaract" id="" {if isset($objDec) && $objDec->rd_tranb_cvmodo == 2}checked=""{/if} value="2" data-parsley-mincheck="2" required class="flat radTransCaract"  /> Alquilado&nbsp;&nbsp;&nbsp;
                                            </div><div style="float:right">
                                              <input type="radio" name="radTransBCaract" id="" {if isset($objDec) && $objDec->rd_tranb_cvmodo == 1}checked=""{/if} value="1" data-parsley-mincheck="2" required class="flat radTransCaract"  /> Propio&nbsp;&nbsp;&nbsp;
                                            </div></th></tr>
                                                <tr style="background-color: rgb(192, 192, 192);">
                                                  <th>Tipo de Vehículo</th>
                                                  <th>Nº de Placa</th>
                                                  <th>Capacidad Promedio (TM)</th>
                                                  <th>Año de Fabricación</th>
                                                  <th>Color</th>
                                                  <th>Número de Ejes</th>
                                                </tr>
                                                <tr>
                                                  <td style=""><input type="text" name="txtTransBCaractTV" value="{$objDec->rd_tranb_cvtipo|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBCaractNroP" value="{$objDec->rd_tranb_cvnplaca|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBCaractCP" value="{$objDec->rd_tranb_cvcpro|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBCaractAF" value="{$objDec->rd_tranb_cvafab|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBCaractColor" value="{$objDec->rd_tranb_cvcolor|default:'-'}" placeholder=""></td>
                                                  <td style=""><input type="text" name="txtTransBCaractNroE" value="{$objDec->rd_tranb_cvnrejes|default:'-'}" placeholder=""></td>
                                                </tr>

                                              </tbody>
                                            </table>
                                          {* </div> *}

                                        </fieldset>
                                      </div>
                                    </div>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <fieldset>
                                          <legend>DISPOSICIÓN FINAL</legend>
                                          <table class="table table-bordered tblTratamiento" style="margin-bottom:0px">
                                            <tbody>
                                              <tr>
                                                <th colspan="4">Razón Social y siglas de la EPS-RS administradora: <input type="text" name="txtTransDispoRazonSYS" value="{$objDec->rd_disf_epsrs}" placeholder="Escribir aquí" style="display:inline-block;width:220px;border:0px"></th>
                                              </tr>
                                              <tr style="background-color: rgb(192, 192, 192);">
                                                <th colspan="2">Nº Registro EPS-RS y Fecha de Vencimiento</th>
                                                <th>Nº Autorización Municipal</th>
                                                <th>Nº Autorización del Relleno</th>
                                              </tr>

                                              <tr>
                                                 <td style=""><input type="text" name="txtTransDispoReg" value="{$objDec->rd_disf_eps|default:'-'}" placeholder=""></td>
                                                 <td style=""><input type="text" name="txtTransDispoFechaVenc" value="{$objDec->rd_disf_fv|default:'-'}" placeholder=""></td>
                                                 <td style=""><input type="text" name="txtTransDispoAM" value="{$objDec->rd_disf_nram|default:'-'}" placeholder=""></td>
                                                 <td style=""><input type="text" name="txtTransDispoADR" value="{$objDec->rd_disf_nrar|default:'-'}" placeholder=""></td>
                                              </tr>
                                            </tbody>
                                          </table>
                                          <table class="table table-bordered tblTratamiento" style="border-top:0px">
                                            <tbody>
                                              <tr>
                                                <th colspan="2" style="border-top:0px">INFORMACIÓN DEL SERVICIO</th>
                                              </tr>
                                              <tr style="background-color: rgb(192, 192, 192);">
                                                <th>Método</th>
                                                <th>Ubicación</th>
                                              </tr>
                                              <tr>
                                                <td style=""><textarea  style="border:0px;width:100%;resize:vertical" name="txtTransDispoMetodo" class="textarea-auto" value="" placeholder="Escriba aquí">{$objDec->rd_disf_ismetodo}</textarea></td>
                                                <td style=""><textarea  style="border:0px;width:100%;resize:vertical" name="txtTransDispUbicac" class="textarea-auto" value="" placeholder="Escriba aquí">{$objDec->rd_disf_isubi}</textarea></td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </fieldset>
                                      </div>
                                    </div>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <fieldset>
                                          <legend>PROTECCIÓN AL PERSONAL</legend>
                                          <table class="table table-bordered tblTratamiento" style="margin-bottom:0px">
                                            <thead>
                                              <tr style="background-color: rgb(192, 192, 192);">
                                                <th>Descripción el Trabajo</th>
                                                <th>Nº de Personal en el Puesto</th>
                                                <th>Riesgos a los que se exponen</th>
                                                <th>Medidas de seguridad adoptadas</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              <tr>
                                                <td rowspan=""><textarea rows="4"  style="border:0px;width:100%;resize:vertical" name="txtPersonalDesc" class="textarea-auto" value="" placeholder="Escriba aquí">{$objDec->rd_prp_desc}</textarea></td>
                                                <td rowspan=""><textarea rows="4"  style="border:0px;width:100%;resize:vertical" name="txtPersonalPerPuesto" class="textarea-auto" value="" placeholder="Escriba aquí">{$objDec->rd_prp_nrpp}</textarea></td>
                                                <td rowspan=""><textarea rows="4"  style="border:0px;width:100%;resize:vertical" name="txtPersonalRiesgos" class="textarea-auto" value="" placeholder="Escriba aquí">{$objDec->rd_prp_rexp}</textarea></td>
                                                <td rowspan=""><textarea rows="4"  style="border:0px;width:100%;resize:vertical" name="txtPersonalMedSeg" class="textarea-auto" value="" placeholder="Escriba aquí">{$objDec->rd_prp_msa}</textarea></td>

                                              </tr>

                                            </tbody>
                                          </table>
                                          <table class="table table-bordered tblTratamiento" style="border-top:0px;">
                                            <tbody>
                                              <tr>
                                                <td style="padding:8px;border-top:0px">Acccidentes producids en el año : <input type="text" name="txtPersonalAPEEA" value="{$objDec->rd_prp_apa|default:'Ninguno'}" placeholder="Escribir aquí" style="display:inline-block;width:130px;border:0px"></td>
                                                <td style="padding:8px;border-top:0px">Veces <input type="text" name="txtPersonalAccVeces" value="{$objDec->rd_prp_apaveces|default:0}" placeholder="Escribir aquí" style="display:inline-block;width:220px;border:0px"></td>
                                                <td style="padding:8px;border-top:0px">Descripción <input type="text" name="txtPersonalAccDesc" value="{$objDec->rd_prp_apades|default:'------'}" placeholder="Escribir aquí" style="display:inline-block;width:220px;border:0px"></td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </fieldset>
                                      </div>
                                    </div>

                                  </div>

                </div>
              </form>
            </div>
        </div>
    </div>
</div>
{/block}
{block 'script'}
        <!-- jQuery Smart Wizard -->
    <script src="{$public_url}vendors/jQuery-Smart-Wizard/js/jquery.smartWizard.js"></script>
    <script src="{$public_url}vendors/autosize/dist/autosize.js"></script>


     <script>
      $(document).ready(function() {
        $('#wizard').smartWizard({
            labelNext:'Siguiente', // label for Next button
            labelPrevious:'Anterior', // label for Previous button
            labelFinish:'Finalizar',
            {if isset($objDec)}
            enableAllSteps : true,
            {/if}
            selected:0,
        });

        autorizetest();
        $('.buttonNext').addClass('btn btn-success');
        $('.buttonPrevious').addClass('btn btn-primary');
        $('.buttonFinish').addClass('btn btn-default');

        $('body').on('focus','input[type="text"]',function(){
          this.select();
        })
        $('body').on('focus','textarea',function(){
          this.select();
        })



      });
      function autorizetest(){
          $('.textarea-auto').each(function(){
            autosize(this);
          }).on('autosize:resized', function(){

            $('.stepContainer').height($('#step-3').outerHeight());
          });
      }
      $('#tblFuenteResiduo').on('keyup','.txtFuenGenTR', function(e){
      console.log(e);
      if(e.keyCode != 36 && e.keyCode != 16)
        this.value = this.value.toUpperCase();
      });

      $('.radTipoTratamiento, .radTransCaract').on('ifClicked', function(e){
        if(this.checked == true){
          $(e.target).iCheck('uncheck');
        }
      });
    </script>
    {if isset($objDec)}
    <script src="{$public_url}views/residuo/js/res_generar_dos.js"></script>
    {else}
    <script src="{$public_url}views/residuo/js/res_generar.js"></script>
    {/if}
{/block}