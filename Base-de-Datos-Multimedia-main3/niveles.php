<?php
    include('db_conection.php');

    Class Level{
        public $nombreNivel;
        public $descripcionNivel;
        public $video;
        public $archivo;

        function addNivel(){
            $this->nombreNivel = $_POST["nombreNivel"];
            $this->descripcionNivel = $_POST["descNivel"];
            $this->video = $_POST["video"];
            $this->archivo = $_POST["archivo"];

            $db = new Connection;

            $mysqli = $db->connect();

            session_start();

            $result = $mysqli->query("CALL sp_createNivel('".$this->nombreNivel."','".$this->descripcionNivel."','".$_SESSION["idCursoActual"]."','".$this->video."','".$this->archivo."');");
        
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