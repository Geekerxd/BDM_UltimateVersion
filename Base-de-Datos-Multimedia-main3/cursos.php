<?php

    include('db_conection.php');

    Class Signature{
        public $nombre;
        public $descripcion;
        public $descripcionCorta;
        public $costo;
        public $categoria;

        function addCurso(){
            $this->nombre = $_POST["nombre"];
            $this->descripcion = $_POST["descripcion"];
            $this->descripcionCorta = $_POST["descripcionCorta"];
            $this->costo = $_POST["costo"];
            $this->categoria = $_POST["categoria"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_createCurso('".$this->nombre."','".$this->descripcionCorta."','".$this->descripcion."','".$this->costo."','".$this->categoria."','".$_SESSION["rol"]."','".$_SESSION["contrasena"]."','".$_SESSION["email"]."');");
        
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

        


    }

    $signature = new Signature;

    $action = $_POST['action'];
    if($action == "addCurso"){
        $signature->addCurso();
    }
    else if($action == "getCursos"){
        $signature->getCursos();
    }

?>