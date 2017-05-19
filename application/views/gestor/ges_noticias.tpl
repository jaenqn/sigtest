{extends $_template}
{block 'css'}
 <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
{*     <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
<style type="text/css">
    .td-middle{
        text-align: center;
    }
</style>
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
<div class="row">
    <div class="col-md-10 col-sm-10 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Filtrar Lista de Noticias<small>&nbsp;</small></h2>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtTituloNot">Título</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtTituloNot" id="txtTituloNot" placeholder="Buscar por  título">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtAutorNot">Autor</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                              <input  class="form-control col-md-7 col-xs-12 input-filter" type="text" name="txtAutorNot" id="txtAutorNot" placeholder="Buscar por autor">
                            </div>
                        </div>


                        <div class="form-group">

                            <div class="control-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtFechaNot">Fecha</label>
                                <div class="controls">
                                  <div class="col-md-6 col-sm-6 col-xs-12 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left txtFechas" id="txtFechaNot" placeholder="Fecha  de publicación" aria-describedby="inputSuccess2Status2">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>

                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="radEstadoNot">Estado</label>
                            <div class="col-md-9 col-sm-9 col-xs-12">
                                <div class="radio">
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="1" name="radEstadoNot" > Visible
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="2" name="radEstadoNot" > Oculto
                                    </label>
                                    <label>
                                        <input type="radio" class="flat input-filter option-residuo"  value="-1" name="radEstadoNot" checked=""> Ambos
                                    </label>
                                </div>
                            </div>
                        </div>
                    </form>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-10 col-sm-10 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Lista de Noticias</h2>
                <ul class="nav navbar-right panel_toolbox">
                    <li><a  class="btn btn-primary" id="btnGenerarNot">Generar Noticia</a></li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <div class="table-responsive">
                     <table class="table table-striped" id="tblListar">
                      <thead>
                        <tr>
                          <th>TÍTULO</th>
                          <th>FECHA</th>
                          <th>AUTOR</th>
                          <th>ESTADO</th>
                          <th>ACCIÓN</th>
                        </tr>
                      </thead>
                      <tbody>
                      </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
{/block}
{block 'script'}
   <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="{$public_url}views/gestor/js/ges_noticias.js"></script>
{/block}