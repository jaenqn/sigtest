{extends $_template}
{block 'contenido'}

 <div class="">
			<div class="col-md-12col-xs-12"> 
                <div class="x_panel">
  
                  <div class="x_content">


                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#tab_contDetalleBoletaG" id="tabDetalleBoletaG" role="tab" data-toggle="tab" aria-expanded="true">Detalle Boleta Generada</a>
                        </li>
                        <li role="presentation" class=""><a href="#tab_contRespuestaBoleta" role="tab" id="tabRespuestaBoleta" data-toggle="tab" aria-expanded="false">Respuesta Boleta</a>
                        </li>
                        <li role="presentation" class=""><a href="#tab_contFiscalizarBoleta" role="tab" id="tabFiscalizarBoleta" data-toggle="tab" aria-expanded="false">Fiscalizar Boleta</a>
                        </li>
                      </ul>
                      <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="tab_contDetalleBoletaG" aria-labelledby="home-tab">
                        <!-- INICIO DETALLE BOLETA GENERADA -->
                          <p>Detalle boleta generada</p>
                        <!-- FIN DETALLE BOLETA GENERADA -->
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_contRespuestaBoleta" aria-labelledby="profile-tab">
                        <!--  INICIO RESPUESTA BOLETA-->
                         <div class="x_content">

							 <div class="x_pannel">
 	<div class="x_title">
     <h2>AREA GENERADORA DE LA BOLETA <small></small></h2>
     <div class="clearfix"></div>
     </div>

     <div class="col-md-6 col-xs-12">
     <div class="x_content">
     	<label>Acciones inmediatas tomadas:</label>
     	<p style="padding: 5px;">
		<input type="checkbox" name="hobbies[]" id="hobby1" value="ski" data-parsley-mincheck="2" required class="flat" /> Colocación de recipiente
		<br />

		<input type="checkbox" name="hobbies[]" id="hobby2" value="run" class="flat" /> Cierre de accesorios
		<br />

		<input type="checkbox" name="hobbies[]" id="hobby3" value="eat" class="flat" /> Orden y Limpieza
		<br />

		<input type="checkbox" name="hobbies[]" id="hobby4" value="sleep" class="flat" /> Suspención del permiso de trabajo
		<br />

		<input type="checkbox" name="hobbies[]" id="hobby5" value="sleep" class="flat" /> Aislamiento del área
		</p>
     </div>
     </div>

     	<label for="message">Otras acciones inmediatas tomadas :</label>
		<textarea id="message" required="required" class="col-md-6 col-xs-5" name="message" data-parsley-trigger="keyup"></textarea>

</div>

