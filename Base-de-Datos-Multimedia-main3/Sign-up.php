<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>sign-up</title>
  <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>


  <link rel="stylesheet" href="bootstrap/bootstrap.css" />

  <link rel="stylesheet" href="CSS/Sign-Up.css" />

  <script type="text/javascript" src="js/usuario.js"></script>
  <script type="text/javascript" src="singin.js"></script>

  <link rel="shortcut icon" href="#">


</head>

<body>
  <div class="container">
    <!--Letras -->
    <h1 class="Subtitles">Registro</h1>
    <!-- icono -->
    <div class="icono">

      <img class="icon" src="recursos/HiramiSVG_03.svg" alt="error-en-al-capa-8">
    </div>
    <!-- form-->

  </div>

  <div class="container peque">
    <form action="Principal.php" id="form-signin" class="form-signin" method="POST" enctype="multipart/form-data">

      <div class="tipo_usuario">
        <input type="radio" id="escuela" name="tipo_usuario" value="escuela">
        <label for="escuela">Escuela</label><br>
        <input type="radio" id="estudiante" name="tipo_usuario" value="estudiante">
        <label for="estudiante">Estudiante</label><br>
      </div>

      <div class="form-label-group">
        <label for="input">Nombre(s)</label>
        <input type="text" id="inputNombre" class="form-control" placeholder="tu nombre" required required>

      </div>
      <div class="form-label-group">
        <label for="input">Apellido paterno</label>
        <input type="text" id="inputApellidoP" class="form-control" placeholder="apellido paterno" required required>

      </div>

      <div class="form-label-group">
        <label for="input">Apellido materno</label>
        <input type="text" id="inputApellidoM" class="form-control" placeholder="apellido materno" required required>

      </div>


      <div class="form-label-group">
        <label for="inputEmail">Correo Electrónico</label>
        <input type="email" id="ElEmail" class="form-control" placeholder="Ingrese aquí su correo" required autofocus>

      </div>

      <div class="form-label-group">
        <label for="inputPassword">Contraseña</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Ingrese aquí su contraseña" required>

      </div>

      <div class="form-label-group">
        <label for="inputPassword2">Confirme su contraseña</label>
        <input type="password" id="inputPassword2" class="form-control" placeholder="confirme" required required>

      </div>


      <div class="form-label-group">
        <label for="inputTel">Número de teléfono</label>
        <input type="number" id="inputTel" class="form-control" placeholder="Número de teléfono" required autofocus>

      </div>


      <div class="form-label-group">
        <label for="inputNombreUsuario">Nombre de usuario</label>
        <input type="text" id="inputNombreUsuario" class="form-control" placeholder="Nombre de usuario" required required>

      </div>


      <div class="checkbox mb-3">
        <label>
          <input type="checkbox" value="remember-me"> Acepto los terminos y condiciones.
        </label>
      </div>
      <button id="Registrarse" class="btn btn-lg btn-primary btn-block">Registrarse</button>

      <p class="mt-5 mb-3 text-muted text-center">&copy;Hiromi 2017-2021</p>
    </form>

  </div>

  <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>