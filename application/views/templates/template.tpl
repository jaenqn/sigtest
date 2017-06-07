<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{if isset($part_title)}{$part_title} | {/if}Sistema Integrado de Gestión </title>
    <link rel="shortcut icon" href="{$base_url}ico.ico" type="image/x-icon" />
    <link href="{$public_url}views/templates/home/fonts/roboto/roboto.css" rel="stylesheet">

    <!-- Normalize -->
    <link href="{$public_url}vendors/normalize-css/normalize5.css" rel="stylesheet"><!-- Bootstrap -->
    <link href="{$public_url}vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DtaRanget-->
    <link href="{$public_url}vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Sweetalert -->

    <link href="{$public_url}vendors/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="{$public_url}vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Loader Font Awesome -->
    <link href="{$public_url}vendors/load-awesome-master/css/ball-pulse.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="{$public_url}vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="{$public_url}vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Selec2 Css -->
    <link href="{$public_url}vendors/select2/dist/css/select2.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="{$public_url}vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="{$public_url}vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="{$public_url}vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="{$public_url}vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->

    <!-- jQuery custom content scroller -->
    <link href="{$public_url}vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
    <link href="{$public_url}views/templates/gentelella/build/css/custom.min.css" rel="stylesheet">
    <link href="{$public_url}views/templates/gentelella/build/css/app.css" rel="stylesheet">

    <style>
      .loading-container {
        position:fixed;
        background-color:white;
        z-index:999999999;
        top: 0;
        left: 0;
        height:100%;
        width:100%;
        cursor:wait;
      }
      .loading-errors {
        position:fixed;
        background-color:white;
        z-index:999999999;
        top: 0;
        left: 0;
        height:100%;
        width:100%;
        overflow-y: scroll;

      }
      .la-ball-pulse {
          color: rgb(223, 2, 9);
          height: 25px;
          width: 60px;
          position: absolute;
          top: 0;
          left: 0;
          bottom: 0;
          right: 0;
          margin: auto;

      }
    .table-hover>tbody>tr:hover{
      background-color: rgba(26, 187, 156, 0.26) !important;
    }
    .noload{
      visibility: hidden;
    }
    </style>
    {block 'css'}
    {/block}


  <script >
    let BASE_URL = '{$base_url}';



  </script>
  </head>

  <body class="nav-md noload">
  <audio id="audio_noti">
    {* <source src="{$public_url}app/audio/campanas.wav" type="audio/wav">
    <source src="{$public_url}app/audio/campanas.ogg" type="audio/ogg"> *}
    <source src="{$public_url}app/audio/campanas.mp3" type="audio/mpeg">
  </audio>
    <div id="show-error" class="loading-errors hidden">
      <div class="options"><a href="#" data-errors="on" style="float:right"><i class="fa fa-close"></i></a></div>
      <div class="clearfix"></div>
      <div class="message">

      </div>
    </div>

    {* <div class="loading-container">
        <div class="la-ball-pulse">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div> *}
    <div class="container body" id="casoT">
      <div class="main_container">
        <div class="col-md-3 left_col ">
        {* <div class="col-md-3 left_col menu_fixed"> *}
          <div class="left_col scroll-view">
            <div class="navbar nav_title title_logo" style="border: 0;">
              <a href="{$base_url}" class="site_title">
              <img id="logoA" src="{$public_url}app/img/logopetro1.png" alt="" style="width:99%">
              <img id="logoB" src="{$public_url}app/img/logopetro1.png" alt="" style="width:99%" class="hidden">
              </a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                {* <img src="{$public_url}views/templates/gentelella/images/img.jpg" alt="..." class="img-circle profile_img"> *}
              </div>
              <div class="profile_info">
                {* <span>Bienvenido,</span> *}
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />
            <div class="clearfix"></div>

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                {* <h3>General</h3> *}
                <ul class="nav side-menu">
                  <li><a href="{$base_url}dashboard"><i class="fa fa-home"></i> Home </a></li>
                  <!--##ADMINISTRAR-->
                  <li><a><i class="fa fa-cog"></i> Administrar SIG <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">

                      {if $smarty.session.tipo_usuario == 4 || $smarty.session.tipo_usuario == 5}
                      <li><a href="{$base_url}carpeta">Carpetas</a></li>
                      <li><a href="{$base_url}carpeta/categorias">Carpeta categorías</a></li>
                      <li><a href="{$base_url}visitas">Estadísticas de visitas</a></li>
                      {/if}
                      <li><a href="{$base_url}gestor/noticias">Noticias</a></li>

                    </ul>
                  </li>
                  {* <li><a href="{$base_url}fotos"><i class="fa fa-file-image-o"></i> Foto de Portada</a></li> *}

                  <!--##BOLETA-->
                  <li><a><i class="fa fa-book"></i> Boletas SIG <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">

                      {if $smarty.session.tipo_usuario == 1 or $smarty.session.tipo_usuario == 2}
                        <li><a href="{$base_url}boletasig/generar_boleta">Generar</a></li>
                      {/if}
                      {* {if $smarty.session.tipo_usuario == 2 or $smarty.session.tipo_usuario == 3} *}
                      <li><a href="{$base_url}boletasig/listar">Listar</a></li>
                      {* {/if} *}
                      {* <li><a href="{$base_url}residuo/reportes_generados">Reporte Residuos Generados</a></li>
                      <li><a href="{$base_url}residuo/reportes_general_solidos">Reporte General Residuos Sólidos</a></li>
                      <li><a href="{$base_url}residuo/declaracion_residuos"> Generar Declaración de Manejo de Residuos Sólidos</a></li> *}
                      {* <li><a href="{$base_url}residuo/autorizar">Autorizar</a></li> *}
                    </ul>
                  </li>

                  <!--##SACP-->
                  <li><a><i class="fa fa-sitemap"></i> SACP <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{$base_url}sacp/listar">Listar</a></li>
                      <li><a href="{$base_url}sacp/generar_sacp">Generar</a></li>
                    </ul>
                  </li>
                   <li><a><i class="fa fa-exclamation-triangle"></i> Incidencias <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{$base_url}gestor/causas">Causas</a></li>
                      <li><a href="{$base_url}incidencias/listar">Listar</a></li>
                      <li><a href="{$base_url}incidencias/reportar">Reportar</a></li>
                      <li><a href="{$base_url}incidencias/resumen">Resumen</a></li>
                      <li><a href="{$base_url}incidencias/listar">Listar</a></li>
                    </ul>
                  </li>
                  <!--##PLAN-->
                   <li><a><i class="fa fa-soundcloud"></i> Plan de Contingencia <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                    {if $ref_areas.seguridad == $smarty.session.id_unidad}
                      <li><a href="{$base_url}contingencia/subir">Subir</a></li>
                    {/if}

                      <li><a href="{$base_url}contingencia/listar">Listar</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-bar-chart"></i> Indicadores <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{$base_url}indicadores/ingresar_indicador">Ingresar</a></li>
                      <li><a href="{$base_url}indicadores/gestionar">Gestionar</a></li>
                      <li><a href="{$base_url}indicadores/reporte">Reporte</a></li>
                    </ul>
            </li>
                  <!--##RESIDUOS-->
                  <li><a><i class="fa fa-trash"></i> Residuos <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{$base_url}residuo/ingreso">Ingreso</a></li>
                      <li><a href="{$base_url}residuo/listar">Listar</a></li>
                      <li><a href="{$base_url}residuo/reportes_generados">Resumen Residuos Generados</a></li>
                      <li><a href="{$base_url}residuo/reportes_general_solidos">Reporte General Residuos Sólidos</a></li>

                      <li><a href="{$base_url}residuo/declaracion_residuos"> Generar Declaración de Manejo de Residuos Sólidos</a></li>



                      <li><a>Gestor<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu">
                          <li><a href="{$base_url}gestor/residuos">Residuos</a></li>
                          <li><a href="{$base_url}gestor/almacenes">Alamacen de Residuos</a></li>
                          <li><a href="{$base_url}gestor/empresa_contratista">Empresa Contratista</a></li>
                          <li><a href="{$base_url}gestor/origen_residuos">Origen de Residuos</a></li>
                        </ul>
                      </li>
                      {* <li><a href="{$base_url}residuo/autorizar">Autorizar</a></li> *}
                    </ul>
                  </li>
                  <!--##GESTORES-->
                  <li><a><i class="fa fa-life-ring"></i> Gestores <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">




                      <li><a href="{$base_url}gestor/departamentos">Departamentos</a></li>
                      <li><a href="{$base_url}gestor/correlativo">Correlativo</a></li>
                      <li><a href="{$base_url}gestor/unidades">Unidad</a></li>
                      <li><a href="{$base_url}gestor/instalaciones">Instalaciones</a></li>







                      {if $smarty.session.tipo_usuario == 3 || $smarty.session.tipo_usuario == 4 || $smarty.session.tipo_usuario == 5}
                      <li><a href="{$base_url}gestor/usuarios">Usuarios</a></li>
                      {/if}

                    </ul>
                  </li>
                  <li><a><i class="fa fa-envelope-o"></i> Notificaciones <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{$base_url}notificaciones/listar">Edición de Asuntos y Mensajes</a></li>
                      <li><a href="{$base_url}notificaciones/gestionar_notificaciones">Gestionar </a></li>
                      <li><a href="{$base_url}notificaciones/enviar_observacion_formulario">Enviar Observación </a></li>
                    </ul>
                  </li>


                  <li><a><i class="fa fa-cubes"></i> Análisis de Procesos <span class="fa fa-chevron-down"></span></a>
                  <!-- ##ANALISIS_PROCESOS -->
                    <ul class="nav child_menu">



                      {* <li><a href="{$base_url}analisis_proceso/generar">Generar</a></li> *}
                      <li><a href="{$base_url}analisis_proceso/lista">Lista</a></li>
                      <li><a href="{$base_url}analisis_proceso/habilitar">Habilitar</a></li>
                      {* <li><a href="{$base_url}analisis_proceso/agregar_peligro_actividad">Agregar Peligro a Actividad</a></li> *}
                      {* <li><a href="{$base_url}analisis_proceso/agregar_aspecto_actividad">Agregar Aspecto Ambiental a Actividad</a></li> *}
                      <li><a href="{$base_url}analisis_proceso/reporte_peligro_aspectos">Reporte de Peligros / Aspectos Significativos</a></li>


                      <li><a>Gestor<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu">
                          <li><a href="{$base_url}gestor/procesos">Procesos</a></li>
                          <li><a href="{$base_url}gestor/proceso_estapas">Procesos Etapas</a></li>
                          <li><a href="{$base_url}gestor/proceso_actividades">Procesos Actividades</a></li>
                          <li><a href="{$base_url}gestor/categorias">Categoría de Peligros y Aspectos Ambientales</a></li>
                          <li><a href="{$base_url}gestor/peligros">Peligros</a></li>
                          <li><a href="{$base_url}gestor/riesgo">Riesgo</a></li>
                          <li><a href="{$base_url}gestor/aspecto_ambiental">Aspecto Ambiental</a></li>
                          <li><a href="{$base_url}gestor/impacto_ambiental">Impacto Ambiental</a></li>
                          <li><a href="{$base_url}gestor/medidas_control">Medidas de Control</a></li>

                        </ul>
                      </li>


                    </ul>
                  </li>


                </ul>
              </div>
              {* <div class="menu_section">
                <h3>Live On</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-bug"></i> Additional Pages <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="e_commerce.html">E-commerce</a></li>
                      <li><a href="projects.html">Projects</a></li>
                      <li><a href="project_detail.html">Project Detail</a></li>
                      <li><a href="contacts.html">Contacts</a></li>
                      <li><a href="profile.html">Profile</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-windows"></i> Extras <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="page_403.html">403 Error</a></li>
                      <li><a href="page_404.html">404 Error</a></li>
                      <li><a href="page_500.html">500 Error</a></li>
                      <li><a href="plain_page.html">Plain Page</a></li>
                      <li><a href="login.html">Login Page</a></li>
                      <li><a href="pricing_tables.html">Pricing Tables</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-sitemap"></i> Multilevel Menu <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="#level1_1">Level One</a>
                        <li><a>Level One<span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                            <li class="sub_menu"><a href="level2.html">Level Two</a>
                            </li>
                            <li><a href="#level2_1">Level Two</a>
                            </li>
                            <li><a href="#level2_2">Level Two</a>
                            </li>
                          </ul>
                        </li>
                        <li><a href="#level1_2">Level One</a>
                        </li>
                    </ul>
                  </li>
                  <li><a href="javascript:void(0)"><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a></li>
                </ul>
              </div> *}

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
         {*    <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div> *}
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                   {*  <img src="{$public_url}views/templates/gentelella/images/img.jpg" alt=""> *} {$smarty.session.nombre_usuario|default:['session.nombre_usuario']} , «{$smarty.session.nombre_tipo_usuario|default:['session.nombre_tipo_usuario']|upper}»
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                 {*    <li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <li><a href="javascript:;">Help</a></li> *}
                    <li><a href="{$base_url}usuario/logout"><i class="fa fa-sign-out pull-right"></i>Cerrar sessión</a></li>
                  </ul>
                </li>

                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green" id="cantidad_notificaciones"></span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">

                  </ul>
                </li>
                <li>
                  <a href="javascript:;">{$smarty.session.nom_uni} | {$smarty.session.nom_dep}</a>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        <div class="right_col" role="main">
            <div>
              <ol class="breadcrumb breadcrumb-quirk" style="background: none; padding: 8px 0px;">
                <li><a href="{$base_url}dashboard"><i class="fa fa-home mr5"></i> Inicio</a></li>
                {block 'ref_urls'}
                {foreach $ar_pages as $p}
                  {if $p@last}
                    <li class="active">{$p}</li>
                  {else}
                    <li class="">{$p}</li>
                  {/if}
                {/foreach}
                {/block}
              </ol>
            </div>
              <div class="page-title">
                <div class="title_left">
                  <h3>{$titulo_header|default:'titulo_header'}</h3>
                </div>

            {*   <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div> *}
            </div>
            <div class="clearfix"></div>


            {block 'contenido'}
              {* ##Contenido *}
            {/block}
        </div>
      </div>

        <!-- page content -->{*

         *}<!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
             <a href="#">Sistema de Gestión | PetroPerú</a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="{$public_url}vendors/jquery/dist/jquery.min.js"></script>
    <script src="{$public_url}vendors/is/is.min.js"></script>
    {* <!-- knockout -->
    <script src="{$public_url}vendors/knockout/knockout-3.4.1.js"></script> *}

    <!-- sweetalert -->
    <script src="{$public_url}vendors/sweetalert/sweetalert.min.js"></script>
    <!-- Handlebars -->
    <script src="{$public_url}vendors/handlebars/handlebars-v4.0.5.js"></script>
    <!-- Bootstrap -->
    <script src="{$public_url}vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Bootstrap Validation -->
    <script src="{$public_url}vendors/bootstrap-validation/jqBootstrapValidation.js"></script>
    <!-- FastClick -->
    <script src="{$public_url}vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="{$public_url}vendors/nprogress/nprogress.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="{$public_url}vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
        <!-- Switchery -->
    <script src="{$public_url}vendors/switchery/dist/switchery.min.js"></script>
    <!-- Chart.js -->
    <script src="{$public_url}vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- jQuery Sparklines -->
    <script src="{$public_url}vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
    <!-- Flot -->
    <script src="{$public_url}vendors/Flot/jquery.flot.js"></script>
    <script src="{$public_url}vendors/Flot/jquery.flot.pie.js"></script>
    <script src="{$public_url}vendors/Flot/jquery.flot.time.js"></script>
    <script src="{$public_url}vendors/Flot/jquery.flot.stack.js"></script>
    <script src="{$public_url}vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="{$public_url}vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
    <script src="{$public_url}vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
    <script src="{$public_url}vendors/flot.curvedlines/curvedLines.js"></script>
    <!-- DateJS -->
    {* <script src="{$public_url}vendors/DateJS/build/date.js"></script> *}
    <!-- bootstrap-daterangepicker -->
    <script src="{$public_url}vendors/moment/min/moment-with-locales.js"></script>
    {* <script src="{$public_url}views/templates/gentelella/js/datepicker/daterangepicker.js"></script> *}
    <script src="{$public_url}vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
     <!-- iCheck -->
    <script src="{$public_url}vendors/iCheck/icheck.min.js"></script>
       <!-- PNotify -->
    <script src="{$public_url}vendors/pnotify/dist/pnotify.js"></script>
    <script src="{$public_url}vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="{$public_url}vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <script src="{$public_url}vendors/pnotify/dist/pnotify.callbacks.js"></script>
    <!-- Select2 -->
    <script src="{$public_url}vendors/select2/dist/js/select2.min.js"></script>
    <!-- APP JS -->
    <script src="{$public_url}app/js/app.js" ></script>
    <!-- Tools -->
    <script src="{$public_url}tool/tools.js" ></script>
       <!-- jQuery custom content scroller -->
    <script src="{$public_url}vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="{$public_url}views/templates/gentelella/build/js/custom.min.js"></script>
  <script src="{$public_url}views/notificaciones/js/notificaciones_general2.js"></script>



    {literal}
    <script type="text/javascript">

    $(window).ready(function() {
      $('body').removeClass('noload');
        var state_click_logo = true;
        var user_online = setInterval(fnReloadUser,2000);
        $('#menu_toggle').on('click',function(e){
          if(state_click_logo){
            $('#logoA').addClass('hidden');
            $('#logoB').removeClass('hidden');
            state_click_logo = false;

          }else{
            $('#logoB').addClass('hidden');
            $('#logoA').removeClass('hidden');
            state_click_logo = true;
          }
        })
        function fnReloadUser(){
          // DATA_USUARIOS.activos  = moment().format('hh:mm:ss');
          $.post(BASE_URL + 'usuario/set_online', {}, function(data, textStatus, xhr) {

            if(data.reload != undefined)
                document.location = BASE_URL;
          },'json').fail(fnFailAjax);
          $.post(BASE_URL + 'usuario/listar_online', {}, function(data, textStatus, xhr) {
          // console.log(data);
            if(typeof(DATA_USUARIOS) != 'undefined'){
              let uA = 0;
              for (let i = data.length - 1; i >= 0; i--) {
                if(+data[i].id_usuario != 0) uA++;
              }
              DATA_USUARIOS.activos = uA;

              DATA_USUARIOS.activos_enlinea = data.length;
            }
        },'json').fail(fnFailAjax);
        }
        /*
        $('.loading-container').fadeOut(1500, function() {
            $(this).remove();
        });
        */

    });
    </script>
    {/literal}
    {block 'script'}
    {/block}
    <script type="text/javascript">
      $(document).ready(function(){
        $('#menu_toggle').on('click',function(){
          try{
            if(!is.undefined(dtListar))
              dtListar.columns.adjust();

          }catch(e){
            console.log('not-datable');
          }


        })
      });
    </script>
  </body>
</html>