<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Progreso de alumnos</title>
    <!-- Bootstrap CSS 
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">


    -->

    <!-- Iconos-->
    <script src="https://kit.fontawesome.com/8a399301fb.js" crossorigin="anonymous"></script>
    <!-- Fonts de google:-->
    <link href="https://fonts.googleapis.com/css2?family=Oleo+Script:wght@700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&display=swap" rel="stylesheet" />

    <!--bootstrap-->
    <link rel="stylesheet" href="bootstrap/bootstrap.css" />
    <!-- CSS -->
    <link rel="stylesheet" href="CSS/progresoAlumnos.css">

    <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="alumnosdeCurso.js"></script>

    <script type="text/javascript">
        function creaChat(valor){
                // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "creaChat",
            idDelOtro: valor,
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "chats.php",
            async: true,
            type: "POST",
            data: dataToSend,
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                //alert("yendo a "+valor);

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < 4; index++) {

                    //$(".noticias-row").append("<div class='card' id=" + Object.values(data[index].idCurso).join("") + "col-12 col-sm-6 col-md-3 d-none d-sm-block'><span class='badge badge-info etiqueta'>" + Object.values(data[index].nombreCat).join("") + "</span><a href='curso.php' target='_blank'><img src=" + Object.values(data[index].fotoCurso).join("") + " class='card-img-top' alt='no se pudo cargar esta imagen' /></a><div class='Tarjeta-texto'><p style='margin-top: 15px'><strong>" + Object.values(data[index].nombreCurso).join("") + "</strong></p><p class='lead' style='font-size: 15px'>" + Object.values(data[index].descCortaCurso).join("") + "<a class='linkColor' href='curso.php'>Más información</a></p></div><div class='row empty'></div><div class='container_iconos row'><span class='material-icons md-xx'>thumb_up</span><i class='fas' :hover>" + Object.values(data[index].valoracion).join("") + "%</i><i class='fas fa-comment' :hover>138</i></div><input type='hidden' name='idCurso' value=" + Object.values(data[index].idCurso).join("") + "></div>");
                    $(".noticias-row").append("<div class='card col-12 col-sm-6 col-md-3 d-none d-sm-block' style='display: inline-flex;'><span class='badge badge-info etiqueta'>" + Object.values(data[index].nombreCat).join("") + "</span><a href='curso.php' target='_blank'><img src=" + Object.values(data[index].fotoCurso).join("") + " class='card-img-top' alt='no se pudo cargar esta imagen' /></a><div class='Tarjeta-texto'><p style='margin-top: 15px'><strong>" + Object.values(data[index].nombreCurso).join("") + "</strong></p><p class='lead' style='font-size: 15px'>" + Object.values(data[index].descCortaCurso).join("") + "</p><a class='linkCurso' href='curso.php' target='_blank'><button class='btnInfoCurso btn-primary' onclick='buscaCurso(this.value)' type='submit' value="+ Object.values(data[index].idCurso).join("") + " style='border-radius: 5px; margin-left: 40%;'>Más información</button></a></div><div class='row empty'></div><div class='container_iconos row'><span class='material-icons md-xx'>thumb_up</span><i class='fas' :hover>" + Object.values(data[index].valoracion).join("") + "%</i><i class='fas fa-comment' :hover>"+ Object.values(data[index].cantComentarios).join("") +"</i></div><input type='hidden' name='idCurso' value=" + Object.values(data[index].idCurso).join("") + "></div>");
                    
                }

            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
        }
    </script>
</head>

<body>

    <!-- Barra de navegacion -->


    <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="border-bottom: solid 1px #275d8c7e">
        <a class="navbar-brand" id="azulado" href="Principal.php" :hover>
            Hiromi
            <img class="icon" src="recursos/HiramiSVG_02.svg" alt="error-en-al-capa-8">
            <!-- 
          <img class="icon" src=" Assets/KineCineNaranja.png " alt="error-en-al-capa-8" /> 
      -->
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#" style="color: #275d8c">Inicio <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #f29849">
                        Categorias
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="todosCursos.php">Todos los cursos</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Programación general</a>

                        <a class="dropdown-item" href="#">API</a>
                        <a class="dropdown-item" href="#">Programación web</a>
                        <a class="dropdown-item" href="#">Programación de apps</a>
                        <a class="dropdown-item" href="#">Base de datos</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Clásicos</a>
                        <a class="dropdown-item" href="#">Accion</a>
                        <a class="dropdown-item" href="#">Aventura</a>
                    </div>
                </li>
                <!-- 
<li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            id="navbarDropdown"
            role="button"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
            style="color: #f29849"
          >
            Reviews
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="#">Reciente Actividad</a>
            <a class="dropdown-item" href="#">Listas Films</a>
            <a class="dropdown-item" href="#">Top lo mejor de lo mejor</a>
            <a class="dropdown-item" href="#">Top lo peor de lo peor</a>
          </div>
        </li> 
-->

            </ul>

            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Buscar cursos..." aria-label="search" />

                <button class="btn btn-primary uni" type="submit">
                    <i class="fas fa-search uni"></i>
                </button>
            </form>

            <a href="LogIn.jsp" class="LogIn-text " style="color: #F29849; margin-left: 20px; ">
                Log In
            </a>

            <button type="button" class="btn btn-primary SignIn" style="margin-left: 15px; ">
                <a href="SignIn.jsp" style="color: white;">Sign In</a>

            </button>
        </div>
    </nav>


    <div class="container" style="margin-top: 50px">
        <div id="main-news">
            <h2 class="Subtitles">Progreso de alumnos</h2>
            <div class="progresoAlumnos" id="progresoAlumnos">
                <!-- Tamaño PC-->

            </div>
        </div>
    </div>





    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

    <script src="jquery/jquery.js"></script>
    <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>