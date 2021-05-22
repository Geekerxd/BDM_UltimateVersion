<?php

    include('db_conection.php');

    Class Chat{
        public $idChat;
        public $usuario1;
        public $usuario2;
        public $mensaje;
        public $fechaMensaje;
        public $stringBuscar;

        function buscadorChat(){
            $this->stringBuscar = $_POST["stringaBuscar"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_buscadorUsuarios('".$this->stringBuscar."','".$_SESSION["email"]."','".$_SESSION["contrasena"]."');");
        
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

        function cargaChats(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_cargaChats('".$_SESSION["email"]."','".$_SESSION["contrasena"]."');");
        
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


        function establecerChat(){
            $this->idChat = $_POST["idChat"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_estableceChat('".$this->idChat."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{

                $_SESSION["idChat"] = $this->idChat;

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

        function creaChat(){
            $this->usuario1 = $_POST["idDelOtro"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_creaChat('".$this->usuario1."','".$_SESSION["email"]."','".$_SESSION["contrasena"]."');");
        
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

        function mandaMensaje(){
            $this->mensaje = $_POST["mensaje"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_creaMensaje('".$this->mensaje."','".$_SESSION["idChat"]."','".$_SESSION["email"]."','".$_SESSION["contrasena"]."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo bien";
            }

            mysqli_close($mysqli);
        }

    }

    $mensajeChat = new Chat;

    $action = $_POST['action'];
    if($action == "buscadorChat"){
        $mensajeChat->buscadorChat();
    }
    else if($action == "cargaChats"){
        $mensajeChat->cargaChats();
    }
    else if($action == "establecerChat"){
        $mensajeChat->establecerChat();
    }
    else if($action == "creaChat"){
        $mensajeChat->creaChat();
    }
    else if($action == "mandaMensaje"){
        $mensajeChat->mandaMensaje();
    }


?>