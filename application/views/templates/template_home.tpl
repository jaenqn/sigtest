<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{if isset($part_title)}{$part_title} | {/if} Sistema Integrado de Gestion</title>
<link rel="shortcut icon" href="{$public_url}app/img/ico.ico" type="image/x-icon" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<meta name="description" content="" />
<link href="{$public_url}vendors/load-awesome-master/css/ball-pulse.css" rel="stylesheet">
<!-- Selec2 Css -->
<link href="{$public_url}vendors/select2/dist/css/select2.css" rel="stylesheet">
<!-- css -->
<link href="{$public_url}vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="{$public_url}vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
<link href="{$public_url}views/templates/home/plugins/flexslider/flexslider.css" rel="stylesheet" media="screen" />
<link href="{$public_url}views/templates/home/css/cubeportfolio.min.css" rel="stylesheet" />
<link href="{$public_url}views/templates/home/css/style.css" rel="stylesheet" />
<link href="{$public_url}app/css/noticias.css" rel="stylesheet" />


<!-- Theme skin -->
<link id="t-colors" href="{$public_url}views/templates/home/skins/default.css" rel="stylesheet" />

    <!-- boxed bg -->
    {* <link id="bodybg" href="{$public_url}views/templates/home/bodybg/bg1.css" rel="stylesheet" type="text/css" /> *}
    <link id="bodybg" href="{$public_url}views/templates/home/css/home.css" rel="stylesheet" type="text/css" />


