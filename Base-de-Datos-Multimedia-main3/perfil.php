<?php
// Initialize the session
session_start();


?>

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
    <link rel="stylesheet" href="CSS/perfil.css">
    <link rel="stylesheet" href="CSS/historial.css">

    <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="js/usuario.js"></script>
    <script type="text/javascript" src="perfil.js"></script>

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

    <?php
    if (isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true) {
        echo "Tipo: " . $_SESSION['rol'] . " Contrasena: " . $_SESSION['contrasena'] . " correo: " . $_SESSION['email'] . " foto: " . $_SESSION['fotoUser'];
    }

    ?>

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


    <div class="container">
        <div class="container2" style="background-color: #ffffff">



            <div>

                <img class="card-img-top" src="https://assets.sensacine.com/skin/img/userprofile-cover-default-43b92a5c13.png" alt="Card image cap" />

            </div>




            <div id="espacioFoto2">

    
            </div>
            <div id="nombreDelUsuario">
            
            </div>
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                
                <li class="nav-item">
                    <a class="nav-link active" id="ajustes-tab" data-toggle="tab" href="#ajustes" role="tab" aria-controls="ajustes" aria-selected="false">Ajustes</a>
                </li>
            
                <li class="nav-item">
                    <a class="nav-link" id="inicio-tab" data-toggle="tab" href="#inicio" role="tab" aria-controls="inicio" aria-selected="true">Historial</a>
                </li>


                <li class="nav-item">
                    <a class="nav-link" id="cursos-tab" data-toggle="tab" href="#noticias" role="tab" aria-controls="noticias" aria-selected="false">Mis Cursos</a>
                </li>


                <li class="nav-item">
                    <a class="nav-link" id="noticias-tab" data-toggle="tab" href="#mensajes" role="tab" aria-controls="Mensajes" aria-selected="false">Mensajes</a>
                </li>



                <li class="nav-item">
                    <a class="nav-link" id="informacion-tab" data-toggle="tab" href="#informacion" role="tab" aria-controls="informacion" aria-selected="false">Información</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" id="LogOut-tab" data-toggle="tab" href="#LogOut" role="tab" aria-controls="LogOut" aria-selected="false">Salir</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" id="categoria-tab" data-toggle="tab" href="#categoria" role="tab" aria-controls="LogOut" aria-selected="false">Categoria</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade" id="inicio" role="tabpanel" aria-labelledby="inicio-tab">
                    <div class="container" style="margin-top: 50px">
                        <div id="main-news">
                        <h2 class="Subtitles">Historial</h2>
                            <div class="historial" id="seccion_historial">
                <!-- Tamaño PC-->

                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="noticias" role="tabpanel" aria-labelledby="noticias-tab">


                    <div class="totalVentas" id="totalVentas">
                        
                    </div>
                    <div id="divGestorCursos" class="divGestorCursos" >

                        <center>
                        <a href="crearCurso.php">
                            <button type="button" class="btnGestor btn-primary" id="gotogestor" style="margin-right: auto; margin-left: auto">
                                Gestor de Cursos
                            </button>
                        </a>
                        </center>

                    </div>



                </div>

                <div class="tab-pane fade" id="mensajes" role="tabpanel" aria-labelledby="noticias-tab">


                    <h3>Tus mensajes</h3>
                    <a href="chat.php">
                        <button type="button" class="btn btn-primary" id="gotogestor" style="margin-right: auto; margin-left: auto">
                            Ver mensajes
                        </button>


                    </a>




                </div>
                <div class="tab-pane fade" id="informacion" role="tabpanel" aria-labelledby="informacion-tab">

                    <form action="upload.php" method="POST" enctype="multipart/form-data">

                        <div class="form-group">
                            <label for="image">Cambiar foto de perfil:</label>
                            <input type="file" name="image" id="image" class="form-control" required>
                            <small id="emailHelp" class="form-text text-muted">Tamaño maximo de archivo 5 Mb.</small>
                        </div>
                        <input type="hidden" name="idUsuario" value="elId">

                        <div class="form-group">
                            <input id="btnEnviarFoto" type="submit" class="btn btn-primary" value="Actualizar imagen">
                            <!--<input type="submit" class="btn btn-primary" data-toggle="modal" data-target="#solicitudenviada" id="solicitar"value="Solicitar">-->
                        </div>
                    </form>

                </div>



                <div class="tab-pane fade show active" id="ajustes" role="tabpanel" aria-labelledby="ajustes-tab">
                    <form class="ajustes">
                        
                        
                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-2 col-form-label">Nombre</label>
                            <div class="col-sm-10" id="InfoNombre1">
                                
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-2 col-form-label">Apellido paterno</label>
                            <div class="col-sm-10" id="InfoApellidoPat1">
                                
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-2 col-form-label">Apellido materno</label>
                            <div class="col-sm-10" id="InfoApellidoMat1">
                                
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label for="colFormLabel" class="col-sm-2 col-form-label">Email</label>
                            <div class="col-sm-10" id="inputInfoEmail1">
                                
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="colFormLabel" class="col-sm-2 col-form-label">Telefono</label>
                            <div class="col-sm-10" id="inputInfoTelefono1">
                                
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-2 col-form-label">Nueva Contraseña</label>
                            <div class="col-sm-10" id="inputInfoContrasena1">
                                <input type="password" class="form-control" id="inputInfoContrasena" placeholder="Contraseña" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-2 col-form-label">Confirmar Contraseña</label>
                            <div class="col-sm-10" id="inputInfoContrasena21">
                                <input type="password" class="form-control" id="inputInfoContrasena2" placeholder="Contraseña" />
                            </div>
                        </div>
                    </form>
                    <button id="btnModificar" type="submit" class="btn btn-primary">Guardar</button>
                </div>

                <div class="tab-pane fade" id="LogOut" role="tabpanel" aria-labelledby="LogOut-tab">

                    <a href="logout.php" class="btn btn-danger ml-3">Sign Out of Your Account</a>




                </div>

                <div class="tab-pane fade" id="categoria" role="tabpanel" aria-labelledby="categoria-tab">

                    <a href="crearCategoria.php" id="abtncat">
                        <button type="button" class="btn btn-primary" id="gotogestor2" style="margin-right: auto; margin-left: auto">
                            Gestor de Categorias
                        </button>

                    </a>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var tipo_usuarioLogin = "<?php  echo $_SESSION['rol']; ?>";
        //alert (tipo_usuarioLogin);

        if(tipo_usuarioLogin == "estudiante"){
            
            document.getElementById("cursos-tab").style.visibility = "hidden";
            document.getElementById("categoria-tab").style.visibility = "hidden";
        }
        else{
            document.getElementById("inicio-tab").style.visibility = "hidden";
        }

        
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

    <!--<script src="jquery/jquery.js"></script> -->
    <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>