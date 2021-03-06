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
    <script type="text/javascript">
        function pasarNivel(){
            var dataToSend = {
                action: "pasarNivel",
            };

            //var objetoEnJSON = JSON.stringify(sendProduct);

            //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

            $.ajax({
                //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
                url: "user.php",
                async: true,
                type: "POST",
                data: dataToSend,
                
                success: function(data) {
                    //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                    alert("nivel superado");         
                        
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
                //alert("yendo a "+valor);

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

    <!--///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////Contenido de curso////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <div class="contenidoCurso">
        <div class="tituloCurso">
            <div class="nombreCurso" id="nombreCurso">
            
            </div>
            <div class="categoriaCurso" id="categoriaCurso">
                
            </div>
        </div>
        <!--imagen-->
        <center>
            <div class="imgCurso" id="imgCurso">
            
            </div>
        </center>
        <!--texto de descripcion-->
        <div class="descCurso" id="descCurso">
            
        </div>
        <!--cuadros/botones-->
        <div class="nivelesCurso">
            <div class="nivelCurso">
                <h3 class="nivelCurso">Niveles</h3>
            </div>
            <div class="losNiveles">
                <center>
                    <!-- <button class="btnNivel" id="btn1">Nivel 1</button> -->
                    
                </center>
            </div>
            <div class="crearCurso">
                <center>
                    <div id="botonCrearNivel">
                    
                    </div>
                </center>
            </div>
        </div>

        <!--video-->

        <center>
        <div id="videoCurso">
        
        </div>
            
        </center>


        <!--boton inscribirse-->
        <center>
            <div id="inscripcionCurso" class="inscripcionCurso">
                
                <a href="pagarCurso.php">
                    <button class="btnInscripcion">
                        Inscribirse
                    </button>
                </a>
                
            </div>
        </center>

        <!--///////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////Niveles del curso/////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////-->
        
        <div class="contenerdorInfoNiveles" id="contenerdorInfoNiveles">
        
        </div>

        <div class="comentariosCurso" id="comentariosCurso">
            <h1 id="comentCurso">Comentarios</h1>
            <div class="comentariosEnCurso" id="comentariosEnCurso">
            
            </div>
        </div>


    </div>

    

    <script type="text/javascript">


        function verificaEstudianteCursando(){
                var dataToSend = {
                    action: "verificaEstudianteEnCurso",
                };

                 //var objetoEnJSON = JSON.stringify(sendProduct);

                //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

                $.ajax({
                    //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
                    url: "user.php",
                    async: true,
                    type: "POST",
                    data: dataToSend,
                    dataType: 'json',
                    success: function(data) {
                        //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                        //alert("Se cargo boton de inscribir");

                        console.log(Object.values(data));
                        
                        if(data != ""){
                            document.getElementById("inscripcionCurso").style.visibility = "hidden";

                            console.log(Object.values(data));
                            var objectLength = Object.keys(data).length;

                            var numNivel = 1;

                            for (let index = 0; index < Object.values(data[index].nivelCursado).join(""); index++) {
                                
                                if(numNivel == Object.values(data[index].nivelCursado)){
                                    if(1 == Object.values(data[index].ultimoNivel)){
                                        $("#contenerdorInfoNiveles").append("<div class='niveldeCurso'><h1 id='numNivel'>Nivel " + numNivel + "</h1><h1 id='nombreNivel'>"+ Object.values(data[index].nombreNivel).join("") +"</h1><p>"+ Object.values(data[index].descripcionNivel).join("") + "</p><center><iframe width='560' height='315' src='uploads/"+ Object.values(data[index].videoNivel).join("") + "' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe><br></center><br><center><a href='uploads/"+ Object.values(data[index].archivoNivel).join("") +"' target='_blank' style='font-size: larger; color: darkblue; font-weight: bold;'>Contenido del curso</a></center><br><br><div><center><a href='evaluarCurso.php'><button class='finalizarNivel btn-primary' id='finalizarNivel' onclick='pasarNivel()'>Finalizar nivel</button></a></center></div><br></div>");
                                    }
                                    else{
                                        $("#contenerdorInfoNiveles").append("<div class='niveldeCurso'><h1 id='numNivel'>Nivel " + numNivel + "</h1><h1 id='nombreNivel'>"+ Object.values(data[index].nombreNivel).join("") +"</h1><p>"+ Object.values(data[index].descripcionNivel).join("") + "</p><center><iframe width='560' height='315' src='uploads/"+ Object.values(data[index].videoNivel).join("") + "' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe><br></center><br><center><a href='uploads/"+ Object.values(data[index].archivoNivel).join("") +"' target='_blank' style='font-size: larger; color: darkblue; font-weight: bold;'>Contenido del curso</a></center><br><br><div><center><a href='curso.php'><button class='finalizarNivel btn-primary' id='finalizarNivel' onclick='pasarNivel()'>Finalizar nivel</button></a></center></div><br></div>");
                                    }
                                }
                                else{
                                    $("#contenerdorInfoNiveles").append("<div class='niveldeCurso'><h1 id='numNivel'>Nivel " + numNivel + "</h1><h1 id='nombreNivel'>"+ Object.values(data[index].nombreNivel).join("") +"</h1><p>"+ Object.values(data[index].descripcionNivel).join("") + "</p><center><iframe width='560' height='315' src='uploads/"+ Object.values(data[index].videoNivel).join("") + "' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe><br></center><br><center><a href='uploads/"+ Object.values(data[index].archivoNivel).join("") +"' target='_blank' style='font-size: larger; color: darkblue; font-weight: bold;'>Contenido del curso</a></center><br><br><br></div>");
                                    
                                }
                                
                    
                                numNivel += 1;
                            }
                        }
                            
                        
                    },
                    error: function(x, y, z) {
                        alert("Error en webservice: " + x + y + z);
                    },
                });
            }
        
        
        if("<?php echo $_SESSION['rol'] ?>" == "estudiante"){
            //alert("si es estudiante");
            verificaEstudianteCursando();
        }
        else{
            document.getElementById("inscripcionCurso").style.visibility = "hidden";
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
</body>

</html>