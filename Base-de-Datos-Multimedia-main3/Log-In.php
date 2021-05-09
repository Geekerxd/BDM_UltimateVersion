<?php
// Initialize the session
session_start();

// Check if the user is already logged in, if yes then redirect him to welcome page
if (isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true) {
    header("location: Principal.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Log-in</title>
    <link rel="stylesheet" href="bootstrap/bootstrap.css" />
    <link rel="stylesheet" href="CSS/Log-In.css" />
    <script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>

    <script type="text/javascript" src="js/usuario.js"></script>
    <script type="text/javascript" src="login.js"></script>


</head>

<body>

    <div class="container">
        <!--Letras -->
        <h1 class="Subtitles">Ingresar</h1>
        <!-- icono
        <div class="icono">
            <img class="icon" src="Assets/KineCineNaranja.png" alt="error-en-al-capa-8" />
        </div>
        -->
        <div class="icono">

            <img class="icon" src="recursos/HiramiSVG_02.svg" alt="error-en-al-capa-8">
        </div>

    </div>

    <div class="container peque">

        <form class="form-signin" action="Principal.php" method="POST">

            <div class="tipo_usuario">
                <input type="radio" id="escuela" name="tipo_usuario" value="escuela">
                <label for="escuela">Escuela</label><br>
                <input type="radio" id="estudiante" name="tipo_usuario" value="estudiante">
                <label for="estudiante">Estudiante</label><br>
            </div>

            <div class="form-label-group">
                <label for="inputEmail">Correo Electrónico</label>
                <input type="email" id="inputEmail" class="form-control" placeholder="Ingrese aquí su correo" required autofocus>

            </div>

            <div class="form-label-group">
                <label for="inputPassword">Contraseña</label>
                <input type="password" id="inputPassword" class="form-control" placeholder="Ingrese aquí su contraseña" required>

            </div>

            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me"> Remember me
                </label>
            </div>
            <button id="btnLogin" class="btn btn-lg btn-primary btn-block" type="submit">Ingresar</button>
            ¿Eres nuevo?
            <a class="color2" href="Sign-up.php">registrate aquí</a>
            <p class="mt-5 mb-3 text-muted text-center">&copy;Hiromi 2017-2021</p>
        </form>

    </div>


    <script src="jquery/jquery.js"></script>
    <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>