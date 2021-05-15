<?php

    include('db_conection.php');

    Class Comentario{
        public $valoracion;
        public $contenido;

        function addComentarioCurso(){
            $this->valoracion = $_POST["valoracion"];
            $this->contenido = $_POST["contenido"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_createComentarioCurso('".$this->valoracion."','".$this->contenido."','".$_SESSION["email"]."','".$_SESSION["contrasena"]."','".$_SESSION["idCursoActual"]."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }

        function cargaComentariosCurso(){

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_cargaComentariosCurso('".$_SESSION["idCursoActual"]."');");

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

    $comentario = new Comentario;

    $action = $_POST['action'];
    
    if($action == "addComentarioCurso"){
        $comentario->addComentarioCurso();
    }
    else if($action == "cargaComentariosCurso"){
        $comentario->cargaComentariosCurso();
    }

?>