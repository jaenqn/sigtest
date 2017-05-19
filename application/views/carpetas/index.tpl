{extends $_template}
{block 'ref_urls'}
            <li class="active">Carpetas</li>
{/block}
{block 'css'}
  <link href="{$public_url}views/carpetas/css/carpetas.css" rel="stylesheet">
{/block}
{block 'contenido'}

<div class="row">


    <div class="col-sm-8 col-xs-12">

                <div class="x_panel">
                  <div class="x_title">
                    <h2>Crear Carpeta</h2>
                    {* <ul class="nav navbar-left panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                    </ul> *}
                    <div class="clearfix"></div>
                  </div>

                  <div class="x_content">

                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-4 col-xs-12">
                                <select id="selTipoCarpeta" class="form-control " style="width: 100%" data-placeholder="- Seleccione Tipo Carpeta ">
                                  <option value="">&nbsp;</option>
                                  <option value="1" selected>General</option>
                                  <option value="2">Específico - Departamento</option>
                                  <option value="3">Específico - Unidad</option>
                                </select>
                            </div>
                            <div class="col-sm-4 col-xs-12">
                                <select id="selDepartamento" class="form-control " style="width: 100%" data-placeholder="- Seleccione Departamento -" disabled>
                              <option value="">&nbsp;</option>


                            </select>
                            </div>
                            <div class="col-sm-4 col-xs-12">
                                <select id="selUnidad" class="form-control " style="width: 100%" data-placeholder="- Seleccione Unidad -" disabled>
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
                                  <button type="button" class="btn btn-default col-lg-5" data-toggle="tooltip" data-placement="top" title="" data-original-title="Subir Archivos" id="btnSubirArchivo"><span class="fa fa-cloud-upload"></span></button>

                                </div>
                                  <div class="col-sm-9">
                              {*       <button type="button" class="btn ">button</button>
                                    <button type="button" class="btn ">button</button> *}
                                    <ol class="breadcrumb breadcrumb-quirk" id="rutaCarpetas">
                                      <li>
                                        <a href="{$base_url}carpetas"><i class="fa fa-folder-open-o mr5"></i> raiz</a>
                                      </li>
                                      {if isset($lstRutaCarpetas)}
                                        {foreach $lstRutaCarpetas as $obj}
                                          <li class="active"><a href="{$base_url}carpetas/f/{$obj->idCarpeta}">{$obj->desCarpeta}</a></li>
                                        {/foreach}

                                      {else}
                                        <li class="active">&nbsp;</li>
                                      {/if}
                                      {* <li class="active">Carpetas</li>
                                      <li class="active">Carpetas</li>
                                      <li class="active">Carpetas</li>
                                      <li class="active">Carpetas</li> *}

                                    </ol>
                                  </div>
                    </div>
                    <hr>
                    <div>
                          <div class="modal fade bs-example-modal-sm modalConfCarpeta" id="modalConfCarpeta-create" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog">
                              <div class="modal-content">
                                <div class="modal-header">

                                  <h4 class="modal-title" id="myModalLabel2">CREAR CARPETA</h4>
                                </div>
                                <div class="modal-body">
                                  <form enctype="multipart/form-data" action="" method="POST" class="form-horizontal form-label-left frmDetallesCarpeta" role="form" id="frmCrearCarpeta">
                                    <input type="hidden" name="txtIdCarpeta" value="">
                                      <div class="form-group">
                                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Título</label>
                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                          <input class="form-control" id="txtTitulo" name="txtTitulo" placeholder="Escriba el título" type="text" value="">
                                        </div>
                                      </div>
                                      <div class="form-group">
                                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Categoría</label>
                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                            <select id="selCategoria-" name="selCategoria" class="form-control selCategoria" style="width: 100%" data-placeholder="- Seleccione Categoría -" >
                                                <option value="">&nbsp;</option>
                                                {foreach $lstCategorias as $objCate}
                                                  <option value="{$objCate->idArchivo}">{$objCate->nomArchivo}</option>
                                                {/foreach}
                                              </select>
                                        </div>
                                      </div>
                                              <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Visible</label>
                                                <div class="col-md-9 col-sm-9 col-xs-12" style="padding-top:5px">
                                                  <div class="">
                                                    <label>
                                                      <input type="checkbox" name="txtVisible" class="js-switch txtVisible" id=""  /> <span class="txtVisibleEstado" style="padding-top:5px"></span>
                                                    </label>
                                                  </div>

                                                </div>
                                              </div>
                                  </form>
                                </div>
                                <div class="modal-footer">
                                  <button type="button" class="btn btn-default btnCancelar" data-dismiss="modal" data-id-carpeta = "">Cancelar</button>
                                  <button type="button" class="btn btn-primary btnGuardar" data-id-carpeta = "">Crear</button>
                                </div>

                              </div>
                            </div>
                          </div>
                    </div>
                    <div id="modalTabla">
                      <!-- Lista de modales para las carpetas que se encuentran en la tabla 'tblArchivos' -->

                    </div>


                            <div class="table-responsive">

                      <table class="table table-striped jambo_table bulk_action" id="tblArchivos">
                        <thead>
                          <tr class="headings">
                            <th class="column-title" colspan="2">Nombre </th>
                            <th class="column-title" style="">&nbsp; </th>
                          </tr>
                        </thead>

                        <tbody id="tablArchivos">
                          {foreach $lstCarpetas as $objC}
                            <tr class="even pointer">
                            {if $objC->TipoFichero == 2}
                              <td><span class="fa {$objC->FaIcono}"></span></td>
                            {else}
                              <td><span class="fa fa-folder-o"></span></td>
                            {/if}

                              <td class="obj-target" data-tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}" data-id-dependencia="1"><p>{$objC->NombreFichero} - {$objC->Descripcion}</p></td>
                              <td class="last">
                                {* <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button> *}
                                <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="Configuración" data-original-title="Configuración" data-tipo-archivo="{$objC->TipoFichero}" data-id-archivo="{$objC->IdFichero}"><span class="fa fa-gear"></span></button>
                                {* <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button> *}
                              </td>
                            </tr>

                          {/foreach}

                        </tbody>
                      </table>
                        {literal}
                        <script id="tpltablaArchivosDocumentos" type="text/x-handlebars-template">
                            <tr class="even pointer">
                              <td class="obj-target" data-tipo-archivo="1" data-id-archivo="22" data-id-dependencia="1"><p>{{nombreDoc}}</p></td>
                              <td class="last">
                              <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button>
                              <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-gear"></span></button>
                              <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button></td>
                            </tr>
                        </script>
                          <div id="tpltablaArchivosCarpeta" class="hidden">
                            <tr class="even pointer">
                              <td class="obj-target" data-tipo-archivo="1" data-id-archivo="22" data-id-dependencia="1">test</td>
                              <td class="last"><button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button>
                              <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button>
                              <button type="button" class="btn btn-default btn-option-files" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nueva Carpeta"><span class="fa fa-folder"></span></button></td>
                            </tr>
                          </div>
                          {/literal}
                    </div>

                  </div>
                </div>
    </div>
    {* <div class="col-sm6">dad</div> *}
