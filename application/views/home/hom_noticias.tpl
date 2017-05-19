{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
{/block}
{block 'contenido'}
    <!--Contenido HTML-->
  <article>


        <div class="post-image">
            <div class="post-heading">
                <h3><a href="#">{$objNot->not_titulo}</a></h3>
            </div>
            {if $objNot->portada}
            <img src="{$base_url}/docs/_noticias/{$objNot->not_id}/{$objNot->portada->dno_nombre_fichero}" alt="{$objNot->portada->dno_nombre_fichero}" title="{$objNot->portada->dno_nombre_fichero}" class="img-responsive" />
            {/if}
        </div>

        <div class="post-article">

        {$objNot->not_contenido}
        </div>

        <div class="bottom-article">
            <ul class="meta-post">
                {* <li><i class="fa fa-calendar"></i><a > Mar 27, 2014</a></li> *}
                <li><i class="fa fa-calendar"></i><a > {$objNot->not_fecha_generado} </a></li>
                <li><i class="fa fa-user"></i><a > {$objNot->not_autor} </a></li>
                <!--
                <li><i class="fa fa-comments"></i><a href="#">4 Comments</a></li>
                <li><i class="fa fa-tags"></i><a href="#">Design</a>, <a href="#">Blog</a></li>
                -->
            </ul>
        </div>
</article>
{/block}
{block 'script'}
    {* <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script> *}
{/block}