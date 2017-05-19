{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}

{/block}
{block 'contenido'}
    <!--Contenido HTML-->
<div class="row">
    <div class="col-md-8 col-sm-10 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Correlatividad<small>&nbsp;</small></h2>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <form id="frmCorrelativo" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">

                          <div class="form-group">

                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Boleta SIG
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="select-minimum form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Tipo - " name="selCorreSig" id="selCorreSig" >
                                <option value=""></option>
                                <option value="1">Ambiental</option>
                                <option value="2">Seguridad</option>
                              </select>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-12">
                              <input  class="form-control col-md-12 col-xs-12 input-filter" type="number" name="txtCorreSig" id="txtCorreSig" placeholder="" disabled="" required="">
                            </div>
                          </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">SACP
                            </label>
                            <div class="col-md-2 col-sm-2 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="number" name="txtCorreSacp" id="txtCorreSacp" placeholder="" value="{$lstCorrSacp->cor_val}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Reporte de Incidencias
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <select class="select-default form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Tipo - " name="selCorreIncUni" id="selCorreIncUni" >
                                <option value=""></option>
                                {foreach $lstunidades as $obj}
                                <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                                {/foreach}
                              </select>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="number" name="txtCorreInc" id="txtCorreInc" placeholder="" disabled="" required="">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Autorización de Ingreso de Residuos a Almacén SIG
                            </label>
                            <div class="col-md-2 col-sm-2 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="number" name="txtCorreAutori" id="txtCorreAutori" placeholder="" value="{$lstCorrAlmacen->cor_val}">
                            </div>
                        </div>
                          <div class="form-group">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                              {* <button type="submit" class="btn btn-primary">Cancel</button> *}
                              <button type="submit" style="float:right; " class="btn btn-success" id="btnGuardar">Guardar</button>
                            </div>
                          </div>

                        </form>

            </div>
        </div>
    </div>
</div>
{/block}
{block 'script'}
    <script src="{$public_url}views/gestor/js/ges_correlativos.js"></script>
{/block}