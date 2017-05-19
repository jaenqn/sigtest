{extends $_template}
{block 'contenido'}
    <h3>REGISTRO DE USUARIOS TEST</h3>
    <form action="{$base_url}testuser/registro" method="post" accept-charset="utf-8">
        <input type="text" name="txtNombre" value="" placeholder="Nombres">
        <input type="text" name="txtApellidos" value="" placeholder="Apellidos">
        <input type="text" name="txtDireccion" value="" placeholder="Dirección">
        <input type="submit" name="" value="Registrar">
    </form>
    <table class="table" style="border:1px solid black">
        <thead>
            <tr>
                <th>#</th>
                <th>NOMBRE</th>
                <th>APELLIDOS</th>
                <th>DIRECCIÓN</th>
                <th>ACCIÓN</th>
            </tr>
        </thead>
        <tbody>
            {foreach $lstUsuarios as $objU}
                 <tr>
                    <td>{$objU->idUsuario}</td>
                    <td>{$objU->userNombre}</td>
                    <td>{$objU->userApellido}</td>
                    <td>{$objU->userDireccion}</td>
                    <td>
                        <a href="{$base_url}testuser/eliminar/{$objU->idUsuario}">eliminar</a>
                        <a href="{$base_url}testuser/editar/{$objU->idUsuario}">editar</a>
                    </td>
                </tr>
            {/foreach}

        </tbody>
    </table>

{/block}