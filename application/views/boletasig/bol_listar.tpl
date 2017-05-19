{extends $_template}
{block 'css'}

    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="{$public_url}views/boletasig/css/gb_color_estado.css" rel="stylesheet">
    <style type="text/css">
        .td-middle{
            vertical-align: middle !important;
            text-align: center !important;
        }
        .dt-buttons.btn-group{
            display:none !important;
        }
        .x_title a>span{
            color:white;
        }
    </style>
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Filtro de lista <small></small></h2>

                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

                        <div class="col-sm-5 col-xs-12">
                            <div class="form-group">
                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="txtNroBoleta"><span>Nro Boleta</span></label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <input type="text" id="txtNroBoleta" name="txtNroBoleta" required="required" class="form-control col-md-12 col-xs-12 input-filter">
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-7 col-xs-12">

                                <div class="form-group">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-12" for="selTipoBoletaF"><span>Tipo boleta</span></label>
                                    <div class="col-md-4 col-sm-4 col-xs-12">
                                      <select class="select-minimum form-control input-filter" tabindex="-1" name="selTipoBoletaF" id="selTipoBoletaF" data-placeholder=" - Seleccione - " style="width:100%">
                                        <option value="-1" selected="">Ambos</option>
                                        {foreach from=collection item=item key=key name=name}
                                        <option value="{ent_boleta::getTipoBoleta('ambiental')}">Ambiental</option>
                                        <option value="{ent_boleta::getTipoBoleta('seguridad')}">Seguridad</option>
                                        {/foreach}

                                      </select>
                                    </div>


                                    <label class="control-label col-md-2 col-sm-2 col-xs-12" for="selEstadoF"><span>Estado</span></label>
                                    <div class="col-md-4 col-sm-4 col-xs-12">
                                      <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoF" id="selEstadoF" data-placeholder=" - Seleccione - " style="width:100%">
                                        <option value="-1" selected="">Todos</option>
                                        {foreach ent_boleta::lstEstados() as $val}
                                        <option value="{$val.value}">{$val.name|capitalize}</option>

                                        {/foreach}

                                      </select>
                                    </div>
                                </div>


                         {*        <div class="form-group">
                                </div> *}



                        </div>
                        <div class="clearfix"></div>
                        {assign var='msref' value=7}
                        {assign var='msrefw' value=8}
                        {assign var='mostrardiv' value=false}

                        {if $smarty.session.tipo_usuario == ent_usuarios::getUsuario('admin-sig')}
                            {$mostrardiv = true}
                        {elseif $smarty.session.tipo_usuario == ent_usuarios::getUsuario('administrador')}
                            {if $smarty.session.id_unidad == procesos_sig::autoriza('boleta_ambiental') || $smarty.session.id_unidad == procesos_sig::autoriza('boleta_seguridad')}
                                {$mostrardiv = true}
                            {else}
                                {$msref = 5}
                                {$msrefw = 9}
                            {/if}
                        {else}
                            {$msref = 5}
                            {$msrefw = 9}
                        {/if}
                        {if $mostrardiv == true}
                            <div class="col-sm-5 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label col-md-2 col-sm-2 col-xs-12" for="selUniDeF">De</label>
                                    <div class="col-md-9 col-sm-9 col-xs-12">
                                      <select class="select-default form-control input-filter" tabindex="-1" name="selUniDeF" id="selUniDeF" data-placeholder=" - Seleccione - " style="width:100%">
                                        <option value="-1" selected="">Todos</option>
                                        {foreach $lstunidades as $obj}
                                        <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                                        {/foreach}
                                      </select>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        <div class="col-sm-{$msref} col-xs-12">
                           <div class="form-group">
                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="selUniParaF">A</label>
                                <div class="col-md-{$msrefw} col-sm-{$msrefw} col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selUniParaF" id="selUniParaF" data-placeholder=" - Seleccione - "  style="width:100%">
                                    <option value="-1" selected="">Todos</option>

                                    {foreach $lstunidades as $obj}
                                    <option value="{$obj->idDepend}">{$obj->desDepend}</option>
                                    {/foreach}
                                  </select>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>


                        <div class="col-sm-5 col-xs-12">

                            <div class="control-group">
                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="txtFechaInicio">Fecha</label>
                                <div class="controls">
                                  <div class="col-md-9 col-xs-12 xdisplay_inputx form-group has-feedback">
                                    <input type="text" class="form-control has-feedback-left txtFechas" id="txtFechaInicio" placeholder="dd/mm/yyyy" aria-describedby="inputSuccess2Status2">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                    <span id="inputSuccess2Status2" class="sr-only">(success)</span>
                                  </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-sm-7 col-xs-12">

                            <div class="form-group">
                                <label class="control-label col-md-2 col-sm-2 col-xs-12" for="selPlazo"><span>Plazo ejecución</span></label>
                                <div class="col-md-5 col-sm-5 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selPlazo" id="selPlazo" data-placeholder=" - Seleccione - " style="width:100%">
                                  <option></option>

                                    <option value="1">Enero</option>
                                    <option value="2">Febrero</option>
                                    <option value="3">Marzo</option>
                                    <option value="4">Abril</option>
                                    <option value="5">Mayo</option>
                                    <option value="6">Junio</option>
                                    <option value="7">Julio</option>
                                    <option value="8">Agosto</option>
                                    <option value="9">Septiembre</option>
                                    <option value="10">Octubre</option>
                                    <option value="11">Noviembre</option>
                                    <option value="12">Diciembre</option>
                                  </select>
                                </div>
                                <label class="control-label col-md-1 col-sm-1 col-xs-12" for="selPlazoYear" style="height: 0.5em;"><span>&nbsp;</span></label>
                                <div class="col-md-4 col-sm-5 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selPlazoYear" id="selPlazoYear" data-placeholder=" - Seleccione - " style="width:100%" disabled="">
                                  <option></option>
                                  </select>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                </form>

                {* <div class="col-sm-12">
                    <a href="{$base_url}boletasig/generar_boleta" style="float:right"  class="btn btn-primary">Generar boleta</a>
                </div> *}
                {* <div class="clearfix"></div> *}
                {* <hr> *}
                {* <p style="font-size: 1.2em;"><b>Lista de boletas SIG</b></p> *}

            </div>
        </div>
    </div>
