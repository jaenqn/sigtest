
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Datatables extends CI_Model {
    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    var $table = '';
    // var $order = array('1' => 'asc');
    var $order = false;
    var $column_order;
    var $column_search;
    var $col_likes = array();
    var $tab_join = array();
    var $filter = array();
    // var $col_select = array();
    var $col_select = array('*');


    private function _get_datatables_query()
    {
        $this->db->select($this->col_select);

        $this->db->from($this->table);

        $i = 0;
         foreach ($this->tab_join as $key => $value) {
                if(isset($value[2]))
                    $this->db->join($value[0], $value[1],$value[2]);
                else $this->db->join($value[0], $value[1]);
            }

        foreach ($this->column_search as $item)
        {

            if($_POST['search']['value'])
            {

                if($i===0) // first loop
                {
                    $this->db->group_start();
                    $this->db->like($item, $_POST['search']['value']);
                }
                else
                {
                    $this->db->or_like($item, $_POST['search']['value']);
                }

                if(count($this->column_search) - 1 == $i) //last loop
                    $this->db->group_end(); //close bracket
            }
            $i++;
        }
        // if($col_likes){
        $i = 0;
        foreach ($this->col_likes as $item) {
            $this->db->like($item['column'], $item['filter']);

        }
        // }


        $i = 0;
        // print_rr($this->filter);
        foreach ($this->filter as $item) {
            // echo 'filtro';
            if(isset($item['type'])){
                switch ($item['type']) {
                    case 'custom':
                        $this->db->where($item['column']);
                        break;
                }
            }else{
                $this->db->where($item['column'], $item['filter']);
            }
            // if(count($this->filtros) - 1 == $i)
                // $this->db->group_end();
            // $i++;
        }
        // print_rr($this->filter);

        if(isset($_POST['order']))
        {


            if($this->order){
                $order = $this->order;
                // print_rr($order);
                if(count($order) > 1){
                    foreach ($order as $key => $value) {
                        $this->db->order_by($key, $value);
                    }

                }else{
                    $this->db->order_by(key($order), $order[key($order)]);
                }

            }else{
                if(count($_POST['order']) > 1){
                    foreach ($_POST['order'] as $key => $value) {
                        $this->db->order_by($_POST['columns'][$value['column']]['data'], $value['dir']);
                    }
                }else{
                    $this->db->order_by($_POST['columns'][$_POST['order']['0']['column']]['data'], $_POST['order']['0']['dir']);
                }

            }
            // $this->db->order_by()
            // $this->db->order_by($_POST['columns'][$_POST['order']['0']['column']]['data'], $_POST['order']['0']['dir']);
            // $this->db->order_by($this->column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
        }
        else
        {
            // $order = $this->order;
            // $this->db->order_by(key($order), $order[key($order)]);
            $this->db->order_by('1', 'asc');
        }
    }
    function pre_query(){
        if(isset($_POST['order']))
        {


            if($this->order){
                $order = $this->order;
                print_rr($order);
                foreach ($this->order as $key => $value) {
                    # code...
                    $this->db->order_by(key($order), $order[key($order)]);
                }
                // $this->db->order_by(key($order), $order[key($order)]);
            }else{

                $this->db->order_by($_POST['columns'][$_POST['order']['0']['column']]['data'], $_POST['order']['0']['dir']);
            }
            // $this->db->order_by()
            // $this->db->order_by($_POST['columns'][$_POST['order']['0']['column']]['data'], $_POST['order']['0']['dir']);
            // $this->db->order_by($this->column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
        }
        else
        {
            // $order = $this->order;
            // $this->db->order_by(key($order), $order[key($order)]);
            $this->db->order_by('1', 'asc');
        }
    }
    function get_datatable_query($query,$order_by = false, $limitlength = 10, $limitstart = 0){
        if($order_by)
            $this->order = $order_by;
        $this->pre_query();

        if($limitlength != -1)
            $this->db->limit($limitlength, $limitstart);

        $query = $this->db->query($query);
        $datos['list']  = $query->result_object();



        $this->pre_query();
        $query = $this->db->query($query);
        $datos['count_filtered']  = $query->num_rows();

        //resultados del filtro de un filtro
        $this->db->from($this->table);
        $datos['count_all']  = $this->db->count_all_results();
    }
    function get_simpledata(){

    }
    function get_datatables($nom_table, $custom_obj, $col_search = false, $filtros = false, $col_s = array(),$order_by = false,$joins = array(),$limitlength = -1, $limitstart = 0)
    {
        $this->filter = array();
        // print_rr($filtros);

        $this->table  = $nom_table;
        if($order_by)
            $this->order = $order_by;

        if($filtros){
            // print_rr($filtros);
            // $this->filter = array();

            $this->filter = $filtros;
        }
        if($col_search){
            $this->col_likes = $col_search;
        }
        $this->tab_join = $joins;
        // $_POST['search']['value'] = 'a';
        $this->column_order =$this->db->list_fields($this->table);
        $this->column_search =$this->db->list_fields($this->table);
        // $this->col_select =$this->db->list_fields($this->table);

        $this->col_select[0] = $this->table.'.*';
        $this->col_select = array_merge($this->col_select, $col_s);

        $this->_get_datatables_query();

        // if($_POST['length'] != -1)
        //     $this->db->limit($_POST['length'], $_POST['start']); //old

        if($limitlength != -1){
            // print_rr('entre a limit');
            $this->db->limit($limitlength, $limitstart);
        }

        $query = $this->db->get();
        // echo $this->db->last_query();

        if($custom_obj != 'object')
            $datos['list']  = $query->custom_result_object($custom_obj);
        else $datos['list']  = $query->result_object();



        $this->_get_datatables_query();
        $query = $this->db->get();
        $datos['count_filtered']  = $query->num_rows();


        foreach ($this->filter as $key => $value) {
            // if(isset($value['type'])){
            //     switch ($value['type']) {
            //         case 'not':
            //             $this->db->where($value['column'], $value['filter']);
            //             break;

            //         default:
            //             # code...
            //             break;
            //     }
            // }
            if(isset($value['default']) && $value['default']){
                if(isset($value['type'])){
                    switch ($value['type']) {
                        case 'custom':
                            $this->db->where($value['column']);
                            break;
                    }
                }else{
                    $this->db->where($value['column'], $value['filter']);
                }
            }


        }
        $this->db->from($this->table);
        $datos['count_all']  = $this->db->count_all_results();

        // print_rr($this->db);
        $this->db->reset_query();
        return $datos;


        // return $query->result();
    }
}