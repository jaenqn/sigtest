{extends $_template}

{block 'css'}
    {* <link href="{$public_url}views/gestor/css/carpetas.css" rel="stylesheet"> *}
    <link href="{$public_url}vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {* <link href="{$public_url}vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet"> *}
    {* <link href="{$public_url}vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet"> *}
{/block}

{block 'contenido'}
    <!--Contenido HTML-->
    <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Filtro de lista de usuarios<small>&nbsp;</small></h2>

                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <form id="frmFiltrar" data-parsley-validate class="form-horizontal form-label-left">

                        <div class="col-sm-7">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="txtNombreUsuarioF"><span>Nombre</span></label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <input type="text" id="txtNombreUsuarioF" name="txtNombreUsuarioF" required="required" class="form-control col-md-7 col-xs-12 input-filter">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label class="control-label col-md-5 col-sm-5 col-xs-12" for="selTipoUsuarioF"><span>Tipo Usuario</span></label>
                                <div class="col-md-7 col-sm-7 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selTipoUsuarioF" id="selTipoUsuarioF" data-placeholder=" - Seleccione - ">
                                    <option value="-1" selected="">Todos</option>
                                    <option value="1">Elaborador</option>
                                    <option value="2">Revisador</option>
                                    <option value="3">Jefe</option>
                                    <option value="4">Administrador</option>
                                  </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-7">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selDepUsuarioF">Departamento</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selDepUsuarioF" id="selDepUsuarioF" data-placeholder=" - Seleccione - " {if isset($lstDepUni)}disabled=""{/if}>

                                    {if isset($lstDepUni)}
                                      <option value="{$lstDepUni->dep_id}" selected="" >{$lstDepUni->dep_nombre}</option>
                                    {else}
                                      <option value="-1" selected="">Todos</option>
                                      {foreach $lstDepartamento as $obj}
                                      <option value="{$obj->dep_id}">{$obj->dep_nombre}</option>
                                      {/foreach}
                                    {/if}
                                  </select>
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12" for="selUniUsuarioF">Unidad</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                  <select class="select-default form-control input-filter" tabindex="-1" name="selUniUsuarioF" id="selUniUsuarioF" data-placeholder=" - Seleccione - " disabled="">
                                  {if isset($lstDepUni)}
                                      <option value="{$lstDepUni->idDepend}" selected="" disabled="">{$lstDepUni->desDepend}</option>
                                  {/if}
                                  </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label class="control-label col-md-5 col-sm-5 col-xs-12" for="selEstadoUsuarioF">Estado</label>
                                <div class="col-md-7 col-sm-7 col-xs-12">
                                  <select class="select-minimum form-control input-filter" tabindex="-1" name="selEstadoUsuarioF" id="selEstadoUsuarioF" data-placeholder=" - Seleccione - ">
                                    <option></option>
                                    <option value="-1" selected="">Ambos</option>
                                    <option value="1">Activo</option>
                                    <option value="0">Inactivo</option>
                                  </select>
                                </div>
                            </div>
                        </div>
                    </form>



                  </div>
                </div>
              </div>
            </div>
