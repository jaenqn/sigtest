{extends $_template}
{block 'css'}
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">
	<div class="col-md-9 col-sm-9 col-xs-12 ">
		<div class="x_panel">
			<div class="x_title">
	     		<h2> Detalle de Notificación </h2>

	     		<div class="clearfix"> </div>
	     	 </div>
	    <div class="x_content">

	   {foreach $notificacion as $item}
	   <center> <h3>{$item['rel_asunto']}</h3>	</center>
	    <br>

	 <input type="hidden" id="rel_id" value="{$item['rel_id']}" />

	 <form   method="POST" action="" >
	 	<input type="hidden" value="{$item['not_id']}" name="id_notificacion" />
	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">De: </label>
            <div class="col-md-8 col-sm-8 col-xs-12">
           		{$unidad_emisora}
            </div>
        </div>
  <div class="clearfix"></div>



        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Mensaje: </label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <div name="mensaje" readonly="" style="width: 100%;">{$item['rel_mensaje']}</div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Enlace: </label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <div name="mensaje" readonly="" style="width: 100%;"><a href="{$base_url}{$item['rel_url']}">Ir a Proceso</a></div>
            </div>
        </div>
        <br>



      <div class="clearfix"></div>



          <div class="form-group">
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            {if $permision_delete == true}
            <div class="control-label col-md-12 col-sm-12 col-xs-12">
              <button type="submit" class="btn btn-success" id="btn_marcar" style="float:right" data-leido="{if $item['rel_estado'] == 2}1{else}0{/if}">{if $item['rel_estado'] == 2}Leído{else}Marcar como Leído{/if}</button>
            	<button type="submit" class="btn btn-danger" id="btn_eliminar" style="display: inline-block;float:right">Eliminar&nbsp;&nbsp;</button>
		        </div>
            {/if}
       	 </div>
       	  {/foreach}
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


     <script src="{$public_url}views/notificaciones/js/eliminar.js"></script>-->
{/block}