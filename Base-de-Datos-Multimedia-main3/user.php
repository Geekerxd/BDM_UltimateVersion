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

        function addUser(){
            $this->tipo_usuario = $_POST["rol"];
            $this->nombre = $_POST["nombre"];
            $this->apellidoPat = $_POST["apellidoPat"];
            $this->apellidoMat = $_POST["apellidoMat"];
            $this->contrasena = $_POST["contrasena"];
            $this->email = $_POST["email"];
            $this->telefono = $_POST["telefono"];

            $db = new Connection;

            $mysqli = $db->connect();

            $result = $mysqli->query("CALL sp_signupUsuario('".$this->tipo_usuario."','".$this->nombre."','".$this->apellidoPat."','".$this->apellidoMat."','".$this->contrasena."','".$this->email."','".$this->telefono."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }

        function getUser(){
            $this->tipo_usuario = $_POST["rol"];
            $this->contrasena = $_POST["contrasena"];
            $this->email = $_POST["email"];

            $db = new Connection;

            $mysqli = $db->connect();

            $result = $mysqli->query("CALL sp_loginUsuario('".$this->tipo_usuario."','".$this->email."','".$this->contrasena."');");

            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                // Recorremos los resultados devueltos

                session_start();
                            
                // Store data in session variables
                $_SESSION["loggedin"] = true;
                $_SESSION["rol"] = $this->tipo_usuario;
                $_SESSION["contrasena"] = $this->contrasena;
                $_SESSION["email"] = $this->email; 
            
			$rows = array();
			while( $r = $result->fetch_assoc()) {
				$rows[] = $r;
			}			
			// Codificamos los resultados a formato JSON y lo enviamos al HTML (Client-Side)
			echo json_encode($rows);
            }

            mysqli_close($mysqli);
        }


    }

    $user = new User;

    $action = $_POST['action'];
    if($action == "addUser"){
        $user->addUser();
    }
    else if($action == "getUser"){
        $user->getUser();
    }

?>