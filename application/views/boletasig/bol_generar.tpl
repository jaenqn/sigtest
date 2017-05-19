{extends $_template}
{block 'css'}
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
    margin-bottom:5px;
  }
</style>
<script type="text/javascript">
  var ICONS = {$ref_icons};
</script>

{/block}
{block 'contenido'}

<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>{$smarty.session.nom_dep} - {$smarty.session.nom_uni} <small></small></h2>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
            <form id="frmBoletaSIG" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">
              <div class="col-sm-3">
                <input type="radio" name="radTipoBoleta" id="tbAmbiental" value="1" data-parsley-mincheck="2" required class="flat radTipoBoletaC" checked="" /> Ambiental
                        <label>&nbsp;</label>
                <input type="radio" name="radTipoBoleta" id="tbSeguridad" value="2" class="flat radTipoBoletaC" /> Seguridad
                <br>
                <br>
                <input type="hidden" name="txtBolCorrelativo" id="txtBolCorrelativo" value="">
                <p><b id="textCorrelativo" data-correlativo="0"></b></p>
              </div>
              <div class="col-sm-6">
               {*   <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">De
                      </label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <input type="hidden" name="txtCodUniRem" id="txtCodUniRem" value="{$smarty.session.id_unidad}">
                        <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtNombreUnidRemi" id="txtNombreUnidRemi" placeholder="" value="{$smarty.session.nom_uni}" disabled="">
                      </div>
                  </div> *}
                 <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Para
                      </label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <input type="hidden" name="txtCodUniRem" id="txtCodUniRem" value="{$smarty.session.id_unidad}">
                              <select class="select-default form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Unidad - " name="selCorreIncUni" id="selCorreIncUni" required="">
                                <option value=""></option>
                                {foreach $lstunidades as $obj}
                                <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                                {/foreach}
                              </select>
                      </div>
                  </div>

              </div>
              <div class="col-sm-3">
                <p><b><span id="fecha_solicita">--</span></b></p>
              </div>
              <div class="clearfix"></div>
              <div class="col-sm-6">

                <fieldset>
                  <legend>Descripción de la observación</legend>
                  <textarea name="txtDesObserva" id="txtDesObserva" class="form-control resize-vertical textarea-auto" rows="1" required="required"></textarea>
                </fieldset>
              </div>
              <div class="col-sm-6">

                <fieldset>
                  <legend>Recomendaciones para corregir la observación</legend>
                  <textarea name="txtDesCorregir" id="txtDesCorregir" class="form-control resize-vertical textarea-auto" rows="1" required="required"></textarea>
                </fieldset>
              </div>
              <div class="col-sm-12">

                <fieldset>
                  <legend>Elaborado por</legend>
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
                    {*    <table style="margin-top:-1em;width:100%">
                        <tbody>
                          <tr>
                            <td>Nombre(s) y Apellidos</td>
                            <td style="padding-left:1em"><input type="text" name="txtNombreEla" id="txtNombreEla" class="form-control" value="" required="required"  title="Nombre del elaborador"></td>
                          </tr>
                          <tr style="">
                            <td style="padding-top:10px">Nro Ficha</td>
                            <td style="padding-left:1em;padding-top:10px"><input type="text" name="txtFichaEla" id="txtFichaEla" class="form-control"  value="" required="required" ></td>
                          <tr style="">
                            <td style="padding-top:10px">DNI</td>
                            <td style="padding-left:1em;padding-top:10px">

                                <div class="controls">

                              <input type="text" name="txtDniEla" id="txtDniEla" class="form-control" value="" required="required"  title="Ingresar el número de DNI"   pattern="{literal}(^([0-9]{8,8})|^){/literal}" minlength="8" maxlength="8" data-validation="on" data-message="Escribir solo números">
                                </div>


                            </td>
                          </tr>
                        </tbody>
                      </table> *}
                  </div>

                </fieldset>
                <fieldset>
                  <legend>Evidencia</legend>

                  <table class="table table-bordered table-hover" id="tblFicheros">
                    <thead>
                      <tr>
                        <th colspan="3">Adjuntos <span id="msgErrorUF"></span></th>
                        <th style="text-align: center;width: 55px">
                        <label for="fileupload" id="prevFileUp" class="btn btn-success btn-option-files">
                        <i class="fa fa-plus"></i>
                           <input id="fileupload" type="file" name="files[]" data-url="{$base_url}documentos/upload_docs/" multiple class="hidden" accept="jpg">
                           {* <input id="fileupload" type="file" name="files[]" data-url="{$base_url}server/php/" multiple class="hidden"> *}
                        </label>
                        {* <button id="btnAgregarFichero" type="button" class="btn btn-success btn-option-files" data-toggle="tooltip" data-placement="left" title="" data-original-title="Agregar ficheros"><i class="fa fa-plus"></i></button> *}
                        </th>
                      </tr>
                    </thead>


                    <tbody id="lstFicheros">
                    </tbody>
                  </table>

                </fieldset>
              </div>
              <div class="clearfix"></div>
              <hr>
              <div class="col-sm-12">
                <div>
                  <button type="submit" class="btn btn-success">Generar</button>
                  <button type="button" class="btn btn-danger">Cancelar</button>
                </div>

              </div>
            </form>
            </div>
        </div>
    </div>
</div>




{/block}

{block 'script'}
<!-- bootstrap-daterangepicker -->
    {* <script src="{$public_url}views/templates/gentelella/js/moment/moment.min.js"></script> *}
    {* <script src="{$public_url}views/templates/gentelella/js/datepicker/daterangepicker.js"></script> *}
       <!-- jQuery -->
    {* <script src="{$public_url}vendors/jquery/dist/jquery.min.js"></script> *}
    <!-- Bootstrap -->
    {* <script src="{$public_url}vendors/bootstrap/dist/js/bootstrap.min.js"></script> *}
    <!-- FastClick -->
    {* <script src="{$public_url}vendors/fastclick/lib/fastclick.js"></script> *}
    <!-- NProgress -->
    {* <script src="{$public_url}vendors/nprogress/nprogress.js"></script> *}
    <!-- Dropzone.js -->
    {* <script src="{$public_url}vendors/dropzone/dist/min/dropzone.min.js"></script> *}
    <script src="{$public_url}vendors/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.iframe-transport.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.fileupload.js"></script>
    <script src="{$public_url}vendors/autosize/dist/autosize.js"></script>
    <script src="{$public_url}views/boletasig/js/bol_generar.js"></script>

    <!-- Custom Theme Scripts -->
    {* <script src="../build/js/custom.min.js"></script> *}
	<script>
	$(document).ready(function(){

    $('.textarea-auto').each(function(){
            autosize(this);
    });
		$('#single_cal2').daterangepicker({
			singleDatePicker: true,
			calender_style: "picker_2"
		}, function(start, end, label){
			console.Log(start.toISOString(), end.toISOString(), label);
		});
	});
	</script>


    {/block}