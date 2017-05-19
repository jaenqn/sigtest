{extends $_template}
{block 'css'}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
    <style>
        #tblResumenGeneral{
          width:100%;
        }
    </style>
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
        <div class="col-sm-6 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Estadísticas generales</h2>
                        <div class="clearfix"></div>
                    </div>
                <div class="x_content">
                        <div class="col-sm-8 col-xs-12">
                            <table id="tblResumenGeneral">
                            <tbody>
                                <tr>
                                    <td><span>Usuarios logueados</span></td>
                                    <td><b id="usuariosConectado">--</b></td>
                                </tr>
                                <tr>
                                    <td><span>Usuarios en línea</span></td>
                                    <td><b id="usuariosEnLinea">--</b></td>
                                </tr>
                                <tr>
                                    <td><span>Hoy</span></td>
                                    <td><b>{$data_visitas.visitas_hoy}</b></td>
                                </tr>
                                <tr>
                                    <td><span>Ayer</span></td>
                                    <td><b>{$data_visitas.visitas_ayer}</b></td>
                                </tr>
                                <tr>
                                    <td><span>Semana</span></td>
                                    <td><b>{$data_visitas.visitas_semana}</b></td>
                                </tr>
                                <tr>
                                    <td><span>Año</span></td>
                                    <td><b>{$data_visitas.visitas_year}</b></td>
                                </tr>
                                <tr>
                                    <td><span>Total visitas</span></td>
                                    <td><b>{$data_visitas.visitas_total}</b></td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                </div>
            </div>

        </div>

        <div class="col-sm-6 col-xs-12">

            <div class="x_panel">

                <div class="x_content">
                    <div class="row">
                        <div class="col-sm-7">
                            <h4><b>Visitas de : <span id="target_fecha"></span></br>Total : <span id="target_total_visitas">--</span></b></h4>
                        </div>
                        <div class="col-sm-5">
                            <select class="select-minimum form-control input-filter" tabindex="-1" name="selOpcionVisitas" id="selOpcionVisitas" data-placeholder=" - Seleccione - ">
                            <option></option>
                            <option value="1" selected="">Hoy</option>
                            <option value="2">Ayer</option>
                            <option value="3">Semana</option>
                            <option value="4" >Rango</option>
                          </select>
                        </div>

                    </div>

                    <div class="col-sm-12 container-rango hidden" style="margin-top:12px">
                            <div class="control-group">
                                <div class="controls">
                                  <div class="col-md-6 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left txtFechas" id="txtFechaInicio" placeholder="Fecha  inicial" aria-describedby="inputSuccess2Status2">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>
                                <div class="controls">
                                  <div class="col-md-6 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left txtFechas" id="txtFechaFinal" placeholder="Fecha final" aria-describedby="inputSuccess2Status2">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="controls">
                                    <div class="col-sm-12">
                                        <button type="button" class="btn btn-success" id="btnGenerarVisitasRango" disabled="">Generar</button>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="clearfix"></div>
                    <hr>

                    <div class="table-responsive tbl-container" id="contenedor_tablas">
                        <table class="table table-striped" id="tblListarHoy" style="width: 100%">
                          <thead>
                            <tr>
                              <th>HORA</th>
                              <th>CANTIDAD DE USUARIOS</th>

                            </tr>
                          </thead>
                          <tbody>

                          </tbody>
                        </table>
                    </div>
                    <div class="table-responsive tbl-container hidden">
                         <table class="table table-striped " id="tblListarSemana" style="width: 100%">
                          <thead>
                            <tr>
                              <th>FECHA</th>
                              <th>CANTIDAD DE USUARIOS</th>
                              <th>DETALLES x HORA</th>
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
<script type="text/javascript">

</script>
  <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
  <script src="{$public_url}vendors/datatables.net/js/sorting-datetime-moment.js"></script>
  <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="{$public_url}views/home/js/hom_estadisticas.js"></script>
{/block}