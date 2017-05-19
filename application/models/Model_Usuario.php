<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Model_Usuario extends CI_Model {

    public $variable;

    public function __construct()
    {
        parent::__construct();
        $this->load->database();

    }
    public function eliminarUsuario($id){
        $this->db->where('idUsuario', $id);
        $this->db->delete('testuser');
        $tt = $this->db->affected_rows();
        // var_dump($tt);
        // exit;
    }
    public function listarUsuarios(){
        $this->db->select();
        $q = $this->db->get('testuser');
        return $q->result();
    }
    public function insertarUsuarios($datos){
        $values = array(
            'userNombre' => $datos['txtNombre'],
            'userApellido' => $datos['txtApellidos'],
            'userDireccion' => $datos['txtDireccion']
            );
        $this->db->insert('testuser', $values);

    }
    public function validarUsuario(Usuario &$objUsuario){
        $sql="SELECT * FROM usuario WHERE nomUser=? AND claveUser=md5(?)";
        $query =$this->db->query($sql,array(
            $objUsuario->NombreUsuario,
            $objUsuario->ClaveUsuario
            ));
        if($row = $query->row()){
            $objUsuario->IdUsuario = $row->idUser;
            $objUsuario->IdDependenciaUsuario = $row->idUser;
            $objUsuario->Persona = $row->persona;
            $objUsuario->FechaUsuario = $row->fechaUser;
            $objUsuario->EstadoUsuario = $row->estadoUser;
            $objUsuario->TipoUsuario = $row->tipoUser;
            return true;
        }else return false;

    }

    public function listar(){

        $query =$this->db->query('select*from usuario');
        $lst = $query->result('Hola');
        return $lst;
    }
    public function verificar($usaurio, $password){

    }

}

/* End of file Model_Usuario.php */
/* Location: ./application/models/Model_Usuario.php */