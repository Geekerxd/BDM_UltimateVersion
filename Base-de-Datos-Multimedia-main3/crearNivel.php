<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Crear nivel</title>

  <link rel="stylesheet" href="bootstrap/bootstrap.css" />

  <link rel="stylesheet" href="CSS/crearNivel.css" />

  <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
  <script type="text/javascript" src="js/nivel.js"></script>
  <script type="text/javascript" src="crearNivel.js"></script>
</head>

<body>
  <div class="container">
    <!--Letras -->
    <h1 class="Subtitles">Crear Nivel</h1>
    <!-- icono -->
    <div class="icono">

      <img class="icon" src="recursos/HiramiSVG_03.svg" alt="error-en-al-capa-8">
    </div>
    <!-- form-->

  </div>

  <div class="container peque">
    <form class="form-signin">

      <div class="form-label-group">
        <label for="input">Nombre del nivel</label>
        <input type="text" id="inputnombre" class="form-control" placeholder="" required required>

      </div>
      <div class="form-label-group">
        <label for="input">Descripcion</label>
        <input type="text" id="inputdesc" class="form-control" placeholder="Detalle en que consiste su curso" required required>

      </div>

      <div class="form-label-group">
        <label for="inputPassword">Imagen representativa</label>
        <input type="text" id="inputimagen" class="form-control" placeholder="Ingrese aquí el link" required>

      </div>

      <div class="form-label-group">
        <label for="inputPassword">Video del nivel</label>
        <input type="text" id="inputvideo" class="form-control" placeholder="Ingrese aqui el link" required required>

      </div>

      <div class="form-label-group">
        <label for="inputPassword">Archivo</label>
        <input type="text" id="inputarchivo" class="form-control" placeholder="Ingrese archivo" required required>

      </div>

      <button class="btn btn-lg btn-primary btn-block" type="submit" id="btnCrearNivel">Crear nivel</button>

      <p class="mt-5 mb-3 text-muted text-center">&copy;Hiromi 2017-2021</p>
    </form>

  </div>


  <script src="jquery/jquery.js"></script>
  <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>