{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/home/css/hom_generales.css" rel="stylesheet"> *}
    <link href="{$public_url}views/home/css/hom_normativas.css" rel="stylesheet">
{/block}
{block 'contenido'}
    <!--Contenido HTML-->

        <fieldset id="ref_archivos">
            <legend>Áreas</legend>
            <form class="form-horizontal" accept-charset="utf-8">

                <div class="form-group">
                    <div class="col-md-6 col-sm-6 col-xs-12">
                       <select class="select-minimum form-control input-filter" tabindex="-1" name="selDepartamento" id="selDepartamento" data-placeholder=" - Seleccione área - ">
                        <option></option>
                        {foreach $lstDepartamentos as $obj}
                        <option value="{$obj->idDepend}">{$obj->desDepend}</option>

                        {/foreach}

                      </select>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                       <select class="select-minimum form-control input-filter" tabindex="-1" name="selunidades" id="selunidades" data-placeholder=" - Seleccione unidad - " disabled="">
                      </select>
                    </div>
                </div>

            </form>
        </fieldset>

            <fieldset>
                <legend>Documentos</legend>
                <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 200px;">
                    <ul id="lstEnlacesDoc" class="sub_folders">

                    </ul>
                </div>
                <div class="clearfix"></div>

    <hr>
                <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 300px;">
                    <ul id="listaDocumentos"></ul>
                </div>
            </fieldset>

{/block}
{block 'script'}
    <script src="{$public_url}views/home/js/doc_areas.js"></script>
{/block}