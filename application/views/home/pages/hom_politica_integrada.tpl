{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
{/block}
{block 'contenido'}
<div class="container">
    <!--Contenido HTML-->
    <div class="row">
        <table border="0" cellpadding="0" cellspacing="0" align="center" class="col-sm-8 col-sm-offset-2">
            <tr>
                <td style="text-align:center"><span style="font-size: 2em"><b >POLÍTICA DE GESTIÓN INTEGRADA DE LA CALIDAD, AMBIENTE, SEGURIDAD Y SALUD EN EL TRABAJO</b></span></td>

            </tr>
            <tr>
                <td style="text-align: center">
                    <center>
                    <div style=" text-align: justify;  font-size: 13px; padding: 25px">
                        <img src="{$public_url}app/img/politicaimg.jpg">

                     <br>  <br>
                        Petr&#243;leos del Per&#250; - PETROPER&#218; S.A. es una Empresa Estatal del Sector Energ&#237;a y Minas de Derecho Privado, creada con el objeto social de llevar a cabo actividades de hidrocarburos en las fases de Exploraci&#243;n, Explotaci&#243;n, Procesamiento, Refinaci&#243;n, Almacenamiento, Transporte, Distribuci&#243;n y Comercializaci&#243;n de hidrocarburos, incluyendo sus derivados, Petroqu&#237;mica B&#225;sica e Intermedia y otras formas de energ&#237;a.
                        <br><br>
                       PETROPER&#218; S.A. gestiona sus actividades asegurando la calidad y competitividad de sus productos y servicios para satisfacer las necesidades de sus clientes; protegiendo el ambiente, la integridad f&#237;sica, la salud y la calidad de vida de sus trabajadores, colaboradores y otras personas que puedan verse involucradas en sus operaciones; y la protecci&#243;n de la propiedad, bajo un enfoque preventivo, de eficiencia integral y mejora continua. Asimismo, promueve el fortalecimiento de sus relaciones con la comunidad de su entorno, realizando esfuerzos para desempe&#241;ar sus actividades de forma sostenible, reduciendo sus posibles impactos negativos.
                       <br><br>
                       <span style="color: darkolivegreen; font-weight: bold">
                       Para ello, en sus lugares de trabajo desarrolla su gesti&#243;n integrada de la calidad, ambiente, seguridad y salud en el trabajo, basada en los siguientes compromisos:
                       </span>
                       <br><br>
                       <ul>
                       <li style="color: darkolivegreen;">
                           <span style="color:#222;">
                           Desempe&#241;ar sus actividades de manera responsable y eficiente manteniendo sistemas de gesti&#243;n auditables.
                           </span>
                       </li>
                       <br>
                       <li style="color: darkolivegreen;">
                           <span style="color:#222;">
                            Identificar, evaluar y controlar los aspectos ambientales, los peligros y riesgos de sus procesos, productos y servicios, previniendo la contaminaci&#243;n ambiental, da&#241;os a la propiedad y el deterioro de la salud de las personas con el objetivo de satisfacer las necesidades de sus clientes.
                           </span>
                       </li>
                       <br>
                       <li style="color: darkolivegreen;">
                           <span style="color:#222;">
                            Cumplir la legislaci&#243;n vigente, la normativa interna; y los compromisos voluntariamente suscritos.
                           </span>
                       </li>
                       <br>
                       <li style="color: darkolivegreen;">
                           <span style="color:#222;">
                        Promover el desarrollo de las competencias de sus trabajadores, orientadas al cumplimiento de los objetivos y de las metas establecidas.
                           </span>
                       </li>
                       <br>
                       <li style="color: darkolivegreen;">
                         <span style="color:#222;">
                        Difundir esta pol&#237;tica a sus trabajadores, clientes, colaboradores, autoridades, comunidad y otros grupos de inter&#233;s, fomentando una actitud diligente, a trav&#233;s de una sensibilizaci&#243;n y de capacitaci&#243;n adecuadas a sus requerimientos.
                         </span>
                       </li>
                       <br>
                       <li style="color: darkolivegreen;">
                         <span style="color:#222;">
                        Proveer a toda la organizaci&#243;n de los recursos necesarios y requeridos para lograr un desempe&#241;o acorde con la presente Pol&#237;tica.
                         </span>
                       </li>
                       </ul>
                       <br>
                        <span style="font-weight: bold">Acuerdo de Directorio N° 053-2013-PP</span>
                    </div>
                    </center>
            <div style="text-align: left">
              {* <?php
              $resPoli=$objLN->listaPolitica();
              $arraPoli=$objLN->NextObject($resPoli);
              ?>
                <?php //echo  $arraPoli->desDoc;?>
                <?php

                    if(end(explode(".",$arraPoli->nombreDoc))=="jpg")
                    {
                        $ico='img/jpg-icono-4736-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="jpeg")
                    {
                        $ico='img/jpg-icono-4736-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="gif")
                    {
                        $ico='img/jpg-icono-4736-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="png")
                    {
                        $ico='img/jpg-icono-4736-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="pdf")
                    {
                        $ico='img/archivo-pdf-icono-3871-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="doc")
                    {
                        $ico='img/microsoft-office-word-2003-icono-8261-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="docx")
                    {
                        $ico='img/microsoft-office-word-2003-icono-8261-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="ppt")
                    {
                        $ico='img/microsoft-office-powerpoint-2003-icono-4740-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="pptx")
                    {
                        $ico='img/microsoft-office-powerpoint-2003-icono-4740-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="xls")
                    {
                        $ico='img/microsoft-office-powerpoint-2003-icono-3696-32.png';
                    }
                    if(end(explode(".",$arraPoli->nombreDoc))=="xlsx")
                    {
                        $ico='img/microsoft-office-powerpoint-2003-icono-3696-32.png';
                    }
                    ?> *}
                    {* <img src='<?php echo $ico;?>' >
                    <a href="<?php echo $arraPoli->rutaDoc.$arraPoli->nombreDoc;?>" class="docu" target='_blank'> <?php echo $arraPoli->desDoc;?></a> *}

            </div>
                </td>
            </tr>
        </table>
    </div>
</div>
{/block}
{block 'script'}
    {* <script src="{$public_url}views/carpeta_controlador/js/carpetas.js"></script> *}
{/block}