{extends $_template}
{block 'css'}
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">
	<div class="col-md-9 col-sm-9 col-xs-12 ">
		<div class="x_panel">
			<div class="x_title">
	     		<h2> Edición de Notificaciones </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div>
	    <div class="x_content">

	   {foreach  $notificacion  as $item}
	 <form   method="POST" action="../editar_notificacion" >
	 	<input type="hidden" value="{$item['not_id']}" name="id_notificacion" />
	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Origen</label>
            <div class="col-md-8 col-sm-8 col-xs-12">
           		 {$item['not_origen'] }
            </div>
        </div>
        <div class="clearfix"></div>
        <br>


      <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Asunto</label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <input type="text" class="form-control" name="asunto"  placeholder="" required value="{$item['not_asunto']}">
            </div>
        </div>
        <div class="clearfix"></div>
        <br>

        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Mensaje</label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <textarea name="mensaje" style="width: 100%;" class="resize-vertical">{$item['not_mensaje']}</textarea>
            </div>
        </div>
        <div class="clearfix"></div>
        <br>

      <div class="clearfix"></div>

       {/foreach}

          <div class="form-group">

            <label class="control-label col-md-4 col-md-offset-2 col-sm-4 col-sm-offset-2 col-xs-12">
            	<button type="submit" class="btn btn-success" id="btn_subir">Actualizar</button>
            </label>

       	 </div>
	 </form>
	   </div><!-- fin  de Content -->
		</div>
	</div> <!-- Contenedor  de Columna 8 -->
</div><!-- Contenedor  de Fila -->







    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'   -->

      <script src="{$public_url}views/indicadores/js/indicadores.js"></script>
    <script src="{$public_url}views/indicadores/js/agregar_unidades.js"></script>
{/block}