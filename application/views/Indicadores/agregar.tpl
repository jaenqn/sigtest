{extends $_template}
{block 'css'}        
    <link href="{$public_url}views/indicadores/css/modal.css" rel="stylesheet">
{/block}
{block 'contenido'}
<div class="row">	
	<div class="col-md-12 col-sm-12 col-xs-12 center-margin">
		<div class="x_panel"> 
			<div class="x_title">
	     		<h2> Registrar Proceso </h2>
	     		<ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>                      
                    </ul>
	     		<div class="clearfix"> </div>
	     	 </div> 	     	 
	    <div class="x_content"> 
	 <form   method="POST" action="registrar_indicador" >		 
	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Indicador de Desempeño</label>
            <div class="col-md-8 col-sm-8 col-xs-12">
              <input type="text" class="form-control" name="indicador"  placeholder="" required value=""> 
            </div>
        </div> <br><br><br>    
        
         <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Tipo</label>
            <div class="col-md-9 col-sm-9 col-xs-12">
               <div style="display: inline-block">
                <label>
                  <input type="radio" class="flat" name="tipo" value="SGC" checked=""> SGC &nbsp;&nbsp;
                </label>
              </div>
              <div  style="display: inline-block">
                <label>
                  <input type="radio" class="flat" name="tipo" value="SGA"> SGA &nbsp;&nbsp;
                </label>
              </div>
              <div  style="display: inline-block">
                <label>
                  <input type="radio" class="flat" name="tipo" value="SGSST"> SGSST &nbsp;&nbsp;
                </label>
              </div>
            </div>
        </div> <br><br><br>	  
	   	
	  
	    <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Unidad de Medida</label>
            <div class="col-md-4 col-sm-4 col-xs-12">
              <select class="form-control" name="unidad_medida"  id="select_unidades">
              	{foreach $lstUnidadesMedida as $item }
				  <option value="{$item['med_id'] }"> {$item['med_nombre'] }</option>	  
				  {/foreach}               
              </select>
            </div>            
            <div class="col-md-4 col-sm-4 col-xs-12">
              <!--<input type="text" class="form-control" name="unidad_nueva" id="unidad_nueva" style="width:16em; display: inline-block;" 
              		placeholder="Agregue Nueva Unidad"  value="">
              <button type="button" class="btn btn-primary " id="btn_agregar_unidad">+</button> <br> -->
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-sm">Gestor de Medidas</button>
            </div>
     </div> <br><br><br>
     
      <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Formula de Medicion</label>
            <div class="col-md-4 col-sm-4 col-xs-12">
              <input type="text" class="form-control" name="formula"  placeholder="" required value=""> 
            </div>
        </div> <br><br><br>	
        
        <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Nivel de Gestion</label>
            <div class="col-md-4 col-sm-4 col-xs-12">
              <input type="text" class="form-control" name="nivel"  placeholder="" required value=""> 
            </div>
        </div> <br><br><br>	 
        
         <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Requiere Evidencia</label>
            <div class="col-md-9 col-sm-9 col-xs-12">               
              <div class="checkbox" style="display: inline-block">
                <label>
                  <input type="radio" class="flat" name="evidencia" value="0" checked="checked"> NO
                </label>
              </div>
              <div class="checkbox" style="display: inline-block">
                <label>
                  <input type="radio" class="flat" name="evidencia" value="1"> SI
                </label>
              </div>              
            </div>
        </div> <br><br><br>	
        
           <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Responsable</label>
            <div class="col-md-7 col-sm-7 col-xs-12">              
                 <select class="select2_multiple form-control" multiple="multiple"  name="responsables[]" tabindex="-1" data-placeholder="Seleccione" required>
	                   {foreach $lstUnidades as $obj }
					  <option value="{$obj->idDepend}">{$obj->desDepend}</option>
				  {/foreach}                    
                  </select>   
                         
            </div>
        </div> <br><br><br>
        
           <div class="form-group">
            <label class="control-label col-md-2 col-sm-2 col-xs-12">Estado</label>
            <div class="col-md-9 col-sm-9 col-xs-12">              
                <label>
                  <input type="checkbox" class="flat" name="estado" value="1" checked="checked" disabled=""> Activo
                  <input type="hidden" class="flat" name="estado_oculto" value="1" > 
                </label>
              </div>
                       
          
        </div> <br><br><br>	<br><br>  
        
       
        
          <div class="form-group"> 
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;</label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">
            	<button type="submit" class="btn btn-success" id="btn_subir">Guardar</button>
            </label>
            <label class="control-label col-md-4 col-sm-4 col-xs-12">&nbsp;  </label>                        
       	 </div>
	 </form>	
	   </div><!-- fin  de Content -->
		</div>
	</div> <!-- Contenedor  de Columna 8 -->
