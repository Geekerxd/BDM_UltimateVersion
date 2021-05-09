<?php
	$action = $_POST['action'];

	if ($action == "addUsuario") 
		addUsuario();

	function connect() {
		$databasehost = "localhost:3306";
		$databasename = "webstudy";
		$databaseuser = "root";
		$databasepass = "root";

		$mysqli = new mysqli($databasehost, $databaseuser, $databasepass, $databasename);
		if ($mysqli->connect_errno) {
			echo "Problema con la conexion a la base de datos";
		}
		else{
			echo "si se conecto";
		}
		return $mysqli;
	}

	function disconnect() {
		mysqli_close();
	}

	function addUsuario() {
		$rol = $_POST["rol"];
		$nombre = $_POST["nombre"];
		$apellidoPat = $_POST["apellidoPat"];
		$apellidoMat = $_POST["apellidoMat"];
		$contrasena = $_POST["contrasena"];
		$email = $_POST["email"];
		$telefono = $_POST["telefono"];
		$fecha_registro = "2021-05-11 10:05:45";

		//echo "rol " . $rol . " nombre " . $nombre . " apellP " . $apellidoPat . " apellM " . $apellidoMat . " contra " . $contrasena . " email " . $email . " tel " . $telefono;

		$mysqli = connect();
		
		$result = $mysqli->query("INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono, fecha_registro) values('".$rol."','".$nombre."','".$apellidoPat."','".$apellidoMat."','".$contrasena."','".$email."','".$telefono."','".$fecha_registro."');");
		
		if (!$result) {
			echo "Problema al hacer un query: " . $mysqli->error;								
		} else {
			echo "Todo salio bien";		
		}
		mysqli_close($mysqli);
	}

?>