{block 'css'}
{/block}
<style>
    a,a:visited,a:focus,a:active,:visited,:focus,:active,.btn:focus,.btn:active:focus,.btn.active:focus,.btn.focus,.btn:active.focus,.btn.active.focus {
        outline: 0
    }
    .select2-results__option {
        padding: 2px 6px 2px 6px !important;
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
</style>
 <script >
    var BASE_URL = '{$base_url}';


  </script>
</head>
<body>
 <div id="show-error" class="loading-errors hidden">
      <div class="options"><a href="#" data-errors="on" style="float:right"><i class="fa fa-close"></i></a></div>
      <div class="clearfix"></div>
      <div class="message">

      </div>
    </div>
<div class="loading-container">
    <div class="la-ball-pulse">
        <div></div>
        <div></div>
        <div></div>
    </div>
</div>



<div id="wrapper">
    <!-- start header -->
    <header>
            <div class="top bg-top" style="background: url({$public_url}/app/img/bg1.jpg);height: 11em;background-repeat: no-repeat;
    background-color: #df0209;
    background-position-x: 50%;">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <ul class="topleft-info">
                            </ul>
                        </div>
                    {*  <div class="col-md-6">
                            <div id="sb-search2" class="sb-search">
                                <form>
                                    <input class="sb-search-input" placeholder="Buscardor General" type="text" value="" name="search" id="search">
                                    <input class="sb-search-submit" type="submit" value="">
                                    <span class="sb-icon-search" title="Click to start searching"></span>
                                </form>
                            </div>
                        </div> *}
                    </div>
                </div>
            </div>
        <div class="navbar navbar-default navbar-static-top">
            <div class="container">

                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    {* <a class="navbar-brand" href="index.html"><img src="img/logo.png" alt="" width="199" height="52" /></a> *}
                    <a href="{$base_url}" class="navbar-brand" style="line-height: 1.5em;"><span>SIG-C | PETROPERU</span></a>

                </div>
                <div class="navbar-collapse collapse">


{*
                {if isset($documento)}
                    <ul class="nav navbar-nav" id="urls_docs">
                        {foreach $documento as $cate}
                            <li><a href="{$base_url}home/politica_integrada">{$cate->nomArchivo}</a></li>
                        {/foreach}
                    </ul>
                {else} *}
                    <ul class="nav navbar-nav">
                        <li><a href="{$base_url}home/politica_integrada">Política integrada</a></li>
                        <li><a href="{$base_url}home/organizacion">Organización</a></li>
                        <li><a href="{$base_url}home/alcance">Alcance</a></li>
                        <li><a href="{$base_url}home/ambiente">Ambiente</a></li>
                        <li><a href="{$base_url}home/seguridad">Seguridad</a></li>
                        <li><a href="{$base_url}home/calidad">Calidad</a></li>
                        {if $smarty.session.usuario_logueado == true}
                            <li><a href="{$base_url}visitas">Dashboard</a></li>
                        {/if}
                        {if $smarty.session.usuario_logueado == false}
                        <li><a data-toggle="modal" href='#modLogin'>Ingresar</a></li>
                        {else}
                        <li><a data-toggle="modal" href='{$base_url}usuario/logout'>Cerrar Sessión</a></li>
                        {/if}

                        {* <li class="dropdown">
                            <a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">Home <i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu">
                                <li><a href="index.html">Home slider 1</a></li>
                                <li><a href="index2.html">Home slider 2</a></li>

                            </ul>

                        </li> *}
                  {*       <li class="dropdown active">
                            <a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">Features <i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu">
                                <li><a href="typography.html">Typography</a></li>
                                <li><a href="components.html">Components</a></li>
                                <li><a href="pricing-box.html">Pricing box</a></li>
                                <li class="dropdown-submenu">
                                    <a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown">Pages</a>
                                    <ul class="dropdown-menu">
                                        <li><a href="fullwidth.html">Full width</a></li>
                                        <li><a href="right-sidebar.html">Right sidebar</a></li>
                                        <li><a href="left-sidebar.html">Left sidebar</a></li>
                                        <li><a href="comingsoon.html">Coming soon</a></li>
                                        <li><a href="search-result.html">Search result</a></li>
                                        <li><a href="404.html">404</a></li>
                                        <li><a href="register.html">Register</a></li>
                                        <li><a href="login.html">Login</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li> *}

                    </ul>
                {* {/if} *}
                </div>

            </div>
        </div>
    </header>
    <!-- end header -->
{*  <section id="inner-headline">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <ul class="breadcrumb">
                    <li><a href="#"><i class="fa fa-home"></i></a><i class="icon-angle-right"></i></li>
                    <li><a href="#">Features</a><i class="icon-angle-right"></i></li>
                    <li class="active">Right sidebar</li>
                </ul>
            </div>
        </div>
    </div>
    </section> *}
    {if isset($documento)}
        <section id="content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8">
                    {block 'contenido'}

                    {/block}
                    </div>
                    <div class="col-sm-4">
                            <aside class="right-sidebar">
                                <div class="widget">
                                    <form role="form" method="get" action="{$base_url}home/document">
                                      <div class="form-group">
                                        <input type="text" class="form-control" id="s" placeholder="Buscar" name="s">
                                        <input type="hidden"  id="p"  value="1" name="p">
                                      </div>
                                    </form>
                                </div>
                                <div class="widget">
                                    <h5 class="widgetheading">Documentación SIG</h5>
                                    <ul class="cat">
                                    {foreach $documento as $cate}
                                      <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/{$cate->url}">{$cate->nomArchivo|capitalize:true}</a><span></span></li>

                                    {/foreach}
                                    </ul>
                                </div>
                                <div class="widget">
                                    <h5 class="widgetheading">Enlaces SIG</h5>
                                    <ul class="cat">
                                        <li><i class="fa fa-angle-right"></i><a href="{$smarty.const.PORTAL_REFINERIA}">Portal Refinería</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$smarty.const.CORREO_REFINERIA}">Correo Web</a><span></span></li>
                                    </ul>
                                </div>

                                <div class="widget">
                                    <h5 class="widgetheading">Noticias</h5>

                                    <ul class="cat cat-noticia">
                                        {foreach $lstNoticias as $obj}
                                        <li>
                                            <div>
                                                <div class="cont-img">
                                                    <div >
                                                        <a href="{$base_url}home/noticia/{$obj->not_id}" id="refnoticia" style="text-decoration: none"><p class="tt-intro">{$obj->not_intro|default:''}</p></a>
                                                    </div>
                                                    <img src="{if $obj->file_portada }{$base_url}/docs/_noticias/{$obj->not_id}/{$obj->file_portada->dno_nombre_fichero}{else}{$public_url}app/img/fotos_refineria/logopetroperu.jpg{/if}">
                                                </div>
                                                <div class="cont-title">
                                                    <p><b> <a href="{$base_url}home/noticia/{$obj->not_id}" style="text-decoration: none"> {$obj->not_titulo|default:'Sin título'} </a> </b></p>
                                                </div>
                                            </div>
                                        </li>
                                        {/foreach}


                                    </ul>
                                </div>
                            </aside>
                    </div>
                </div>


        </section>
    {else}
    <section id="content">
        {block 'contenido'}
        {/block}
    </section>

    {/if}
    <footer>
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="widget">
                    <h4>Petróleos del Perú - PETROPERU S.A</h4>
                    <address>
                    <strong>Refinería Selva - Iquitos</strong><br>
                     {$smarty.const.DIRECCION_REFINERIA}</address>
                    <p>

                        <i class="icon-phone fa fa-phone"></i> {$smarty.const.TELEFONOS_REFINERIA}<br>


                    </p>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="widget widget-img">
                    <div style="text-align: center">
                        <img src="{$public_url}app/img/iso/ISO_9001.png" alt="">
                    </div>
                    <h4>ISO 9001</h4>
                </div>
                <div class="widget widget-img">
                    <div style="text-align: center">
                        <img src="{$public_url}app/img/iso/217-2.jpg" alt="">
                    </div>
                    <h4>ISO 14001</h4>
                </div>
                <div class="widget widget-img">
                    <div style="text-align: center">
                        <img src="{$public_url}app/img/iso/Logo202.jpg" alt="">
                    </div>
                    <h4>OHSAS 18001</h4>
                </div>
            </div>

    {*      <div class="col-lg-3">
                <div class="widget">
                    <h4>Newsletter</h4>
                    <p>Fill your email and sign up for monthly newsletter to keep updated</p>
                    <div class="form-group multiple-form-group input-group">
                        <input type="email" name="email" class="form-control">
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-theme btn-add">Subscribe</button>
                        </span>
                    </div>
                </div>
            </div> *}
        </div>
    </div>
    <div id="sub-footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="copyright">
                        <p>&copy; SIGC&nbsp;-&nbsp;PETROPERU</p>
                    </div>
                </div>
                {* <div class="col-lg-6">
                    <ul class="social-network">
                        <li><a href="#" data-placement="top" title="Facebook"><i class="fa fa-facebook"></i></a></li>
                        <li><a href="#" data-placement="top" title="Twitter"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="#" data-placement="top" title="Linkedin"><i class="fa fa-linkedin"></i></a></li>
                        <li><a href="#" data-placement="top" title="Pinterest"><i class="fa fa-pinterest"></i></a></li>
                        <li><a href="#" data-placement="top" title="Google plus"><i class="fa fa-google-plus"></i></a></li>
                    </ul>
                </div> *}
            </div>
        </div>
    </div>
    </footer>

