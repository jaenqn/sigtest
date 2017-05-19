 <link href="{$public_url}vendors/normalize-css/normalize5.css" rel="stylesheet">
 <style type="text/css">
<!--
.ladoA{
    width: 40%;
    display: inline;
    vertical-align: baseline;
    background: blue;
}
.ladoB{
    width: 50%;
    display: inline;
    vertical-align: baseline;

}
.container-header{

    vertical-align: middle;
}

.table-titulos tr td{

    overflow: hidden;
    width: 100%;
    text-align: center;

}
.table-titulos .tt-titulo{
    font-size: 18px;
}
.table-titulos .tt-subtitulo{
    font-size: 14px;
}
.inst-logo{
    width: 40%;
}
.inst-oficina{
    width: 60%;


}
.inst-oficina{
    /*background: blue;*/

}
.table-titulos{

    width: 100%;
}
.table-header{
    width: 100%;
}
-->
 </style>
 {block 'contenidoCss'}
 {/block}
 <page backtop="30mm" backbottom="10mm" backleft="0mm" backright="0mm">
      <page_header>
            <table class="table-header">
                <tr>
                    <td class="inst-logo">
                        <img src="{$public_url}app/img/logopetroperu.jpg" alt="" style="height: 25mm;">
                    </td>
                    <td class="inst-oficina">
                        <table class="table-titulos">
                            <tr >
                                <td class="tt-titulo" style=""><strong><span>{$title}</span></strong></td>
                            </tr>
                            <tr>
                                <td class="tt-subtitulo" style=""><strong><span>{$sub_title}</span></strong></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
      </page_header>
      <page_footer>
           <table style="border-top:1px solid black;width:100%;font-size:11px;">
               <tr>
                   <td style="width:60%">
                       <span>Dirección: Refinería Selva</span>
                   </td>
                   <td style="width:40%;text-align:right;">
                       <span>www.petroperu.pe</span>
                   </td>
               </tr>
               <tr>
                   <td colspan="2" style="width:100%;">E-mail: petro@petreperu.edu.pe</td>
               </tr>
           </table>
      </page_footer>
      {block 'contenido'}
      {/block}

 </page>
