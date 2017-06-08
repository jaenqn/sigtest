{extends $_template}
{block 'css'}
<style>
    .row-dashboard {
        font-size: 12px;
    }
    .chart_graficos{
        height: 400px;
    }
    #char_boletasig{

    }
    .app_dash>li{
        float:right;
    }
</style>
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row row-dashboard">
        <div class="row">
            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title">
                    <h4>Últimas notificaciones</h4>
                    </div>
                    <div class="x_content">

                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Asunto</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>07/10/2016</td>
                                    <td>Revisión de plan de contingencia</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>07/10/2016</td>
                                    <td>Observación de matriz de proceso mantenimiento de radio enlace</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>07/10/2016</td>
                                    <td>Boleta SIG</td>
                                    <td><a href="#">ver</a></td>
                                </tr>

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title x_title_app">
                        <h2 class="x_text hidden">Boletas SIG</h2>
                        <ul class="nav navbar-right panel_toolbox app_dash">
                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                            </li>
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>

                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div id="char_boletasig" class="chart_graficos"></div>

                    </div>

                </div>
            </div>
        </div>
        <div class="row">

            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title">
                    <h4>SACP</h4>
                    </div>
                    <div class="x_content">

                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Nro</th>
                                    <th>Fecha Emisión</th>
                                    <th>Fecha Respuesta</th>
                                    <th>Plazo de Ejecución de Acciones</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>AL-001-2016</td>
                                    <td>16/09/2016</td>
                                    <td>25/09/2016</td>
                                    <td>Diciembre-2016</td>
                                    <td>Abierta</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>AL-001-2016</td>
                                    <td>16/09/2016</td>
                                    <td>25/09/2016</td>
                                    <td>Diciembre-2016</td>
                                    <td>Abierta</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title">
                    <h4>Reportes de Incidencia</h4>
                    </div>
                    <div class="x_content">

                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Nro</th>
                                    <th>Fecha de Reporte</th>
                                    <th>Tipo</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>RI-USI-001-2016</td>
                                    <td>16/09/2016</td>
                                    <td>Pendiente</td>
                                    <td>Abierta</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>RI-USI-001-2016</td>
                                    <td>16/09/2016</td>
                                    <td>Pendiente</td>
                                    <td>Abierta</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>RI-USI-001-2016</td>
                                    <td>16/09/2016</td>
                                    <td>Pendiente</td>
                                    <td>Abierta</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
        <div class="row">

            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title">
                    <h4>Residuos a Almacen</h4>
                    </div>
                    <div class="x_content">

                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Nro</th>
                                    <th>Residuo</th>
                                    <th>Origen</th>
                                    <th>Almacén</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1281</td>
                                    <td>Baterías</td>
                                    <td>Unidad X</td>
                                    <td>Almacén central de RP</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>1281</td>
                                    <td>Baterías</td>
                                    <td>Unidad X</td>
                                    <td>Almacén central de RP</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>1281</td>
                                    <td>Baterías</td>
                                    <td>Unidad X</td>
                                    <td>Almacén central de RP</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>1281</td>
                                    <td>Baterías</td>
                                    <td>Unidad X</td>
                                    <td>Almacén central de RP</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>1281</td>
                                    <td>Baterías</td>
                                    <td>Unidad X</td>
                                    <td>Almacén central de RP</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title">
                    <h4>Matrices de procesos actualizados</h4>
                    </div>
                    <div class="x_content">

                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Proceso</th>
                                    <th>Unidad</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Mantenimiento de radio enlace</td>
                                    <td>Servicios informáticos</td>
                                    <td>Aprobado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>Proceso 1</td>
                                    <td>Servicios</td>
                                    <td>Finalizado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>Proceso 3</td>
                                    <td>Contabilidad</td>
                                    <td>Revisado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>Mantenimiento de radio enlace</td>
                                    <td>Servicios informáticos</td>
                                    <td>Aprobado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
        <div class="row">

            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title">
                    <h4>Plan de contingencia</h4>
                    </div>
                    <div class="x_content">

                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Documento</th>
                                    <th>Fecha de aprobación</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Plan de contingencia 2010</td>
                                    <td>13/09/2010</td>
                                    <td>Publicado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>Plan de contingencia 2006</td>
                                    <td>13/09/2007</td>
                                    <td>Publicado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
            <div class="col-sm-6">

                <div class="x_panel">
                    <div class="x_title">
                    <h4>Indicadores de calidad</h4>
                    </div>
                    <div class="x_content">

                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Indicador</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Consumo de cartuchos de tinta de impresora</td>
                                    <td>Ingresado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>Consumo de tóners</td>
                                    <td>Ingresado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                                <tr>
                                    <td>Consumo de papel bond</td>
                                    <td>Ingresado</td>
                                    <td><a href="#">ver</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>

{/block}
{block 'script'}
    <script src="{$public_url}vendors/amcharts/amcharts.js"></script>
    <script src="{$public_url}vendors/amcharts/plugins/dataloader/dataloader.min.js"></script>
    <script src="{$public_url}vendors/amcharts/pie.js"></script>
    <script src="{$public_url}views/dashboard/js/graficos.js"></script>
{/block}