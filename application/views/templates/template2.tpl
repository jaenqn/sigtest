<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Sistema Integrado de Gestion  </title>

    <!-- Bootstrap -->
    <link href="{$public_url}vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="{$public_url}vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="{$public_url}vendors/nprogress/nprogress.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="{$public_url}views/templates/gentelella/build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="col-md-12">
          <div class="col-middle">
            <div class="text-center text-center">
              <h3 class="error-number">EN DESARROLLO</h3>
              <h3>No se puede mostrar el contenido</h3>
              <div class="row">
                <div class="col-sm-4 col-sm-offset-4">
                 {if $smarty.session.usuario_logueado != 1}
                   <form  method="POST" class="form-horizontal" role="form" id="frmLogin" action="">
                      <input type="hidden" name="frm-level" value="1">
                      <div class="form-group">
                        <legend>ACCESO</legend>
                      </div>
                      <div class="form-group">
                      <label>{$lblMensaje|default:''}</label>
                      </div>
                      <div class="form-group">
                        <input type="text" name="txtUsuario" id="txtUsuario"  class="form-control" value="" required="required" title="" placeholder="Usuario">
                      </div>
                      <div class="form-group">
                        <input type="password" name="txtPassword" id="txtPassword"  class="form-control" value="" required="required"  title="" placeholder="Contraseña">
                      </div>


                      <div class="form-group">
                        <div class="col-sm-1 ">
                          <button type="submit" class="btn btn-primary" id="btnIngreso" name="btnIngreso">Ingresar</button>
                        </div>
                      </div>
                  </form>
                  {else}
                    <a href="{$base_url}home/dashboard">Dashboar</a>
                 {/if}
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="{$public_url}vendors/jquery/dist/jquery.min.js"></script>
    <!-- APP JS -->
    {* <script src="{$public_url}app/js/app.js" async="async"></script> *}
    <!-- Tools -->
    <script src="{$public_url}tool/tools.js" async="async"></script>
    <!-- Bootstrap -->
    <script src="{$public_url}vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="{$public_url}vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="{$public_url}vendors/nprogress/nprogress.js"></script>

    {* <script src="{$public_url}views/home/home.js"></script> *}

    <!-- Custom Theme Scripts -->
    {* <script src="../build/js/custom.min.js"></script> *}
  </body>
</html>
