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
         ul.showfiles >li{
        border:0px;
      }
      #lstseguimiento > li>.block>.block_content hr{
          margin-top:0.5em;
          margin-bottom:0.5em;

      }
      #lstseguimiento > li>.block>.block_content hr:nth-last-child(1){
          display:none;
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
                  {if count($objBoleta->seguimiento) > 0}
                  <!--##SEGUIMIENTO-->
                    <li role="presentation" class=""><a href="#tab_content72" role="tab" id="seguimiento-tabb" data-toggle="tab" aria-controls="seguimiento" aria-expanded="false">Seguimiento</a>
                    </li>
                  {/if}
                  <li role="presentation" class="active"><a href="#tab_content33" role="tab" id="profile-tabb3" data-toggle="tab" aria-controls="profile" aria-expanded="false">Fiscalizar Boleta</a>
                  </li>
                </ul>
                <div id="myTabContent2" class="tab-content">
                  <!--##DETALLES-->
                  <div role="tabpanel" class="tab-pane fade  " id="tab_content11" aria-labelledby="home-tab">
                    {include file='../boletasig/respuesta/br_detalles.tpl'}
                  </div>
                  <!--##RESPUESTAS-->
                  <div role="tabpanel" class="tab-pane fade " id="tab_content22" aria-labelledby="profile-tab">
                    {include file='../boletasig/respuesta/br_respuesta.tpl'}
                  </div>

                    {if count($objBoleta->seguimiento) > 0}
                    <!--##SEGUIIMIENTO-->
                    <div role="tabpanel" class="tab-pane fade " id="tab_content72" aria-labelledby="seguimiento-tab">
                      {include file='../boletasig/respuesta/br_seguimiento.tpl'}
                    </div>
                    {/if}


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
                      <hr>

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
    <script src="{$public_url}vendors/autosize/dist/autosize.js"></script>


    <script>
    $(document).ready(function(){
      $('.textarea-auto').each(function(){
              autosize(this);
      });

      let targetnow = moment();
      $('span.txt-fecha').each(function(e,v){
          let tempdate = moment(this.dataset.fecha);
          if(targetnow.format('D/M/Y') == tempdate.format('D/M/Y'))
              $(v).text(tempdate.fromNow());
          else $(v).text(moment(this.dataset.fecha).format('HH:mm'));
      });
    });
  </script>
  <script src="{$public_url}views/boletasig/js/bol_fiscalizar.js"></script>
{/block}