<?php
    include('db_conection.php');

    Class Level{
        public $nombreNivel;
        public $descripcionNivel;

        function addNivel(){
            $this->nombreNivel = $_POST["nombreNivel"];
            $this->descripcionNivel = $_POST["descNivel"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_createNivel('".$this->nombreNivel."','".$this->descripcionNivel."','".$_SESSION["idCursoActual"]."');");
        
            if(!$result){
                echo "Problema al hacer el query: " . $mysqli->error;
            }
            else{
                echo "Todo salio bien.";
            }

            mysqli_close($mysqli);
        }


    }

    $level = new Level;

    $action = $_POST['action'];
    if($action == "addNivel"){
        $level->addNivel();
    }

?>