</div>
<div class="row">

    <div class="col-sm-12 col-md-12 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                  <h2>Lista de Boletas SIG</h2>
                  <ul class="nav navbar-right panel_toolbox app" id="accionesLista">
                    {if $smarty.session.tipo_usuario == 1 || $smarty.session.tipo_usuario ==  2}
                    <li><a href="{$base_url}boletasig/generar_boleta"  class="btn btn-primary">Generar Boleta</a></li>
                    {/if}

                    <li id="imprimirLista"></li>
                    <li><a class="btn btn-primary">Exportar</a></li>
                 {*    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                      <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Settings 1</a>
                        </li>
                        <li><a href="#">Settings 2</a>
                        </li>
                      </ul>
                    </li> *}
                   {*  <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li> *}
                  </ul>
                  <div class="clearfix"></div>
                </div>
            {* <div class="x_title">
                <h2></h2>
            </div> *}
            <div class="x_content">

              {*   <a href="{$base_url}boletasig/generar_boleta" style="float:right"  class="btn btn-primary">Generar boleta</a>
                <div class="clearfix"></div>


                <div>
                        <button type="button" class="btn btn-primary" style="float:right">Imprimir</button><button type="button" class="btn btn-primary" style="float:right">Exportar</button>
                    </div>
                    <div class="clearfix"></div>
                    <h2>Lista de Boletas SIG </h2> *}
                <div class="table-responsive">

                    <table class="table table-striped " id="tblListar">
                        <thead>
                            <tr>
                                <th>BOLETA</th>
                                <th>TIPO</th>
                                <th>UNI. GENERADORA</th>
                                <th>UNI. OBSERVADA</th>
                                <th>FECHA</th>
                                <th>PLAZO DE RESPUESTA</th>
                                <th>PLAZO DE EJECUCIÓN</th>
                                <th>ESTADO</th>
                                <th>REVISIÓN</th>
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
    <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
      <script src="{$public_url}vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
      <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
      <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>

    <script type="text/javascript">
        var ocultar_columna = {if $mostrardiv == true}false{else}2{/if};

        let ent_boleta = (function(){
            let estados = {echo_json(ent_boleta::lstEstados())};
            let res_deso = {ent_boleta::ambiental()};
            let res_segu = {ent_boleta::seguridad()};
            class ent_boleta{
                constructor(){}
                static getEstado(target){
                    for (var i = 0 ; i < estados.length; i++) {
                        if(estados[i].name == target){
                            return estados[i].value;
                            break;
                        }

                    };
                    return false;
                }
                static getRespondeBoleta(tipo_voleta){
                    switch(+tipo_voleta){
                        case 1:
                            return res_deso;
                            break;
                        case 2:
                            return res_segu;
                            break;
                        default:
                            return 0;
                            break;
                    }
                }

            }
            return ent_boleta;
        })();
        let ent_usuarios = (function(){
            let estados = [];
            $.getJSON("{base_url('usuario/get_tipos_usuarios')}",{},(j,t)=>{
                estados = j;
            })
            class ent_usuarios{
                constructor(){}
                static getEstado(target){
                    for (var i = 0 ; i < estados.length; i++) {
                        if(estados[i].name == target){
                            return estados[i].value;
                            break;
                        }

                    };
                    return false;
                }
                static isUsuario(target, usuarios){
                    if(Array.isArray(usuarios)){
                        for (var i = 0; i < usuarios.length; i++) {
                            if(this.getEstado(usuarios[i]) == target) return true;
                        };

                    }else if(this.getEstado(usuarios) == target) return true;
                    return false;
                }


            }
            return ent_usuarios;
        })();
    </script>
    <script src="{$public_url}views/boletasig/js/bol_listar.js"></script>
{/block}