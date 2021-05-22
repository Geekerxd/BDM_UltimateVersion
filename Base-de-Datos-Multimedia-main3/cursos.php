<?php

    include('db_conection.php');

    Class Signature{
        public $idCurso;
        public $nombre;
        public $descripcion;
        public $descripcionCorta;
        public $costo;
        public $categoria;
        public $idCreador;
        public $foto;
        public $video;

        function addCurso(){
            $this->nombre = $_POST["nombre"];
            $this->descripcion = $_POST["descripcion"];
            $this->descripcionCorta = $_POST["descripcionCorta"];
            $this->costo = $_POST["costo"];
            $this->categoria = $_POST["categoria"];
            $this->foto = $_POST["foto"];
            $this->video = $_POST["video"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_createCurso('".$this->nombre."','".$this->descripcionCorta."','".$this->descripcion."','".$this->costo."','".$this->categoria."','".$_SESSION["rol"]."','".$_SESSION["contrasena"]."','".$_SESSION["email"]."','".$this->foto."','".$this->video."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }


        function getCursos(){
            $db = new Connection;

            $mysqli = $db->connect();

            $result = $mysqli->query("CALL sp_getCursos();");

            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
            
			    $rows = array();
			    while( $r = $result->fetch_assoc()) {
				    $rows[] = $r;
			    }			
			    // Codificamos los resultados a formato JSON y lo enviamos al HTML (Client-Side)
			    echo json_encode($rows);
            }

            mysqli_close($mysqli);
        }

        function setCursoActual(){

            $this->idCurso = $_POST["idCurso"];

            session_start();

            $_SESSION["idCursoActual"] = $this->idCurso;
        }
        
        function getInfoCurso(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_traeInfoCurso('".$_SESSION["idCursoActual"]."');");

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

        function verificaCreadorCurso(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_verificaIdUsuarioCreador('".$_SESSION["rol"]."','".$_SESSION["email"]."','".$_SESSION["contrasena"]."','".$_SESSION["idCursoActual"]."');");

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

        function getDatosCurso(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_traeDatosCurso('".$_SESSION["idCursoActual"]."');");

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

        function cargaNombreCursoEvaluar(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_cargaNombreCursoEvaluar('".$_SESSION["idCursoActual"]."');");

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
        

        function getCursosProfesor(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_cargaCursosProfesor('".$_SESSION["email"]."','".$_SESSION["contrasena"]."');");

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

        function getAlumnosDeCurso(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_getAlumnosDeCurso('".$_SESSION["idCursoActual"]."');");

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

    $signature = new Signature;

    $action = $_POST['action'];
    if($action == "addCurso"){
        $signature->addCurso();
    }
    else if($action == "getCursos"){
        $signature->getCursos();
    }
    else if($action == "setCursoActual"){
        $signature->setCursoActual();
    }
    else if($action == "getInfoCurso"){
        $signature->getInfoCurso();
    }
    else if($action == "verificaCreadorCurso"){
        $signature->verificaCreadorCurso();
    }
    else if($action == "getDatosCurso"){
        $signature->getDatosCurso();
    }
    else if($action == "cargaNombreCursoEvaluar"){
        $signature->cargaNombreCursoEvaluar();
    }
    else if($action == "getCursosProfesor"){
        $signature->getCursosProfesor();
    }
    else if($action == "getAlumnosDeCurso"){
        $signature->getAlumnosDeCurso();
    }

?>