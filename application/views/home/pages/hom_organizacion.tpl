{extends $_template}
{block 'css'}
    {* <link href="{$public_url}views/carpeta_del_controlador/css/carpetas.css" rel="stylesheet"> *}
    <style type="text/css">
        ul.ul-org {
            list-style: none ;
        }
        ul.ul-org > ul{
            list-style-type: initial;;
        }
    </style>
{/block}
{block 'contenido'}
<div class="container">
    <!--Contenido HTML-->
    <div class="row">
        <table class="col-sm-8 col-sm-offset-2" id="thetbl">
            <tr>

                <td style="text-align:center"><span style="font-size: 2em"><b >ORGANIZACIÓN SIG (ISO 9001/ISO 14001/OHSAS 18001)</b></span></td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <div style=" text-align: justify; font-family: Tahoma; font-size: 1em; padding: 25px">
                        <div class="col-sm-12">
                            <img src="{$base_url}{$imgPortal->rutaDoc}{$imgPortal->nombreDoc}" width="800px">
                        </div>
                        <div class="clearfix"></div>
                        <ul class="ul-org">
                            <li><b>ALTA DIRECCIÓN</b>
                                <ul>
                                    <li>Establece y asegura la implementación y mantenimiento de la Política de Gestión Integrada de la Calidad, Ambiente, Seguridad y Salud en el Trabajo, así como los objetivos y metas.</li>
                                    <li>Lleva a cabo periódicamente la revisión del SIG.</li>
                                    <li>Define y comunica las responsabilidades y autoridades de Refinería Selva.</li>
                                    <li>Asegura la provisión de recursos para el SIG.</li>
                                </ul>
                            </li>
                            <li><b>REPRESENTANTE DE LA ALTA DIRECCIÓN</b>
                                <ul>
                                    <li>Asegura la implementación, mantenimiento y mejora del SIG.</li>
                                    <li>Evalúa el desempeño del SIG e informa los resultados a la Alta Dirección.</li>
                                </ul>
                            </li>
                            <li><b>COMITÉ SIG</b>
                                <ul>
                                    <li>Define estrategias para la implementación del SIG.</li>
                                    <li>Apoya en la estandarización de los documentos transversales.</li>
                                    <li>Evalúa el desempeño del SIG.</li>
                                </ul>
                            </li>
                            <li><b>COORDINADOR SIG</b>
                                <ul>
                                    <li>Asegura la implementación de las estrategias definidas por el Comité SIG, facilita el apoyo, orientación y el soporte a las áreas en el desarrollo de tareas.</li>
                                </ul>
                            </li>
                            <li><b>UNIDAD DESARROLLO SOSTENIBLE</b>
                                <ul>
                                    <li>Implementa las estrategias definidas por el comité SIG.</li>
                                    <li>Elaboran documentos relacionados al SIG según las orientaciones de los especialistas en medio ambiente seguridad y salud en el trabajo y calidad.</li>
                                    <li>Monitorea el avance de las tareas relacionadas con la implementación y mantenimiento del SIG.</li>
                                    <li>Consolida la información referente a los programas y seguimiento de objetivos del SIG, en calidad, ambiente y seguridad y salud en el trabajo.</li>
                                </ul>
                            </li>
                            <li><b>SUB-COMITÉ SIG</b>
                                <ul>
                                    <li>Implementa y mantiene el SIG en las áreas designadas a su cargo.</li>
                                    <li>Asegura la capacitación del personal de su área.</li>
                                    <li>Controla la seguridad del personal.</li>
                                    <li>Controla los aspectos y peligros relacionados a los procesos, actividades, productos, servicios de su área.</li>

                                </ul>
                            </li>
                            <li><b>SUB-COMITÉ SGC</b>
                                <ul>
                                    <li>Implementa y mantiene el SGC en las áreas asignadas a su cargo.</li>
                                    <li>Asegura la capacitación y sensibilización del personal en sus áreas en lo referente al cliente y el cumplimiento de sus requisitos.</li>
                                </ul>
                            </li>
                            <li><b>TODO EL PERSONAL</b>
                                <ul>
                                    <li>Cumple con las disposiciones del SIG que le correspondan.</li>
                                    <li>Cumple los requisitos del cliente externo o interno a través del cumplimiento de sus procedimientos indicando a sus superiores las mejoras necesarias.</li>
                                    <li>Cuida de su seguridad y salud y la de los demás en toda acción que realice.</li>
                                    <li>Controla y toma conciencia de los aspectos ambientales presentes en toda acción que realice.</li>
                                </ul>
                            </li>
                        </ul>
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