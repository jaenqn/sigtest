<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Testuser extends CI_Controller {
    public function urls(){
        // print_rr(ent_boleta::lstEstados());
        // print_rr(ent_boleta::getEstado('elaborado'));
        $this->load->model('mod_test','test');
        print_rr($this->test->where());
        // print_rr($_SERVER);
        // echo $_SERVER['REQUEST_URI'];
        // $url = 'http://username:password@hostname:9090/path/asd?arg=value#anchor';

        // var_dump(parse_url(base_url()));
    }
    public function fechas(){

        echo md5('9648381e1f4f2865de0c70d685bc02b0845e178a_res'.'BA-131312');
        br();
        echo md5('9648381e1f4f2865de0c70d685bc02b0845e178a_res'.'BA-131313');
        exit;
        $fechados = new DateTime('2017-05-02 08:00:00');
        $fecha = date_create();
        print_rr($fecha);
        print_rr($fechados);
        // echo $fechados->diff($fecha)->format('%H - %R%i');
        echo $fecha->getTimestamp() - $fechados->getTimestamp();
        br();
        echo floor(25/2.7);
        br();
        echo 25/2.7;
        // echo $fecha->format('F j, Y, g:i a');
        // echo $fechados->add(ent_boleta::getTiempoRespuesta('interval'))->format('F j, Y, g:i a');
        // date_add($fecha, ent_boleta::getTiempoRespuesta('interval'));



        // echo $fecha->format('F j, Y, g:i a');

    }
    public function testsolicitud(){

        $this->load->model('Model_Residuos','res');
        $obj = $this->res->getcompletedata(1);
        // ob_start();
        // echo  $obj->rss_observaciones;
        // $salida2 = ob_get_contents();
        // ob_end_clean();
        // print_rr($salida2);
        // echo convert_uuencode($obj->rss_observaciones);
        $porciones = explode("\n", $obj->rss_observaciones);
        print_rr($porciones);
        // $tt = str_split($obj->rss_observaciones);
        // foreach ($tt as $key => $value) {
        //     echo ord($value).'--';
        // }
        print_rr(sscanf($obj->rss_observaciones,'%s'));
        print_rr(sscanf($obj->rss_observaciones,'%s\n'));

        // while ($userinfo = sscanf($obj->rss_observaciones, "%s\n")) {
        //     list ($nombre) = $userinfo;
        //     echo '-----'.$nombre.'----';
        //     //... hacer algo con los valores
        // }
        // $data = $obj->rss_observaciones;

        // foreach (count_chars($data, 1) as $i => $val) {
        //     print_rr($i);
        //    echo "Se ha encontrado $val instancia (s) de \"" , chr($i) , "\" en la cadena.\n";
        // }
        print_rr($obj);
    }
    public function tplworddos(){
        require_once LIBSPATH.'vendor/phpoffice/phpword/samples/sample_header.php';
        echo date('H:i:s'), ' Create new PhpWord object', EOL;
        $phpWord = new \PhpOffice\PhpWord\PhpWord();

        // New section
        $section = $phpWord->addSection();

        $section->addText('Check box in section');
        $section->addCheckBox('chkBox1', 'Checkbox 1');
        $section->addText('Check box in table cell');
        $table = $section->addTable();
        $table->addRow();
        $cell = $table->addCell();
        $cell->addCheckBox('chkBox2', 'Checkbox 2');

        // Save file
        echo write($phpWord, basename(__FILE__, '.php'), $writers);
        if (!CLI) {
            include_once LIBSPATH.'vendor/phpoffice/phpword/samples/sample_header.php';
        }
    }
    public function tplword(){
        require_once LIBSPATH.'vendor/phpoffice/phpword/bootstrap.php';
        $phpWord = new \PhpOffice\PhpWord\PhpWord();
        $ruta = DOCSPATH.'__procesoss'.DS.'_templates'.DS.'tpl_res_declaracion_test.docx';
        $testWord = $phpWord->loadTemplate($ruta);


        $xml = new \PhpOffice\Common\XMLWriter();
        $ccc = new \PhpOffice\PhpWord\Element\CheckBox('casa');
        print_rr($ccc);
        $ccc2 = new  \PhpOffice\PhpWord\Writer\Word2007\Element\CheckBox($xml,$ccc,true);
        $ccc2->write();
        // print_rr();
        // print_rr($ccc2);
        $tt = $xml->getData();


        $check = '<w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:fldChar w:fldCharType="begin"><w:ffData><w:name w:val="__casilla_pel__"/><w:enabled/><w:calcOnExit w:val="0"/><w:checkBox><w:sizeAuto/><w:default w:val="1"/></w:checkBox></w:ffData></w:fldChar></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:instrText xml:space="preserve"> FORMCHECKBOX </w:instrText></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:fldChar w:fldCharType="end"/></w:r>';
        $uncheck = '<w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:fldChar w:fldCharType="begin"><w:ffData><w:name w:val="__casilla_pel__"/><w:enabled/><w:calcOnExit w:val="0"/><w:checkBox><w:sizeAuto/><w:default w:val="0"/></w:checkBox></w:ffData></w:fldChar></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:instrText xml:space="preserve"> FORMCHECKBOX </w:instrText></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:fldChar w:fldCharType="end"/></w:r>';
        $testWord->setValue("rad_pel",$check);
        $testWord->setValue("rad_nopel",$check);
        $testWord->setValue("rad_sol",$check);
        $testWord->setValue("rad_liq",$uncheck);
        // $testWord->setValue("rad_text",$uncheck);
        // $testWord->addCheckBox('chkBox2', 'Checkbox 2');
        // $testWord->setValue("rad_text",$tt);
        // $testWord->addCheckBox("rad_pel_asd");
        $testWord->saveAs(DOCSPATH.'_test/result.docx');
        print_rr($testWord);
        // $phpWord2 = \PhpOffice\PhpWord\IOFactory::load($ruta);
        // $phpWord2->save(DOCSPATH.'_test/result.docx');

        // $templateProcessor = new \PhpOffice\PhpWord\TemplateProcessor($ruta);

        // $templateProcessor->setValue("rad_pel",'77777777777777777777777777');
        // var_dump($templateProcessor);
        // print_r($templateProcessor);
        // $phpWord2->saveAs(DOCSPATH.'_test/result2.docx');
        // $templateProcessor->setValue('Name', 'John Doe');
        // $templateProcessor->setValue(array('City', 'Street'), array('Detroit', '12th Street'));
    }
    public function testword(){
        // $PHPWord = new PHPWord();
        // echo LIBSPATH.'vendor\phpoffice\phpword\bootstrap.php';
        require_once LIBSPATH.'vendor/phpoffice/phpword/bootstrap.php';
        $phpWord = new \PhpOffice\PhpWord\PhpWord();

        /* Note: any element you append to a document must reside inside of a Section. */

        // Adding an empty Section to the document...
        $section = $phpWord->addSection();
        // Adding Text element to the Section having font styled by default...
        $section->addText(
            '"Learn from yesterday, live for today, hope for tomorrow. '
                . 'The important thing is not to stop questioning." '
                . '(Albert Einstein)'
        );

        /*
         * Note: it's possible to customize font style of the Text element you add in three ways:
         * - inline;
         * - using named font style (new font style object will be implicitly created);
         * - using explicitly created font style object.
         */

        // Adding Text element with font customized inline...
        $section->addText(
            '"Great achievement is usually born of great sacrifice, '
                . 'and is never the result of selfishness." '
                . '(Napoleon Hill)',
            array('name' => 'Tahoma', 'size' => 10)
        );

        // Adding Text element with font customized using named font style...
        $fontStyleName = 'oneUserDefinedStyle';
        $phpWord->addFontStyle(
            $fontStyleName,
            array('name' => 'Tahoma', 'size' => 10, 'color' => '1B2232', 'bold' => true)
        );
        $section->addText(
            '"The greatest accomplishment is not in never falling, '
                . 'but in rising again after you fall." '
                . '(Vince Lombardi)',
            $fontStyleName
        );

        // Adding Text element with font customized using explicitly created font style object...
        $fontStyle = new \PhpOffice\PhpWord\Style\Font();
        $fontStyle->setBold(true);
        $fontStyle->setName('Tahoma');
        $fontStyle->setSize(13);
        $myTextElement = $section->addText('"Believe you can and you\'re halfway there." (Theodor Roosevelt)');
        $myTextElement->setFontStyle($fontStyle);

        // Saving the document as OOXML file...
        $objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'Word2007');
        $objWriter->save('helloWorld.docx');
        // print_rr($objWriter);
        // // Saving the document as ODF file...
        // $objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'ODText');
        // $objWriter->save('helloWorld.odt');

        // // Saving the document as HTML file...
        // $objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'HTML');
        // $objWriter->save('helloWorld.html');

/* Note: we skip RTF, because it's not XML-based and requires a different example. */
/* Note: we skip PDF, because "HTML-to-PDF" approach is used to create PDF documents. */
    }
    function __construct() {
        parent::__construct();
        $this->load->model('Model_Usuario');
    }
    public function eliminar($idUsuario = false){
        if($idUsuario){
            $this->Model_Usuario->eliminarUsuario($idUsuario);
        }
        redirect('testuser');
    }
    public function registro(){
        $datos = $this->input->post();
        if($datos){
            $this->Model_Usuario->insertarUsuarios($datos);
        }
        redirect('testuser');
    }
    public function index()
    {
        echo AppSession::get('user_id');
        print_rr($_SESSION);
        echo base_url();
        print_rr($_SERVER);

        // $datos = array();
        // $lst = $this->Model_Usuario->listarUsuarios();
        // $datos['lstUsuarios'] = $lst;
        // $this->smartys->assign($datos);
        // $this->smartys->render('index','template_home');
    }

    public function test(){
        $this->load->model('Model_Instalacion');
        $l = $this->Model_Instalacion->listar();
        print_rr($l);
    }

    public function variables(){
        $r = new OrigenResiduos();

        $r->rso_id = 0;
        $array = get_object_vars($r);
        print_rr($r);
        // print_rr($rr);
        // $r = null;
        foreach ($array as $key => $value) {
            // echo $value;
           if(is_null($value)){
                unset($array[$key]);
           }

        }
        print_rr($array);
        if(is_null($r->rso_id)) echo 'a';
        else echo 'b';
    }

    public function hash(){
        $this->load->library('Hash');

        echo Hash::getHash('sha1', 'admin', HASH_KEY);
        // echo Hash::getHash('sha1', 'hola', HASH_KEY);
    }
    public function pruebax(){


        $this->smartys->render('caso','custom');
    }
    public function session(){
        print_rr($this->session);
        print_rr($this);
    }
    public function generar_carpeta(){
        $titulo = '       ';
        echo $titulo.'</br>';
        $nt = trim(strtolower($titulo));
        $cadena = preg_replace('/\s/', '', $nt);
        br();
        echo $cadena.'d</br>';
        if($cadena)
            echo 'asdsd';
        else echo 'xxxxx';
        br();

        exit;
        $cadena2 = preg_replace('/\s/', '_', $cadena);
        echo $cadena2.'</br>';

        // echo $nt.'</br>';
        // $nnt = str_replace()
    }
    public function dividir()
    {
        echo floor(31/10) + (20%10 > 0 ? 1 : 0) ;
        echo '</br>';
echo 28%10;
echo '</br>';
        echo round(9.5, 0, PHP_ROUND_HALF_DOWN);
    }

    public function  upload(){
        // $this->smartys->render('update',false);
        $rr = array('carro' => '12345','perro' => 'kaiser');
        $a = array('carro' => 'toyota');
        $r =   $a + $rr;
        print_rr($r);
    }
    public function objetos(){
        $objeto = array('persona' => 'adasdasdasdasd');
        var_dump(is_object($objeto));
        echo count($objeto);
        print_rr($objeto);
        br();
        $array = array(
            'casa' => 'adasdasdasdasd',
            'edificio' => 'adasdasdasdasd',
            );
        $array = array();
        $array['casa'] = 'dasdasdasda';
        $array['edificio'] = 'dasdasdasda';
        foreach($array as $index => $value){
            echo $index;
            br();
        }
        // $array = (object) $array;
        var_dump(is_object($array));
        echo count($array);
        print_rr($array);
        br();
        $arrayb[] = array('gato' => 'adasdasdasdasd');
        $arrayb[] = array('perro' => 'adasdasdasdasd');
        $arrayb[] = array('perico' => 'adasdasdasdasd');
        var_dump(is_object($arrayb));
        echo count($arrayb);
        print_rr($arrayb);
    }
    public function tiempo(){
         // print_rr($_SERVER);
        $t = time();
        print_rr($t);
        echo $t + 60*60*2;
        // echo  60*60*2;

    }
    public function visitas(){
        // $this->load->model('Model_Usuarios','usuario');
        // echo date('G:00');
        // $t = 'dasd';
        // echo strlen($t);
        // echo date('Y-m-d');
        // exit;
        // $t = $this->usuario->listar_estadisticas();
        // print_rr($t);
        // $this->usuario->visita_hoy('2016-12-25');

        // echo date('Y-m-d');
        // br();
        // echo time();
        // br();
        // echo date('Y-m-d',time() - 24*60*60);

        // echo '------------------------------------------------------------';
        // br();
        // echo date('w');

                $dia_sem = +date('w');
                $t = $dia_sem == 0 ? 6 : ($dia_sem == 1? 0 : ($dia_sem - 1));
                $ini_sem_num = time() - ($t)*3600*24;
                $ini_sem = date('Y-m-d',$ini_sem_num);
                $fin_sem = date('Y-m-d',$ini_sem_num + 6*3600*24);
                echo $ini_sem;br();
                echo $fin_sem;br();

        // $dia_sem = +date('w');
        // echo $dia_sem;
        // echo 4>2?'si':'no';
        // br();
        // $t = $dia_sem == 0 ? 6 : ($dia_sem == 1? 0 : ($dia_sem - 1));
        // $ini_sem = time() - ($t)*3600*24;
        // echo $t;
        // br();
        // echo date('Y-m-d',$ini_sem);
        // br();
        // echo date('Y-m-d',$ini_sem + 6*3600*24);
        // echo date('Y-m-d', time() -)

         // echo $_SERVER['HTTP_REFERER'];
    }
    public function imagen(){
        $this->load->model('Model_Unidad','doc');
        $this->doc->listar();

        echo base_url();
    }
    public function muestras(){
        // $this->load->model('Model_Boleta','bol');
        // $r = $this->bol->listar_respuestas(2,'post');
        // print_rr($r);

        // $this->load->model('Model_Boleta','bol');
        // $r = $this->bol->getdatafilesimple(24);
        // print_rr($r);
        // $this->load->library('themoment');
        // $m = new Moment\Moment(); // default is "now" UTC
        // echo $m->format();
        // print_rr($this->momen00000000t);
        exit;
          $this->load->model('Model_Departamento','dep');
        $r = $this->dep->listar('desDepend','asc');
        print_rr($r);
    }
    public function pdf3(){
        require_once APPPATH.'third_party'.DS.'PHPExcel.php';
        $rendererName = PHPExcel_Settings::PDF_RENDERER_TCPDF;
        //$rendererName = PHPExcel_Settings::PDF_RENDERER_DOMPDF;
        //$rendererLibrary = 'tcPDF5.9';
        $rendererLibrary = 'mPDF5.4';
        //$rendererLibrary = 'domPDF0.6.0beta3';
        $rendererLibraryPath = APPPATH.'third_party'.DS.'tcpdf'.DS;


        // Create new PHPExcel object
        $objPHPExcel = new PHPExcel();
        $ruta = "docs/__procesoss/_residuos/_templates/frmt_autorizacion_dos.xlsx";
        // Leemos un archivo Excel 2007
        $objReader = PHPExcel_IOFactory::createReader('Excel2007');
        // $objPHPExcel = $objReader->load("public/views/indicadores/plantillas/plantilla_meses_pdf.xlsx");
        // $objPHPExcel = $objReader->load("public/views/indicadores/plantillas/frmt_autorizacion.xlsx");
        $objPHPExcel = $objReader->load($ruta);
        // Indicamos que se pare en la hoja uno del libro

        // Agregar Informacion
        //  $objPHPExcel->setActiveSheetIndex(0)
        // ->setCellValue('B1', 'adasdasd')
        // ->setCellValue('B2', 'asdasdasd');
        /*->setCellValue('C2', 'Estado');*/

        // $objPHPExcel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');

        // Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
        $objPHPExcel->getActiveSheet()->setShowGridLines(false);
        $objPHPExcel->setActiveSheetIndex(0);


        // Set document properties
        // $objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
        //                              ->setLastModifiedBy("Maarten Balliauw")
        //                              ->setTitle("PDF Test Document")
        //                              ->setSubject("PDF Test Document")
        //                              ->setDescription("Test document for PDF, generated using PHP classes.")
        //                              ->setKeywords("pdf php")
        //                              ->setCategory("Test result file");


        // // Add some data
        // $objPHPExcel->setActiveSheetIndex(0)
        //             ->setCellValue('A1', 'Hello')
        //             ->setCellValue('B2', 'world!')
        //             ->setCellValue('C1', 'Hello')
        //             ->setCellValue('D2', 'world!');

        // // Miscellaneous glyphs, UTF-8
        // $objPHPExcel->setActiveSheetIndex(0)
        //             ->setCellValue('A4', 'Miscellaneous glyphs')
        //             ->setCellValue('A5', 'éàèùâêîôûëïüÿäöüç');

        // // Rename worksheet
        // $objPHPExcel->getActiveSheet()->setTitle('Simple');
        // $objPHPExcel->getActiveSheet()->setShowGridLines(false);

        // // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        // $objPHPExcel->setActiveSheetIndex(0);


        if (!PHPExcel_Settings::setPdfRenderer(
                $rendererName,
                $rendererLibraryPath
            )) {
            die(
                'NOTICE: Please set the $rendererName and $rendererLibraryPath values' .
                '<br />' .
                'at the top of this script as appropriate for your directory structure'
            );
        }


        // Redirect output to a client’s web browser (PDF)
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment;filename="01simpleasdasd.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'PDF');
        $objWriter->save('php://output');
        exit;
    }
    public function pdf2(){
        // echo 'adasd';
        //  echo DOCSPATH;exit;

        require_once APPPATH.'third_party'.DS.'PHPExcel.php';
        $objPHPExcel = new PHPExcel();
        $rendererName = PHPExcel_Settings::PDF_RENDERER_TCPDF;
        //$rendererName = PHPExcel_Settings::PDF_RENDERER_DOMPDF;
        //$rendererLibrary = 'tcPDF5.9';
        $rendererLibrary = 'mPDF5.4';
        //$rendererLibrary = 'domPDF0.6.0beta3';
        $rendererLibraryPath = APPPATH.'third_party'.DS.'tcpdf'.DS;


        // Create new PHPExcel object


        // Set document properties
        // $objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
        //                              ->setLastModifiedBy("Maarten Balliauw")
        //                              ->setTitle("PDF Test Document")
        //                              ->setSubject("PDF Test Document")
        //                              ->setDescription("Test document for PDF, generated using PHP classes.")
        //                              ->setKeywords("pdf php")
        //                              ->setCategory("Test result file");

        $objReader = PHPExcel_IOFactory::createReader('Excel2007');
        $ruta = doc_templates::getExcel('rep_gen_sol');
        // echo $ruta;exit;
        $objPHPExcel = $objReader->load($ruta);
        // Indicamos que se pare en la hoja uno del libro

        // Agregar Informacion
        //  $objPHPExcel->setActiveSheetIndex(0)
        // ->setCellValue('C17', 'adasdasd');
        /*->setCellValue('C2', 'Estado');*/

        // $this->excel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');


        // Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
        $objPHPExcel->setActiveSheetIndex(0);
        // Add some data
        // $objPHPExcel->setActiveSheetIndex(0)
        //             ->setCellValue('A1', 'Hello')
        //             ->setCellValue('B2', 'world!')
        //             ->setCellValue('C1', 'Hello')
        //             ->setCellValue('D2', 'world!');

        // // Miscellaneous glyphs, UTF-8
        // $objPHPExcel->setActiveSheetIndex(0)
        //             ->setCellValue('A4', 'Miscellaneous glyphs')
        //             ->setCellValue('A5', 'éàèùâêîôûëïüÿäöüç');

        // // Rename worksheet
        // $objPHPExcel->getActiveSheet()->setTitle('Simple');
        // $objPHPExcel->getActiveSheet()->setShowGridLines(false);

        // // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        // $objPHPExcel->setActiveSheetIndex(0);
        // $objPHPExcel->getActiveSheet()->getPageSetup()->setOrientation('landscape');

// $objPHPExcel->getActiveSheet()->getPageSetup()->setOrientation('landscape');
        if (!PHPExcel_Settings::setPdfRenderer(
                $rendererName,
                $rendererLibraryPath
            )) {
            die(
                'NOTICE: Please set the $rendererName and $rendererLibraryPath values' .
                '<br />' .
                'at the top of this script as appropriate for your directory structure'
            );
        }
        PHPExcel_Writer_PDF_Core::setOrientation('landscape');
         PHPExcel_Writer_PDF_Core::setPaperSize(8);
        // Redirect output to a client’s web browser (PDF)
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment;filename="01asdsimple.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'PDF');
        $objWriter->save('php://output');
        exit;
    }
    public function pdf(){
        // $this->load->library('excel');
        require_once APPPATH.'third_party'.DS.'PHPExcel.php';
        // echo PHPEXCEL_ROOT;
        // print_rr($this->excel);exit;
        // $ttt = new PHPExcel_IOFactory();
        // var_dump($ttt);exit;
        // $this->excel = new PHPExcel();

        $rendererName = PHPExcel_Settings::PDF_RENDERER_TCPDF;
         $rendererLibraryPath = APPPATH.'third_party'.DS.'tcpdf';

        // Leemos un archivo Excel 2007
        $objReader = PHPExcel_IOFactory::createReader('Excel2007');
        $this->excel = $objReader->load(doc_templates::getExcel('rep_gen_sol'));
        // Indicamos que se pare en la hoja uno del libro

        // Agregar Informacion
         $this->excel->setActiveSheetIndex(0)
        ->setCellValue('C17', 9);
        /*->setCellValue('C2', 'Estado');*/

        // $this->excel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');


        // Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
        $this->excel->setActiveSheetIndex(0);

        // Se modifican los encabezados del HTTP para indicar que se envia un archivo de Excel.
        //

        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="Reporte Mensual.xlsx"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel2007');
        $objWriter->save('php://output');



        //PDFDF

    // if (!PHPExcel_Settings::setPdfRenderer(
    //         $rendererName,
    //         $rendererLibraryPath
    //     )) {
    //     die(
    //         'NOTICE: Please set the $rendererName and $rendererLibraryPath values' .
    //         '<br />' .
    //         'at the top of this script as appropriate for your directory structure'
    //     );
    // }
    //      PHPExcel_Writer_PDF_Core::setOrientation('landscape');



    //     // Redirect output to a clientâ€™s web browser (PDF)
    //     header('Content-Type: application/pdf');
    //     header('Content-Disposition: attachment;filename="Reporte Mensual.pdf"');
    //     header('Cache-Control: max-age=0');

    //     $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
    //     $objWriter->save('php://output');
        exit;
        // echo '<button>PDF</button>';
    }
    public function pdf5(){
        // print_rr($this);
        // exit;
        require_once LIBSPATH.'html2pdf.php';

            $content = "
        <page>
            <h1>Exemple d'utilisation</h1>
            <br>
            Ceci est un <b>exemple d'utilisation</b>
            de <a href='http://html2pdf.fr/'>HTML2PDF</a>.<br>
        </page>";
        $html = $this->smartys->render_cache('parapdf',false);
        // require_once(dirname(__FILE__).'/html2pdf/html2pdf.class.php');
        $html2pdf = new HTML2PDF('P','A4','fr');
        $html2pdf->WriteHTML($html);
        $html2pdf->Output('exemple.pdf');
    }
    public function fecha(){
        echo dirname(APPPATH).DS.'public'.DS.'app'.DS.'font'.DS.'Roboto-Regular.ttf';
        // require_once LIBSPATH.'themoment.php';
        // $m = new \Moment\Moment();
        // \Moment\Moment::setLocale('es_ES');
        // echo $m->format('dddd DD MMM YYYY, hh:mm a',new \Moment\CustomFormats\MomentJs());
        //
        echo '<iframe class="preview-pane" type="application/pdf" width="100%" height="650" frameborder="0" style="position:relative;z-index:999"></iframe>';
    }
    public function textindex(){


        // $this->smartys->assign($datos);
        $this->smartys->render('spider','template_home');
    }
    public function posted(){
        print_rr($_POST);
    }

    public function notifi(){
        // $hh = ent_notificaciones::boletasig('elaborado', array('uni_receptora' => 'la unidaasdasd'));
        // print_rr($hh);
        //
        $text = 'Se <a href="#dassdasdasd"> ah elaborado una  </a> boleta SIG para UNIDAD TI Y COMUNICACIONES';
        echo strip_tags($text);
        br();
        echo "\n";

        // Permite <p> y <a>
        echo strip_tags($text, '<p><a>');
    }
    public function fechatest(){
        $g = new DateTime();
        echo $g->format('Y-m-d H:i');

        $g = DateTime::createFromFormat('d/m/Y','22/12/2016');
        var_dump($g);
        echo $g->format('Y-m-d');
        br();
        print_rr($g);
    }
    public function declara(){
        // print_rr($_POST);
        $num = 123123;
        $numa = +'123s';
        echo strlen($numa).'-'.strlen('123s');
        $numb = +'ss123';

        var_dump(is_int($num));
        var_dump(is_int($numa));

        var_dump(is_int($numb));
    }

}
