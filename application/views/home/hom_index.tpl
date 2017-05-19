{extends $_template}
{block 'contenido'}
<div class="container">
    <div class="row">
        <div class="col-sm-8">
        <!-- Slider -->
            <div id="main-slider" class="main-slider flexslider">
                <ul class="slides">
                  <li>
                    <img src="{$public_url}app/img/fotos_refineria/1.jpg" alt="" />
                    <div class="flex-caption">
                        <h3>Planta A</h3>
                        <p>Descripción</p>
                        {* <a href="#" class="btn btn-theme">Learn More</a> *}
                    </div>
                  </li>
                  <li>
                    <img src="{$public_url}app/img/fotos_refineria/2.jpg" alt="" />
                    <div class="flex-caption">
                        <h3>Área B</h3>
                        <p>Descripción</p>
                        {* <a href="#" class="btn btn-theme">Learn More</a> *}
                    </div>
                  </li>
                  <li>
                    <img src="{$public_url}app/img/fotos_refineria/3.jpg" alt="" />
                    <div class="flex-caption">
                        <h3>Zona C</h3>
                        <p>Descripción</p>
                        {* <a href="#" class="btn btn-theme">Learn More</a> *}
                    </div>
                  </li>
                </ul>
            </div>
        <!-- end slider -->
        <h3>Sistema Integrado de Gestión (SIG)</h3>
        <div class="mCustomScrollbar col-sm-12" data-mcs-theme="dark"  style="background: url({$public_url}app/img/bg_floral.png) no-repeat; z-index:200;background-position-y: 100%">
            <p>La acción preventiva y la permanente mejora del desempeño ambiental son pilares importantes de nuestra Empresa para mantener al petróleo como un material de uso futuro ambientalmente sostenible; contribuyendo a reducir los posibles impactos negativos de su proceso de producción y uso, en todo su ciclo de vida.</p>
            <p>Nuestra Empresa tiene asumido el compromiso de proteger la integridad física, la salud y la calidad de vida de nuestros trabajadores, la de nuestros colaboradores directos y la de otras personas que pueden verse afectadas por nuestras operaciones. Consideramos que la acción preventiva y permanente mejora del desempeño de seguridad y salud ocupacional es un factor clave para adecuar el comportamiento de nuestra Empresa a los nuevos estándares de exigencia del mercado.</p>
            <p>En el mundo actual, un elemento fundamental que fortalece la imagen y otorga competitividad a una Empresa es la aplicación de normas de gestión estandarizadas a nivel internacional, como son: ISO 14001 (Gestión Ambiental) y la OHSAS 18001 (Gestión de Seguridad y Salud en el Trabajo).</p>
            <p>Durante el 2009, hemos visto con satisfacción el cumplimiento del reto trazado, la cual fue la implementación de los <span style="color: #333">Sistemas de Gestión Ambiental (SGA - Norma ISO 14001:2004) y de Gestión de Seguridad y Salud en el Trabajo (SGS&SO - Norma OHSAS 18001:2007)</span>. Al conjunto de estos dos Sistemas de Gestión se denominó "SISTEMA INTEGRADO DE GESTIÓN" (SIG). Sin duda un gran reto asumido por la alta dirección, personal y colaboradores directos, lográndose la tan ansiada certificación del SIG otorgada por la Compañía SGS en las normas ISO 14001:2004 (Sistema de Gestión Ambiental) y OHSAS 18001:2007 (Sistema de Seguridad y Salud en el Trabajo).</p>
            <p>La Certificación del SIG no fue una tarea fácil, por el contrario un desafío trascendental que involucro cambios importantes en la actitud de la alta dirección, personal y colaboradores, que demostró nuestro alto nivel de competencia y que fortalece la imagen de PETRÓLEOS DEL PERÚ S.A. y REFINERÍA SELVA.</p>
            <p>Finalmente como parte de los compromisos asumidos en la Política Integrada de PETROPERÚ S.A. y en cumplimiento a la normativa legal (ley 27943 "ley del Sistema Portuario Nacional" - Art. 33) se implementó la Norma ISO 9001:2008 - Sistema de Gestión de Calidad para el proceso de "CARGA Y DESCARGA DE HIDROCARBUROS EN LA INSTALACIÓN PORTUARIA (MUELLES 1 Y 2) DE REFINERÍA IQUITOS".</p>
            <p>Con tu ayuda y la participación de todos se lograron las metas trazadas para el 2012 de la <span style="color: blue">"CERTIFICACIÓN DEL SISTEMA DE GESTIÓN DE CALIDAD - ISO 9001" </span>y la <span style="color: blue">"RECERTIFICACIÓN DE LAS</span> <span style="color: #333">NORMAS ISO:14001</span> <span style="color: blue"> Y </span><span style="color: green">OHSAS 18001"</span>.</p>
            <p>Ahora debemos poner el mismo énfasis, entusiasmo, profesionalismo y compromiso a fin de mantener la certificaciones obtenidas.</p>
        </div>
        </div>
            <div class="col-sm-4">
                <aside class="right-sidebar">
                <div class="widget">
                    <form role="form" method="get" action="{$base_url}home/document">
                      <div class="form-group">
                        <input type="text" class="form-control" name="s" id="s" placeholder="Buscar">
                        <input type="hidden" name="p" id="p" value="1">
                      </div>
                    </form>
                </div>
                <div class="widget">
                    <h5 class="widgetheading">Documentación SIG</h5>
                    <ul class="cat">

                        {foreach $lst_documento as $cate}
                          <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/{$cate->url}">{$cate->nomArchivo|capitalize:true}</a><span></span></li>

                        {/foreach}
                      {*   <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/sig-generales#ref_archivos">Documentación SIG|Generales</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/areas">Documentación por áreas</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/seg-informacion">Formatos Seg. Infomación</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/formatos-sig">Formatos SIG</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/normativa-legal">Normativa legal</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/otros-documentos">Otros documentos</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$base_url}home/document/charlas-sig">Charlas SIG</a><span></span></li> *}

                    </ul>
                </div>
                <div class="widget">
                    <h5 class="widgetheading">Enlaces SIG</h5>
                    <ul class="cat">
                        <li><i class="fa fa-angle-right"></i><a href="{$smarty.const.PORTAL_REFINERIA}">Portal Refinería</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="{$smarty.const.CORREO_REFINERIA}">Correo Web</a><span></span></li>
                    </ul>
                </div>
                <div class="widget">
                    <h5 class="widgetheading">Noticias</h5>

                    <ul class="cat cat-noticia">
                        {foreach $lstNoticias as $obj}
                        <li>
                            <div>
                                <div class="cont-img">
                                    <div>
                                        <a href="{$base_url}home/noticia/{$obj->not_id}" id="refnoticia" style="text-decoration: none"><p class="tt-intro">{$obj->not_intro|default:''}</p></a>
                                    </div>
                                    <img src="{if $obj->file_portada }{$base_url}/docs/_noticias/{$obj->not_id}/{$obj->file_portada->dno_nombre_fichero}{else}{$public_url}app/img/fotos_refineria/logopetroperu.jpg{/if}">
                                </div>
                                <div class="cont-title">
                                    <p><b> <a href="{$base_url}home/noticia/{$obj->not_id}" style="text-decoration: none"> {$obj->not_titulo|default:'Sin título'} </a> </b></p>
                                </div>
                            </div>
                        </li>
                        {/foreach}


                    </ul>
                </div>
                {* <div class="widget">
                    <h5 class="widgetheading">Latest posts</h5>
                    <ul class="recent">
                        <li>
                        <img src="img/dummies/blog/65x65/thumb1.jpg" class="pull-left" alt="" />
                        <h6><a href="#">Lorem ipsum dolor sit</a></h6>
                        <p>
                             Mazim alienum appellantur eu cu ullum officiis pro pri
                        </p>
                        </li>
                        <li>
                        <a href="#"><img src="img/dummies/blog/65x65/thumb2.jpg" class="pull-left" alt="" /></a>
                        <h6><a href="#">Maiorum ponderum eum</a></h6>
                        <p>
                             Mazim alienum appellantur eu cu ullum officiis pro pri
                        </p>
                        </li>
                        <li>
                        <a href="#"><img src="img/dummies/blog/65x65/thumb3.jpg" class="pull-left" alt="" /></a>
                        <h6><a href="#">Et mei iusto dolorum</a></h6>
                        <p>
                             Mazim alienum appellantur eu cu ullum officiis pro pri
                        </p>
                        </li>
                    </ul>
                </div> *}
                {* <div class="widget">
                    <h5 class="widgetheading">Popular tags</h5>
                    <ul class="tags">
                        <li><a href="#">Web design</a></li>
                        <li><a href="#">Trends</a></li>
                        <li><a href="#">Technology</a></li>
                        <li><a href="#">Internet</a></li>
                        <li><a href="#">Tutorial</a></li>
                        <li><a href="#">Development</a></li>
                    </ul>
                </div> *}
                </aside>
            </div>
    </div>
</div>

{/block}