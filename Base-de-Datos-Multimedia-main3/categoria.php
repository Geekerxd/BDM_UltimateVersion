<?php

    include('db_conection.php');

    Class Category{
        public $nombre;
        public $descripcion;

        function addCategoria(){
            $this->nombre = $_POST["nombre"];
            $this->descripcion = $_POST["descripcion"];

            $db = new Connection;

            $mysqli = $db->connect();

            $result = $mysqli->query("CALL sp_createCategory('".$this->nombre."','".$this->descripcion."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }

        function getCategorias(){
            $db = new Connection;

            $mysqli = $db->connect();

            $result = $mysqli->query("CALL sp_getCategorias();");

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

    $categoria = new Category;

    $action = $_POST['action'];
    if($action == "addCategoria"){
        $categoria->addCategoria();
    }
    else if($action == "getCategorias"){
        $categoria->getCategorias();
    }

?>