</div><!-- Contenedor  de Fila -->


<!--  ================= Para el Modal  de unidades de medida ===================================== -->
   
  <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">

        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_cerrar_cabeza"><span aria-hidden="true">×</span>
          </button>
          <h4 class="modal-title" id="myModalLabel2">Gestor de Medidas</h4>
        </div>
        <div class="modal-body">
          <h4>Listado de Unidades de Medida</h4>
          
           <table class="table table-bordered" id="tblListar_unidades">
                      <thead>
                        <tr>
                          <th class="alineacion">Medida</th>
                          <th class="alineacion">En uso</th>                            
                          <th class="alineacion">&nbsp;&nbsp;&nbsp;Accion&nbsp;&nbsp;&nbsp;</th>                                                      
                        </tr>                                                                  
                      </thead>                           
                      <tbody>
                      	{foreach $lstUnidadesMedida_modal as $unidad}
                      	<tr id="{$unidad['med_id']}">
                         	<td>
                         		<span id="one_{$unidad['med_id']}" class="texto">{$unidad['med_nombre']}</span>
                         		<input type="text" id="one_input_{$unidad['med_id']}" class="editbox_search"   value="{$unidad['med_nombre']}">
                         	</td>
                         	
	                     	{if $unidad['uso'] == 1}
	                     	<td> 
	                     		SI 
	                     	</td>
	                     	{elseif $unidad['uso'] == 0}
	                     	<td> 
	                     		NO  
	                     	</td>
	                     	{/if}
	                     	
                         	<td> 
                         		<a class="edit" href="#tblListar_unidades">
                         			<img src="{$public_url}views/indicadores/img/edit.png" width="20px"></img>
                         		</a>                         		
                         		{if $unidad['uso'] == 1}
	                         	&nbsp;
	                         	{elseif $unidad['uso'] == 0}
	                         	 <a class="delete" href="#tblListar_unidades">
                         			<img src="{$public_url}views/indicadores/img/delete.png" width="20px"></img>
                         		 </a> 
	                         	{/if}
	                         	<a class="update" href="#tblListar_unidades">
                         			<img src="{$public_url}views/indicadores/img/checkmark_24.png" width="20px"></img>
                         		 </a> 
                         		 <a class="cancel" href="#tblListar_unidades">
                         			<img src="{$public_url}views/indicadores/img/block_24.png" width="20px"></img>
                         		 </a> 
	                         </td>                         		 
                           </tr> 
                        {/foreach}
                        
                        <tr class="fila_datos">
                         	<td>
                         		<input id="unidad_medida_nueva"  type="text">
                         	</td>                      	
	                     	<td> 	                     	
	                     		&nbsp;  
	                     	</td>                     	
                         	<td> 
	                     	 	 <a href="#" id="add" class="add">
	                     			<i class="fa fa-plus"> Añadir </i>
	                     		 </a> 
	                        </td>                         		 
                           </tr> 
                        
                         		
                                                   
                                        	                 
                      </tbody>
	     		</table>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_cerrar_pie">Cerrar</button>          
        </div>

      </div>
    </div>
  </div>




    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'   -->
    
    <script src="http://192.168.1.40/mapache/public/views/templates/gentelella/build/js/custom.min.js"></script>

      <script src="{$public_url}views/indicadores/js/indicadores.js"></script>
      <script src="{$public_url}views/indicadores/js/agregar_unidades.js"></script>
      <script src="{$public_url}views/indicadores/js/modal.js"></script>
{/block}