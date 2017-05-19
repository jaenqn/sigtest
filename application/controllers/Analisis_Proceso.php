<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Analisis_Proceso extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_AnalisiProceso','apr');
    }

    public function index()
    {
        $datos = array();


        $this->smartys->assign($datos);
        $this->smartys->render('index');
    }
    public function generar(){
        AppSession::logueado();
        $this->smartys->render('apr_editar');
    }
    public function guardar(){
        AppSession::logueado();
        // print_rr($_POST);
        $p = $this->input->post();
        if(isset($p['txtModProceso'])){
            $objApr = $this->apr->getdata($p['txtIDProceso']);
            switch ($p['txtModProceso']) {
                case md5(1)://agregar
                    # code...
                    break;
                case md5(2)://actualizar



                    $values['apr_id'] = $p['txtIDProceso'];
                    $values['apr_sede'] = $p['txtSede'];
                    switch (+AppSession::get('tipo_usuario')) {
                        case 1:
                            $values['apr_invo_ela'] = $p['txtNomElabora'];
                            $values['apr_estado'] = 2;
                            if(isset($p['txtFechaElaboracion']))
                                $values['apr_fecha_ela'] = DateTime::createFromFormat('d/m/y', $p['txtFechaElaboracion'])->format('Y-m-d');
                            else $values['apr_fecha_ela'] = null;
                            break;
                        case 2:
                            $values['apr_invo_rev'] = $p['txtNomRevisa'];
                            $values['apr_estado'] = 3;
                            if(isset($p['txtFechaRevisado']))
                                $values['apr_fecha_rev'] = DateTime::createFromFormat('d/m/y', $p['txtFechaRevisado'])->format('Y-m-d');
                            else $values['apr_fecha_rev'] = null;
                            break;
                        case 3:
                            $values['apr_invo_apr'] = $p['txtNomAprueba'];
                            $values['apr_estado'] = 4;
                            //enviar notificación a administradores, informando que se actualizó la matriz
                            enviar_notificacion_sistema_custom_dos($objApr->uni_id, AppSession::get('id_unidad'),24,array(
                                'default' => true,
                                'unidad_remite' => AppSession::get('nom_uni'),
                                'matriz_proceso' => $objApr->pro_nombre,
                                'ref_url' => 'analisis_proceso/ver/'.$objApr->apr_id
                                ));
                            if(isset($p['txtFechaAprobacion']))
                                $values['apr_fecha_apr'] = DateTime::createFromFormat('d/m/y', $p['txtFechaAprobacion'])->format('Y-m-d');
                            else $values['apr_fecha_apr'] = null;
                            break;
                        case 4:
                        case 5:
                            $values['apr_invo_ela'] = $p['txtNomElabora'];
                            if(isset($p['txtFechaElaboracion']))
                                $values['apr_fecha_ela'] = DateTime::createFromFormat('d/m/y', $p['txtFechaElaboracion'])->format('Y-m-d');
                            else $values['apr_fecha_ela'] = null;
                            $values['apr_invo_rev'] = $p['txtNomRevisa'];
                            if(isset($p['txtFechaRevisado']))
                                $values['apr_fecha_rev'] = DateTime::createFromFormat('d/m/y', $p['txtFechaElaboracion'])->format('Y-m-d');
                            else $values['apr_fecha_rev'] = null;
                            $values['apr_invo_apr'] = $p['txtNomAprueba'];
                            if(isset($p['txtFechaAprobacion']))
                                $values['apr_fecha_apr'] = DateTime::createFromFormat('d/m/y', $p['txtFechaElaboracion'])->format('Y-m-d');
                            else $values['apr_fecha_apr'] = null;
                            break;
                    }

                    $this->apr->actualizar($values);
                    break;
            }
        }
        echo_json(array('respuesta'=>true));
    }

    public function editar($id_proceso)
    {
        // print_rr($_SESSION);exit;
        AppSession::logueado();
        if(is_numeric($id_proceso)){
            $this->load->model('Model_Procesos','pro');
            $this->load->model('Model_PeligroCategoria','pc');
            $this->load->model('Model_MedidaControl','mco');
            $this->load->model('Model_Peligro','pel');
            $datos['objA'] = $this->apr->getdata($id_proceso);
            // print_rr($datos['objA']);exit;
            if( $datos['objA']->apr_fecha_ela != null){
                $fechaA = DateTime::createFromFormat('Y-m-d H:i:s', $datos['objA']->apr_fecha_ela);
                $datos['objA']->apr_fecha_ela = $fechaA->format('d/m/y');
            }
            if( $datos['objA']->apr_fecha_rev != null){
                $fechaA = DateTime::createFromFormat('Y-m-d H:i:s', $datos['objA']->apr_fecha_rev);
                $datos['objA']->apr_fecha_rev = $fechaA->format('d/m/y');
            }
            if( $datos['objA']->apr_fecha_apr != null){
                $fechaA = DateTime::createFromFormat('Y-m-d H:i:s', $datos['objA']->apr_fecha_apr);
                $datos['objA']->apr_fecha_apr = $fechaA->format('d/m/y');
            }


            $datos['is_edit'] = true;
            $datos['modPro'] = md5(2);
            $datos['modProDos'] = 2;
            if($datos['objA']->pro_estado == 0){
                show_404();exit;
            }
            $this->load->model('Model_ProcesosEtapa','pet');
            $datos['lstCatePel'] = $this->pc->listar_peligro(1);
            $datos['lstCateAmb'] = $this->pc->listar_ambiental(1);

            $datos['lstMCRiesgos'] = $this->mco->listar_jerarquia_by_tipo(1);
            $datos['lstMCImpactos'] = $this->mco->listar_jerarquia_by_tipo(2);

            $datos['lstEtapas'] = $this->pet->listar_by_procesos($datos['objA']->pro_id);
            $datos['part_title'] = 'Editar Análisis de Proceso';
            $datos['titulo_header'] = 'Editar Análisis de Proceso </br><small> (Matriz) de Identificación de Peligros y Aspectos Ambientales</small>';
            $datos['ar_pages'] = array('Análisis de Proceso','Editar', $id_proceso);
            $datos['lstDeps'] = $this->pro->listar_deps(1);
            $this->smartys->assign($datos);

            $this->smartys->render('apr_editar');
        }else show_404();
    }
    public function analis_excel($idana){
        $objA = $this->apr->getcompletedata($idana);


        if($objA){
                // print_rr($objA);
                // exit;
                // $lst = $this->residuos->reporte_general($_GET);
                // print_rr($lst);exit;
                require_once APPPATH.'third_party'.DS.'PHPExcel.php';

                $objExcel = new PHPExcel();

                $rendererName = PHPExcel_Settings::PDF_RENDERER_TCPDF;
                 $rendererLibraryPath = APPPATH.'third_party'.DS.'tcpdf';

                // Leemos un archivo Excel 2007
                $objReader = PHPExcel_IOFactory::createReader('Excel2007');
                $objExcel = $objReader->load(doc_templates::getExcel('apr_rep_matriz'));
                $objExcel->setActiveSheetIndex(0);
                $objWorksheet = $objExcel->getActiveSheet();
                $initRow = 10;
                $indexEtapa; $indexActividad;

                $colorB = new PHPExcel_Style_Color('FFE5B8B7');
                $colorT = new PHPExcel_Style_Color('FFFFFFFF');

                $colorA = new PHPExcel_Style_Color('FFDAEEF3');
                $colorDef = new PHPExcel_Style_Color('FFFFFFFF');

                // $objWorksheet->getCell('K9')->getStyle()->getFill()->setStartColor($colorA);
                // print_rr($objWorksheet->getCell('K9')->getStyle()->getFill());
                // exit;
                // print_rr($objWorksheet->getCell('B9'));
                // exit;
                $objWorksheet->setCellValue('B3', $objA->apr_sede);
                $objWorksheet->setCellValue('B4', $objA->dep_nombre.' / '.$objA->uni_nombre);
                $objWorksheet->setCellValue('B5', $objA->pro_nombre);
                foreach ($objA->lst_etapas as $key => $objE) {
                    $indexEtapa = 1;
                    foreach ($objE->lst_actividades as $key => $objAc) {
                        $indexActividad = 1;
                        $indexEtapa = 1;
                        foreach ($objAc->lst_blan_peligros as $key => $objP) {
                            $initRow++;
                            $objWorksheet->insertNewRowBefore($initRow, 1);

                            $indexEtapa == 1 ? $objWorksheet->setCellValue('A'.$initRow, $objE->pet_nombre) : $objWorksheet->setCellValue('A'.$initRow, "-----------");
                            if($indexActividad == 1){
                                $objWorksheet->setCellValue('B'.$initRow, $objAc->pac_nombre);
                                $objWorksheet->setCellValue('C'.$initRow, $objAc->pac_puesto_trabajo);
                            }else{
                                $objWorksheet->setCellValue('B'.$initRow, "-----------");
                                $objWorksheet->setCellValue('C'.$initRow, "-----------");
                            }
                            switch (+$objAc->pac_situacion) {
                                case 1:

                                    $indexActividad == 1 ? $objWorksheet->setCellValue('D'.$initRow, 'X') : $objWorksheet->setCellValue('D'.$initRow, '-');
                                    $objWorksheet->setCellValue('E'.$initRow, '');
                                    $objWorksheet->setCellValue('F'.$initRow, '');
                                    break;
                                case 2:

                                    $objWorksheet->setCellValue('D'.$initRow, '');
                                    $indexActividad == 1 ? $objWorksheet->setCellValue('E'.$initRow, 'X') : $objWorksheet->setCellValue('E'.$initRow, '-');
                                    $objWorksheet->setCellValue('F'.$initRow, '');
                                    break;
                                case 3:

                                    $objWorksheet->setCellValue('D'.$initRow, '');
                                    $objWorksheet->setCellValue('E'.$initRow, '');
                                    $indexActividad == 1 ? $objWorksheet->setCellValue('F'.$initRow, 'X') : $objWorksheet->setCellValue('F'.$initRow, '-');
                                    break;

                            }

                            if($objAc->pac_ubicacion == 1){
                                $indexActividad == 1 ? $objWorksheet->setCellValue('G'.$initRow, 'X') : $objWorksheet->setCellValue('G'.$initRow, '-');
                                $objWorksheet->setCellValue('H'.$initRow, '');
                            }
                            if($objAc->pac_ubicacion == 2){
                                $objWorksheet->setCellValue('G'.$initRow, '');
                                $indexActividad == 1 ? $objWorksheet->setCellValue('H'.$initRow, 'X') : $objWorksheet->setCellValue('H'.$initRow, '-');
                            }

                            switch (+$objAc->pac_tipo_personal) {
                                case 1:
                                $objWorksheet->setCellValue('I'.$initRow, 'PP');
                                    break;
                                case 2:
                                $objWorksheet->setCellValue('I'.$initRow, 'PC');
                                    break;
                                case 3:
                                $objWorksheet->setCellValue('I'.$initRow, 'V');
                                    break;
                            }

                            // $objWorksheet->setCellValue('J'.$initRow, '');
                            if($indexActividad == 1){

                                $objWorksheet->getStyle('N'.$initRow)->getFill()->setStartColor($colorA)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('O'.$initRow)->getFill()->setStartColor($colorA)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('P'.$initRow)->getFill()->setStartColor($colorA)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('Q'.$initRow)->getFill()->setStartColor($colorA)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('R'.$initRow)->getFill()->setStartColor($colorA)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);

                                $objWorksheet->getStyle('J'.$initRow)->getFill()->setStartColor($colorA)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('K'.$initRow)->getFill()->setStartColor($colorDef)->setEndColor($colorDef)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                            }

                            // $objWorksheet->getCell('K'.$initRow)->getStyle()->getFill()->setStartColor($colorDef);
                            // $objWorksheet->setCellValue('K'.$initRow, '');

                            $objWorksheet->setCellValue('L'.$initRow, $objP->pel_nombre);


                            $riesgos = '';
                            foreach ($objP->lst_riesgos as $key => $value) {
                                $riesgos .= '•'.$value->rie_nombre.PHP_EOL;
                            }
                            $objWorksheet->setCellValue('M'.$initRow, $riesgos);

                            $objWorksheet->setCellValue('N'.$initRow, $objP->acb_vfp_ie);
                            $objWorksheet->setCellValue('O'.$initRow, $objP->acb_vfp_if);
                            $objWorksheet->setCellValue('P'.$initRow, $objP->acb_vfp_ip);
                            $objWorksheet->setCellValue('Q'.$initRow, $objP->acb_vfp_ic);
                            $objWorksheet->setCellValue('R'.$initRow, "=N$initRow+O$initRow+P$initRow+Q$initRow");
                            $objWorksheet->setCellValue('S'.$initRow, '=IF(R'.$initRow.'<=7,"1",IF(AND(R'.$initRow.'>7,R'.$initRow.'<=10),"2",IF(AND(R'.$initRow.'>10,R'.$initRow.'<=13),"3",IF(AND(R'.$initRow.'>13,R'.$initRow.'<=16),"4",IF(AND(R'.$initRow.'>16,R'.$initRow.'<=20),"5")))))');
                            $objWorksheet->setCellValue('T'.$initRow, $objP->acb_sev);
                            $objWorksheet->setCellValue('U'.$initRow, "=S$initRow*T$initRow");
                            $objWorksheet->setCellValue('V'.$initRow, '=IF(U'.$initRow.'>16,"IN",IF(U'.$initRow.'>9,"IM",IF(U'.$initRow.'>3,"MO",IF(U'.$initRow.'>2,"TO",IF(U'.$initRow.'>0,"AC")))))');
                            $objWorksheet->setCellValueExplicit('W'.$initRow, '=IF(U'.$initRow.'>=10,"SI","NO")', 'f');

                            $medidas = '';
                            foreach ($objP->lst_medidas as $key => $value) {
                                $medidas .= '•'.$value->mco_nombre.PHP_EOL;
                            }
                            $objWorksheet->setCellValue('X'.$initRow, $medidas);

                            $indexEtapa++;
                            $indexActividad++;

                        }
                        $indexEtapa = 1;
                        $indexActividad = 1;
                        foreach ($objAc->lst_blan_ambiental as $key => $objAm) {

                            $initRow++;
                            $objWorksheet->insertNewRowBefore($initRow, 1);


                            $indexEtapa == 1 ? $objWorksheet->setCellValue('A'.$initRow, $objE->pet_nombre) : $objWorksheet->setCellValue('A'.$initRow, "-----------");
                            if($indexActividad == 1){

                                $objWorksheet->setCellValue('B'.$initRow, $objAc->pac_nombre);
                                $objWorksheet->setCellValue('C'.$initRow, $objAc->pac_puesto_trabajo);
                            }else{
                                $objWorksheet->setCellValue('B'.$initRow, "-----------");
                                $objWorksheet->setCellValue('C'.$initRow, "-----------");
                            }
                            switch (+$objAc->pac_situacion) {
                                case 1:
                                    $indexActividad != 1 ? $objWorksheet->setCellValue('D'.$initRow, '-') :$objWorksheet->setCellValue('D'.$initRow, 'X');
                                    $objWorksheet->setCellValue('E'.$initRow, '');
                                    $objWorksheet->setCellValue('F'.$initRow, '');
                                    break;
                                case 2:

                                    $objWorksheet->setCellValue('D'.$initRow, '');
                                    $indexActividad != 1 ? $objWorksheet->setCellValue('E'.$initRow, '-') : $objWorksheet->setCellValue('E'.$initRow, 'X');
                                    $objWorksheet->setCellValue('F'.$initRow, '');
                                    break;
                                case 3:
                                    $objWorksheet->setCellValue('D'.$initRow, '');
                                    $objWorksheet->setCellValue('E'.$initRow, '');
                                    $indexActividad != 1 ? $objWorksheet->setCellValue('F'.$initRow, '-') : $objWorksheet->setCellValue('F'.$initRow, 'X');
                                    break;

                                default:
                                    # code...
                                    break;
                            }

                            if($objAc->pac_ubicacion == 1){
                                $indexActividad == 1 ? $objWorksheet->setCellValue('G'.$initRow, 'X') : $objWorksheet->setCellValue('G'.$initRow, '-');
                                $objWorksheet->setCellValue('H'.$initRow, '');
                            }
                            if($objAc->pac_ubicacion == 2){
                                $objWorksheet->setCellValue('G'.$initRow, '');
                                $indexActividad == 1 ? $objWorksheet->setCellValue('H'.$initRow, 'X') : $objWorksheet->setCellValue('H'.$initRow, '-');
                            }

                            switch (+$objAc->pac_tipo_personal) {
                                case 1:
                                $objWorksheet->setCellValue('I'.$initRow, 'PP');
                                    break;
                                case 2:
                                $objWorksheet->setCellValue('I'.$initRow, 'PC');
                                    break;
                                case 3:
                                $objWorksheet->setCellValue('I'.$initRow, 'V');
                                    break;
                            }

                            // $objWorksheet->setCellValue('J'.$initRow, '');
                            // $objWorksheet->setCellValue('K'.$initRow, 'X');
                            if($indexActividad == 1){

                                $objWorksheet->getStyle('J'.$initRow)->getFill()->setStartColor($colorDef)->setEndColor($colorDef)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('K'.$initRow)->getFill()->setStartColor($colorB)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);

                                $objWorksheet->getStyle('N'.$initRow)->getFill()->setStartColor($colorB)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('O'.$initRow)->getFill()->setStartColor($colorB)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('P'.$initRow)->getFill()->setStartColor($colorB)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('Q'.$initRow)->getFill()->setStartColor($colorB)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                                $objWorksheet->getStyle('R'.$initRow)->getFill()->setStartColor($colorB)->setEndColor($colorT)->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                            }

                            $objWorksheet->setCellValue('L'.$initRow, $objAm->asp_nombre);


                            $impactos = '';

                            foreach ($objAm->lst_impactos as $key => $value) {
                                $impactos .=  '•'.$value->imp_nombre.PHP_EOL;
                            }
                            $objWorksheet->setCellValue('M'.$initRow, $impactos);

                            $objWorksheet->setCellValue('N'.$initRow, '');
                            $objWorksheet->setCellValue('O'.$initRow, '');
                            $objWorksheet->setCellValue('P'.$initRow, '');
                            $objWorksheet->setCellValue('Q'.$initRow, '');
                            $objWorksheet->setCellValue('R'.$initRow, '');

                            $objWorksheet->setCellValue('S'.$initRow, $objAm->aba_vfp_pr);
                            $objWorksheet->setCellValue('T'.$initRow, $objAm->aba_vfp_sev);
                            $objWorksheet->setCellValue('U'.$initRow, "=S$initRow*T$initRow");
                            $objWorksheet->setCellValue('V'.$initRow, '=IF(U'.$initRow.'>16,"IN",IF(U'.$initRow.'>9,"IM",IF(U'.$initRow.'>3,"MO",IF(U'.$initRow.'>2,"TO",IF(U'.$initRow.'>0,"AC")))))');
                            $objWorksheet->setCellValue('W'.$initRow, '=IF(U'.$initRow.'>=10,"SI","NO")');

                            $medidas = '';
                            foreach ($objAm->lst_medidas as $key => $value) {
                                $medidas .= '•'.$value->mco_nombre.PHP_EOL;
                            }
                            $objWorksheet->setCellValue('X'.$initRow, $medidas);


                            $indexEtapa++;
                            $indexActividad++;
                        }
                    }
                }
                $objWorksheet->removeRow(10, 1);
                // $objWorksheet->refreshRowDimensions();
                for ($i=10; $i < $initRow ; $i++) {

                    $objWorksheet->getRowDimension($i)->setRowHeight(-1);
                }
                //2017-03-22 15:38:55

                $objWorksheet->setCellValue('D'.$initRow, $objA->apr_invo_ela);
                if($objA->apr_fecha_ela != null){
                    $fechSol = DateTime::createFromFormat('Y-m-d H:i:s',$objA->apr_fecha_ela);
                    $objWorksheet->setCellValue('X'.$initRow++, $fechSol->format('d/m/Y'));
                }


                $objWorksheet->setCellValue('D'.$initRow, $objA->apr_invo_rev);
                if($objA->apr_fecha_rev != null){
                    $fechSol = DateTime::createFromFormat('Y-m-d H:i:s',$objA->apr_fecha_rev);
                    $objWorksheet->setCellValue('X'.$initRow++, $fechSol->format('d/m/Y'));
                }


                $objWorksheet->setCellValue('D'.$initRow, $objA->apr_invo_apr);
                if($objA->apr_fecha_apr != null){
                    $fechSol = DateTime::createFromFormat('Y-m-d H:i:s',$objA->apr_fecha_apr);
                    $objWorksheet->setCellValue('X'.$initRow++, $fechSol->format('d/m/Y'));
                }




                $objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');

                // $objWriter->save(DOCSPATH.'unicoxxxxxx.xlsx');
                header("Content-disposition: attachment; filename=Reportes Generales asdasd - 2222.xlsx");
                header("Content-type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                ob_end_clean();
                $objWriter->save('php://output');
                // readfile(DOCSPATH.'unico.xlsx');
                exit;



        }else{
               show_404();
        }
    }
    public function ver($id_proceso){
        AppSession::logueado();
        if(is_numeric($id_proceso)){
            $datos['objA'] = $this->apr->getcompletedata($id_proceso);
            // print_rr($datos['objA']); exit;
            $datos['titulo_header'] = 'REPORTE DE MATRIZ DE IDENTIFICACIÓN DE PELIGROS Y ASPECTOS AMBIENTALES';
            $datos['part_title'] = 'Reporte de Matriz - '.$datos['objA']->pro_nombre;
            $datos['ar_pages'] = array('Análisis de Proceso','Ver', $datos['objA']->pro_nombre);
            $this->smartys->assign($datos);

            // print_rr($datos['objA']);exit;
            $this->smartys->render('apr_ver');
        }else show_404();
    }
    public function getdatablanco($opc,$idval){
        $lst = array();
        switch (+$opc) {
            case 1://peligro
                $lst = $this->apr->getdataactividadpeligro($idval);
                break;
            case 2://ambiental
                $lst = $this->apr->getdataactividadambiental($idval);
                break;
        }
        echo_json($lst);
    }
    public function eliminar_blanco($opc, $val){
        if(is_ajax(false)){
            $res['resultado'] = false;
            if(is_numeric($opc)){
                switch ($opc) {
                    case 1://peligro
                        $res['resultado'] = $this->apr->eliminar_peligro($val);
                        // print_rr($values);
                        break;
                    case 2://ambiental
                        $res['resultado'] = $this->apr->eliminar_ambiental($val);
                        break;
                }
            }
            echo_json($res);
        }else show_404();
    }
    public function guardar_blanco($opc){
        if(is_ajax(false)){
            $res['resultado'] = false;
            if(is_numeric($opc)){
                switch ($opc) {
                    case 1:
                        // print_rr($_POST);exit;
                        $p = $this->input->post();
                        $values['pac_id_actividad'] = $p['txtIdActividad'];
                        $values['pel_id_peligro'] = $p['selPeligro'];
                        $values['rie_id_riesgo'] = $p['selRiesgo'];

                        $values['acb_vfp_ie'] = $p['radIEP'];
                        $values['acb_vfp_if'] = $p['radIFP'];
                        $values['acb_vfp_ip'] = $p['radIPP'];
                        $values['acb_vfp_ic'] = $p['radICP'];

                        $values['acb_sev'] = $p['radSevP'];
                        if(isset($p['txtMedPeligro']))
                            $values['acb_medidas_control'] = implode(',',$p['txtMedPeligro']);
                        $res['resultado'] = $this->apr->insertar_peligro($values);
                        // print_rr($values);
                        break;
                    case 2:
                        // print_rr($_POST);exit;
                        $p = $this->input->post();
                        $values['pac_id_actividad'] = $p['txtIdActividad'];
                        $values['asp_id_ambiental'] = $p['selAspectoAmbiental'];
                        $values['imp_id_impacto'] = $p['selImpacto'];

                        $values['aba_vfp_pr'] = $p['radIPR'];
                        $values['aba_vfp_sev'] = $p['radISEV'];
                        // $values['acb_vfp_ip'] = $p['radIPP'];
                        // $values['acb_vfp_ic'] = $p['radICP'];

                        // $values['acb_sev'] = $p['radSevP'];
                        if(isset($p['txtMedAmbiental']))
                            $values['aba_medidas_control'] = implode(',',$p['txtMedAmbiental']);
                        $res['resultado'] = $this->apr->insertar_ambiente($values);
                        // print_rr($values);

                        # code...
                        break;
                }
            }
            echo_json($res);
        }else show_404();
    }
    public function actualizar_blanco($opc){
        if(is_ajax(false)){
            $res['resultado'] = false;
            if(is_numeric($opc)){
                switch ($opc) {
                    case 1:

                        $p = $this->input->post();
                        $values['acb_id'] = $p['txtIdBlanco'];
                        $values['pac_id_actividad'] = $p['txtIdActividad'];
                        $values['pel_id_peligro'] = $p['selPeligro'];
                        $values['rie_id_riesgo'] = $p['selRiesgo'];

                        $values['acb_vfp_ie'] = $p['radIEP'];
                        $values['acb_vfp_if'] = $p['radIFP'];
                        $values['acb_vfp_ip'] = $p['radIPP'];
                        $values['acb_vfp_ic'] = $p['radICP'];

                        $values['acb_sev'] = $p['radSevP'];
                        if(isset($p['txtMedPeligro']))
                            $values['acb_medidas_control'] = implode(',',$p['txtMedPeligro']);
                        // print_rr($values);
                        $res['resultado'] = $this->apr->actualizar_blapeligro($values);
                        break;
                    case 2:
                        $p = $this->input->post();
                        $values['aba_id'] = $p['txtIdBlanco'];
                        $values['pac_id_actividad'] = $p['txtIdActividad'];
                        $values['asp_id_ambiental'] = $p['selAspectoAmbiental'];
                        $values['imp_id_impacto'] = $p['selImpacto'];

                        $values['aba_vfp_pr'] = $p['radIPR'];
                        $values['aba_vfp_sev'] = $p['radISEV'];
                        // $values['acb_vfp_ip'] = $p['radIPP'];
                        // $values['acb_vfp_ic'] = $p['radICP'];

                        // $values['acb_sev'] = $p['radSevP'];
                        if(isset($p['txtMedAmbiental']))
                            $values['aba_medidas_control'] = implode(',',$p['txtMedAmbiental']);
                        // print_rr($values);
                        $res['resultado'] = $this->apr->actualizar_blaambiente($values);
                        break;
                }
            }
            echo_json($res);
        }else show_404();
    }
    public function lista()
    {
        AppSession::logueado();
        $datos['titulo_header'] = 'Análisis de Proceso';
        $datos['part_title'] = 'Análisis de Proceso';
        $this->load->model('Model_Procesos','pro');
        $datos['lstDeps'] = $this->pro->listar_deps(1);
        $datos['lstEstados'] = $this->apr->getestados_analisis();
        $datos['ar_pages'] = array('Análisis de Proceso','Lista');
        $this->smartys->assign($datos);

        $this->smartys->render('lista');
    }
    public function agregar_peligro_actividad()
    {

        $datos['titulo_header'] = 'Análisis de Proceso';
        $datos['ar_pages'] = array('Análisis de Proceso','Agregar Peligro a Actividad');
        $this->smartys->assign($datos);

        $this->smartys->render('apr_agregar_peligro_actividad');
    }
    public function reporte_peligro_aspectos()
    {

        $datos['titulo_header'] = 'Análisis de Proceso';
        $datos['ar_pages'] = array('Análisis de Proceso','Reporte','Peligros y Aspectos Significativos');
        $this->smartys->assign($datos);

        $this->smartys->render('apr_reporte_peligro_aspecto');
    }

    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
                "p.pro_nombre",
                "uni.desDepend as uni_nombre",
                "dep.desDepend as dep_nombre"
            );
        if(isset($_POST['order'])){
            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                // case 'get_estado':
                //     $order = array('uni_estado' => $_POST['order']['0']['dir']);
                //     break;
            }

        }
        $filter = array();
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'rso_nombre':

                        $likes[] = $p[$i];
                        break;
                    case 'dep_id_departamento':
                        $filter[] = array('column' => 'dd.idDepend', 'filter' => $value['filter']);
                        break;
                    case 'uni_id_unidad':
                        $filter[] = array('column' => 'd.idDepend', 'filter' => $value['filter']);
                        // $filter[] = $value;
                        // $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(

                array('tbl_procesos p ','p.pro_id = tbl_analisis_proceso.pro_id_proceso'),
                array('dependencia uni','uni.idDepend = p.uni_id_unidad'),
                array('dependencia dep','dep.idDepend = uni.reportaDpend')
        );
        $datas = $this->Model_Datatables->get_datatables('tbl_analisis_proceso','object',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);

        // $list = get_object_vars($list);
        $data = array();
        $no = $_POST['start'];


        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => $datas['count_all'],
                        "recordsFiltered" => $datas['count_filtered'],
                        "data" => $datas['list'],
                        "post" => $_POST
                );
        //output to json format
        echo json_encode($output);
    }
}