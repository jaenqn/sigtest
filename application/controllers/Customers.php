<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Customers extends CI_Controller {

    public function __construct()
    {
        parent::__construct();
        $this->load->model('customers_model','customers');
    }

    public function index()
    {
        $this->load->helper('url');
        $this->load->view('customers_view');
    }

    public function ajax_list()
    {
        $list = $this->customers->get_datatables();
        // $list = get_object_vars($list);
        $data = array();
        $no = $_POST['start'];
        // foreach ($list as $customers) {
        //     // $no++;
        //     $row = array();
        //     // $row = get_object_vars($customers);
        //     $row[] = $customers->empc_id;
        //     $row[] = $customers->empc_nombre;
        //     $row[] = $customers->empc_direccion;
        //     $row[] = $customers->empc_telefono;
        //     $row[] = $customers->empc_fecha_registro;


        //     // $row[] = $customers->FirstName;
        //     // $row[] = $customers->LastName;
        //     // $row[] = $customers->phone;
        //     // $row[] = $customers->address;
        //     // $row[] = $customers->city;
        //     // $row[] = $customers->country;

        //     $data[] = $row;
        // }

        $output = array(
                        "draw" => $_POST['draw'],
                        "recordsTotal" => $this->customers->count_all(),
                        "recordsFiltered" => $this->customers->count_filtered(),
                        "data" => $list
                );
        //output to json format
        echo json_encode($output);
    }

}
