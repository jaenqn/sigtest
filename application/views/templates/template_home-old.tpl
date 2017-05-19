<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Hoem Template</title>
    <link rel="stylesheet" href="">
</head>
<body>

  {*   <p>Ejemplo de template </p>
    <p>Solo para el login</p>
    <p>y los enlaces</p>
    <br>
    <div id="ingreso" style="">
            <form name="fIngreso" method="POST" action="">
            <input type="hidden" name="txtEnvio" value="1">
            <table>
                <tbody><tr>
                    <td width="">
                        <a href="javascript:void(0)" onclick="ingresarX()" class="menu">  CERRAR</a>
                    </td>
                    <td>
                        <label>Usuario :</label>
                          <input name="txtUser" value="" style="font-family: Tahoma; font-size: 11px;" type="text">
                    </td>
                    <td>
                        <label>Clave :</label>
                          <input name="txtPass" value="" style="font-family: Tahoma; font-size: 11px;" maxlength="15" type="password">
                    </td>
                    <td style="">
                        <input  value=":: Ingresar::" style="cursor:pointer; font-family: Tahoma; font-size: 11px; font-weight: bold; border: #000 solid 1px;" type="submit">
                    </td>
                    </tr>
                    <tr>
                        <td>
                            <span>{$msgError|default:''}</span>
                        </td>
                    </tr>
                </tbody>
            </table>
            </form>

        </div> *}
        {block 'contenido'}
        {/block}
</body>
</html>