</div>
<a href="#" class="scrollup"><i class="fa fa-angle-up active"></i></a>

<div class="modal fade" id="modLogin">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">&nbsp;</h4>
            </div>
            <div class="modal-body">

<div class="row">
    <div class="col-xs-12 col-sm-10 col-md-10 col-sm-offset-1 col-md-offset-1">
        <form role="form" class="register-form" id="frmLogin">
            <h2>Ingreso de Sistema</br><small id="lblMensaje" class=""></small></h2>
            <hr class="colorgraph">

            <div class="form-group">
                <input type="text" name="txtUsuario" id="txtUsuario" class="form-control input-lg" placeholder="Nombre de Usuario" tabindex="1" required autofocus>
            </div>
            <div class="form-group">
                <input type="password" class="form-control input-lg" id="txtPassword" name="txtPassword" placeholder="Password" tabindex="2" required>
            </div>
{*
            <div class="row">
                <div class="col-xs-4 col-sm-3 col-md-3">
                    <span class="button-checkbox">
                        <button type="button" class="btn" data-color="info" tabindex="7" id="btnRecordar">Recordarme</button>
                        <input type="checkbox" name="t_and_c" id="t_and_c" class="hidden" value="0">
                    </span>
                </div>
            </div> *}

            <hr class="colorgraph">
            <div class="row">
                <div class="col-xs-12 col-md-6"><input type="submit" id="btnIngresar" value="Ingresar" class="btn btn-primary btn-block btn-lg" tabindex="7"></div>
                {* <div class="col-xs-12 col-md-6">Don't have an account? <a href="register.html">Register</a></div> *}
            </div>
        </form>
    </div>
</div>

            </div>{*
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div> *}
        </div>
    </div>
</div>

<!-- javascript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="{$public_url}vendors/jquery/dist/jquery.min.js"></script>
<script src="{$public_url}vendors/is/is.min.js"></script>

<script src="{$public_url}views/templates/home/js/modernizr.custom.js"></script>
<!-- APP JS -->
    {* <script src="{$public_url}app/js/app.js" async="async"></script> *}


    <!-- Handlebars -->
    <script src="{$public_url}vendors/handlebars/handlebars-v4.0.5.js"></script>

<script src="{$public_url}views/templates/home/js/jquery.easing.1.3.js"></script>
<script src="{$public_url}views/templates/home/plugins/flexslider/jquery.flexslider-min.js"></script>
<script src="{$public_url}views/templates/home/plugins/flexslider/flexslider.config.js"></script>
<!-- jQuery custom content scroller -->
<script src="{$public_url}vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="{$public_url}views/templates/home/js/bootstrap.min.js"></script>
<!-- Select2 -->
    <script src="{$public_url}vendors/select2/dist/js/select2.min.js"></script>
    <!-- iCheck -->
    <script src="{$public_url}vendors/iCheck/icheck.min.js"></script>
    <!-- APP JS -->
    <script src="{$public_url}app/js/app.js" ></script>

<!-- Tools -->
    <script src="{$public_url}tool/tools.js"></script>
<script src="{$public_url}views/templates/home/js/jquery.appear.js"></script>
<script src="{$public_url}views/templates/home/js/stellar.js"></script>
<!-- Moment -->
<script src="{$public_url}views/templates/gentelella/js/moment/moment.min.js"></script>
<script src="{$public_url}views/templates/home/js/classie.js"></script>
{* <script src="{$public_url}views/templates/home/js/uisearch.js"></script> *}
<script src="{$public_url}views/templates/home/js/jquery.cubeportfolio.min.js"></script>
<script src="{$public_url}views/templates/home/js/google-code-prettify/prettify.js"></script>
<script src="{$public_url}views/templates/home/js/animate.js"></script>
<script src="{$public_url}views/templates/home/js/custom.js"></script>


{block 'script'}
{/block}
{literal}
<script>
    $(window).load(function() {

          $('.loading-container').fadeOut(1000, function() {
            $(this).remove();
          });
        });
    $(document).ready(function() {


        var t_and_c = $('#t_and_c');
        $('#btnRecordar').on('click',function(e){
            if(+t_and_c.val() == 0){
                t_and_c.val(1);return;
            }
            if(+t_and_c.val() == 1){
                t_and_c.val(0);return;
            }

        });


        $('#frmLogin').submit(function(e){
            e.preventDefault();
            $.post(BASE_URL + 'home/login', {
                txtUsuario : $('#txtUsuario').val(),
                txtPassword : $('#txtPassword').val(),
                txtRecordar : $('#t_and_c').val()
            }, function(data, textStatus, xhr) {
                console.log(data);
                if(data.is_log){
                    if(data.prev_url)
                        document.location =  '/'+data.prev_url;
                    else document.location.reload();

                }else $('#lblMensaje').html(data.lblMensaje).fadeIn('fast', function() {
                    var selfd = this;
                    setInterval(function(){
                        $(selfd).fadeOut('slow',function(){});
                    },2500)


                });



            },'json').fail(fnFailAjax);
            return false;
        })

    });
</script>
{/literal}
<script src="{$public_url}app/js/noticias.js"></script>
</body>
</html>












