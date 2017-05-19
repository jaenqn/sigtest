<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Model_Usuarios extends CI_Model {
    private $table = 'tbl_usuarios';
    private $class = 'ent_usuarios';
    private $id = 'usu_id';

    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        // $this->load->library('Hash');

    }
    public function lista_visitas($tipo){
        switch ($yipo) {
            case 'hoy':
                $fecha_dia = '2016-12-26';
                break;
            default:
                # code...
                break;
        }

    }
    public function visita_rango($fechaUno, $fechaDos = false){
        $this->db->select('CONVERT(vis_date,DATE) AS fecha_semana');
        $this->db->select('COUNT(vis_date) AS num_visitas');
        $this->db->where("CONVERT(vis_date,DATE) >= CONVERT('$fechaUno',DATE)");
        $this->db->where("CONVERT(vis_date,DATE) <= CONVERT('$fechaDos',DATE)");
        $this->db->where("is_first", 1);
        // $this->db->where("vis_url",'/');
        $this->db->group_by('fecha_semana');
        $this->db->order_by('fecha_semana', 'asc');
        $g = $this->db->get('tbl_visitas')->result_object();
        // print_rr($g);
        return $g;
    }
    public function visita_hoy($dia){
        $this->db->select("EXTRACT( HOUR FROM vis_date) AS hora");
        $this->db->select("COUNT(vis_date) as num_visitas");
        $this->db->where("CONVERT(vis_date,DATE) = '$dia'");
        $this->db->where("is_first", 1);

        // $this->db->where("vis_url",'/');
        $this->db->group_by('hora');
        $this->db->order_by('vis_date', 'asc');
        $g = $this->db->get('tbl_visitas')->result_object();
        $t = 0;
        $horas = array();
        for ($i = 0; $i < 24 ; $i++) {
            $horaf = $i < 10 ? '0'.$i.':00' : $i.':00';
            if($g){
                if($g[$t]->hora == $i){
                    $horas[] = array(
                        'hora' => $g[$t]->hora,
                        'visitas' => $g[$t]->num_visitas,
                        'hora_format' => $horaf
                    );
                    if($t < count($g) -1)
                        $t++;
                }else{
                    // $horas[] = array(
                    //     'hora' => $i,
                    //     'visitas' => 0,
                    //     'hora_format' => $horaf
                    // );
                }
            }


        }
        return $horas;

    }
    public function listar_estadisticas(){
        //Visitas hoy
        $this->db->select('COUNT(vis_date) AS num_visitas');
        $this->db->where('CONVERT(vis_date,DATE)', date('Y-m-d'));
        $this->db->where("is_first", 1);
        // $this->db->where('vis_url', '/');
        $g = $this->db->get('tbl_visitas')->row();
        // echo $this->db->last_query();
        $data_fecha['visitas_hoy'] = $g->num_visitas;
        //visitas ayer
        $this->db->select('COUNT(vis_date) AS num_visitas');
        $this->db->where('CONVERT(vis_date,DATE)', date('Y-m-d',time() - 86400));
        // $this->db->where('vis_url', '/');
        $this->db->where("is_first", 1);
        $g = $this->db->get('tbl_visitas')->row();
        $data_fecha['visitas_ayer'] = $g->num_visitas;
        //visitas semana
        $this->db->select('COUNT(vis_date) AS num_visitas');
        $dia_sem = date('w');
        $fecha = date('Y-m-d',time() - ($dia_sem == 0 ? 6 : ($dia_sem == 1? 0 : ($dia_sem - 1)))*3600*24);
        $this->db->where("vis_date >= CONVERT('".$fecha."',DATE)");
        // $this->db->where('vis_url', '/');
        $this->db->where("is_first", 1);
        $g = $this->db->get('tbl_visitas')->row();
        $data_fecha['visitas_semana'] = $g->num_visitas;
        //visitas yeaar
        $this->db->select('COUNT(vis_date) AS num_visitas');
        $this->db->where("EXTRACT(YEAR FROM vis_date) = EXTRACT(YEAR FROM NOW())");
        // $this->db->where('vis_url', '/');
        $this->db->where("is_first", 1);
        $g = $this->db->get('tbl_visitas')->row();
        $data_fecha['visitas_year'] = $g->num_visitas;
        //visitas totales
        $this->db->select('COUNT(vis_date) AS num_visitas');
        // $this->db->where('vis_url', '/');
        $this->db->where("is_first", 1);
        $g = $this->db->get('tbl_visitas')->row();
        $data_fecha['visitas_total'] = $g->num_visitas;

        return $data_fecha;


    }
    public function insertar_visita($values){
        $this->db->set('vis_date', 'now()',false);
        $q = $this->db->insert('tbl_visitas', $values);
    }
    public function eliminar_onlines($limite){
        $this->db->where("tiempo < $limite");
        $q = $this->db->delete('tbl_usuarios_online');
        // print_rr($q);

        // echo '['.$this->db->affected_rows().']';
        // echo $this->db->last_query();
    }
    public function delete_online($id){
        $this->db->where('id_usuario', $id);
        $this->db->delete('tbl_usuarios_online');
        echo $this->db->affected_rows();
    }
    public function registrar_activo($values){
        if($values['name_usuario']!=null){
            $this->db->select('name_usuario');
            $this->db->where('name_usuario', $values['name_usuario']);
            $g = $this->db->get('tbl_usuarios_online');
            $l = $g->result();
            if(count($l)>0){
                $this->db->where('name_usuario', $values['name_usuario']);

                $q['res'] = $this->db->update('tbl_usuarios_online', array(
                    'tiempo' => $values['tiempo']
                    ));
            }else{
                $q['res'] = $this->db->insert('tbl_usuarios_online', $values);
            }
            // else{
            // $url = $_SERVER['REQUEST_URI'];
            // if(procesos_sig::not_url($url, array('set_online'))){
            //     $vaL_visita = array(
            //         'vis_url' => $url,
            //         'ci_session' => get_cookie('ci_session'),
            //         'is_first' => 1
            //         );
            //     $this->insertar_visita($vaL_visita);

            // }
            // if($url != '/set_online');

            // }
            // echo 'fin';
            // exit;

            return $q;
        }
        return true;

    }
    public function listar_onlines(){
        $limit = time() - ent_usuarios::$tiempo_usuario;
        $this->eliminar_onlines($limit);
        $this->db->select();
        $q = $this->db->get('tbl_usuarios_online');
        return $q->result_object();

    }
    public function eliminar_activo(){

    }
    public function actualizar_activo(){

    }
    public function existen_usuarios(){
        $q = $this->listar();
        if(count($q) > 0)
            return true;
        return false;
    }
    public function existe_usuario($usu, $idusuario = false){
        $this->db->select();
        $this->db->where('usu_usuario', $usu);
        if($idusuario)
            $this->db->where_not_in('usu_id', array($idusuario));

        $this->db->get('tbl_usuarios');
        return $this->db->affected_rows();
    }
    public function validar_usuario(ent_usuarios $obj){
        $this->db->select();
        $this->db->where('usu_usuario', $obj->usu_usuario);
        $this->db->where('usu_pass', Hash::getHash('sha1',$obj->usu_pass,HASH_KEY));
        // $this->db->join('unidades', 'unidades.uni_id = tbl_usuarios.uni_id_unidad', 'left');
        $q = $this->db->get($this->table);
        return $q->custom_row_object(0, $this->class);
    }

    public function insertar(ent_usuarios $obj){
        $values = $this->db->fields_filter($obj, $this->table, true);
        $this->db->insert($this->table, $values);
        return $this->db->affected_rows() == 1 ? true : false;

    }

    public function listar(){
        $this->db->select();
        // $this->db->from('unidades');
        // $this->db->join('departamentos', 'departamentos.dep_id = unidades.dep_id_departamento');
        $q = $this->db->get($this->table);
        // $lst = $q->result();
        // print_rr($lst);exit;
        $lst = $q->custom_result_object($this->class);
        return $lst;
    }
    public function get_obj(ent_usuarios $obj)
    {
        $this->db->select($this->table.'.*');
        $this->db->select('d.reportaDpend as dep_id_departamento');
        $this->db->where($this->id, $obj->usu_id);
        $this->db->join('dependencia d', 'd.idDepend = tbl_usuarios.uni_id_unidad', 'left');
        $q = $this->db->get($this->table);
        return $q->custom_row_object(0, $this->class);
    }

    public function eliminar($id){
        $this->db->where($this->id, $id);
        $this->db->delete($this->table);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return false;
    }

    public function actualizar(ent_usuarios $obj){
        $values = $this->db->fields_filter($obj, $this->table);
        if($values['usu_pass'] == Hash::getHash('sha1','',HASH_KEY))
            unset($values['usu_pass']);

        $this->db->where($this->id, $obj->usu_id);
        $this->db->update($this->table, $values);
        if($this->db->affected_rows() >= 1){
            return true;
        }
        return true;
    }
}