{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
    <style type="text/css">
        #tblMastriz > tbody tr td.td-medidas ul,#tblMastriz > tbody tr td.td-rie-imp ul{
            padding: 0px 0px 0px 10px;
        }
        .verticalText {
            writing-mode: vertical-rl;
            transform: rotate(180deg);
            text-align: center;
        }
        .th-vertical{
            height: 150px;
            vertical-align: middle !important;
        }
        .th-center-text{
            vertical-align: middle !important;
            text-align: center;
        }
        td.justificar-centrar{
            vertical-align: middle !important;
            text-align: justify;
        }
        td.solo-centrar{
            vertical-align: middle !important;
            text-align: center;
        }
    </style>
    <style type="text/css" media="print">
        body{
            background-color:white;
        }
        header, footer, nav, aside {
          display: none;
        }

    </style>
{/block}
{block 'contenido'}
    <!--Contenido HTML-->

<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_content">
            <div class="col-sm-12">

                <h4>Sede : {$objA->apr_sede}</h4>
                <h4>Departamento / Unidad : {$objA->dep_nombre}&nbsp;/&nbsp;{$objA->uni_nombre}</h4>
                <h4>Proceso : {$objA->pro_nombre}</h4>
            </div>
                <div class="col-sm-12 hidden">
                    <button type="button" class="btn btn-primary" style="float:right;padding: 3px 6px;" onclick="window.print()">Imprimir</button>
                </div>
                <div class="col-sm-12">
                    <a href="{$base_url}analisis_proceso/analis_excel/{$objA->apr_id}" class="btn btn-primary" style="float:right;padding: 3px 6px;">Exportar a Excel</a>
                    {if $smarty.session.tipo_usuario == 4}
                    <a href="{$base_url}analisis_proceso/analis_excel/{$objA->apr_id}" class="btn btn-primary" style="float:right;padding: 3px 6px;">Enviar Observación</a>
                    {/if}
                    {if $smarty.session.tipo_usuario == 4 && $objA->apr_estado == 4}
                    <a href="{$base_url}analisis_proceso/analis_excel/{$objA->apr_id}" class="btn btn-primary" style="float:right;padding: 3px 6px;">Finalizar</a>
                    {/if}

                </div>
                <div class="clearfix"></div>
                <div class="col-sm-12">

            <div class="table-responsive">
                <table class="table   table-bordered" id="tblMastriz" style="font-size: 9px">
                    <thead>

                        <tr>
                            <th rowspan="2" class="th-center-text" style="width: 90px">Etapa del Proceso</th>
                            <th rowspan="2" class="th-center-text" style="width: 90px">Actividades</th>
                            <th rowspan="2" class="th-center-text" style="width: 80px">Puesto de Trabajo</th>
                            <th colspan="3" class="th-center-text">Situación</th>
                            <th colspan="2" class="th-center-text">Ubicación</th>
                            <th rowspan="2" class="th-vertical" style="height: 150px"><p class="verticalText">Personal Propio (PP), Contratado (PC) y Visita (V)</p></th>
                            <th colspan="2" class="th-center-text">Blanco</th>
                            <th rowspan="2" class="th-center-text">Peligro / Aspecto Ambiental</th>
                            <th rowspan="2" class="th-center-text">Riesgo / Impacto Ambiental</th>
                            <th colspan="5" class="th-center-text">Evaluación de Riesgos de Seguridad y salud en el Trabajo e Impactos Ambientales</th>
                            <th rowspan="2" class="th-center-text">Medida(s) de Control de Riesgo e Impacto</th>
                        </tr>
                        <tr>
                            <th class="th-vertical"><p class="verticalText">Rutinario (Normal)</p></th>
                            <th class="th-vertical"><p class="verticalText">No Rutinario (Anormal)</p></th>
                            <th class="th-vertical"><p class="verticalText">Emergencia</p></th>
                            <th class="th-vertical"><p class="verticalText">Dentro del lugar de trabajo</p></th>
                            <th class="th-vertical"><p class="verticalText">Fuera del lugar de Trabajo</p></th>
                            <th class="th-vertical"><p class="verticalText">SGSST</p></th>
                            <th class="th-vertical"><p class="verticalText">SGA</p></th>
                            <th class="th-vertical"><p class="verticalText">Probabilidad (Pr)</p></th>
                            <th class="th-vertical"><p class="verticalText">Severidad (Se)</p></th>
                            <th class="th-vertical"><p class="verticalText">Puntaje (Pr x Se)</p></th>
                            <th class="th-vertical"><p class="verticalText">Nivel de Riesgo de Impacto</p></th>
                            <th class="th-vertical"><p class="verticalText">Riesgo e Impacto Significativo (SI) (NO)</p></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $objA->lst_etapas as $objE}
                            {$etapa = 1}
                            {foreach $objE->lst_actividades as $objAc}
                                {$actividad = 1}
                                  {$etapa = 1}

                                {foreach $objAc->lst_blan_peligros as $objP}
                                <tr>
                                    {if $etapa == 1}
                                        <td class="solo-centrar">{$objE->pet_nombre}</td>
                                    {else}
                                        <td class="solo-centrar">----</td>
                                    {/if}

                                    {if $actividad == 1}
                                    <td class="solo-centrar">{$objAc->pac_nombre}</td>
                                    {else}
                                        <td class="solo-centrar">-----</td>
                                    {/if}

                                    {if $actividad == 1}
                                    <td class="solo-centrar">{$objAc->pac_puesto_trabajo}</td>
                                    {else}
                                        <td class="solo-centrar">-----</td>
                                    {/if}



                                    {if $objAc->pac_situacion == 1}
                                    <td class="solo-centrar">X</td>
                                    <td></td>
                                    <td></td>
                                    {/if}
                                    {if $objAc->pac_situacion == 2}
                                    <td></td>
                                    <td class="solo-centrar">X</td>
                                    <td></td>
                                    {/if}
                                    {if $objAc->pac_situacion == 3}
                                    <td></td>
                                    <td></td>
                                    <td class="solo-centrar">X</td>
                                    {/if}

                                    {if $objAc->pac_ubicacion == 1}
                                    <td class="solo-centrar">X</td>
                                    <td></td>
                                    {/if}
                                    {if $objAc->pac_ubicacion == 2}
                                    <td></td>
                                    <td class="solo-centrar">X</td>
                                    {/if}

                                    {if $objAc->pac_tipo_personal == 1}
                                    <td class="solo-centrar">PP</td>
                                    {/if}
                                    {if $objAc->pac_tipo_personal == 2}
                                    <td class="solo-centrar">PC</td>
                                    {/if}
                                    {if $objAc->pac_tipo_personal == 3}
                                    <td class="solo-centrar">V</td>
                                    {/if}

                                    <td style="background-color:rgb(218, 238, 243)"></td>
                                    <td></td>

                                    <td class="justificar-centrar">{$objP->pel_nombre}</td>

                                    <td class="td-rie-imp justificar-centrar">
                                        <ul>
                                        {foreach $objP->lst_riesgos as $obj}
                                        <li>{$obj->rie_nombre}</li>
                                        {/foreach}
                                        </ul>
                                    </td>


                                    <td class="solo-centrar">{$objP->acb_vfp_pr}</td>
                                    <td class="solo-centrar">{$objP->acb_sev}</td>
                                    <td class="solo-centrar">{$objP->acb_vfp_prxse}</td>
                                    <td class="solo-centrar">{$objP->acb_vfp_nivrieimp}</td>
                                    <td class="solo-centrar">{$objP->acb_vfp_riimpsig}</td>
                                    <td class="td-medidas justificar-centrar">
                                        <ul>
                                            {foreach $objP->lst_medidas as $objM}
                                            <li>{$objM->mco_nombre}</li>
                                            {/foreach}
                                        </ul>
                                    </td>
                                </tr>
                                {$etapa = $etapa + 1}
                                {$actividad = $actividad + 1}


                                {/foreach}
                                {$etapa = 1}
                                {$actividad = 1}
                                {foreach $objAc->lst_blan_ambiental as $objAm}


                                <tr>
                                    {if $etapa == 1}
                                        <td class="solo-centrar">{$objE->pet_nombre}</td>
                                    {else}
                                        <td class="solo-centrar">----</td>
                                    {/if}

                                    {if $actividad == 1}
                                    <td class="solo-centrar">{$objAc->pac_nombre}</td>
                                    {else}
                                        <td class="solo-centrar">-----</td>
                                    {/if}

                                    {if $actividad == 1}
                                    <td class="solo-centrar">{$objAc->pac_puesto_trabajo}</td>
                                    {else}
                                        <td class="solo-centrar">-----</td>
                                    {/if}


                                    {if $objAc->pac_situacion == 1}
                                    <td class="solo-centrar">X</td>
                                    <td></td>
                                    <td></td>
                                    {/if}
                                    {if $objAc->pac_situacion == 2}
                                    <td></td>
                                    <td class="solo-centrar">X</td>
                                    <td></td>
                                    {/if}
                                    {if $objAc->pac_situacion == 3}
                                    <td></td>
                                    <td></td>
                                    <td class="solo-centrar">X</td>
                                    {/if}

                                    {if $objAc->pac_ubicacion == 1}
                                    <td class="solo-centrar">X</td>
                                    <td></td>
                                    {/if}
                                    {if $objAc->pac_ubicacion == 2}
                                    <td></td>
                                    <td class="solo-centrar">X</td>
                                    {/if}

                                    {if $objAc->pac_tipo_personal == 1}
                                    <td class="solo-centrar">PP</td>
                                    {/if}
                                    {if $objAc->pac_tipo_personal == 2}
                                    <td class="solo-centrar">PC</td>
                                    {/if}
                                    {if $objAc->pac_tipo_personal == 3}
                                    <td class="solo-centrar">V</td>
                                    {/if}

                                    <td></td>
                                    <td style="background-color:rgb(229, 184, 183)"></td>

                                    <td class="justificar-centrar">{$objAm->asp_nombre}</td>

                                    <td class="td-rie-imp justificar-centrar">
                                        <ul>
                                        {foreach $objAm->lst_impactos as $obj}
                                        <li>{$obj->imp_nombre}</li>
                                        {/foreach}
                                        </ul>
                                    </td>

                                    <td class="solo-centrar">{$objAm->aba_vfp_pr}</td>
                                    <td class="solo-centrar">{$objAm->aba_vfp_sev}</td>
                                    <td class="solo-centrar">{$objAm->aba_vfp_prxse}</td>
                                    <td class="solo-centrar">{$objAm->aba_vfp_nivrieimp}</td>
                                    <td class="solo-centrar">{$objAm->aba_vfp_riimpsig}</td>
                                    <td class="td-medidas justificar-centrar">
                                        <ul>
                                            {foreach $objAm->lst_medidas as $objM}
                                            <li>{$objM->mco_nombre}</li>
                                            {/foreach}
                                        </ul>
                                    </td>
                                </tr>
                                {$etapa = $etapa + 1}
                                {$actividad = $actividad + 1}

                                {/foreach}

                            {/foreach}
                        {/foreach}
                    </tbody>
                </table>
            </div>
                </div>

            </div>
        </div>
    </div>
</div>
{/block}
{block 'script'}
<script type="text/javascript">
    window.onload = function(){
        getById('menu_toggle').click();
    }
</script>

    <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script>
{/block}