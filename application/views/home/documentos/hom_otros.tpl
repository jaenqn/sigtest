{extends $_template}
{block 'css'}
    <link href="{$public_url}views/home/css/hom_generales.css" rel="stylesheet">
{/block}
{block 'contenido'}
    <!--Contenido HTML-->

        <fieldset id="ref_archivos"
>            <legend >Otros Documentos</legend>
            <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 200px;">
                    <ul id="lstEnlacesDoc">
                        {foreach $lstCarpetasGenerales as $obj}
                            <li><a href="#" class="ref_carpetas ini" data-id-carpeta="{$obj->idCarpeta}"><span class="estado-folder">&nbsp;+&nbsp;</span>&nbsp;{$obj->descripcionCarpeta}</a></li>
                        {/foreach}
                    </ul>
            </div>

        </fieldset>
        <fieldset>
                <legend>Documentos</legend>

                <div class="clearfix"></div>


                <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 300px;">
                    <ul id="listaDocumentos"></ul>
                </div>
            </fieldset>

{/block}
{block 'script'}
    <script src="{$public_url}views/home/js/doc_generales.js"></script>
{/block}