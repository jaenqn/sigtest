{extends $_template}
{block 'ref_urls'}
            <li class="active">Carpetas</li>
{/block}
{block 'css'}

  <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
  <link href="{$public_url}views/carpetas/css/carpetas.css" rel="stylesheet">
{/block}
{block 'contenido'}

<div class="row">


    <div class="col-sm-12 col-xs-12">

                <div class="x_panel">


                  <div class="x_content">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-4 col-xs-12">
                                <select id="selTipoCarpeta" class="form-control select-minimum" style="width: 100%" data-placeholder="- Seleccione Tipo Carpeta ">
                                  <option value="">&nbsp;</option>
                                  <option value="1" selected>General</option>
                                  <option value="2">Específico - Departamento</option>
                                  <option value="3">Específico - Unidad</option>
                                </select>
                            </div>
                            <div class="col-sm-4 col-xs-12">
                                <select id="selDepartamento" class="form-control select-minimum" style="width: 100%" data-placeholder="- Seleccione Departamento -" disabled>
                              <option value="">&nbsp;</option>


                            </select>
                            </div>
                            <div class="col-sm-4 col-xs-12">
                                <select id="selUnidad" class="form-control select-minimum" style="width: 100%" data-placeholder="- Seleccione Unidad -" disabled>
                              <option value="">&nbsp;</option>
                              <option value="United States">United States</option>
                              <option value="United Kingdom">United Kingdom</option>
                              <option value="Japan">Japan</option>

                            </select>
                            </div>
                          </div>
                    </div>
                    <hr>


                    <div class="row">

                            <div class="col-sm-3 col-xs-12 col-lg-2">
                                  <button type="button" class="btn btn-default col-lg-5" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta" id="btnNuevaCarpeta"><span class="fa fa-folder"></span></button>
                                  <button type="button" class="btn btn-default col-lg-5" data-toggle="tooltip" data-placement="top" title="" data-original-title="Subir Archivos" id="btnSubirArchivo" disabled=""><span class="fa fa-cloud-upload"></span></button>
                                  <label for="fileupload" id="prevFileUp">
                                     <input id="fileupload" type="file" name="files[]" data-url="{$base_url}documentos/upload_docs/" multiple class="hidden">
                                     {* <input id="fileupload" type="file" name="files[]" data-url="{$base_url}server/php/" multiple class="hidden"> *}
                                  </label>


                                </div>
                                  <div class="col-sm-9">
                              {*       <button type="button" class="btn ">button</button>
                                    <button type="button" class="btn ">button</button> *}
                                    <ol class="breadcrumb breadcrumb-quirk" id="rutaCarpetas">
                                      <li>
                                        <a href="{$base_url}carpeta" id="btnRaiz"><i class="fa fa-folder-open-o mr5" ></i> raiz</a>
                                      </li>

                                      {if isset($lstRutaCarpetas)}
                                        {foreach $lstRutaCarpetas as $obj}
                                          <li class="active"><a href="{$base_url}carpetas/f/{$obj->idCarpeta}">{$obj->desCarpeta}</a></li>
                                        {/foreach}

                                      {/if}
                                      {* <li class="active">Carpetas</li>
                                      <li class="active">Carpetas</li>
                                      <li class="active">Carpetas</li>
                                      <li class="active">Carpetas</li> *}

                                    </ol>
                                  </div>
                    </div>
                    <hr>
                    <div class="col-sm-12" id="lstDocumentosSubida" style="margin-top:-1em">
                      <button id="btnLimpiarSubidas" type="button" class="btn btn-success hidden" style="float:right">Limpiar</button>
                      <div class="clearfix "></div>
                 {*      <div class="newload">
                        <div class="col-sm-6 tituloDocumento"><span>FORMATO 01305 (PETROPERÚ) INFORME PRELIMINAR DE ACCIDENTE DE TRÁNSITO asdasdasd asd</span></div>
                        <div class="col-sm-6">
                          <div class="progress">
                            <div class="progress-bar progress-bar-success" data-transitiongoal="55"></div>
                          </div>
                        </div>
                      </div>

                      <div class="newload2">
                        <div class="col-sm-6 tituloDocumento"><span>FORMATO 01305 (PETROPERÚ) INFORME PRELIMINAR DE ACCIDENTE DE TRÁNSITO asdasdasd asd</span></div>
                        <div class="col-sm-6">
                          <div class="progress">
                            <div class="progress-bar progress-bar-success" data-transitiongoal="55"></div>
                          </div>
                        </div>
                      </div> *}
                     </div>
                    <div class="clearfix " id="clearFixPreTable"></div>
                    <div class="clearfix"></div>
                    <div id="modalTabla">
                      <!-- Lista de modales para las carpetas que se encuentran en la tabla 'tblArchivos' -->

                    </div>


                    <div class="table-responsive">

                      <table class="table" id="tblArchivos">
                        <thead>
                          <tr class="headings">
                            <th class="column-title" >&nbsp; </th>
                            <th class="column-title">Nombre </th>
                            <th class="column-title">Categoría </th>
                            <th class="column-title">Estado </th>
                            <th class="column-title"  >Acciones</th>
                            {* <th class="column-title"  style="width: 20px">&nbsp; </th> *}
                          </tr>
                        </thead>

                        <tbody >
                        {*   {foreach $lstCarpetas as $objC}
                            <tr class="even pointer">
                            {if $objC->TipoFichero == 2}
                              <td><span class="fa {$objC->FaIcono}"></span></td>
                            {else}
                              <td><span class="fa fa-folder-o"></span></td>
                            {/if}

                              <td class="obj-target" data-tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"><p>{$objC->NombreFichero} - {$objC->Descripcion}</p></td>
                              <td class="last">
                                 <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button>
                                <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="Configuración" data-original-title="Configuración" data-tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}"><span class="fa fa-gear"></span></button>
                                 <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button>
                              </td>
                            </tr>

                          {/foreach} *}

                        </tbody>
                      </table>

                    </div>

                  </div>
                </div>
    </div>
    {* <div class="col-sm6">dad</div> *}
