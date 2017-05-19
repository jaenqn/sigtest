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
  }thead > tr > th:nth-child(1) {
    border-right:none;
  }
tbody  tr > td:nth-child(1){
    border-right:none;
  }tbody  tr > td:nth-child(2){
    border-right:none;
    border-left:none;
  }tbody  tr > td:nth-child(3){
    border-right:none;
    border-left:none;
    width:40%;

  }tbody  tr > td:nth-child(4){
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
                <h2>{$objBoleta->nom_area} - {$objBoleta->nom_unidad} <small></small></h2>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
            <form id="frmBoletaSIG" data-parsley-validate class="col-sm-12 form-horizontal form-label-right">
              <input type="hidden" name="txtId" id="txtId" value="{$objBoleta->bol_id}">
              <div class="col-sm-3">
                <input type="radio" name="radTipoBoleta" id="tbAmbiental" value="1" data-parsley-mincheck="2" required class="flat radTipoBoletaC" {if $objBoleta->bol_tipo == 1} checked="" {/if}/> Ambiental
                        <label>&nbsp;</label>
                <input type="radio" name="radTipoBoleta" id="tbSeguridad" value="2" class="flat radTipoBoletaC" {if $objBoleta->bol_tipo == 2} checked="" {/if} /> Seguridad
                <br>
                <br>
                <input type="hidden" name="txtBolCorrelativo" id="txtBolCorrelativo" value="">
                <p><b id="textCorrelativo">{$objBoleta->bol_correlativo}</b></p>
              </div>
              <div class="col-sm-6">
                 <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Para
                      </label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                              <select class="select-default form-control input-filter" style="width:100%" tabindex="-1" data-placeholder=" - Unidad - " name="selCorreIncUni" id="selCorreIncUni" required="" disabled="">
                                <option value=""></option>
                                {foreach $lstunidades as $obj}
                                <option value="{$obj->idDepend}" {if $objBoleta->bol_uni_receptor == $obj->idDepend} selected="" {/if}>{$obj->desDepend}</option>

                                {/foreach}
                              </select>
                      </div>
                  </div>

              </div>

              <div class="col-sm-3">
                <p><b><span id="fecha_solicita"></span></b></p>
              </div>
              <div class="clearfix"></div>
              <div class="col-sm-6">

                <fieldset>
                  <legend>Descripción de la observación</legend>
                  <textarea name="txtDesObserva" id="txtDesObserva" class="form-control  resize-vertical textarea-auto" rows="1" required="required">{$objBoleta->bol_observacion}</textarea>
                </fieldset>
              </div>
              <div class="col-sm-6">

                <fieldset>
                  <legend>Recomendaciones para corregir la observación</legend>
                  <textarea name="txtDesCorregir" id="txtDesCorregir" class="form-control  resize-vertical textarea-auto" rows="1" required="required">{$objBoleta->bol_corregir}</textarea>
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
                    </fieldset>
                  </div>
              </div>
                  <div class="clearfix"></div>
          {if count($objBoleta->ficheros_evidencia)>0}
              <div class="col-sm-12">
                <fieldset>
                  <legend>Archivos adjuntos</legend>
                  {* <div class="col-sm-12">
                    <button style="float: right" type="button" class="btn btn-success"><i class="fa fa-plus"></i></button>
                    <div class="clearfix"></div>
                  </div> *}


                    <table class="table table-bordered table-hover" id="tblFicheros">
                      <thead>
                        <tr>
                          <th colspan="2">Evidencia</th>
                          <th>{* <button  type="button" class="btn btn-success btn-option-files" data-toggle="tooltip" data-placement="left" title="" data-original-title="Agregar ficheros"><i class="fa fa-plus"></i></button> *}</th>
                        </tr>
                      </thead>
                      <tbody>
                      {foreach $objBoleta->ficheros_evidencia as $files}
                        <tr>
                            <td style="width: 40px" class="icon-files"><img src="{$public_url}app/img/iconos/{$files->ico_img[1]}" title="{$files->ico_img[2]}"></img></td>
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
              {/if}
              <div class="clearfix"></div>
              <hr>
              {if $objBoleta->bol_rechazado != 1}

              <div class="col-sm-12">
                <div>
                  <button type="submit" class="btn btn-success">Aprobar</button>
                  <button type="button" class="btn btn-danger" id="btnRechazar">Rechazar</button>
                </div>

              </div>
              {/if}
            </form>
            </div>
        </div>
    </div>
</div>




{/block}

{block 'script'}
<script type="text/javascript">
  var boleta_data = {
    fecha_generado : '{$objBoleta->bol_fecha_generado}',
    rechazado : {if $objBoleta->bol_rechazado != 1}false{else}true{/if}
  }
</script>
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
    <script src="{$public_url}vendors/autosize/dist/autosize.js"></script>
    <script src="{$public_url}views/boletasig/js/bol_aprobar.js"></script>

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