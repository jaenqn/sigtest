<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Residuo extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('Model_Residuos','residuos');
    }

    public function eliminar_declaracion($iddec){
        $this->residuos->eliminar_declaracion($iddec);
        echo_json(array('resultado' => true));
    }

    public function index()
    {
        redirect('residuos/ingreso','refresh');
    }
    private function get_word_dec($values){
        // print_rr($values);exit;
        $this->load->library('WordElements');
        $this->load->library('LibPhpWord');
        $setValA['year'] = $values->rd_year;

        $setValA['ins_raz_sig'] = $values->ins_razon_social.' - '.$values->ins_rz_siglas.' / '.$values->ins_nombre;
        $setValA['ins_ruc'] = $values->ins_ruc;                     $setValA['ins_email'] = $values->ins_email;
        $setValA['ins_tel'] = $values->ins_telefono;
        $setValA['itca'] = '  ';
        $setValA['itcb'] = '  ';
        $setValA['itcc'] = '  ';
        switch(strtolower($values->ins_attr_direccion)){
            case 'calle': $setValA['itcc'] = 'X'; break;
            case 'av': $setValA['itca'] = 'X'; break;
            case 'jr': $setValA['itcb'] = 'X'; break;
        }

        $setValA['ins_dir'] = $values->ins_direccion;               $setValA['ins_num'] = $values->ins_dir_num;
        $setValA['ins_urb'] = $values->ins_urb_localidad;           $setValA['ins_dis'] = $values->dis_id_distrito;
        $setValA['ins_prov'] = $values->pro_id_provincia;           $setValA['ins_dep'] = $values->dep_id_departamento;
        $setValA['ins_pos'] = $values->ins_cod_postal;              $setValA['ins_rlel'] = $values->ins_representante;
        $setValA['ins_dnil'] = $values->ins_dni_representante;      $setValA['ins_nl'] = $values->ins_ing_responsable;
        $setValA['ins_cipl'] = $values->ins_cip_responsable;

        $setValA['r1'] = '-';               $setValA['o1'] = '-';
        $setValA['r2'] = '-';               $setValA['o2'] = '-';
        $setValA['r3'] = '-';               $setValA['o3'] = '-';
        $setValA['r4'] = '-';               $setValA['o4'] = '-';
        $setValA['r5'] = '-';               $setValA['o5'] = '-';
        $setValA['r6'] = '-';               $setValA['o6'] = '-';
        $setValA['r7'] = '-';               $setValA['o7'] = '-';
        $setValA['r8'] = '-';               $setValA['o8'] = '-';
        $setValA['r9'] = '-';               $setValA['o9'] = '-';
        $setValA['r10'] = '-';              $setValA['o10'] = '-';
        $setValA['r11'] = '-';              $setValA['o11'] = '-';
        $setValA['r12'] = '-';              $setValA['o12'] = '-';
        if($values->res_peligro == 1){
            $setValA['r1'] = number_format((+$values->datatotal->resv_1)/1000, 3, ',', '.');    $setValA['r2'] = number_format((+$values->datatotal->resv_2)/1000, 3, ',', '.');
            $setValA['r3'] = number_format((+$values->datatotal->resv_3)/1000, 3, ',', '.');    $setValA['r4'] = number_format((+$values->datatotal->resv_4)/1000, 3, ',', '.');
            $setValA['r5'] = number_format((+$values->datatotal->resv_5)/1000, 3, ',', '.');    $setValA['r6'] = number_format((+$values->datatotal->resv_6)/1000, 3, ',', '.');
            $setValA['r7'] = number_format((+$values->datatotal->resv_7)/1000, 3, ',', '.');    $setValA['r8'] = number_format((+$values->datatotal->resv_8)/1000, 3, ',', '.');
            $setValA['r9'] = number_format((+$values->datatotal->resv_9)/1000, 3, ',', '.');    $setValA['r10'] = number_format((+$values->datatotal->resv_10)/1000, 3, ',', '.');
            $setValA['r11'] = number_format((+$values->datatotal->resv_11)/1000, 3, ',', '.');  $setValA['r12'] = number_format((+$values->datatotal->resv_12)/1000, 3, ',', '.');
        }else{
                $setValA['o1'] = number_format((+$values->datatotal->resv_1)/1000, 3, ',', '.');    $setValA['o2'] = number_format((+$values->datatotal->resv_2)/1000, 3, ',', '.');
                $setValA['o3'] = number_format((+$values->datatotal->resv_3)/1000, 3, ',', '.');    $setValA['o4'] = number_format((+$values->datatotal->resv_4)/1000, 3, ',', '.');
                $setValA['o5'] = number_format((+$values->datatotal->resv_5)/1000, 3, ',', '.');    $setValA['o6'] = number_format((+$values->datatotal->resv_6)/1000, 3, ',', '.');
                $setValA['o7'] = number_format((+$values->datatotal->resv_7)/1000, 3, ',', '.');    $setValA['o8'] = number_format((+$values->datatotal->resv_8)/1000, 3, ',', '.');
                $setValA['o9'] = number_format((+$values->datatotal->resv_9)/1000, 3, ',', '.');    $setValA['o10'] = number_format((+$values->datatotal->resv_10)/1000, 3, ',', '.');
                $setValA['o11'] = number_format((+$values->datatotal->resv_11)/1000, 3, ',', '.');  $setValA['o12'] = number_format((+$values->datatotal->resv_12)/1000, 3, ',', '.');
        }
        $setValA['res_des'] = $values->rd_des_res;


        $setValA['rr1'] = WordElements::checkBox('nameA', 0);
        $setValA['rr2'] = WordElements::checkBox('nameB', 0);
        $setValA['rr3'] = WordElements::checkBox('nameC', 0);
        $setValA['rr4'] = WordElements::checkBox('nameD', 0);
        $setValA['rr5'] = WordElements::checkBox('nameE', 0);
        $setValA['rr6'] = WordElements::checkBox('nameF', 0);
        $setValA['rr7'] = WordElements::checkBox('nameG', 0);
        $setValA['rr8'] = '';

        switch(+$values->rd_peligrosidad){
            case 1: $setValA['rr1'] = WordElements::checkBox('nameA', 1); break;
            case 2: $setValA['rr2'] = WordElements::checkBox('nameB', 1); break;
            case 3: $setValA['rr3'] = WordElements::checkBox('nameC', 1); break;
            case 4: $setValA['rr4'] = WordElements::checkBox('nameD', 1); break;
            case 5: $setValA['rr5'] = WordElements::checkBox('nameE', 1); break;
            case 6: $setValA['rr6'] = WordElements::checkBox('nameF', 1); break;
            case 7: $setValA['rr7'] = WordElements::checkBox('nameG', 1); break;
            case 8:
                $setValA['rr1'] = $values->rd_otra_pel;
                break;
        }

        $setValA['m_rep'] = $values->rd_alm_recip;
        $setValA['m_mat'] = $values->rd_alm_material;
        $setValA['m_vol'] = $values->rd_alm_volumen;
        $setValA['m_nr'] = $values->rd_alm_num_recip;

        $setValA['rt1'] = '';
        $setValA['rt2'] = '';
        switch(+$values->rd_tra_mod){
            case 1: $setValA['rt1'] = 'X';break;
            case 2: $setValA['rt2'] = 'X';break;
        }
        $setValA['treg'] = $values->rd_tra_reg_eps;     $setValA['tfv'] = $values->rd_tra_fv_eps;
        $setValA['tam'] = $values->rd_tra_nram;         $setValA['tdm'] = $values->rd_tra_desmetodo;
        $setValA['tdc'] = $values->rd_tra_cantidad;

        $setValA['rrec'] = $values->rd_rea_reci;        $setValA['rrecp'] = $values->rd_rea_recu;
        $setValA['rreu'] = $values->rd_rea_reu;         $setValA['rcm'] = $values->rd_rea_cantidad;

        $setValA['msdasm'] = $values->rd_mise_desc;     $setValA['msctm'] = $values->rd_mise_cantidad;

        $setValA['tersnr'] = $values->rd_trana_nreg;        $setValA['tefv'] = $values->rd_trana_fv;
        $setValA['team'] = $values->rd_trana_nram;          $setValA['tear'] = $values->rd_trana_nrar;
        $setValA['isns'] = $values->rd_trana_isnrs;         $setValA['isnv'] = $values->rd_trana_isvol;
        $setValA['ist'] = $values->rd_trana_istipo;         $setValA['isc'] = $values->rd_trana_iscapacidad;
        $setValA['isvptm'] = $values->rd_trana_isvptm;      $setValA['isfvd'] = $values->rd_trana_isfvd;
        $setValA['isvcv'] = $values->rd_trana_isvcv;

        $setValA['xxa'] = '';
        $setValA['xya'] = '';
        $setValA['xza'] = '';
        switch(+$values->rd_trana_cvmodo){
            case 1: $setValA['xxa'] = 'X';break;
            case 2: $setValA['xya'] = 'X';break;
            case 3: $setValA['xza'] = 'X';break;
        }

        $setValA['istv'] = $values->rd_trana_cvtipo;        $setValA['isnp'] = $values->rd_trana_cvnplaca;
        $setValA['iscpp'] = $values->rd_trana_cvcpro;       $setValA['isafv'] = $values->rd_trana_cvafab;
        $setValA['istcv'] = $values->rd_trana_cvcolor;      $setValA['isnev'] = $values->rd_trana_cvnrejes;
        //mod 2
        $setValA['tersnrb'] = $values->rd_tranb_nreg;        $setValA['tefvb'] = $values->rd_tranb_fv;
        $setValA['teamb'] = $values->rd_tranb_nram;          $setValA['tearb'] = $values->rd_tranb_nrar;
        $setValA['isnsb'] = $values->rd_tranb_isnrs;         $setValA['isnvb'] = $values->rd_tranb_isvol;
        $setValA['istb'] = $values->rd_tranb_istipo;         $setValA['iscb'] = $values->rd_tranb_iscapacidad;
        $setValA['isvptmb'] = $values->rd_tranb_isvptm;      $setValA['isfvdb'] = $values->rd_tranb_isfvd;
        $setValA['isvcvb'] = $values->rd_tranb_isvcv;

        $setValA['xxb'] = '';
        $setValA['xyb'] = '';
        $setValA['xzb'] = '';
        switch(+$values->rd_tranb_cvmodo){
            case 1: $setValA['xxb'] = 'X';break;
            case 2: $setValA['xyb'] = 'X';break;
            case 3: $setValA['xzb'] = 'X';break;
        }

        $setValA['istvb'] = $values->rd_tranb_cvtipo;        $setValA['isnpb'] = $values->rd_tranb_cvnplaca;
        $setValA['iscppb'] = $values->rd_tranb_cvcpro;       $setValA['isafvb'] = $values->rd_tranb_cvafab;
        $setValA['istcvb'] = $values->rd_tranb_cvcolor;      $setValA['isnevb'] = $values->rd_tranb_cvnrejes;

        $setValA['dfrss'] = $values->rd_disf_epsrs;         $setValA['dfnrer'] = $values->rd_disf_eps;
        $setValA['dffv'] = $values->rd_disf_fv;             $setValA['dfnam'] = $values->rd_disf_nram;
        $setValA['dfadr'] = $values->rd_disf_nrar;          $setValA['dfis'] = $values->rd_disf_ismetodo;
        $setValA['dfubi'] = $values->rd_disf_isubi;

        $setValA['ppdt'] = $values->rd_prp_desc;            $setValA['pppp'] = $values->rd_prp_nrpp;
        $setValA['pprexp'] = $values->rd_prp_rexp;          $setValA['ppmdsea'] = $values->rd_prp_msa;
        $setValA['ppapa'] = $values->rd_prp_apa;            $setValA['ppv'] = $values->rd_prp_apaveces;
        $setValA['ppdes'] = $values->rd_prp_apades;

        $setValA['fgagdra'] = '';
        $setValA['fgiup'] = '';
        $setValA['fgtr'] = '';
        $setValA['new_files'] = '';
        if(count($values->rd_fuentes) > 0){
            $setValA['fgagdra'] = $values->rd_fuentes[0]->rdf_actividad;
            $setValA['fgiup'] = $values->rd_fuentes[0]->rdf_insumos;
            $setValA['fgtr'] = $values->rd_fuentes[0]->rdf_tipo;
            $tempnf = '';
            if(count($values->rd_fuentes) > 1){

                for ($i = 1; $i < count($values->rd_fuentes); $i++) {
                    $tempnf .= WordElements::trfuentedec(
                        $values->rd_fuentes[$i]->rdf_actividad,
                        $values->rd_fuentes[$i]->rdf_insumos,
                        $values->rd_fuentes[$i]->rdf_tipo
                        );
                }

            }

            // $tempnf .= WordElements::trfuentedec('ads','asd','sss').WordElements::trfuentedec('ads','asd','sss');
            $setValA['new_files'] = $tempnf;
        }

        $phpWord = new \PhpOffice\PhpWord\PhpWord();
        $testWord = $phpWord->loadTemplate(doc_templates::getWord('rep_declaracion'));
        $vars  = $testWord->getVariables();

        $testWord->setValue(array_keys($setValA), array_values($setValA));

        $testWord->saveAs(DOCSPATH.'_test/test_declara.docx');
         // header('Content-Type: application/docx');
        header('Content-Disposition: attachment;filename="DECLARACIÓN DE MANEJO DE RR.SS. '.$values->ins_abbr.' '.$values->rd_year.'.docx"');
        header('Cache-Control: max-age=0');
        ob_end_clean();
        readfile(DOCSPATH.'_test/test_declara.docx');
        // print_rr($vars);

    }
    function declaracion($iddec){
        $this->load->model('Model_Instalacion','inst');
        $datos['lstInstalacion'] = $this->inst->getdata();
        $datos['objDec'] = $this->residuos->getdatadeclaracion($iddec);
        if(isset($_GET['download'])){
            switch($_GET['download']){
                case 'word':
                    $this->get_word_dec($datos['objDec']);
                    exit;
                    break;
            }
        }



        $datos['titulo_header'] = 'DECLARACIÓN DE MANEJO DE RESIDUOS SÓLIDOS-'.$datos['objDec']->ins_abbr.'-'.$datos['objDec']->rd_year;
        // print_rr($datos['objDec']);exit;
        $objR = new ent_residuo();
        $objR->res_id = $datos['objDec']->res_id ;
        $objR->res_nombre = $datos['objDec']->res_nombre;
        $datos['lstResiduos'] = array($objR);

        $datos['lst_years'] = array(array('get_year' => $datos['objDec']->rd_year));
        // print_rr($datos['lstResiduos']);
        $this->smartys->assign($datos);
        $this->smartys->render('res_generar_declaracion');
        // $this->smartys->render('testuser/none');

    }
    public function fuente_declaracion($opcion, $id){

        if(is_ajax(false)){
            $res = array(
                'resultado' => false
                );
            switch($opcion){
                case 'eliminar':
                        if(is_numeric(+$id)){
                            $this->residuos->eliminar_fuente_dec($id);
                            $res['resultado'] = true;
                        }

                    break;
            }
            echo_json($res);
        }else show_404();


    }
    public function actualizar_declaracion(){
        $p = $this->input->post();

        $fuentes = array();
        for ($i=0; $i < count($p['txtFuenGenAGDR']); $i++) {
            $fuentes[] = array(
                'rdf_idsss' => $p['txtFuenteId'][$i],
                'rdf_actividad' => $p['txtFuenGenAGDR'][$i],
                'rdf_insumos' => $p['txtFuenGenIUEEP'][$i],
                'rdf_tipo' => $p['txtFuenGenTR'][$i],
                'rd_id_declaracion' => $p['txtIdDec']
                );
        }
        $values['fuentes'] = $fuentes;
        // $values['rd_year'] = $p['selResiduoYear'];
        // $values['ins_id_instalacion'] = $p['selInstalacion'];
        $values['rd_des_res'] =  $p['txtDescripcionRes'];
        $values['rd_id'] =  $p['txtIdDec'];
        // $values['res_id_residuo'] = $p['selResiduo'];
        $values['rd_peligrosidad'] = isset($p['radTipoPeligrosidad']) ? $p['radTipoPeligrosidad'] : 0;
        $values['rd_otra_pel'] = +$values['rd_peligrosidad'] != 8 ? '' : $p['txtOtraPeligrosidad'];
        $values['rd_alm_recip'] = $p['txtAlmacRecipiente'];
        $values['rd_alm_material'] = $p['txtAlmacMaterial'];                $values['rd_alm_volumen'] = $p['txtAlmacVolumen'];
        $values['rd_alm_num_recip'] = $p['txtAlmacNroRec'];

        $values['rd_tra_mod'] = isset($p['radTipoTratamiento']) ? $p['radTipoTratamiento'] : 0;
        $values['rd_tra_reg_eps'] = $p['txtTrataRegistro'];                 $values['rd_tra_fv_eps'] = $p['txtTrataFechaVenc'];
        $values['rd_tra_nram'] = $p['txtTrataAutoriza'];                    $values['rd_tra_desmetodo'] = $p['txtTrataDescripcion'];
        $values['rd_tra_cantidad'] = $p['txtTrataCantidad'];

        $values['rd_rea_reci'] = $p['txtReaproReciclaje'];
        $values['rd_rea_recu'] = $p['txtReaproRecupera'];                   $values['rd_rea_reu'] = $p['txtReaproReutiliza'];
        $values['rd_rea_cantidad'] = $p['txtReaproCantidad'];

        $values['rd_mise_desc'] = $p['txtMinimiDescripcion'];               $values['rd_mise_cantidad'] = $p['txtMinimiCantidad'];

        $values['rd_trana_nreg'] = $p['txtTransNroRegistro'];               $values['rd_trana_fv'] = $p['txtTransFechaVenci'];
        $values['rd_trana_nram'] = $p['txtTransAutoriMuni'];                $values['rd_trana_nrar'] = $p['txtTransAprobacion'];
        $values['rd_trana_isnrs'] = $p['txtTransNroServicios'];             $values['rd_trana_isvol'] = $p['txtTransVolumen'];
        $values['rd_trana_istipo'] = $p['txtTransInfoTipo'];                $values['rd_trana_iscapacidad'] = $p['txtTransInfoCapacidad'];
        $values['rd_trana_isvptm'] = $p['txtTransInfoVPTM'];                $values['rd_trana_isfvd'] = $p['txtTransInfoFV'];
        $values['rd_trana_isvcv'] = $p['txtTransInfoVCXP'];                 $values['rd_trana_cvmodo'] = isset($p['radTransCaract']) ? $p['radTransCaract'] : 0;
        $values['rd_trana_cvtipo'] = $p['txtTransCaractTV'];                $values['rd_trana_cvnplaca'] = $p['txtTransCaractNroP'];
        $values['rd_trana_cvcpro'] = $p['txtTransCaractCP'];                $values['rd_trana_cvafab'] = $p['txtTransCaractAF'];
        $values['rd_trana_cvcolor'] = $p['txtTransCaractColor'];            $values['rd_trana_cvnrejes'] = $p['txtTransCaractNroE'];

        $values['rd_tranb_nreg'] = $p['txtTransBNroRegistro'];               $values['rd_tranb_fv'] = $p['txtTransBFechaVenci'];
        $values['rd_tranb_nram'] = $p['txtTransBAutoriMuni'];                $values['rd_tranb_nrar'] = $p['txtTransBAprobacion'];
        $values['rd_tranb_isnrs'] = $p['txtTransBNroServicios'];             $values['rd_tranb_isvol'] = $p['txtTransBVolumen'];
        $values['rd_tranb_istipo'] = $p['txtTransBInfoTipo'];                $values['rd_tranb_iscapacidad'] = $p['txtTransBInfoCapacidad'];
        $values['rd_tranb_isvptm'] = $p['txtTransBInfoVPTM'];                $values['rd_tranb_isfvd'] = $p['txtTransBInfoFV'];
        $values['rd_tranb_isvcv'] = $p['txtTransBInfoVCXP'];                 $values['rd_tranb_cvmodo'] = isset($p['radTransBCaract']) ? $p['radTransBCaract'] : 0;
        $values['rd_tranb_cvtipo'] = $p['txtTransBCaractTV'];                $values['rd_tranb_cvnplaca'] = $p['txtTransBCaractNroP'];
        $values['rd_tranb_cvcpro'] = $p['txtTransBCaractCP'];                $values['rd_tranb_cvafab'] = $p['txtTransBCaractAF'];
        $values['rd_tranb_cvcolor'] = $p['txtTransBCaractColor'];            $values['rd_tranb_cvnrejes'] = $p['txtTransBCaractNroE'];


        $values['rd_disf_epsrs'] = $p['txtTransDispoRazonSYS'];             $values['rd_disf_eps'] = $p['txtTransDispoReg'];
        $values['rd_disf_fv'] = $p['txtTransDispoFechaVenc'];               $values['rd_disf_nram'] = $p['txtTransDispoAM'];
        $values['rd_disf_nrar'] = $p['txtTransDispoADR'];                   $values['rd_disf_ismetodo'] = $p['txtTransDispoMetodo'];
        $values['rd_disf_isubi'] = $p['txtTransDispUbicac'];

        $values['rd_prp_desc'] = $p['txtPersonalDesc'];                     $values['rd_prp_nrpp'] = $p['txtPersonalPerPuesto'];
        $values['rd_prp_rexp'] = $p['txtPersonalRiesgos'];                  $values['rd_prp_msa'] = $p['txtPersonalMedSeg'];
        $values['rd_prp_apa'] = $p['txtPersonalAPEEA'];                     $values['rd_prp_apaveces'] = $p['txtPersonalAccVeces'];
        $values['rd_prp_apades'] = $p['txtPersonalAccDesc'];

        $res = $this->residuos->actualizar_declaracion($values);

        echo_json(array('resultado' => $res));
    }
    public function registrar_declaracion(){
        // print_rr($_POST);exit;
        $p = $this->input->post();

        $fuentes = array();
        for ($i=0; $i < count($p['txtFuenGenAGDR']); $i++) {
            $fuentes[] = array(
                'rdf_actividad' => $p['txtFuenGenAGDR'][$i],
                'rdf_insumos' => $p['txtFuenGenIUEEP'][$i],
                'rdf_tipo' => $p['txtFuenGenTR'][$i]
                );
        }
        $values['fuentes'] = $fuentes;
        $values['rd_year'] = $p['selResiduoYear'];
        $values['ins_id_instalacion'] = $p['selInstalacion'];               $values['rd_des_res'] =  $p['txtDescripcionRes'];
        $values['res_id_residuo'] = $p['selResiduo'];                       $values['rd_peligrosidad'] = isset($p['radTipoPeligrosidad']) ? $p['radTipoPeligrosidad'] : 0;
        $values['rd_otra_pel'] = +$values['rd_peligrosidad'] != 8 ? '' : $p['txtOtraPeligrosidad'];
        $values['rd_alm_recip'] = $p['txtAlmacRecipiente'];
        $values['rd_alm_material'] = $p['txtAlmacMaterial'];                $values['rd_alm_volumen'] = $p['txtAlmacVolumen'];
        $values['rd_alm_num_recip'] = $p['txtAlmacNroRec'];

        $values['rd_tra_mod'] = isset($p['radTipoTratamiento']) ? $p['radTipoTratamiento'] : 0;
        $values['rd_tra_reg_eps'] = $p['txtTrataRegistro'];                 $values['rd_tra_fv_eps'] = $p['txtTrataFechaVenc'];
        $values['rd_tra_nram'] = $p['txtTrataAutoriza'];                    $values['rd_tra_desmetodo'] = $p['txtTrataDescripcion'];
        $values['rd_tra_cantidad'] = $p['txtTrataCantidad'];

        $values['rd_rea_reci'] = $p['txtReaproReciclaje'];
        $values['rd_rea_recu'] = $p['txtReaproRecupera'];                   $values['rd_rea_reu'] = $p['txtReaproReutiliza'];
        $values['rd_rea_cantidad'] = $p['txtReaproCantidad'];

        $values['rd_mise_desc'] = $p['txtMinimiDescripcion'];               $values['rd_mise_cantidad'] = $p['txtMinimiCantidad'];

        $values['rd_trana_nreg'] = $p['txtTransNroRegistro'];               $values['rd_trana_fv'] = $p['txtTransFechaVenci'];
        $values['rd_trana_nram'] = $p['txtTransAutoriMuni'];                $values['rd_trana_nrar'] = $p['txtTransAprobacion'];
        $values['rd_trana_isnrs'] = $p['txtTransNroServicios'];             $values['rd_trana_isvol'] = $p['txtTransVolumen'];
        $values['rd_trana_istipo'] = $p['txtTransInfoTipo'];                $values['rd_trana_iscapacidad'] = $p['txtTransInfoCapacidad'];
        $values['rd_trana_isvptm'] = $p['txtTransInfoVPTM'];                $values['rd_trana_isfvd'] = $p['txtTransInfoFV'];
        $values['rd_trana_isvcv'] = $p['txtTransInfoVCXP'];                 $values['rd_trana_cvmodo'] = isset($p['radTransCaract']) ? $p['radTransCaract'] : 0;
        $values['rd_trana_cvtipo'] = $p['txtTransCaractTV'];                $values['rd_trana_cvnplaca'] = $p['txtTransCaractNroP'];
        $values['rd_trana_cvcpro'] = $p['txtTransCaractCP'];                $values['rd_trana_cvafab'] = $p['txtTransCaractAF'];
        $values['rd_trana_cvcolor'] = $p['txtTransCaractColor'];            $values['rd_trana_cvnrejes'] = $p['txtTransCaractNroE'];

        $values['rd_tranb_nreg'] = $p['txtTransBNroRegistro'];               $values['rd_tranb_fv'] = $p['txtTransBFechaVenci'];
        $values['rd_tranb_nram'] = $p['txtTransBAutoriMuni'];                $values['rd_tranb_nrar'] = $p['txtTransBAprobacion'];
        $values['rd_tranb_isnrs'] = $p['txtTransBNroServicios'];             $values['rd_tranb_isvol'] = $p['txtTransBVolumen'];
        $values['rd_tranb_istipo'] = $p['txtTransBInfoTipo'];                $values['rd_tranb_iscapacidad'] = $p['txtTransBInfoCapacidad'];
        $values['rd_tranb_isvptm'] = $p['txtTransBInfoVPTM'];                $values['rd_tranb_isfvd'] = $p['txtTransBInfoFV'];
        $values['rd_tranb_isvcv'] = $p['txtTransBInfoVCXP'];                 $values['rd_tranb_cvmodo'] = isset($p['radTransBCaract']) ? $p['radTransBCaract'] : 0;
        $values['rd_tranb_cvtipo'] = $p['txtTransBCaractTV'];                $values['rd_tranb_cvnplaca'] = $p['txtTransBCaractNroP'];
        $values['rd_tranb_cvcpro'] = $p['txtTransBCaractCP'];                $values['rd_tranb_cvafab'] = $p['txtTransBCaractAF'];
        $values['rd_tranb_cvcolor'] = $p['txtTransBCaractColor'];            $values['rd_tranb_cvnrejes'] = $p['txtTransBCaractNroE'];


        $values['rd_disf_epsrs'] = $p['txtTransDispoRazonSYS'];             $values['rd_disf_eps'] = $p['txtTransDispoReg'];
        $values['rd_disf_fv'] = $p['txtTransDispoFechaVenc'];               $values['rd_disf_nram'] = $p['txtTransDispoAM'];
        $values['rd_disf_nrar'] = $p['txtTransDispoADR'];                   $values['rd_disf_ismetodo'] = $p['txtTransDispoMetodo'];
        $values['rd_disf_isubi'] = $p['txtTransDispUbicac'];

        $values['rd_prp_desc'] = $p['txtPersonalDesc'];                     $values['rd_prp_nrpp'] = $p['txtPersonalPerPuesto'];
        $values['rd_prp_rexp'] = $p['txtPersonalRiesgos'];                  $values['rd_prp_msa'] = $p['txtPersonalMedSeg'];
        $values['rd_prp_apa'] = $p['txtPersonalAPEEA'];                     $values['rd_prp_apaveces'] = $p['txtPersonalAccVeces'];
        $values['rd_prp_apades'] = $p['txtPersonalAccDesc'];

        $res = $this->residuos->registrar_declaracion($values);

        echo_json(array('resultado' => $res));


    }
    function get_res_declaracion(){
        //optener el volumen de los residuos de cada instalación que se solicita en la declaración de residuos
        if(is_ajax(false) && isset($_GET['tipo'])){
            switch (+$_GET['tipo']) {
                case 1:
                    $p = $this->input->post();
                    // print_rr($p);
                    $lst = array();
                    $lst = $this->residuos->listar_by_solicitud($p['idInstalacion'], $p['idYear']);
                    echo_json($lst);
                    break;

                case 2:
                    $this->load->model('Model_unidad', 'uni');
                    $_POST['idInstalacion'] = $this->uni->listar_by_instalacion($_POST['idInstalacion']);
                    $lst = $this->residuos->reporte_residuo_declaracion($_POST);
                    echo_json($lst);
                    break;
                case 3:

                    // $this->load->model('Model_unidad', 'uni');
                    // $_POST['idInstalacion'] = $this->uni->listar_by_instalacion($_POST['idInstalacion']);
                    $lst = $this->residuos->get_years_residuos_by_ins($_POST['idInstalacion']);
                    echo_json($lst);
                    break;
            }

        }else show_404();

    }


    function autorizar_solicitud(){
        $p = $this->input->post();
        $objSol = $this->residuos->getdatasimple($p['txtId']);
        // print_rr($objSol);
        $res = array(
            'resultado' => false
            );
        if($objSol->rss_autorizado == 0){
            // insertar involucrado autorizador
            $this->residuos->registrar_incolucrados(array(
                'rss_id_soliciud' => $p['txtId'],
                'rsi_tipo_invo' => 2,
                'rsi_nombre' => $p['txtNombreAuto'],
                'rsi_ficha' => $p['txtFichaAuto'],
                'rsi_dni' => $p['txtDniAuto']
                ));
            // fin insertar
            $res['resultado'] = $this->residuos->autorizar_solicitud_residuo(+$p['txtId']);
             $options = array(
                'correlativo' => $objSol->rss_correlativo,
                'ref_url' => 'residuo/autorizacion/'.$objSol->rss_id
                );
        enviar_notificacion_sistema_custom($objSol->uni_id_unidad_remitente, $this->session->id_unidad,'res_solicitud_aprobada',$options);
        }

        echo json_encode($res);
    }
    function registrar_solicitud(){

        $this->load->model('Model_Correlativo','corre');
        $p = $this->input->post();
        $values = new ent_residuos_solicitud();
        $res = array('resultado' => false);

        $values->res_id_residuo = $p['selResiduo'];
        $objResiduo = $this->residuos->getsimpleresiduo($values->res_id_residuo);
        $values->rss_correlativo = $this->corre->obtener_correlativo('residuo',1, true)->correlativo;
        $values->rss_peso = $p['txtPesoResiduo'];
        if(trim($p['txtVolumenResiduo']) != '' && +$p['txtVolumenResiduo'] > 0){
            // siempre que exista el volumen
            $values->rss_volumen = $p['txtVolumenResiduo'];
            $values->rss_tipo_volumen = +$p['selTipoVolumen'];
        }
        $values->rss_unidades = $p['txtUnidades'];
        $values->rso_id_origen = $p['selProcedenciaResiduo'];
        if(+$p['selProcedenciaResiduo'] == -1){
            //crear la nuevva procedencia
            //Notificar al administrador que se acaba de crear un nuevo origen de residuos
            $objOri = new OrigenResiduos();
            $objOri->uni_id_unidad = +$p['selUniOrigen'];
            $objOri->rso_es_otro = 0;
            $objOri->rso_nombre = $p['txtNameOrigen'];
            $objOri->rso_estado = 0;
            $values->rso_id_origen  = $this->residuos->insert_origen($objOri,true);
        }
        //crear otro almacenamiento

        // $values->uni_id = ;
        // $values->origen_nombre = ;

        $values->alm_id_almacenamiento = $p['selLugarAlmacenamiento'];
        $values->empc_id_empresa = $p['selEmpresa'];
        $values->rss_epp = $p['radPersonalEPP'];
        $values->rss_observaciones = $p['txtObservacion'];
        $values->uni_id_unidad_remitente = $this->session->id_unidad;
        $this->load->model('Model_unidad','uni');
        $objUnidad = $this->uni->get_departamento($values->uni_id_unidad_remitente);
        // print_rr($p);
        $id_solicitud = $this->residuos->registrar_autorizacion($values);

        //registrar elaborador
        $this->residuos->registrar_incolucrados(array(
            'rss_id_soliciud' => $id_solicitud,
            'rsi_tipo_invo' => 1,
            'rsi_nombre' => $p['txtNombreEla'],
            'rsi_ficha' => $p['txtFichaEla'],
            'rsi_dni' => $p['txtDniEla']
            ));
        //fin resgistrar elaborador

        if($id_solicitud > 0)
            $res['resultado'] = true;
        $options = array(
            'residuo' => $objResiduo->res_nombre,
            'unidad' => $objUnidad->desDepend,
            'ref_url' => 'residuo/autorizar/'.$id_solicitud
            );
        enviar_notificacion_sistema_custom(procesos_sig::autoriza('ingreso_residuos'), $values->uni_id_unidad_remitente,'res_solicitud_generada',$options);

        // enviar_notificacion_sistema_custom(ent_notificaciones::$areas['deso'], $values->uni_id_unidad_remitente,'res_solicitud_generada',$options);
        // enviar_notificacion_sistema_custom(ent_notificaciones::$areas['seguridad'], $values->uni_id_unidad_remitente,'res_solicitud_generada',$options);
        echo json_encode($res);


    }
    public function lista_by_opciones(){
        $post = $this->input->post();
        $filters = array();
        if(isset($post['f_tipo']) && $post['f_tipo']!=-1)
            $filters[] = array(
                'col' => 'res_peligro',
                'val' => $post['f_tipo']
                );
        if(isset($post['f_estado']) && $post['f_estado']!=-1)
            $filters[] = array(
                'col' => 'res_estado',
                'val' => $post['f_estado']
                );
        if(isset($post['f_organico']) && $post['f_organico']!=-1)
            $filters[] = array(
                'col' => 'res_organico',
                'val' => $post['f_organico']
                );

        $lst = $this->residuos->listar_by_opciones($filters);
        echo json_encode($lst);
    }

    public function ingreso()
    {
        if(!AppSession::accesoView(array('elaborador','revisador'))){
            redirect('residuo/listar');
        }
        $this->load->model('Model_Unidad','unidad');
        $this->load->model('Model_EmpreContra','empresa');
        $this->load->model('Model_Almacen','almacen');
        $this->load->model('Model_Departamento','dep');
        $this->load->model('Model_Correlativo','cor');

        $datos = array();
        $datos['ar_pages'] = array('Residuos','Ingreso');
        $datos['titulo_header'] = 'Autorización de Ingreso de Resiudos a Almacenes';
        $datos['part_title'] = 'Ingreso Residuos';
        $datos['objCorrelativo'] = $this->cor->obtener_correlativo('residuo',1,false);
        // if($this->session->id_unidad == ConfigApp::$UNIDAD_ADMIN){

        // }
        $dep = $this->unidad->get_departamento($this->session->id_unidad);

        // exit;
        $datos['departamento_usuario'] = strtoupper($dep->nom_depa.' - '.$dep->desDepend);

        $datos['lstOrigen'] = $this->residuos->listar_origen();
        $datos['lstAlmacen'] = $this->almacen->listar();
        $datos['lstEmpresas'] = $this->empresa->listar();
        $datos['lstDepartamento'] = $this->dep->listar();
        $datos['fecha_solicitud'] = strftime('%A %d %B del %Y',time());
        $this->smartys->assign($datos);
        $this->smartys->render('res_ingreso');

    }
    public function listar()
    {
        // if(!AppSession::accesoView(array('administrador'))){
        //     redirect('residuo/ingreso');
        // }
        $datos = array();
        $datos['ar_pages'] = array('Residuos','Lista de Autorizaciones');
        $datos['titulo_header'] = 'Autorizaciones de Ingreso de Residuos';
        $datos['part_title'] = 'Autorizaciones de Ingreso de Residuos';

        $datos['lst_deps'] = $this->residuos->get_deps_en_ingresos(1);
        $datos['lst_alm'] = $this->residuos->get_almacenes_ingreso();

        $this->smartys->assign($datos);
        $this->smartys->render('res_listar');

    }
    public function get_unidades($iddep){
        $lstUni = $this->residuos->get_deps_en_ingresos(2, $iddep);
        echo_json($lstUni);
    }
    public function autorizar($id)
    {

        // if(!(AppSession::accesoView(array('jefe','elaborador')) && procesos_sig::autoriza('ingreso_residuos') == $this->session->id_unidad)){
        //     redirect('residuo/listar');
        //     exit;
        // }

        $datos = array();

        $datos['objResiduo'] = $this->residuos->getcompletedata($id);
        if($datos['objResiduo']->rss_autorizado != 0){
            redirect('residuo/listar');
            exit;
        }
        // print_rr($datos['objResiduo']);exit;

        $datos['ar_pages'] = array('Residuos','Autorizar Solicitud  de Ingreso de Residuos', $datos['objResiduo']->rss_correlativo);
        $datos['titulo_header'] = 'Autorización de Ingreso de Residuos a Almacenes';

        $datos['tipos_volumen'] = ent_residuos_solicitud::$tipos_volumen;
        $datos['part_title'] = 'Autorizar Ingreso de Residuo';
        $this->smartys->assign($datos);
        $this->smartys->render('res_autorizar');

    }
    public function autorizacion_word($idrss){
        //verificar que el fichero ya fue generado

        require_once LIBSPATH.'themoment.php';
        $this->load->library('WordElements');

        $this->load->library('LibPhpWord');
        \Moment\Moment::setLocale('es_ES');
        $objResiduo = $this->residuos->getcompletedata($idrss);
        $setvalues = array();
        $phpWord = new \PhpOffice\PhpWord\PhpWord();
        // $phpWorddos = \PhpOffice\PhpWord\IOFactory::load(doc_templates::getWord(),'Word2007');
        // print_rr($phpWorddos);
        $testWord = $phpWord->loadTemplate(doc_templates::getWord('rep_autorizacion'));
        $vars  = $testWord->getVariables();

        $m = new \Moment\Moment($objResiduo->rss_fecha_solicitud);
        $m2 = new \Moment\Moment($objResiduo->rss_fecha_autorizado);

        $testWord->setValue('fch_aut', $m2->format('DD/MM/YY, hh:mm a',new \Moment\CustomFormats\MomentJs()));
        $testWord->setValue('nom_aut', $objResiduo->involucrados['autorizador']->rsi_nombre);
        $testWord->setValue('nom_ela', $objResiduo->involucrados['elaborador']->rsi_nombre);

        $testWord->setValue('res_obs',$objResiduo->rss_observaciones);

        if($objResiduo->rss_epp == 1){
            $testWord->setValue('ry', WordElements::checkBox('ry',true));
            $testWord->setValue('rz', WordElements::checkBox('rz',false));

        }
        if($objResiduo->rss_epp == 0){
            $testWord->setValue('ry', WordElements::checkBox('ry',false));
            $testWord->setValue('rz', WordElements::checkBox('rz',true));
        }

        $testWord->setValue('res_almacen',$objResiduo->alm_nombre);
        $testWord->setValue('res_emp',$objResiduo->empc_nombre);

        //generado
        $testWord->setValue('vk', sprintf("%01.2f",$objResiduo->rss_peso));
        $testWord->setValue('vu',$objResiduo->rss_unidades);
        $testWord->setValue('vv',sprintf("%01.2f", $objResiduo->rss_volumen));
        $tv = '--';
        foreach (ent_residuos_solicitud::$tipos_volumen as $key => $v) {
            if($v[1] == $objResiduo->rss_volumen_tipo)
                 $tv = $v[0];
        }
        $testWord->setValue('rv', $tv);
        //endgenerado

        $testWord->setValue('res_nombre',$objResiduo->res_nombre);
        $testWord->setValue('res_origen',$objResiduo->rso_nombre);



        if($objResiduo->res_estado == 1){
            $testWord->setValue('rs', WordElements::checkBox('rs',true));
            $testWord->setValue('rl', WordElements::checkBox('rl',false));

        }
        if($objResiduo->res_estado == 2){
            $testWord->setValue('rs', WordElements::checkBox('rs',false));
            $testWord->setValue('rl', WordElements::checkBox('rl',true));
        }



        if($objResiduo->res_peligro == 1){
            $testWord->setValue('rp', WordElements::checkBox('rp',true));
            $testWord->setValue('rnp', WordElements::checkBox('rnp',false));

        }else{
            $testWord->setValue('rp', WordElements::checkBox('rp',false));
            $testWord->setValue('rnp', WordElements::checkBox('rnp',true));
        }

        $testWord->setValue('res_area', $objResiduo->unidad_generadora->dep_nombre);
        $testWord->setValue('res_uni', $objResiduo->unidad_generadora->desDepend);

        $testWord->setValue('res_fecha',$m->format('DD/MM/YY, hh:mm a',new \Moment\CustomFormats\MomentJs()));
        // $testWord->setValue($setvalues);
        // $testWord->saveAs(DOCSPATH.'_test/'.$objResiduo->rss_correlativo.'.docx');
        $rutaResSol = procesos_sig::path_folder('res_autorizaciones');

        $testWord->saveAs($rutaResSol.$objResiduo->rss_correlativo.'.docx');
         // header('Content-Type: application/docx');
        header('Content-Disposition: attachment;filename="'.$objResiduo->rss_correlativo.'.docx"');
        header('Cache-Control: max-age=0');
        ob_end_clean();
        readfile($rutaResSol.$objResiduo->rss_correlativo.'.docx');
        // $testWord->save('php://output');
        //generar PDF

        // \PhpOffice\PhpWord\Settings::setPdfRendererPath(LIBSPATH.'vendor/tecnickcom/tcpdf');
        // \PhpOffice\PhpWord\Settings::setPdfRendererName('TCPDF');

        // $phpWord = \PhpOffice\PhpWord\IOFactory::load(DOCSPATH.'_test/'.$objResiduo->rss_correlativo.'.docx','Word2007');
        // $xmlWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord , 'PDF');
        // // $xmlWriter->save('result.pdf');

        //  header('Content-Type: application/pdf');
        // header('Content-Disposition: attachment;filename="01simpleasdasd.pdf"');
        // header('Cache-Control: max-age=0');
        // $xmlWriter->save('php://output');
        // echo 'generado';
        // print_rr($vars);
        // $objResiduo = $this->residuos->getcompletedata($idrss);
        // print_rr($objResiduo);
        // print_rr(WordElements::checkBox('asd',true));




    }
    public function autorizacion_pdf($id_solicitud){

        require_once LIBSPATH.'themoment.php';
        require_once LIBSPATH.'html2pdf.php';
         \Moment\Moment::setLocale('es_ES');

         $datos['title'] = 'SISTEMA INTEGRADO DE GESTIÓN CORPORATIVO';
         $datos['sub_title'] = 'SEDE AUTORIZACIÓN DE INGRESO DE RESIDUOS A ALMACENES';

        $html2pdf = new HTML2PDF('P', 'A4', 'es',true,'UTF-8',array(18,5,18,5));
        // $html2pdf->pdf->SetDisplayMode('fullpage');
        // $html2pdf->pdf->addFont('Roboto','', dirname(APPPATH).DS.'public'.DS.'app'.DS.'font'.DS.'Roboto-Regular.ttf');
        // var_dump($html2pdf);

        $html2pdf->AddFont('asap', '', LIBSPATH.'vendor\tecnickcom\tcpdf\fonts\asap.php');
        $html2pdf->setDefaultFont('asap');

        $html2pdf->AddFont('asapb', 'normal', LIBSPATH.'vendor\tecnickcom\tcpdf\fonts\asapb.php');
        // $html2pdf->setDefaultFont('asapb');
        // $html2pdf->AddTTFFont(dirname(APPPATH).DS.'public'.DS.'app'.DS.'font'.DS.'Roboto-Regular.ttf');
        $datos['objResiduo'] = $this->residuos->getcompletedata($id_solicitud);
        $m = new \Moment\Moment($datos['objResiduo']->rss_fecha_solicitud);
        $datos['objResiduo']->rss_fecha_solicitud = $m->format('dddd DD MMM YYYY, hh:mm a',new \Moment\CustomFormats\MomentJs());

        $m = new \Moment\Moment($datos['objResiduo']->rss_fecha_autorizado);
        $datos['objResiduo']->rss_fecha_autorizado = $m->format('dddd DD MMM YYYY, hh:mm a',new \Moment\CustomFormats\MomentJs());
        // print_rr($datos['objResiduo']);exit;
        $datos['tipos_volumen'] = ent_residuos_solicitud::$tipos_volumen;
        $this->smartys->assign($datos);
        $html = $this->smartys->render_cache('res_pdf_autorizacion','template_reporte');

        // echo $html;exit;

        $html2pdf->WriteHTML($html);

        $html2pdf->Output('exempledasdsasd.pdf');

        exit;
        // $this->smartys->render('res_autorizacion');
    }
    public function autorizacion($id)
    {

        if(is_numeric($id)){
            $datos = array();
            $datos['objResiduo'] = $this->residuos->getcompletedata($id);
            // print_rr($datos['objResiduo']);exit;
            $datos['tipos_volumen'] = ent_residuos_solicitud::$tipos_volumen;
            $datos['ar_pages'] = array('Residuos','Autorización ',$datos['objResiduo']->rss_correlativo);
            $datos['titulo_header'] = 'Autorización '.$datos['objResiduo']->rss_correlativo;
            // exit;
            $this->smartys->assign($datos);
            $this->smartys->render('res_autorizacion');
        }else{
            switch ($id) {
                case 'pdf':
                    if(isset($_GET['rss'])){
                        $this->autorizacion_word($_GET['rss']);
                    }else show_404();
                    break;

                default:
                    show_404();
                    break;
            }
        }


    }
    public function get_reporte_generados(){
        if(isset($_GET['t']) && $_GET['t'] == 'rep'){
                // print_rr($_GET);
                // exit;
                $lst = $this->residuos->reporte_general($_GET);
                // print_rr($lst);exit;
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
                $this->excel = $objReader->load(doc_templates::getExcel('rep_gen'));
                // Indicamos que se pare en la hoja uno del libro

                // Agregar Informacion
                $indexStart = 6;
                $title = 'Reporte de Resiudos Generales';
                $title2 = '';
                if(+$_GET['unidad'] != -1){
                    $this->load->model('Model_Unidad','uni');
                    $objU = $this->uni->get_departamento($_GET['unidad']);
                    $title2 = ' - '.$objU->nom_depa.' | '.$objU->desDepend;
                    $title .= $title2;
                }

                $this->excel->setActiveSheetIndex(0)->setCellValue('A1', $title);
                // $this->excel->setActiveSheetIndex(0)
                // ->setCellValue('C17', 9);
                $tv = array(0,0,0,0,0,0,0,0,0,0,0,0,0);
                foreach ($lst as $key => $value) {
                    $this->excel->setActiveSheetIndex(0)->setCellValue('B'.$indexStart, $value->res_nombre);
                    $this->excel->setActiveSheetIndex(0)->setCellValue('C'.$indexStart, +$value->res_1);$tv[0] += +$value->res_1;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('D'.$indexStart, +$value->res_2);$tv[1] += +$value->res_2;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('E'.$indexStart, +$value->res_3);$tv[2] += +$value->res_3;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('F'.$indexStart, +$value->res_4);$tv[3] += +$value->res_4;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('G'.$indexStart, +$value->res_5);$tv[4] += +$value->res_5;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('H'.$indexStart, +$value->res_6);$tv[5] += +$value->res_6;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('I'.$indexStart, +$value->res_7);$tv[6] += +$value->res_7;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('J'.$indexStart, +$value->res_8);$tv[7] += +$value->res_8;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('K'.$indexStart, +$value->res_9);$tv[8] += +$value->res_9;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('L'.$indexStart, +$value->res_10);$tv[9] += +$value->res_10;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('M'.$indexStart, +$value->res_11);$tv[10] += +$value->res_11;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('N'.$indexStart, +$value->res_12);$tv[11] += +$value->res_12;
                    $this->excel->setActiveSheetIndex(0)->setCellValue('O'.$indexStart, +$value->res_peso);$tv[12] += +$value->res_peso;


                    $indexStart++;
                     $this->excel->getActiveSheet()->getStyle('B'.($indexStart).':O'.($indexStart))->applyFromArray(array(
                        'font' => array(
                            'name' => 'Arial Narrow'
                            )

                    ));
                     $this->excel->getActiveSheet()->getStyle('B'.($indexStart).':O'.($indexStart))->getNumberFormat()->applyFromArray(array(
                        'code' => PHPExcel_Style_NumberFormat::FORMAT_NUMBER_COMMA_SEPARATED1
                        ));
                }

                    // $this->excel->getActiveSheet()->getStyle('B7:O7')->applyFromArray(array(
                    //     'font' => array(
                    //         'name' => 'Arial Narrow'
                    //         ),
                    //     'code' => PHPExcel_Style_NumberFormat::FORMAT_NUMBER_COMMA_SEPARATED1
                    // ));
                    // $this->excel->getActiveSheet()->getStyle('B8:O8')->applyFromArray(array(
                    //     'font' => array(
                    //         'name' => 'Arial Narrow'
                    //         ),
                    //     'code' => PHPExcel_Style_NumberFormat::FORMAT_NUMBER_COMMA_SEPARATED1
                    // ));
                $this->excel->setActiveSheetIndex(0)->setCellValue('B'.$indexStart, 'Total');
                $this->excel->setActiveSheetIndex(0)->setCellValue('C'.$indexStart, $tv[0]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('D'.$indexStart, $tv[1]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('E'.$indexStart, $tv[2]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('F'.$indexStart, $tv[3]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('G'.$indexStart, $tv[4]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('H'.$indexStart, $tv[5]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('I'.$indexStart, $tv[6]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('J'.$indexStart, $tv[7]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('K'.$indexStart, $tv[8]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('L'.$indexStart, $tv[9]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('M'.$indexStart, $tv[10]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('N'.$indexStart, $tv[11]);
                $this->excel->setActiveSheetIndex(0)->setCellValue('O'.$indexStart, $tv[12]);
                $this->excel->getActiveSheet()->getStyle('B'.($indexStart).':O'.($indexStart))->applyFromArray(array(
                        'font' => array(
                            'name' => 'Arial Narrow'
                            )

                    ));
                     $this->excel->getActiveSheet()->getStyle('B'.($indexStart).':O'.($indexStart))->getNumberFormat()->applyFromArray(array(
                        'code' => PHPExcel_Style_NumberFormat::FORMAT_NUMBER_COMMA_SEPARATED1
                        ));

                // for ($i = 1; $i <= 12; $i++) {
                //     $target = $this->getDataRpgs($lst, $i);
                //     $npo = 0; $npi = 0; $pp = 0;
                //     if($target){
                //         $npo = $target->no_pel_org;
                //         $npi = $target->no_pel_ino;
                //         $pp = $target->pel;
                //     }else{
                //         $npo = 0;
                //         $npi = 0;
                //         $pp = 0;
                //     }
                //     $this->excel->setActiveSheetIndex(0)->setCellValue('C'.$indexStart, $npo);
                //     $this->excel->setActiveSheetIndex(0)->setCellValue('D'.$indexStart, $npi);
                //     $this->excel->setActiveSheetIndex(0)->setCellValue('G'.$indexStart, $pp);
                //     $indexStart++;
                // }

                /*->setCellValue('C2', 'Estado');*/

                // $this->excel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');


                // Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
                $this->excel->setActiveSheetIndex(0);

                // Se modifican los encabezados del HTTP para indicar que se envia un archivo de Excel.
                //

                // header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
                // header('Content-Disposition: attachment;filename="Reporte Mensualesiop.xlsx"');
                // header('Cache-Control: max-age=0');
                $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel2007');

                // $objWriter->save(DOCSPATH.'unico.xlsx');
                header("Content-disposition: attachment; filename=Reportes Generales ".$title2." - ".$year.".xlsx");
                header("Content-type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                ob_end_clean();
                $objWriter->save('php://output');
                // readfile(DOCSPATH.'unico.xlsx');
                exit;



        }else{
               show_404();
        }
    }
    public function reportes_generados()
    {
        AppSession::logueado(true);
        if(is_ajax(false)){
            if(isset($_POST['t']) && $_POST['t'] == 'rep'){
                // print_rr($_POST);
                $lst = $this->residuos->reporte_general($_POST);
                echo_json(array(
                    'data' => $lst,
                    'resultado' => true
                    ));

            }else{
               echo_json(array('resultado' => false));
            }
        }else{
            $datos = array();
            $datos['ar_pages'] = array('Residuos','Reporte','Residuos Generados ');
            $datos['titulo_header'] = 'Residuos';
            $datos['part_title'] = 'Reportes Generados';
            $datos['lst_years'] = $this->residuos->get_years_residuos();
            $datos['lst_residuos'] = $this->residuos->listar_by_opciones(array());
            $this->load->model('Model_Departamento','dep');
            $datos['lstDep'] = $this->dep->listar('desDepend','asc','activo');
            // print_rr($datos['lst_years']);exit;
            $this->smartys->assign($datos);
            $this->smartys->render('res_reportes_generados');
        }
    }
    private function getDataRpgs($vArray, $sValue){
          for ($i = 0; $i < count($vArray); $i++) {
            if(+$vArray[$i]->mes == $sValue) return $vArray[$i];
        };
        return false;
    }
    private function fn_rpgs_excel($year){
        $lst = $this->residuos->reporte_general_solidos($year);

        if(count($lst)){

            // exit;
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
            $indexStart = 17;

            $this->excel->setActiveSheetIndex(0)->setCellValue('A1', 'Formato DESO-AMBT-005 TEST');
            // $this->excel->setActiveSheetIndex(0)
            // ->setCellValue('C17', 9);
            for ($i = 1; $i <= 12; $i++) {
                $target = $this->getDataRpgs($lst, $i);
                $npo = 0; $npi = 0; $pp = 0;
                if($target){
                    $npo = $target->no_pel_org;
                    $npi = $target->no_pel_ino;
                    $pp = $target->pel;
                }else{
                    $npo = 0;
                    $npi = 0;
                    $pp = 0;
                }
                $this->excel->setActiveSheetIndex(0)->setCellValue('C'.$indexStart, $npo);
                $this->excel->setActiveSheetIndex(0)->setCellValue('D'.$indexStart, $npi);
                $this->excel->setActiveSheetIndex(0)->setCellValue('G'.$indexStart, $pp);
                $indexStart++;
            }

            /*->setCellValue('C2', 'Estado');*/

            // $this->excel->getActiveSheet()->fromArray($dataArray, NULL, 'A5');


            // Establecer la hoja activa, para que cuando se abra el documento se muestre primero.
            $this->excel->setActiveSheetIndex(0);

            // Se modifican los encabezados del HTTP para indicar que se envia un archivo de Excel.
            //

            // header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            // header('Content-Disposition: attachment;filename="Reporte Mensualesiop.xlsx"');
            // header('Cache-Control: max-age=0');
            $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel2007');

            // $objWriter->save(DOCSPATH.'unico.xlsx');
            header("Content-disposition: attachment; filename=Generación de Residuos Sólidos - ".$year.".xlsx");
            header("Content-type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            ob_end_clean();
            $objWriter->save('php://output');
            // readfile(DOCSPATH.'unico.xlsx');
            exit;

        }else show_404();
    }
    public function reportes_general_solidos()
    {
        AppSession::logueado(true);
        if(isset($_GET['r']) && isset($_GET['d']) && is_numeric($_GET['d'])){
            switch ($_GET['r']) {
                case 'excel':
                    $this->fn_rpgs_excel($_GET['d']);
                    break;
                default:
                    show_404();
                    break;
            }
            exit;
        }

        $datos = array();
        $datos['ar_pages'] = array('Residuos','Reporte','General de Residuos Sólidos');
        $datos['titulo_header'] = 'Residuos';

        $datos['lst_years'] = $this->residuos->get_years_residuos();
        $datos['part_title'] = 'Reporte general de Sólidos';
        $this->smartys->assign($datos);
        $this->smartys->render('res_reportes_generales');
    }
    public function get_generacion_residuos_solidos($y){
        // print_rr($y);
        $lst = $this->residuos->reporte_general_solidos($y);
        echo_json($lst);
    }
    public function declaracion_residuos()
    {
        $datos = array();
        $datos['ar_pages'] = array('Residuos','Declaración de Manejo de Residuos Sólidos');
        $datos['titulo_header'] = 'Generar Declaración de Residuos Sólidos';
        $datos['part_title'] = 'Generar Declaración Residuos Sólidos';
        $datos['lstResiduos'] = $this->residuos->get_residuos_declaracion();
        $datos['lstYear'] = $this->residuos->get_years_declaraciones();

        $this->smartys->assign($datos);
        $this->smartys->render('res_declaracion_manejo');
    }
    public function generar_declaracion()
    {
        AppSession::logueado(true);
        $this->load->model('Model_Instalacion','inst');
        $datos = array();
        $optionRes = array(
            array('col' => 'res_estado','val' => 1)
            );
        //obtener residuos que existan en las solicitudes
        // $datos['lstResiduos'] = $this->residuos->listar_by_solicitud($optionRes);


        $datos['lstInstalacion'] = $this->inst->getdata();
        $datos['lst_years'] = $this->residuos->get_years_residuos();
        // print_rr($datos['lstInstalacion']);
        $datos['part_title'] = 'Generar Declaración';
        $datos['ar_pages'] = array('Residuos','Generar declaración');
        $datos['titulo_header'] = 'Generar Declaración de Manejo de Residuos Sólidos';

        $this->smartys->assign($datos);
        $this->smartys->render('res_generar_declaracion');
    }

    public function origen()
    {

    }

    private function set_values($post)
    {
        // print_rr($post);
        // $post['id'] = 'sadadsdasdasd';
        $obj = new ent_residuo();
        $obj->res_id = isset($post['id'])?$post['id']:null;
        $obj->res_nombre = $post['txtNombre'];
        $obj->res_peligro = +$post['txtTipoPeligro'];
        $obj->res_estado = +$post['txtTipoEstado'];
        $obj->res_organico = +$post['txtTipoOrganico'];
        $obj->res_es_otro = isset($post['txtEstadoOtro']) ? +$post['txtEstadoOtro'] : null;
        return $obj;
    }
    public function data($id)
    {
        is_ajax();
        $obj = new ent_residuo();
        $obj->res_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->residuos->get_obj($obj);
        if($res['objRes']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }
    public function insertar()
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $post = $this->input->post();
        $obj = $this->set_values($post);
        $res['resultado'] = $this->residuos->insert($obj);

        if($res['resultado'])
            $res['objRes'] = $obj;
        echo json_encode($res);
    }

    public function actualizar()
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $post = $this->input->post();
        $obj = $this->set_values($post);
        // print_rr($obj);exit;
        $res['resultado'] = $this->residuos->actualizar($obj);
        echo json_encode($res);
    }
    public function eliminar($id)
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['resultado'] = $this->residuos->eliminar($id);

        echo json_encode($res);
    }
    public function datatables_list()
    {
        $this->load->model('Model_Datatables');
        // print_rr($_POST);
        $order = false;
        $selects = array(
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){

            // switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
            //     case 'get_estado':
            //         $order = array('uni_estado' => $_POST['order']['0']['dir']);
            //         break;

            // }

        }
        $filter = array();
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'res_nombre':
                        $likes[] = $p[$i];
                        break;
                    case 'dep_id_departamento':
                    case 'uni_id_unidad':
                        $filter[] = $p[$i];
                        break;
                }
                $i++;
            }
        }
        if($this->input->post('filtersDos')){
            $fd = $this->input->post('filtersDos');
            if($fd['peligro'] != -1){
                $filter[] = array(
                    'column' =>'res_peligro',
                    'filter' => $fd['peligro']
                    );
            }
            if($fd['organico'] != -1){
                $filter[] = array(
                    'column' =>'res_organico',
                    'filter' => $fd['organico']
                    );
            }
            if($fd['estado'] != -1){
                $filter[] = array(
                    'column' =>'res_estado',
                    'filter' => $fd['estado']
                    );
            }
        }

        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(
                // array('unidades','unidades.uni_id = tbl_residuos_origen.uni_id_unidad'),
                // array('departamentos','departamentos.dep_id = unidades.dep_id_departamento')
        );
        $datas = $this->Model_Datatables->get_datatables('tbl_residuos','ent_residuo',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
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

    //Origen

    private function set_values_origen($post)
    {
        // print_rr($post);
        // $post['id'] = 'sadadsdasdasd';
        $obj = new OrigenResiduos();
        $obj->rso_id = isset($post['id'])?$post['id']:null;
        $obj->rso_nombre = $post['txtNombre'];
        $obj->uni_id_unidad = +$post['txtIdUnidad'];
        $obj->rso_es_otro = isset($post['txtEstadoOtro']) ? +$post['txtEstadoOtro'] : null;
        return $obj;
    }
    public function data_origen($id)
    {
        is_ajax();
        $obj = new OrigenResiduos();
        $obj->rso_id = $id;
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['objRes'] = $this->residuos->get_obj_origen($obj);
        if($res['objRes']!=null)
            $res['resultado'] = true;

        echo json_encode($res);
    }
    public function insertar_origen()
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $post = $this->input->post();
        $obj = $this->set_values_origen($post);
        $res['resultado'] = $this->residuos->insert_origen($obj);

        if($res['resultado'])
            $res['objRes'] = $obj;
        echo json_encode($res);
    }

    public function actualizar_origen()
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $post = $this->input->post();
        $obj = $this->set_values_origen($post);
        $res['resultado'] = $this->residuos->actualizar_origen($obj);
        echo json_encode($res);
    }
    public function eliminar_origen($id)
    {
        is_ajax();
        $res = array(
                'resultado' => false,
                'objRes' => null
                );
        $res['resultado'] = $this->residuos->eliminar_origen($id);

        echo json_encode($res);
    }
    public function datatables_declaracions(){
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
                "r.res_nombre",
                "i.ins_nombre"
                // "dd.desDepend as dep_nombre"
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){
            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                // case 'get_estado':
                //     $order = array('uni_estado' => $_POST['order']['0']['dir']);
                //     break;
            }

        }
        $filter = array();
        // $filter[] = array(
        //     'column' => 'd.nivelDepend',
        //     'filter' => 2
        //     );
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    case 'ins_nombre':

                        $likes[] = $p[$i];

                        break;
                    case 'res_id_residuo':
                        $filter[] = array('column' => 'r.res_id', 'filter' => $value['filter']);
                        break;
                    case 'rd_year':
                        $filter[] = $p[$i];
                        // $filter[] = array('column' => 'd.idDepend', 'filter' => $value['filter']);
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

                array('tbl_residuos r','r.res_id = tbl_residuos_declaracion.res_id_residuo'),
                array('instalaciones i','i.ins_id = tbl_residuos_declaracion.ins_id_instalacion')
        );
        $datas = $this->Model_Datatables->get_datatables('tbl_residuos_declaracion','OrigenResiduos',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
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
    public function datatables_list_origen()
    {
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
                "d.desDepend as uni_nombre",
                "dd.desDepend as dep_nombre"
            // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
            // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
            );
        if(isset($_POST['order'])){
            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                case 'get_estado':
                    $order = array('uni_estado' => $_POST['order']['0']['dir']);
                    break;
            }

        }
        $filter = array();
        // $filter[] = array(
        //     'column' => 'd.nivelDepend',
        //     'filter' => 2
        //     );
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

                array('dependencia d','d.idDepend = tbl_residuos_origen.uni_id_unidad'),
                array('dependencia dd','dd.idDepend = d.reportaDpend')
        );
        $datas = $this->Model_Datatables->get_datatables('tbl_residuos_origen','OrigenResiduos',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);

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
    public function dt_listar_autorizaciones(){
        $this->load->model('Model_Datatables');
        $order = false;
        $selects = array(
                "d.*",
                "ar.*",
                "ro.*",
                "re.*"

            );
        if(isset($_POST['order'])){
            switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
                // case 'get_estado':
                //     $order = array('uni_estado' => $_POST['order']['0']['dir']);
                //     break;
            }

        }
        $filter = array();
        // $filter[] = array(
        //     'column' => 'd.nivelDepend',
        //     'filter' => 2
        //     );
        $likes = array();
        if($this->input->post('filters')){
            $p = $this->input->post('filters');
            $i = 0;
            foreach ($p as $key => $value) {
                switch ($value['column']) {
                    // case 'rso_nombre':

                    //     $likes[] = $p[$i];
                    //     break;
                    case 'dep_id':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'd.reportaDpend', 'filter' => $value['filter']);
                        break;
                    case 'uni_id':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'tbl_residuos_solicitud.uni_id_unidad_remitente', 'filter' => $value['filter']);
                        break;
                    case 'alm_id':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'alm_id_almacenamiento', 'filter' => $value['filter']);
                        break;
                    case 'auto_estado':
                        if(+$value['filter'] != -1)
                            $filter[] = array('column' => 'rss_autorizado', 'filter' => $value['filter']);
                        break;
                    // case 'uni_id_unidad':
                    //     $filter[] = array('column' => 'd.idDepend', 'filter' => $value['filter']);
                    //     // $filter[] = $value;
                    //     // $filter[] = $p[$i];
                    //     break;
                }
                $i++;
            }
        }
        $_POST['f'] = $filter;
        $_POST['l'] = $likes;
        $joins = array(

                array('tbl_residuos re','re.res_id = tbl_residuos_solicitud.res_id_residuo'),
                array('dependencia d','d.idDepend = tbl_residuos_solicitud.uni_id_unidad_remitente'),
                array('almacen_residuos ar','ar.alm_id = tbl_residuos_solicitud.alm_id_almacenamiento','left'),
                array('tbl_residuos_origen ro','ro.rso_id = tbl_residuos_solicitud.rso_id_origen')
                // array('dependencia dd','dd.idDepend = d.reportaDpend')
        );
        $datas = $this->Model_Datatables->get_datatables('tbl_residuos_solicitud','object',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);

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
    // public function datatables_list_origen()
    // {
    //     $this->load->model('Model_Datatables');
    //     $order = false;
    //     $selects = array(
    //         // "CONCAT(ins_attr_direccion,' ',ins_direccion) AS dir_total",
    //         // "CONCAT(ins_razon_social,' - ',ins_rz_siglas) AS rz_total"
    //         );
    //     if(isset($_POST['order'])){

    //         // switch ($_POST['columns'][$_POST['order']['0']['column']]['data']) {
    //         //     case 'get_estado':
    //         //         $order = array('uni_estado' => $_POST['order']['0']['dir']);
    //         //         break;

    //         // }

    //     }
    //     $filter = array();
    //     $likes = array();
    //     if($this->input->post('filters')){
    //         $p = $this->input->post('filters');
    //         $i = 0;
    //         foreach ($p as $key => $value) {
    //             switch ($value['column']) {
    //                 case 'rso_nombre':
    //                     $likes[] = $p[$i];
    //                     break;
    //                 case 'dep_id_departamento':
    //                 case 'uni_id_unidad':
    //                     $filter[] = $p[$i];
    //                     break;
    //             }
    //             $i++;
    //         }
    //     }
    //     $_POST['f'] = $filter;
    //     $_POST['l'] = $likes;
    //     $joins = array(
    //             array('unidades','unidades.uni_id = tbl_residuos_origen.uni_id_unidad'),
    //             array('departamentos','departamentos.dep_id = unidades.dep_id_departamento')
    //     );
    //     $datas = $this->Model_Datatables->get_datatables('tbl_residuos_origen','OrigenResiduos',$likes, $filter,$selects, $order,$joins,$_POST['length'],$_POST['start']);
    //     // $list = get_object_vars($list);
    //     $data = array();
    //     $no = $_POST['start'];


    //     $output = array(
    //                     "draw" => $_POST['draw'],
    //                     "recordsTotal" => $datas['count_all'],
    //                     "recordsFiltered" => $datas['count_filtered'],
    //                     "data" => $datas['list'],
    //                     "post" => $_POST
    //             );
    //     //output to json format
    //     echo json_encode($output);
    // }

}