<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

require_once(APPPATH.'libraries/smarty/libs/Smarty.class.php');

class Smartys extends Smarty {

    var $debug = false;

    function __construct()
    {
        parent::__construct();
        $this->setTemplateDir(APPPATH.'views'.DIRECTORY_SEPARATOR.'templates'.DIRECTORY_SEPARATOR);
        $this->setCompileDir(APPPATH.'views'.DIRECTORY_SEPARATOR.'compiled');
        $this->setConfigDir(APPPATH.'libraries'.DIRECTORY_SEPARATOR.'smarty'.DIRECTORY_SEPARATOR.'configs');
        $this->setCacheDir(APPPATH.'libraries'.DIRECTORY_SEPARATOR.'smarty'.DIRECTORY_SEPARATOR.'cache');

        $this->assign( 'FCPATH', FCPATH );

        $this->assign( 'APPPATH', APPPATH );
        $this->assign( 'BASEPATH', BASEPATH );
        if ( method_exists( $this, 'assignByRef') )
        {
            $ci =& get_instance();
            $this->assignByRef("ci", $ci);
        }
        $this->force_compile = 1;
        $this->caching = true;

        // $this->clearAllCache(180);
        // var_dump($this);
        // echo $this->template_dir[0];
    }
    function setDebug( $debug=true )
    {
        $this->debug = $debug;
    }

    // function render_cache($vista, $data = array(), $template = 'template.tpl'){
    //     $this->assign('_template', $template);
    //     if ( ! $this->debug )
    //     {
    //         $this->error_reporting = false;
    //     }
    //     $this->error_unassigned = false;

    //     foreach ($data as $key => $val)
    //     {
    //         $this->assign($key, $val);
    //     }
    //     if (strpos($vista, '.') === FALSE &&
    //     strpos($vista, ':') === FALSE) {
    //         $vista .= '.tpl';
    //     }
    //     $CI =& get_instance();

    //     if(is_readable(VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista.'s')){
    //         $vista = VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista;
    //         // echo 'sí';
    //     }else{
    //         $vista = 'error_vista.tpl';
    //         // echo 'no!';
    //     }
    //     return $this->fetch($vista);

    // }

    function render($vista, $template = 'template.tpl')
    {
        if($template){
            // echo 'soy lfase;';
            // exit;

            if (strpos($template, '.') === FALSE &&
            strpos($template, ':') === FALSE) {
                $template .= '.tpl';
            }
            $this->assign('_template', $template);
        }


        if ( ! $this->debug )
        {
            $this->error_reporting = false;
        }
        $this->error_unassigned = false;
        $CI =& get_instance();
        // echo $vista;
        if(strpos($vista,'/') === false){
            // echo 'no tiene barra';
            if (strpos($vista, '.') === FALSE && strpos($vista, ':') === FALSE) {
                $vista .= '.tpl';
                $vista = VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista;
            }
        }else{
            // echo 'tiene barra';
            $res = explode('/',$vista);
            $lastv = array_pop($res);
            if (strpos($lastv, '.') === FALSE && strpos($lastv, ':') === FALSE) {
                $lastv .= '.tpl';
            }
            $res[] = $lastv;

            $vista = implode(DIRECTORY_SEPARATOR,$res);
            $vista = VIEWPATH.$vista;


        }
        $base_url = $CI->config->config['base_url'];
        $this->assign('base_url', base_url());
        $this->assign('public_url', base_url('public/'));
        $this->assign('site_url', base_url());
        $this->assign('ref_areas', ent_notificaciones::$areas);
        if(!is_readable($vista)){
            $vista = 'error_vista.tpl';
            // echo 'no!';
        }
        // if(is_readable(VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista)){
        //     $vista = VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista;
        //     // echo 'sí';
        // }else{
        //     // show_404();
        //     // $tt = show_error('asd','dddddd');
        //     // echo $sss;
        //     $vista = 'error_vista.tpl';
        //     echo 'no!';
        // }
        // $this->cache_lifetime = 300;
        if (method_exists( $CI->output, 'set_output' ))
        {

            $CI->output->set_output($this->fetch($vista));
        }
        else
        {
            $CI->output->final_output = $this->fetch($vista);
        }
        // print_rr($CI->output);
        return;


        // parent::display($template);
    }
    function render_cache($vista, $template = 'template.tpl')
    {
        if($template){
            // echo 'soy lfase;';
            // exit;

            if (strpos($template, '.') === FALSE &&
            strpos($template, ':') === FALSE) {
                $template .= '.tpl';
            }
            $this->assign('_template', $template);
        }


        if ( ! $this->debug )
        {
            $this->error_reporting = false;
        }
        $this->error_unassigned = false;
        $CI =& get_instance();
        // echo $vista;
        if(strpos($vista,'/') === false){
            // echo 'no tiene barra';
            if (strpos($vista, '.') === FALSE && strpos($vista, ':') === FALSE) {
                $vista .= '.tpl';
                $vista = VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista;
            }
        }else{
            // echo 'tiene barra';
            $res = explode('/',$vista);
            $lastv = array_pop($res);
            if (strpos($lastv, '.') === FALSE && strpos($lastv, ':') === FALSE) {
                $lastv .= '.tpl';
            }
            $res[] = $lastv;

            $vista = implode(DIRECTORY_SEPARATOR,$res);
            $vista = VIEWPATH.$vista;


        }
        $base_url = $CI->config->config['base_url'];
        $this->assign('base_url', base_url());
        $this->assign('public_url', base_url('public/'));
        $this->assign('site_url', base_url());
        if(!is_readable($vista)){
            $vista = 'error_vista.tpl';
            // echo 'no!';
        }
        // if(is_readable(VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista)){
        //     $vista = VIEWPATH.$CI->router->class.DIRECTORY_SEPARATOR.$vista;
        //     // echo 'sí';
        // }else{
        //     // show_404();
        //     // $tt = show_error('asd','dddddd');
        //     // echo $sss;
        //     $vista = 'error_vista.tpl';
        //     echo 'no!';
        // }
        // $this->cache_lifetime = 300;
        $salida = $this->fetch($vista);
        ob_end_clean();
        return $salida;
        // if (method_exists( $CI->output, 'set_output' ))
        // {

        //     $CI->output->set_output($this->fetch($vista));
        // }
        // else
        // {
        //     $CI->output->final_output = $this->fetch($vista);
        // }
        // // print_rr($CI->output);
        // return;


        // parent::display($template);
    }
}
 ?>