<?php

    include('db_conection.php');

    Class Signature{
        public $nombre;
        public $descripcion;
        public $costo;
        public $categoria;

        function addCurso(){
            $this->nombre = $_POST["nombre"];
            $this->descripcion = $_POST["descripcion"];
            $this->costo = $_POST["costo"];
            $this->categoria = $_POST["categoria"];

            $db = new Connection;

            $mysqli = $db->connect();

            $result = $mysqli->query("CALL sp_createCurso('".$this->nombre."','".$this->descripcion."','".$this->costo."','".$this->categoria."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }


    }

    $signature = new Signature;

    $action = $_POST['action'];
    if($action == "addCurso"){
        $signature->addCurso();
    }

?>