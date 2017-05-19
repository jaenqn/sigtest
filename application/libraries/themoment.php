<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

require_once(APPPATH.'libraries'.DS.'moment'.DS.'Moment.php');
require_once(APPPATH.'libraries'.DS.'moment'.DS.'MomentLocale.php');
require_once(APPPATH.'libraries'.DS.'moment'.DS.'FormatsInterface.php');
require_once(APPPATH.'libraries'.DS.'moment'.DS.'CustomFormats'.DS.'MomentJs.php');

// function autoLoadMoment($class){
//     echo $class;
//     echo LIBSPATH.'moment'.DS.$class.'.php';
//         if(file_exists(__DIR__.DS.'moment'.DS.$class.'.php'))
//             include_once __DIR__.DS.'moment'.DS.$class.'.php';
//     }
// spl_autoload_register('autoLoadMoment');
