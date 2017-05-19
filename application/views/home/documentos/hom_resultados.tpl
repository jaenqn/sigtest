{extends $_template}
{block 'css'}
    <link href="{$public_url}views/home/css/hom_normativas.css" rel="stylesheet">

{/block}
{block 'contenido'}
    <!--Contenido HTML-->

        <fieldset id="ref_archivos">
            <legend >Documentos Encontrados :  '{$s_cadena}'</legend>
                <div class="clearfix"></div>
                <div class=" col-sm-12" data-mcs-theme="dark" ">
                    <ul id="listaDocumentos">
                        {foreach $lstDocs as $obj}
                            <li>
                                <div>
                                    <div><img src="{$public_url}app/img/iconos/{$obj->nameFile}" title="{$obj->nameFileTwo}"></img></div>
                                    <div><a href="{$base_url}{$obj->rutaDoc}{$obj->nombreDoc}" target="_blank">{if $obj->desDoc == ''}{$obj->nombreDoc}{else}{$obj->desDoc}{/if}</a></div>
                                    <div><span>{$obj->versionDoc}</span></div>
                                    <div><span>{if $obj->fecAprobacionArchivo == '0000-00-00 00:00:00'}&nbsp;{else}{$obj->fecAprobacionArchivo}{/if}</span></div>
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                    <div class="text-center">
                            {if $np != 0}
                            <ul class="pagination">
                                  {*   <li><a href="{if $pageprev != ''}{$base_url}home/document?s={$query}&p={$pageprev}{else}#{/if}" {if $pageprev == ''}disabled=""{/if}>&laquo;</a></li> *}
                                    {foreach $pagest as $pag}
                                    <li {if +$npage == +$pag}class="active"{/if}><a href="{if $pag != '...'}{$base_url}home/document?s={$query}&p={$pag}{else}#{/if}" {if $pag == '...'}disabled=""{/if}>{$pag}</a></li>
                                    {/foreach}

                                   {*  <li><a href="{if $pagesig != ''}{$base_url}home/document?s={$query}&p={$pagesig}{else}#{/if}" {if $pagesig == ''}disabled=""{/if}>&raquo;</a></li> *}
                          {*       <li><a href="#">&laquo;</a></li>
                                    {for $i = 1 to $np}
                                    <li><a href="{$base_url}home/document?s={$query}&p={$i}">{$i}</a></li>
                                    {/for}
                                <li><a href="#">&raquo;</a></li> *}
                            </ul>
                            {else}
                                <h3>Sin resultados</h3>
                            {/if}
                    </div>
                </div>




        </fieldset>
        </br>

      {*   <fieldset>
                <legend>Normas legales encontradas</legend>
                <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 200px;">
                    <ul id="lstEnlacesDoc">
                        {foreach $lstCarpetasGenerales as $obj}
                            <li><a href="#" class="ref_carpetas" data-id-carpeta="{$obj->idCarpeta}">{$obj->descripcionCarpeta}</a></li>
                        {/foreach}
                    </ul>
                </div>
                <div class="clearfix"></div>


                <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 420px;">
                    <ul id="listaDocumentos"></ul>
                </div>
            </fieldset> *}

{/block}
{block 'script'}

{/block}