<div class="row">
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
      <div class="x_title">
        <h2>Lista de Usuarios<small>&nbsp;</small></h2>

        <ul class="nav navbar-right panel_toolbox">
          {* <li><a href="{$base_url}boletasig/generar_boleta"  class="btn btn-primary">Generar Boleta</a></li> *}
          <li><a  class="btn btn-primary" id="btnNuevo" style="float:right"  title="Agregar nuevo usuario" >Agregar Usuario</a></li>
          {* <li><a class="btn btn-primary">Exportar</a></li> *}
        </ul>

        <div class="clearfix"></div>
      </div>
      <div class="x_content">
        <div class="table-responsive">
          <table class="table table-striped table-hover" id="tblListar">
            <thead>
              <tr>
                <th>NOMBRE</th>
                <th>CARGO</th>
                <th>FICHA</th>
                <th>UNIDAD</th>
                <th>DEPARTAMENTO</th>
                <th>USUARIO</th>
                <th>TIPO</th>
                <th>ESTADO</th>
                <th>ACCIÓN</th>
              </tr>
            </thead>
            <tbody>
              {foreach $lstUnidades as $obj}
               <tr>
                  <th scope="row">{$obj->uni_id}</th>
                  <td>{$obj->uni_nombre}</td>
                  <td>{$obj->dep_nombre}</td>
                  <td>{$obj->getEstado()}</td>
                  <td><a href="" data-id-causa="{$obj->uni_id}">editar</a>/<a href="" data-id-causa="{$obj->uni_id}">eliminar</a></td>
              </tr>
              {/foreach}

            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modRegistro">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
              </button>
              <h4 class="modal-title" id="tituloModal">Registrar Nuevo Usuario</h4>
            </div>
            <div class="modal-body">
                <form id="frmRegistro" data-parsley-validate class="form-horizontal form-label-left"  autocomplete="off">
                    <input type="hidden" name="txtId" value="" id="txtId">
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtNombreUsuario">Nombre
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="txtNombreUsuario" name="txtNombreUsuario" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtApellidosUsuario">Apellidos
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="txtApellidosUsuario" name="txtApellidosUsuario" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtDniUsuario">DNI
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="txtDniUsuario" name="txtDniUsuario" required="required" class="form-control col-md-7 col-xs-12" maxlength="8" minlength="8">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtCargoUsuario">Cargo
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="txtCargoUsuario" name="txtCargoUsuario" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtFichaUsuario">Ficha
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="txtFichaUsuario" name="txtFichaUsuario" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selDepUsuario">Departamento
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="select-default form-control" tabindex="-1" name="selDepUsuario" id="selDepUsuario" data-placeholder=" - Seleccione - " style="width: 100%" {if isset($lstDepUni)}disabled=""{/if}>
                          {if isset($lstDepUni)}
                            <option value="{$lstDepUni->dep_id}" selected="" >{$lstDepUni->dep_nombre}</option>
                          {else}
                            <option></option>
                            {foreach $lstDepartamento as $obj}
                            <option value="{$obj->dep_id}">{$obj->dep_nombre}</option>
                            {/foreach}
                          {/if}
                          </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selUniUsuario">Unidad
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="select-default form-control" tabindex="-1" name="selUniUsuario" id="selUniUsuario" data-placeholder=" - Seleccione - " style="width: 100%" disabled="">
                          {if isset($lstDepUni)}
                            <option value="{$lstDepUni->idDepend}" selected="" >{$lstDepUni->desDepend}</option>
                          {/if}
                          </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtCuentaUsuario">Usuario
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="txtCuentaUsuario" name="txtCuentaUsuario" required="required" class="form-control col-md-7 col-xs-12">
                            <span id="erroUsuario" class="hidden">Nombre de usuario no disponible</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="txtPassUsuario">Contraseña
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="password" id="txtPassUsuario" name="txtPassUsuario" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="selTipoUsuario">Tipo Usuario
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="select-default form-control" tabindex="-1" name="selTipoUsuario" id="selTipoUsuario" data-placeholder=" - Seleccione - " style="width: 100%">
                            <option></option>
                            <option value="1">Elaborador</option>
                            <option value="2">Revisador</option>
                            <option value="3">Jefe</option>
                            <option value="4">Administrador</option>
                          </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label-left col-md-3 col-sm-3 col-xs-12" for="chkEstadoUsuario">Estado </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="checkbox" class="radio-flat flat" name="chkEstadoUsuario" id="chkEstadoUsuario"  required  checked="" />
                             Activo
                        </div>
                    </div>
                </form>
            </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar">Cancelar</button>
      <button type="button" class="btn btn-primary" id="btnRegistrar" data-accion="guardar">Guardar</button>
    </div>
  </div>
  </div>
</div>
{/block}

{block 'script'}
  <script src="{$public_url}vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    {* <script src="{$public_url}vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="{$public_url}vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="{$public_url}vendors/datatables.net-scroller/js/datatables.scroller.min.js"></script>
    <script src="{$public_url}vendors/jszip/dist/jszip.min.js"></script>
    <script src="{$public_url}vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="{$public_url}vendors/pdfmake/build/vfs_fonts.js"></script> *}
    {* <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script> *}


    <script type="text/javascript">
      var noadmin = {if isset($lstDepUni)}true{else}false{/if};
      {if isset($lstDepUni)}
      var predata = [{$lstDepUni->dep_id},{$lstDepUni->idDepend}];
      {/if}

    </script>
    <script src="{$public_url}views/gestor/js/usuarios.js" ></script>
{/block}