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

    <!-- Iconos-->
    <script src="https://kit.fontawesome.com/8a399301fb.js" crossorigin="anonymous"></script>
    <!-- Fonts de google:-->
    <link href="https://fonts.googleapis.com/css2?family=Oleo+Script:wght@700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&display=swap" rel="stylesheet" />

    <!--bootstrap-->
    <link rel="stylesheet" href="bootstrap/bootstrap.css" />
    <!-- CSS -->
    <link rel="stylesheet" href="CSS/categoria.css">
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
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#" style="color: #275d8c">Inicio <span
                            class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #f29849">
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



    <div class="secDescripcion">
        <div class="bienvenidoPrincipal">
            <h3>Programación web</h3>
        </div>

        
        <div class="imgDescripcion">
            <img src="https://indexdesarrollo.com/wp-content/uploads/2017/05/lenguajes-de-programacion-web.png"
                alt="imagen01">
            </img>
            <h6>
                Esta categoria contempla todos los cursos de programacion orientada al desarrollo web. Aqui podras 
                aprender php, html, css, javascript.
            </h6>
        </div>


    </div>

    <div class="container" style="margin-top: 50px">
        <div id="main-news">
            <h2 class="Subtitles">Cursos de la categoria</h2>
            <div class="row">
                <!-- Tamaño PC-->
                <!-- Aqui empieza una carta de curso-->
                <div class="card col-12 col-sm-6 col-md-3 d-none d-sm-block">
                    <span class="badge badge-info etiqueta">Programacion web</span>
                    <a href="curso.php" target="_blank">
                        <img src="https://seeklogo.com/images/E/ElePHPant_-_Mascot_PHP-logo-4C78D1AC4E-seeklogo.com.jpg"
                            class="card-img-top" alt="no se pudo cargar esta imagen" />
                    </a>
                    <div class="Tarjeta-texto">
                        <p style="margin-top: 15px">
                            <strong>
                                php
                            </strong>
                        </p>
                        <p class="lead" style="font-size: 15px">
                            Aprende desarrollo web a traves de php.
                            <a class="linkColor" href="Home.php">Más información</a>
                        </p>
                    </div>
                    <!-- 
                
                <div class="card-body">
                
                    
                </div>
                -->
                    <div class="row empty"></div>
                    <div class="container row A-center">
                        <span class="material-icons md-xx">
                            thumb_up
                        </span>
                        <i class="fas" :hover>80%</i>
                        <!--<i class="fas fa-hand-point-down" :hover>80%</i>-->
                        <i class="fas fa-comment" :hover>138</i>
                        <!--<i class="fas fa-ellipsis-h" :hover></i>-->
                    </div>
                </div>
                <!-- Aqui termina una carta de curso-->

                <!-- Aqui empieza una carta de curso-->
                <div class="card col-12 col-sm-6 col-md-3 d-none d-sm-block">
                    <span class="badge badge-info etiqueta">Programacion web</span>
                    <a href="UnaNoticia.jsp" target="_blank">
                        <img src="https://img.flaticon.com/icons/png/512/174/174854.png?size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF"
                            class="card-img-top" alt="no se pudo cargar esta imagen" />
                    </a>
                    <div class="Tarjeta-texto">
                        <p style="margin-top: 15px">
                            <strong>
                                html
                            </strong>
                        </p>
                        <p class="lead" style="font-size: 15px">
                            Aprende las bases del desarrollo web con html.
                            <a class="linkColor" href="Home.php">Más información</a>
                        </p>
                    </div>

                    <div class="row empty"></div>
                    <div class="container row A-center">
                        <span class="material-icons md-xx">
                            thumb_up
                        </span>
                        <i class="fas" :hover>86%</i>
                        <!--<i class="fas fa-hand-point-down" :hover>80%</i>-->
                        <i class="fas fa-comment" :hover>138</i>
                        <!--<i class="fas fa-ellipsis-h" :hover></i>-->
                    </div>
                </div>
                <!-- Aqui termina una carta de curso-->


                <!-- Tamaño celular-->
                <div class="card mb-3 col-12 d-block d-sm-none">
                    <div class="row no-gutters">
                        <div class="col-md-4">
                            <a href="UnaNoticia.jsp" target="_blank">
                                <img src="https://img.cinemablend.com/filter:scale/quill/4/5/7/3/9/6/4573966e4d7705252c319697471a53bb20b3e1d9.png?mw=600"
                                    class="card-img" alt="..." />
                            </a>
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h5 class="card-title">
                                    Looks Like The Batman Is Going To Start Filming In The
                                    States
                                </h5>
                                <p class="card-text">Somebody light up the bat-Signal</p>
                                <p class="card-text">
                                    <small class="text-muted">Last updated 3 mins ago</small>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-3 col-12 d-block d-sm-none">
                    <div class="row no-gutters">
                        <div class="col-md-4">
                            <a href="UnaNoticia.jsp" target="_blank">
                                <img src="https://img.cinemablend.com/cdn-cgi/image/fit=cover,w=1500,h=1500//quill/2/8/d/5/b/1/28d5b1bea85d197f30133ddbe567c8cb30f3f230.png"
                                    class="card-img" alt="..." />
                            </a>
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h5 class="card-title">
                                    One Matrix 4 Star Really Wants To Join Keanu Reeves In John
                                    Wick
                                </h5>
                                <p class="card-text">
                                    This trend will continue with Lana Wachowski's The Matrix 4,
                                    which will feature the return of a group of actors
                                </p>
                                <p class="card-text">
                                    <small class="text-muted">Last updated 3 mins ago</small>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>





    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
        crossorigin="anonymous"></script>

    <script src="jquery/jquery.js"></script>
    <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>