</div>

<div>
  <div class="modal fade bs-example-modal-sm modalConfCarpeta" id="modalConfCarpeta-create" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">

              <h4 class="modal-title" id="myModalLabel2">CREAR CARPETA</h4>
            </div>
            <div class="modal-body">
              <form class="form-horizontal form-label-left frmDetallesCarpeta" role="form" id="frmCrearCarpeta">
                <input type="hidden" name="txtIdCarpeta" value="" id="txtIdCarpeta">
                  <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Título</label>
                    <div class="col-md-9 col-sm-9 col-xs-12">
                      <input class="form-control" id="txtTitulo" name="txtTitulo" placeholder="Escriba el título" type="text" value="">
                      <span id="msgErrorCarpeta" class="hidden">* Ya existe este nombre de carpeta</span>
                    </div>
                  </div>
                  <div class="form-group" id="frmGroupCategoria">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Categoría</label>
                    <div class="col-md-9 col-sm-9 col-xs-12">
                        <select id="selCategoria" name="selCategoria" class="form-control selCategoria select-minimum" style="width: 100%" data-placeholder="- Seleccione Categoría -" >
                            <option value="">&nbsp;</option>
                            <option value="1">Ninguna</option>
                            {foreach $lstCategorias as $objCate}
                              <option value="{$objCate->idArchivo}">{$objCate->nomArchivo}</option>
                            {/foreach}
                          </select>
                    </div>
                  </div>
                  <div class="form-group hidden" id="frmGroupUnidad" >
                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selUnidadFrm">Unidad</label>
                    <div class="col-md-9 col-sm-9 col-xs-12">
                        <select id="selUnidadFrm" name="selUnidadFrm" class="form-control selUnidadFrm select-minimum" style="width: 100%" data-placeholder="- Seleccione Unidad -" >
                            <option value="">&nbsp;</option>
                          </select>
                    </div>
                  </div>
                          <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Visible</label>
                            <div class="col-md-9 col-sm-9 col-xs-12" style="padding-top:5px">
                              <div class="">
                                <label>
                                  <input type="checkbox" name="txtVisible" class="flat" id="txtVisible"  /> <span class="txtVisibleEstado" style="padding-top:5px"></span>
                                </label>
                              </div>

                            </div>
                          </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default btnCancelar" data-dismiss="modal" data-id-carpeta = "">Cancelar</button>
              <button type="button" class="btn btn-primary btnGuardar" data-id-carpeta = "" id="btnCrearCarpeta" data-accion="guardar">Crear</button>
            </div>

          </div>
        </div>
      </div>
</div>
<div>
  <div class="modal fade bs-example-modal-sm modalConfDocumento" id="modalConfDocumento" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">

              <h4 class="modal-title" id="myModalLabel2">DOCUMENTO</h4>
            </div>
            <div class="modal-body">
              <form enctype="multipart/form-data" action="" method="POST" class="form-horizontal form-label-left frmDetallesCarpeta" role="form" id="frmRefDocs">
                <input type="hidden" name="txtIdDocumento" value="">
                  <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Descripción</label>
                    <div class="col-md-9 col-sm-9 col-xs-12">
                      <input class="form-control" id="txtTituloDoc" name="txtTituloDoc" placeholder="Descripción del documento" type="text" value="">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Versión</label>
                    <div class="col-md-9 col-sm-9 col-xs-12">
                      <input class="form-control" id="txtVerDoc" name="txtVerDoc" placeholder="Versión" type="number" value="" step="any" min="0">
                    </div>
                  </div>

                  <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selAspectoAmbientalF">Fecha de Aprobación</label>
                      <div class="controls">
                        <div class="col-md-9 xdisplay_inputx form-group has-feedback">
                          <input type="text" class="form-control has-feedback-left" id="txtAprobacionDoc" placeholder="" aria-describedby="inputSuccess2Status2" name="txtAprobacionDoc">
                          <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                          <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                        </div>
                      </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Visible</label>
                    <div class="col-md-9 col-sm-9 col-xs-12" style="padding-top:5px">
              {*         <div class=""> *}
                        <label>
                          <input type="checkbox" name="txtVisibleDoc" class="flat" id="txtVisibleDoc"  /> <span class="txtVisibleEstadoDoc" style="padding-top:5px"></span>
                        </label>
                     {*  </div> *}

                    </div>
                  </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default btnCancelar" data-dismiss="modal" data-id-carpeta = "">Cancelar</button>
              <button type="button" class="btn btn-primary btnGuardar" data-id-carpeta = "" id="btnActualizarCarpeta" data-accion="guardar">Actualizar</button>
            </div>

          </div>
        </div>
      </div>
</div>


{/block}



{block 'script'}
  <script>
      var DATAFILES = {$data_carpeta};
      var CATEGORIAS_CARPETA = {$lstCategoriasJSON}
  </script>
  <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
  <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
  <script src="{$public_url}vendors/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
  <script src="{$public_url}vendors/jquery-upload/js/jquery.iframe-transport.js"></script>
  <script src="{$public_url}vendors/jquery-upload/js/jquery.fileupload.js"></script>

{* <script src="{$public_url}views/carpetas/js/carpetas.js"></script> *}
<script src="{$public_url}views/carpetas/js/new-carpetas.js"></script>
{/block}