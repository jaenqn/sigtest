{extends $_template}
{block 'contenidoCss'}
<style type="text/css" >
<!--
.table-reporte{
  width: 100%;
  /*border: 1px solid black;*/
}
.table-reporte .par{
  /*background: blue;*/
}
.table-reporte tr td{


  /*border:1px solid black;*/
  /*border-bottom: 1px solid black;*/

}
.table-reporte tr th{
  padding: 5px 10px;
}
.table-reporte tr td{
  padding: 4px 4px;
  font-size: 12px;
  height: 12px;

}
.table-reporte thead tr th{
  /*border-bottom: 1px solid black;*/

}
.bold{
    font-family: asapb;
}
-->
</style>
{/block}
{block 'contenido'}
{*  <div style="width:100%;">
    <table style="width:100%;" bgcolor="" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="3" style="width:100%"> <b><p>EMPLEADOS QUE POSEEN DOCTORADO:</p></b></td>
      </tr>
      <tr>
        <td style="width:10%">Fecha</td>
        <td style="width:5%;text-align:center;"">:</td>
        <td style="width:80%">{$smarty.now|date_format:"%A, %B %e, %Y"}</td>
      </tr>
      <tr>
        <td style="width:10%">Hora</td>
        <td style="width:5%;text-align:center;"">:</td>
        <td style="width:80%">{$smarty.now|date_format:"%X"}</td>
      </tr>
    </table>
  </div> *}

<table class="table-reporte" cellpadding="0" cellspacing="0">
    <thead>
    <tr>
        <th colspan="2" style='text-align: center;font-family: asapb'><strong><span>SOLICITUD</span> : {$objResiduo->rss_correlativo}</strong></th>
    </tr>
        <tr>
            <th style="width:50%">Cod</th>
            <th style="width:50%">Cod</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Correlativo</td>
            <td>{$objResiduo->rss_correlativo}</td>
        </tr>
        <tr>
            <td>Correlativo</td>
            <td>{$objResiduo->unidad_generadora->dep_nombre}</td>
        </tr>
        <tr>
            <td>Correlativo</td>
            <td>{$objResiduo->unidad_generadora->desDepend}</td>
        </tr>
        <tr>
            <td>Correlativo</td>
            <td>{$objResiduo->rss_fecha_solicitud}</td>
        </tr>
        <tr>
            <td>Correlativo</td>
            <td>{$objResiduo->rss_fecha_autorizado}</td>
        </tr>
        <tr>
            <td>Orgánico</td>
            <td>{if $objResiduo->res_organico == 1}SÍ{else}NO{/if}</td>
        </tr>
        <tr>
            <td>Tipo</td>
            <td>{if $objResiduo->res_peligro == 1}Peligroso{else}No Peligroso{/if}</td>
        </tr>
        <tr>
            <td>Estado</td>
            <td>{if $objResiduo->res_estado == 2}Líquido{else}Sólido{/if}</td>
        </tr>
        <tr>
            <td>Peso</td>
            <td>{$objResiduo->rss_peso}</td>
        </tr>
        <tr>
            <td>Volumen</td>
            <td>{$objResiduo->rss_volumen}&nbsp;{foreach $tipos_volumen as $obj}{if $obj[1] == $objResiduo->rss_volumen_tipo}{$obj[0]}{break}{/if}{/foreach}</td>
        </tr>
        <tr>
            <td>Unidades</td>
            <td>{$objResiduo->rss_unidades}</td>
        </tr>
        <tr>
            <td>Procedencia del Residuo</td>
            <td>{$objResiduo->rso_nombre}</td>
        </tr>
        <tr>
            <td>Lugar de Almcenamiento</td>
            <td>{$objResiduo->alm_nombre}</td>
        </tr>
        <tr>
            <td>Nombre</td>
            <td>{$objResiduo->empc_nombre}</td>
        </tr>
        <tr>
            <td>¿Personal con EPP necesarios?</td>
            <td>{if $objResiduo->rss_epp ==  1}SÍ{else}NO{/if}</td>
        </tr>
        <tr>
            <td>Observaciones</td>
            <td>{$objResiduo->rss_observaciones}</td>
        </tr>
        <tr>
            <td>Nombre</td>
            <td>{$objResiduo->involucrados.elaborador->rsi_nombre}</td>
        </tr>
        <tr>
            <td>Ficha</td>
            <td>{$objResiduo->involucrados.elaborador->rsi_ficha}</td>
        </tr>
        <tr>
            <td>Dni</td>
            <td>{$objResiduo->involucrados.elaborador->rsi_dni}</td>
        </tr>
        <tr>
            <td>Nombre</td>
            <td>{$objResiduo->involucrados.autorizador->rsi_nombre}</td>
        </tr>
        <tr>
            <td>Ficha</td>
            <td>{$objResiduo->involucrados.autorizador->rsi_ficha}</td>
        </tr>
        <tr>
            <td>Dni</td>
            <td>{$objResiduo->involucrados.autorizador->rsi_dni}</td>
        </tr>
    </tbody>
</table>

{/block}