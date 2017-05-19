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
      .tblFicherosX thead > tr > th:nth-child(2) {
        border-left:none;
      }
      .tblFicherosX thead > tr > th:nth-child(1) {
        border-right:none;
      }

      .tblFicherosX tbody  tr > td:nth-child(1){
        border-right:none;
      }
      .tblFicherosX tbody  tr > td:nth-child(2){
        border-right:none;
        border-left:none;
      }
      .tblFicherosX tbody  tr > td:nth-child(3){
        border-right:none;
        border-left:none;
        width:40%;

      }
      .tblFicherosX tbody  tr > td:nth-child(4){
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
        .daterangepicker.dropdown-menu.ltr.show-calendar.opensright .ranges, .daterangepicker.dropdown-menu.ltr.show-calendar.opensright .daterangepicker_input{
            display: none
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
                  <li role="presentation" class=""><a href="#tab_content11" id="home-tabb" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="false">Detalles Boleta Generada</a>
                  </li>
                  {if AppSession::get('id_unidad') == $objBoleta->bol_uni_receptor}
                  <li role="presentation" class="{if $responde}active{/if}"><a href="#tab_content22" role="tab" id="profile-tabb" data-toggle="tab" aria-controls="profile" aria-expanded="false">Respuesta Boleta</a>
                  </li>
                  {if $objBoleta->bol_plazo_establecido == 1}
                    <li role="presentation" class="{if $seguimiento}active{/if}"><a href="#tab_seguimiento" id="seguimiento-tabb" role="tab" data-toggle="tab" aria-controls="seguimiento" aria-expanded="false">Seguimiento</a>
                    </li>
                  {/if}
                  {/if}
                </ul>

                <div id="myTabContent2" class="tab-content">
                  <!--##DETALLES-->
                  <div role="tabpanel" class="tab-pane fade " id="tab_content11" aria-labelledby="home-tab">
                    {include file='../boletasig/respuesta/br_detalles.tpl'}
                  </div>
                  {if AppSession::get('id_unidad') == $objBoleta->bol_uni_receptor}
                  <!--##RESPUESTA-->
                  <div role="tabpanel" class="tab-pane fade {if $responde}active in{/if}" id="tab_content22" aria-labelledby="profile-tab">
                    {include file='../boletasig/respuesta/br_respuesta.tpl'}
                  </div>
                   <!--##SEGUIMIENTO-->
                  {if $objBoleta->bol_plazo_establecido == 1}
                    <div role="tabpanel" class="tab-pane fade {if $seguimiento}active in{/if} " id="tab_seguimiento" aria-labelledby="seguiminto-tabb">
                      {include file='../boletasig/respuesta/br_seguimiento.tpl'}
                    </div>
                  {/if}
                  {/if}
                </div>
              </div>
            </div>
        </div>
    </div>
</div>
<div id="contFecha"></div>
{/block}
{block 'script'}
    <script src="{$public_url}vendors/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.iframe-transport.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.fileupload.js"></script>
    <script src="{$public_url}vendors/autosize/dist/autosize.js"></script>
      <script>
    $(document).ready(function(){

      $('.textarea-auto').each(function(){
              autosize(this);
      });
      $('.txtfechas-datapicker').daterangepicker({
          autoUpdateInput: false,
          singleDatePicker : false,
          timePicker: false,
          autoApply:true,
          locale: {
            format: 'DD/MM/YYYY',

          },
          minDate : moment()


      }).on('apply.daterangepicker', function(ev, picker) {
          $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
      }).on('cancel.daterangepicker', function(ev, picker) {
          $(this).val('');
      });
    });
  </script>
  {if $responde}
    <script src="{$public_url}views/boletasig/js/bol_respuesta.js"></script>
  {/if}
  {if $seguimiento}
    <script src="{$public_url}views/boletasig/js/bol_seguimiento.js"></script>
  {/if}

{/block}