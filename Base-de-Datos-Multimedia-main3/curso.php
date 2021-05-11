<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebStudy</title>
    <!-- Bootstrap CSS 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    -->

    <!--bootstrap-->
    <link rel="stylesheet" href="bootstrap/bootstrap.css" />
    <!--style css-->
    <link rel="stylesheet" href="CSS/curso.css">

    <!-- Iconos-->
    <script src="https://kit.fontawesome.com/8a399301fb.js" crossorigin="anonymous"></script>
    <!-- Fonts de google:-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oleo+Script:wght@700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&display=swap" rel="stylesheet" />
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="cursoInfo.js"></script>
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

    <!--///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////Contenido de curso////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <div class="contenidoCurso">
        <div class="nombreCurso">
            <h1>PHP</h1>
            <h6>Programación web</h6>
        </div>
        <!--imagen-->
        <div class="imgCurso">
            <img src="https://blogs.masterhacks.net/wp-content/uploads/2019/09/masterhacks_vulnerabilidades_abordadas_php.jpg" alt="php">
        </div>
        <!--texto de descripcion-->
        <div class="descCurso">
            <p>PHP es un lenguaje de código abierto muy popular especialmente adecuado para el desarrollo
                web y que puede ser incrustado en HTML. En lugar de usar muchos comandos para mostrar HTML
                (como en C o en Perl), las páginas de PHP contienen HTML con código incrustado que hace "algo".
            </p>
        </div>
        <!--cuadros/botones-->
        <div class="nivelesCurso">
            <div class="nivelCurso">
                <h3 class="nivelCurso">Niveles</h3>
            </div>
            <div class="losNiveles">
                <center>
                    <button class="btnNivel" id="btn1">Nivel 1</button>
                    <button class="btnNivel" id="btn2">Nivel 2</button>
                    <button class="btnNivel" id="btn3">Nivel 3</button>
                    <button class="btnNivel" id="btn4">Nivel 4</button>
                    <button class="btnNivel" id="btn5">Nivel 5</button>
                    <button class="btnNivel" id="btn6">Nivel 6</button>
                </center>
            </div>
        </div>

        <!--video-->

        <center>
            <iframe width="560" height="315" src="https://www.youtube.com/embed/ykGRYEX0n60" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </center>


        <!--boton inscribirse-->
        <center>
            <div class="inscripcionCurso">
                <button class="btnInscripcion" href="pagarCurso.php">
                    <a href="pagarCurso.php">Inscribirse</a>
                </button>
            </div>
        </center>

        <!--///////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////Niveles del curso/////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////-->

        <div class="niveldeCurso">

            <h1 id="numNivel">Nivel 1</h1>
            <h1 id="nombreNivel">Introduccion a php</h1>
            <p>En este nivel veremos las bases de php.</p>
            <center>
                <iframe width="560" height="315" src="https://www.youtube.com/embed/ykGRYEX0n60" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><br>
            </center>
            <a href="https://www.fdi.ucm.es/profesor/jpavon/web/33-PHP.pdf">Contenido del curso</a><br>
            <a href="https://www.fdi.ucm.es/profesor/jpavon/web/33-PHP.pdf">Contenido del curso</a><br>
        </div>

        <div class="comentariosCurso">
            <h1 id="comentCurso">Comentarios</h1>
            <!-- AQUI EMPIEZA EL COMENTARIO -->
            <div id="list-item-1" class="card-comentarios text-left">
                <div class="card-header">
                    <img src="https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg" alt="foto">
                    <label for="usuario">Martin Montemayor</label>
                </div>
                <div class="card-body">
                    <input class="card-text" type="text" style="width:100%" value="Esta muy bueno"></input>
                </div>
                <div class="card-footer">
                    <label for="fecha-hora" class="fecha-hora">10/10/2020 23:12</label>
                </div>

            </div>

            <!-- AQUI EMPIEZA EL COMENTARIO -->
            <div id="list-item-1" class="card-comentarios text-left">
                <div class="card-header">
                    <img src="https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg" alt="foto">
                    <label for="usuario">Alejandra Quiroz</label>
                </div>
                <div class="card-body">
                    <input class="card-text" type="text" style="width:100%" value="Recomendable"></input>
                </div>
                <div class="card-footer">
                    <label for="fecha-hora" class="fecha-hora">10/10/2020 23:12</label>
                </div>

            </div>
        </div>


    </div>






    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</body>

</html>