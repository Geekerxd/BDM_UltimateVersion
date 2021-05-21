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

    <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="categor.js"></script>

    <script type="text/javascript">
        function buscaCurso(idCurso1, idCreador1){

            // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
            var dataToSend = {
                action: "setCursoActual",
                idCurso: idCurso1,
            idCreador: idCreador1,
            };

                //var objetoEnJSON = JSON.stringify(sendProduct);

                //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

            $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "cursos.php",
            async: true,
            type: "POST",
            data: dataToSend,
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("yendo a "+valor);

            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

    function buscaCategor(valor){
            // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "setCatActual",
            idCat: valor,
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "categoria.php",
            async: true,
            type: "POST",
            data: dataToSend,
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("yendo a "+valor);

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
                        <div id="divirsorDropdown" class="dropdown-divider"></div>
                        <div id="categor">

                        </div>
                        
                        
                    </div>
                </li>

            </ul>

            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Buscar cursos..." aria-label="search" />

                <button class="btn btn-primary uni" type="submit">
                    <i class="fas fa-search uni"></i>
                </button>
            </form>

            <a id="btnlogin" href="Log-In.php" class="LogIn-text " style="color: #F29849; margin-left: 20px; ">
                Log In
            </a>

            <button id="btnsignin" type="button" class="btn btn-primary SignIn" style="margin-left: 15px; ">
                <a href="Sign-Up.php" style="color: white;">Sign In</a>

            </button>

            <a id="btnfotoperfil" href="perfil.php">
                
            </a>
        </div>
    </nav>



    <div class="secDescripcion">
        <div class="bienvenidoPrincipal">
            
        </div>

        
        <div class="imgDescripcion">
            <img src="https://indexdesarrollo.com/wp-content/uploads/2017/05/lenguajes-de-programacion-web.png"
                alt="imagen01">
            </img>
            <div class="descCat">

            </div>
            
        </div>


    </div>

    <div class="container" style="margin-top: 50px">
        <div id="main-news">
            <h2 class="Subtitles">Cursos de la categoria</h2>
            <div class="row">
            <div class="container_noticias" id="container-noticias">

            </div>
                


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


    <script type="text/javascript">
        
        var haysesion = "<?php if (isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){echo $_SESSION['loggedin'];} else{echo "false";}?>";
        //alert (tipo_usuarioLogin);

        if(haysesion == true){
            
            document.getElementById("btnfotoperfil").style.visibility = "show";

            document.getElementById("btnlogin").style.visibility = "hidden";
            document.getElementById("btnsignin").style.visibility = "hidden";
        }
        else{
            document.getElementById("btnfotoperfil").style.visibility = "hidden";

            document.getElementById("btnlogin").style.visibility = "show";
            document.getElementById("btnsignin").style.visibility = "show";
        }

    </script>



    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
        crossorigin="anonymous"></script>

    <script src="jquery/jquery.js"></script>
    <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>