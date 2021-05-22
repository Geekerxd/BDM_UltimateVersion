<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Crear categoría</title>
  <!-- 
        
        <link rel="stylesheet" href="css/bootstrap.css" />

        
-->
  <link rel="stylesheet" href="bootstrap/bootstrap.css" />

  <link rel="stylesheet" href="CSS/crearCategoria.css" />

  <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
  <script type="text/javascript" src="js/categoria.js"></script>
  <script type="text/javascript" src="crearCategoria.js"></script>
</head>

<body>
  <div class="container">
    <!--Letras -->
    <h1 class="Subtitles">Crear Categoría</h1>
    <!-- icono -->
    <div class="icono">

      <img class="icon" src="recursos/HiramiSVG_02.svg" alt="error-en-al-capa-8">
    </div>
    <!-- form-->

  </div>

  <div class="container peque">
    <form class="form-signin" action="upload.php" method="POST" enctype="multipart/form-data">

      <div class="form-label-group">
        <label for="input">Nombre de la categoría</label>
        <input type="text" id="nombre" class="form-control" placeholder="" required required>

      </div>
      <div class="form-label-group">
        <label for="input">Descripcion</label>
        <input type="text" id="desc" class="form-control" placeholder="Detalle en que consiste la categoría" required
          required>

      </div>


      <div class="form-label-group">
        <label for="inputPassword">Imagen representativa</label>

        <div class="form-group">

          <input type="file" name="image" id="image" class="form-control" required>
          <small id="emailHelp" class="form-text text-muted">Tamaño maximo de archivo 5 Mb.</small>
        </div>


      </div>

      <button id="btnCrear" class="btn btn-lg btn-primary btn-block" type="submit">Crear categoría</button>

      <p class="mt-5 mb-3 text-muted text-center">&copy;Hiromi 2017-2021</p>
    </form>

  </div>


  <script src="jquery/jquery.js"></script>
  <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>