</div>
{literal}
<script id="tplModalCarpetas" type="text/x-handlebars-template">
      <div class="modal fade bs-example-modal-sm modalConfCarpeta" id="modalConfCarpeta-{{idCarpeta}}" tabindex="-1" role="dialog" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">

                <h4 class="modal-title" id="myModalLabel2">CARPETA</h4>
              </div>
              <div class="modal-body">
                <form enctype="multipart/form-data" action="" method="POST" class="form-horizontal form-label-left frmDetallesCarpeta" role="form" id="frmDetallesCarpeta">
                  <input type="hidden" name="txtIdCarpeta" value="{{idCarpeta}}">
                    <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12">Título</label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <input class="form-control" id="txtTitulo" name="txtTitulo" placeholder="Escriba el título" type="text" value="{{descripcionCarpeta}}">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12">Categoría</label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                          <select id="selCategoria-{{idCarpeta}}" name="selCategoria" class="form-control selCategoria" style="width: 100%" data-placeholder="- Seleccione Categoría -" >
                              <option value="">&nbsp;</option>
                              {/literal}
                              {foreach $lstCategorias as $objCate}
                                <option value="{$objCate->idArchivo}">{$objCate->nomArchivo}</option>
                              {/foreach}
                              {literal}

                            </select>
                      </div>
                    </div>
                            <div class="form-group">
                              <label class="control-label col-md-3 col-sm-3 col-xs-12">Visible</label>
                              <div class="col-md-9 col-sm-9 col-xs-12" style="padding-top:5px">
                                <div class="">
                                  <label>
                                    <input type="checkbox" name="txtVisible" class="js-switch txtVisible" id="" {{checked}} /> <span class="txtVisibleEstado" style="padding-top:5px">{{checkedLabel}}</span>
                                  </label>
                                </div>

                              </div>
                            </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default btnCancelar" data-dismiss="modal" data-id-carpeta = "{{idCarpeta}}">Cancelar</button>
                <button type="button" class="btn btn-primary btnGuardar" data-id-carpeta = "{{idCarpeta}}">Guardar</button>
              </div>

            </div>
          </div>
      </div>
</script>
{/literal}

{/block}
{block 'script'}
<script src="{$public_url}views/carpetas/js/carpetas.js"></script>
{/block}