<div class="x_pannel">
	<div class="clearfix"></div>

     <div class="col-md-6 col-xs-12">
     <div class="x_content">
     	<label>Acciones posteriores tomadas:</label> 
		<p style="padding: 5px;">
		<input type="checkbox" name="hobbies[]" id="hobby1" value="ski" data-parsley-mincheck="2" required class="flat" /> Aviso de avería / PM
		<br />

		<input type="checkbox" name="hobbies[]" id="hobby2" value="run" class="flat" /> SOLPED
		<br />

		<input type="checkbox" name="hobbies[]" id="hobby3" value="eat" class="flat" /> Orden de trabajo a terceros (OTT)
		<br />

		<input type="checkbox" name="hobbies[]" id="hobby4" value="sleep" class="flat" /> No amerita
		<br />
		<p>
     </div>
     </div>

     <label for="message">Otras acciones posteriores tomadas :</label>
		<textarea id="message" required="required" class="col-md-6 col-xs-5" name="message" data-parsley-trigger="keyup"></textarea>
	
	<div class="col-md-2 col-xs-4">
    <div class="x_content">
    	<label class="control-label col-md-6 col-sm-6 col-xs-12">Plazo Ejecución</label>
    </div>
    </div>
	<br/>
	<br/>
	
	<div class="col-md-2 col-xs-4">
	<div class="x_content">
		<div class="form-group">
    <!-- <label class="control-label col-md-3 col-sm-3 col-xs-6">Plazo Ejecución</label> -->
        <div class="col-md-9 col-sm-9 col-xs-12">
        <select class="form-control">
        <option>-Mes-</option>
        <option>Enero</option>
        <option>Febrero</option>
        <option>Marzo</option>
        <option>Abril</option>
        </select>
        </div>
        </div>
    </div>
    </div>

	
	<div class="col-md-2 col-xs-4">
    <div class="x_content">
		<div class="form-group">
       <!-- <label class="control-label col-md-3 col-sm-3 col-xs-6">Select</label> -->
        <div class="col-md-9 col-sm-9 col-xs-12">
        <select class="form-control">
        <option>-Año-</option>
        <option>Option one</option>
        <option>Option two</option>
        <option>Option three</option>
        <option>Option four</option>
        </select>
        </div>
        </div>
    </div>
	</div>




 </div> 

 <div class="x_pannel">    
 	<div class="clearfix"></div>
 	<p><label for="message">Descripcion de la Observacion :</label>
                          <textarea id="message" required="required" class="form-control" name="message" data-parsley-trigger="keyup" data-parsley-minlength="50" data-parsley-maxlength="100" data-parsley-minlength-message="Come on! You need to enter at least a 50 caracters long comment.."
                            data-parsley-validation-threshold="10"></textarea>
	
	          <p><div class="">
                    <h2>Archivos Adjuntos:</h2>
                    <div class="clearfix"></div> 
                    <div class="x_content">
                    <form action="form_upload.html" class="dropzone"></form>
               
                    </div>
                    </div>
                    </div>
                    </div>    
                   


             <form class="form-horizontal form-label-left input_mask">
                <div class="col-md-6 col-xs-12 ">
                  <div class="x_panel">
                      <div class="x_title">
                    <h2>Supervisor Dependencia Observada:(autogenerada)</h2>
                    <div class="clearfix">
                      
                    </div>
                      </div>
                    <div class="x_content">
                      <div class="col-md-6 col-sm-6 col-xs-6 form-group has-feedback">
                        <input type="text" class="form-control has-feedback-left" id="inputSuccess1" placeholder="Nombre(s) y Apelllido(s)">
                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                      </div>

                      <div class="col-md-6 col-sm-6 col-xs-6 form-group has-feedback">
                        <input type="text" class="form-control has-feedback-left" id="inputSuccess1" placeholder="N° Ficha">
                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                      </div>

                      <div class="col-md-6 col-sm-6 col-xs-6 form-group has-feedback">
                        <input type="text" class="form-control has-feedback-left" id="inputSuccess1" placeholder="N° DNI	">
                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                      </div>

                    </div>
                  </div>
                  </div>
                
                  <div class="col-md-6 col-xs-12 ">
                  <div class="x_panel">
                      <div class="x_title">
                    <h2>&nbsp;</h2>
                    <div class="clearfix">
                      
                    </div>
                      </div>
                    <div class="x_content">
                      <div class="calendar second left" style="display: none;">
                            <div class="calendar-date">
                              <table class="table-condensed">
                                <thead>
                                  <tr>
                                    <th class="prev available"><i class="fa fa-arrow-left icon icon-arrow-left glyphicon glyphicon-arrow-left"></i>
                                    </th>
                                    <th colspan="5" class="month">Mar 2013</th>
                                    <th class="next available"><i class="fa fa-arrow-right icon icon-arrow-right glyphicon glyphicon-arrow-right"></i>
                                    </th>
                                  </tr>
                                  <tr>
                                    <th>Su</th>
                                    <th>Mo</th>
                                    <th>Tu</th>
                                    <th>We</th>
                                    <th>Th</th>
                                    <th>Fr</th>
                                    <th>Sa</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <tr>
                                    <td class="available off" data-title="r0c0">24</td>
                                    <td class="available off" data-title="r0c1">25</td>
                                    <td class="available off" data-title="r0c2">26</td>
                                    <td class="available off" data-title="r0c3">27</td>
                                    <td class="available off" data-title="r0c4">28</td>
                                    <td class="available" data-title="r0c5">1</td>
                                    <td class="available" data-title="r0c6">2</td>
                                  </tr>
                                  <tr>
                                    <td class="available" data-title="r1c0">3</td>
                                    <td class="available" data-title="r1c1">4</td>
                                    <td class="available" data-title="r1c2">5</td>
                                    <td class="available" data-title="r1c3">6</td>
                                    <td class="available" data-title="r1c4">7</td>
                                    <td class="available" data-title="r1c5">8</td>
                                    <td class="available" data-title="r1c6">9</td>
                                  </tr>
                                  <tr>
                                    <td class="available" data-title="r2c0">10</td>
                                    <td class="available" data-title="r2c1">11</td>
                                    <td class="available" data-title="r2c2">12</td>
                                    <td class="available" data-title="r2c3">13</td>
                                    <td class="available" data-title="r2c4">14</td>
                                    <td class="available" data-title="r2c5">15</td>
                                    <td class="available" data-title="r2c6">16</td>
                                  </tr>
                                  <tr>
                                    <td class="available" data-title="r3c0">17</td>
                                    <td class="available active start-date end-date" data-title="r3c1">18</td>
                                    <td class="available" data-title="r3c2">19</td>
                                    <td class="available" data-title="r3c3">20</td>
                                    <td class="available" data-title="r3c4">21</td>
                                    <td class="available" data-title="r3c5">22</td>
                                    <td class="available" data-title="r3c6">23</td>
                                  </tr>
                                  <tr>
                                    <td class="available" data-title="r4c0">24</td>
                                    <td class="available" data-title="r4c1">25</td>
                                    <td class="available" data-title="r4c2">26</td>
                                    <td class="available" data-title="r4c3">27</td>
                                    <td class="available" data-title="r4c4">28</td>
                                    <td class="available" data-title="r4c5">29</td>
                                    <td class="available" data-title="r4c6">30</td>
                                  </tr>
                                  <tr>
                                    <td class="available" data-title="r5c0">31</td>
                                    <td class="available off" data-title="r5c1">1</td>
                                    <td class="available off" data-title="r5c2">2</td>
                                    <td class="available off" data-title="r5c3">3</td>
                                    <td class="available off" data-title="r5c4">4</td>
                                    <td class="available off" data-title="r5c5">5</td>
                                    <td class="available off" data-title="r5c6">6</td>
                                  </tr>
                                </tbody>
                              </table>
                            </div>
                          </div>

                        <fieldset>
                          <div class="control-group">
                            <div class="controls">
                              <div class="col-md-10 xdisplay_inputx form-group has-feedback">
                                <input type="text" class="form-control has-feedback-left" id="single_cal2" placeholder="Fecha" aria-describedby="inputSuccess2Status2">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                              </div>
                            </div>
                          </div>
                        </fieldset>

                    </div>
                  </div>
                  </div>
                  </form>
 	
 </div>



                         </div>
                        <!-- FIN RESPUESTA BOLETA -->
                        </div>
                        </p></p></div>
                        </div>


						</p></p></div></div></div>

                        <div role="tabpanel" class="tab-pane fade" id="tab_contFiscalizarBoleta" aria-labelledby="profile-tab">
                        <!-- INICIO FISCALIZAR BOLETA -->
                          <p>FISCALIZAR BOLETA </p>
                        <!-- FIN FISCALIZAR BOLETA -->
                        </div>
                      </div>
                    </div>

                </div>
             

           
	</div>
 </div>

{/block}

{block 'script'}
{/block}
