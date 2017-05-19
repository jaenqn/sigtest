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
            word-wrap: break-word;
            overflow: hidden;
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
    <div class="col-md-7 col-sm-7 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Datos de Noticia</h2>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                    <form id="frmData" data-parsley-validate class="form-horizontal form-label-left" action="{$base_url}noticias/savecontent/{$objN->not_id}" method="post">
                        <input type="hidden" name="txtIdNoticia" id="txtIdNoticia" value="{$objN->not_id}">
                        <input type="hidden" name="tiposave" id="tiposave" value="1">
                        <div class="form-group">
                            <label class="control-label col-md-2 col-sm-2 col-xs-12" for="txtTituloNot">Título</label>
                            <div class="col-md-7 col-sm-7 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtTituloNot" id="txtTituloNot" placeholder="Escriba título de noticia" value="{$objN->not_titulo}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2 col-sm-2 col-xs-12" for="txtAutorNot">Autor</label>
                            <div class="col-md-7 col-sm-7 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtAutorNot" id="txtAutorNot" placeholder="Escriba nombre de autor" value="{$objN->not_autor}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2 col-sm-2 col-xs-12" for="txtAutorNot">Descripción portada</label>
                            <div class="col-md-10 col-sm-10 col-xs-12">
                                <textarea name="txtIntroPortada" id="input" class="form-control resize-vertical" rows="4" required="required">{$objN->not_intro}</textarea>
                              {* <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtAutorNot" id="txtAutorNot" placeholder="Escriba nombre de autor"> *}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2 col-sm-2 col-xs-12" for="">&nbsp;</label>
                            <div class="col-md-10 col-sm-10 col-xs-12">
                                <button type="submit" class="btn btn-primary">Actualizar</button>
                                <a href="{$base_url}home/noticia/{$objN->not_id}" target="_blank" class="btn btn-primary">Ver</a>
                              {* <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtAutorNot" id="txtAutorNot" placeholder="Escriba nombre de autor"> *}
                            </div>
                        </div>




{*
                        <div class="form-group">
                            <div class="col-sm-12">
                                  <textarea cols="100" id="ckeditor" name="editor1" rows="10" class="col-sm-12">&lt;p&gt;This is some &lt;strong&gt;sample text&lt;/strong&gt;. You are using &lt;a href="http://ckeditor.com/"&gt;CKEditor&lt;/a&gt;.&lt;/p&gt;</textarea>

                            </div>
                        </div> *}
                    {* </form> *}

            </div>
        </div>
    </div>
    <div class="col-md-5 col-sm-5 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Adjuntos</h2>

                <ul class="nav navbar-right panel_toolbox">
                    <li><a  class="btn btn-primary "><label  for="fileupload" class="btn-option-files" style="font-weight:100">Agregar</label></a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content mCustomScrollbar" style="height:300px" >
                                        <table class="table table-bordered table-hover " id="tblFicheros"  >



                                          <tbody id="lstFicheros">
                                       {*    <tr>
                                            <td style="width: 40px;vertical-align:middle" class="icon-files"><img src="http://127.0.0.1:8888/public/app/img/iconos/image.png" title="Imagen"></td>
                                            <td colspan="2"><span style="word-break: break-all;line-height:0px">15937036_190930941382592_2723334152750813540_o.jpg</span></td>

                                            <td style="width: 140px;text-aling:center;vertical-align:middle;">

                                              <button type="button" class="btn btn-default  btn-option-files loading" title="Eliminar"><span class="fa fa-minus-circle"></span></button>
                                              <button type="button" class="btn btn-default  btn-option-files loading" title="Eliminar"><span class="fa fa-circle"></span></button><button type="button" class="btn btn-default  btn-option-files loading" title="Eliminar"><span class="glyphicon glyphicon-copy"></span></button>
                                            </td>
                                          </tr>
                                          <tr>

                                            <td style="padding:0px;vertical-align:middle" colspan="4"><div class="progress" style="margin-top: auto;margin-bottom: auto;">
                                                            <div class="progress-bar progress-bar-striped active" data-transitiongoal="10"></div>
                                                </div>
                                            </td>
                                          </tr> *}
                                          {foreach $objN->lstFicheros as $obj}
                                            <tr>
                                              <td style="width: 40px;vertical-align:middle" class="icon-files"><img src="{$public_url}app/img/iconos/{$obj->ico_img[1]}" title="{$obj->ico_img[2]}"></img></td>
                                              <td colspan="2"><span style="word-break: break-all;line-height:0px"><a href="{$base_url}docs/_noticias/{$objN->not_id}/{$obj->dno_nombre_fichero}" class="ver_file" target="_blank">{$obj->dno_nombre_fichero}</a></span></td>

                                              <td style="width: 140px;text-aling:center;vertical-align:middle">
                                                  <button type="button" class="btn btn-default  btn-option-files copy" title="Copiar Url"    data-id-fichero="{$obj->dno_id}" data-clipboard-text="{$base_url}docs/_noticias/{$objN->not_id}/{$obj->dno_nombre_fichero}"><span class="fa fa-link"></span></button>
                                                  <button type="button" class="btn btn-default  btn-option-files {if $obj->ico_img[2] != 'Imagen'}ttt{else}portada{/if} ini" title="Seleccionar como portada"   data-id-fichero="{$obj->dno_id}" {if $obj->ico_img[2] != 'Imagen'}disabled=""{/if}><span class="fa {if $obj->dno_portada == 1}fa-circle{else}{if $obj->ico_img[2] != 'Imagen'}fa-minus-circle{else}fa-circle-o{/if}{/if}" ></span></button>
                                                  <button type="button" class="btn btn-default  btn-option-files loading" title="Eliminar"  data-id-fichero="{$obj->dno_id}" ><span class="fa fa-trash"></span></button>
                                              </td>

                                          </tr>
                                          {/foreach}

                                          </tbody>
                                        </table>


            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Contenido Noticia</h2>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                    {* <form id="frmHTML" data-parsley-validate class="form-horizontal form-label-left" action="{$base_url}noticias/savecontent/{$objN->not_id}" method="post"> *}
                    <input type="hidden" name="txtIdNoticia" id="txtIdNoticia" value="{$objN->not_id}">
                    <input type="hidden" name="tiposave" id="tiposave" value="2">






                        <div class="form-group">
                            <div class="col-sm-12 contieneeditor">
                                  <textarea cols="100" id="ckeditores" name="editor1" rows="10" class="col-sm-12">{$objN->not_contenido}</textarea>

                            </div>
                        </div>
                    </form>
                     <form action="">
                      <input id="fileupload" type="file" name="files[]"  multiple class="hidden">
                    </form>
            </div>
        </div>
    </div>
</div>
{/block}
{block 'script'}
    {* <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script> *}

    <script src="{$public_url}vendors/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.iframe-transport.js"></script>
    <script src="{$public_url}vendors/jquery-upload/js/jquery.fileupload.js"></script>

    <script src="{$public_url}vendors/clipboard/dist/clipboard.min.js"></script>
  <!-- ckeditor -->
    <script src="{$public_url}vendors/ckeditor/ckeditor.js"></script>
    <script src="{$public_url}vendors/ckeditor/adapters/jquery.js"></script>
    <script src="{$public_url}views/gestor/js/ges_noticias_editar.js"></script>

{/block}