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

        function getInfoUser(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_traeInfoUsuario('".$_SESSION["rol"]."','".$_SESSION["email"]."','".$_SESSION["contrasena"]."');");

            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                // Recorremos los resultados devueltos        
			    $rows = array();
			    while( $r = $result->fetch_assoc()) {
				    $rows[] = $r;
			    }			
			    // Codificamos los resultados a formato JSON y lo enviamos al HTML (Client-Side)
			    echo json_encode($rows);
            }

            mysqli_close($mysqli);
        }


        function modificateUser(){
            $this->nombre = $_POST["nombre"];
            $this->apellidoPat = $_POST["apellidoPat"];
            $this->apellidoMat = $_POST["apellidoMat"];
            $this->contrasena = $_POST["contrasena"];
            $this->email = $_POST["email"];
            $this->telefono = $_POST["telefono"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_modificarUsuario('".$this->nombre."','".$this->apellidoPat."','".$this->apellidoMat."','".$this->contrasena."','".$this->email."','".$this->telefono."','".$_SESSION['rol']."','".$_SESSION['email']."','".$_SESSION['contrasena']."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";

                session_start();
                            
                // Store data in session variables
                $_SESSION["contrasena"] = $this->contrasena;
                $_SESSION["email"] = $this->email; 
            }

            mysqli_close($mysqli);
        }

        function inscribirAlumno(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_inscribeUsuario('".$_SESSION["email"]."','".$_SESSION["contrasena"]."','".$_SESSION["idCursoActual"]."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }

        function verificaEstudianteEnCurso(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_verificaEstudianteEnCurso('".$_SESSION["email"]."','".$_SESSION["contrasena"]."','".$_SESSION["idCursoActual"]."');");
        
            if(!$result){
                //echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                // Recorremos los resultados devueltos        
			    $rows = array();
			    while( $r = $result->fetch_assoc()) {
				    $rows[] = $r;
			    }			
			    // Codificamos los resultados a formato JSON y lo enviamos al HTML (Client-Side)
			    echo json_encode($rows);
            }

            mysqli_close($mysqli);
        }

        function pasarNivel(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_pasarNivel('".$_SESSION["email"]."','".$_SESSION["contrasena"]."','".$_SESSION["idCursoActual"]."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                // Recorremos los resultados devueltos        
			    $rows = array();
			    while( $r = $result->fetch_assoc()) {
				    $rows[] = $r;
			    }			
			    // Codificamos los resultados a formato JSON y lo enviamos al HTML (Client-Side)
			    echo json_encode($rows);
            }

            mysqli_close($mysqli);
        }

        function getHistorialUser(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_cargaHistorial('".$_SESSION["rol"]."','".$_SESSION["email"]."','".$_SESSION["contrasena"]."');");

            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                // Recorremos los resultados devueltos        
			    $rows = array();
			    while( $r = $result->fetch_assoc()) {
				    $rows[] = $r;
			    }			
			    // Codificamos los resultados a formato JSON y lo enviamos al HTML (Client-Side)
			    echo json_encode($rows);
            }

            mysqli_close($mysqli);
        }

        function getDiploma(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_getDiploma('".$_SESSION["email"]."','".$_SESSION["contrasena"]."','".$_SESSION["idCursoActual"]."');");

            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                // Recorremos los resultados devueltos        
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
    else if($action == "getInfoUser"){
        $user->getInfoUser();
    }
    else if($action == "modificateUser"){
        $user->modificateUser();
    }
    else if($action == "inscribirAlumno"){
        $user->inscribirAlumno();
    }
    else if($action == "verificaEstudianteEnCurso"){
        $user->verificaEstudianteEnCurso();
    }
    else if($action == "pasarNivel"){
        $user->pasarNivel();
    }
    else if($action == "getHistorialUser"){
        $user->getHistorialUser();
    }
    else if($action == "getDiploma"){
        $user->getDiploma();
    }


?>