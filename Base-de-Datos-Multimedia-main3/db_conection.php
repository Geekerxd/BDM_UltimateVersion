<?php

Class Connection {
    private $databasehost = "localhost";
	private $databasename = "webstudy";
	private $databaseuser = "root";
	private $databasepass = "";

    function connect(){
        $mysqli = new mysqli($this->databasehost, $this->databaseuser, $this->databasepass, $this->databasename);
        if($mysqli->connect_errno){
            echo "Problema con la conexion a la base de datos.";
        }
        return $mysqli;
    }
}

?>