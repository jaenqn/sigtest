{extends $_template}
{block 'css'}
    <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet">
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
{/block}
{block 'script'}
    <!--
    En public existe la carpeta views, en ella se crean las carpetas con el nombre del controlador y de ser bnecesario
    las carpetas 'css' y 'js'
    {$public_url} apunta directamente a la carpeta 'public'
    -->

    <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script>
{/block}