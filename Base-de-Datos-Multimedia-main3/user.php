<?php

    include('db_conection.php');

    Class User{
        public $tipo_usuario;
        public $nombre;
        public $apellidoPat;
        public $apellidoMat;
        public $contrasena;
        public $email;
        public $telefono;
        public $fecha_registro;

        function addUser(){
            $this->tipo_usuario = $_POST["rol"];
            $this->nombre = $_POST["nombre"];
            $this->apellidoPat = $_POST["apellidoPat"];
            $this->apellidoMat = $_POST["apellidoMat"];
            $this->contrasena = $_POST["contrasena"];
            $this->email = $_POST["email"];
            $this->telefono = $_POST["telefono"];
            $this->fecha_registro = $_POST["fecha_registro"];

            $db = new Connection;

            $mysqli = $db->connect();

            $result = $mysqli->query("INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono, fecha_registro) values('".$this->tipo_usuario."','".$this->nombre."','".$this->apellidoPat."','".$this->apellidoMat."','".$this->contrasena."','".$this->email."','".$this->telefono."','".$this->fecha_registro."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }


    }

    $user = new User;

    $action = $_POST['action'];
    if($action == "addUser"){
        $user->addUser();
    }

?>