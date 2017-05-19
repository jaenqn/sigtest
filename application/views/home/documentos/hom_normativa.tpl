{extends $_template}
{block 'css'}
    <link href="{$public_url}views/home/css/hom_normativas.css" rel="stylesheet">

{/block}
{block 'contenido'}
    <!--Contenido HTML-->

        <fieldset id="ref_archivos">
            <legend >Normativa legal</legend>

                <div class="widget">

                    <form role="form" id="frmBuscarNormativa" class="">
                      <div class="form-group">
                        <div class="col-sm-6 col-xs-12 col-sm-offset-2">
                              <input type="text" class="form-control " id="txtSearch" name="txtSearch" placeholder="Ingrese descripción de la norma legal">
                        </div>
                        <div class="col-xs-12 col-sm-2">
                            <button type="submit" class="form-control btn btn-success ">Buscar</button>
                        </div>
                      </div>

                    </form>

                </div>


        </fieldset>
        </br>

        <fieldset>
                <legend>Normas legales encontradas</legend>
            {*     <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 200px;">
                    <ul id="lstEnlacesDoc">
                        {foreach $lstCarpetasGenerales as $obj}
                            <li><a href="#" class="ref_carpetas" data-id-carpeta="{$obj->idCarpeta}">{$obj->descripcionCarpeta}</a></li>
                        {/foreach}
                    </ul>
                </div> *}
                <div class="clearfix"></div>


                <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark" style="height: 420px;">
                    <ul id="listaDocumentos"></ul>
                </div>
            </fieldset>

{/block}
{block 'script'}
    <script type="text/javascript">

            var ID_CATEGORIA = {{$categoria}};
            var ID_CARPETAS = {{$jsonCarpetas}};

    </script>
    <script src="{$public_url}views/home/js/doc_normativa.js"></script>
{/block}