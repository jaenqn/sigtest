{extends $_template}
{block 'css'}
    <link href="{$public_url}views/incidencias/css/reporte.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">
	<div class="col-md-9 col-sm-9 col-xs-12 ">
		<div class="x_panel">
			<div class="x_title">
	     		<h2>Detalle de Observación </h2>

	     		<div class="clearfix"> </div>
	     	 </div>
	    <div class="x_content">


	 <form   method="POST" action="{$base_url}notificaciones/enviar_observacion_procesador" id="formulario" >
	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Para</label>

            	<!-- para ver si se envio una unidad especifica -->
            	{if $fila == ''}
            	<div class="col-md-5 col-sm-5 col-xs-12">
           		 <select class="select-minimum form-control" tabindex="-1" name="selDepartamento"  id="selDepartamento" data-placeholder="Seleccione" required >
              	 <option></option>
	              	 {foreach $lstDepartamento as $obj}
						<option value="{$obj->idDepend}">{$obj->desDepend}</option>
					 {/foreach}
				  </select>
				  </div>
				   <div class="col-md-5 col-sm-5 col-xs-12">
	           		  <select class="select-minimum form-control" name="selUnidad"  id="selUnidad" data-placeholder="Seleccione" required >
	              	  <option></option>
					  </select>
           		   </div>
				  {else}
				    <div class="col-md-7 col-sm-7 col-xs-12">
	           		 <h4> {$fila->nom_depa} &nbsp; / &nbsp;{$fila->desDepend}  </h4>
	           		 <input type="hidden" name="selUnidad" id="selUnidad"  value="{$fila->idDepend}"/>
           		   </div>

				  {/if}


        </div> <br><br><br>


      <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Asunto</label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <input type="text" class="form-control" name="asunto"  placeholder="Ingrese Asunto" autocomplete="off" required value="{$asunto|default:''}">
            </div>
        </div> <br><br><br>

        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Mensaje</label>
            <div class="col-md-10 col-sm-10 col-xs-12">
              <textarea name="mensaje" style="width: 100%;" required class="form-control  resize-vertical textarea-auto"></textarea>
            </div>
        </div>

      <div class="clearfix"></div>

          <div class="form-group" style="margin-top:5px">

            	<div class="col-sm-12">
               <button type="submit" class="btn btn-success" id="btn_subir" style="float:right">Enviar</button>
              </div>

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

    {* <script src="{$public_url}app/js/app.js"></script> *}
    <script src="{$public_url}vendors/autosize/dist/autosize.js"></script>
    <script src="{$public_url}views/notificaciones/js/combobox_unidades.js"></script>
       <script>
    $(document).ready(function(){
      $('.textarea-auto').each(function(){
            autosize(this);
      });
    });
    </script>
{/block}