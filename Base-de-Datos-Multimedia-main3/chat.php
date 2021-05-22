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
    <link rel="stylesheet" href="CSS/chat.css">

    <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="chat.js"></script>

    <script type="text/javascript">

        function crearChat(valor){
            
        }

        function crearMensaje(){
            
                if($("#mensajeEnviar").val() != ""){
                    var mensaje1 = $("#mensajeEnviar").val();

                    mandaMensaje(mensaje1);

                
                }
                else{
                    alert ("No escribiste un mensaje.")
                }
            
            
        }

        function establecerChat(valor){
            // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "establecerChat",
            idChat: valor,
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "chats.php",
            async: true,
            type: "POST",
            data: dataToSend,
            dataType: 'json',
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Se cargaron los mensajes");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;
                
                $(".datosDelContacto div").remove();
                $(".mensajes div").remove();
                
                var yaestanombre = false;
                

                for (let index = 0; index < objectLength; index++) {

                    if(yaestanombre == false && "<?php echo $_SESSION["email"] ?>" != Object.values(data[index].email1).join("") && "<?php echo $_SESSION["contrasena"] ?>" != Object.values(data[index].contra1).join("")){
                        $(".datosDelContacto").append("<div class='datosDelOtro'><img src='uploads/"+ Object.values(data[index].foto1).join("") +"' alt='foto'><label class='nombreDelContacto' id='nombreDelContacto' for=''>" + Object.values(data[index].nombre1).join("") + " "+ Object.values(data[index].apellidoPat1).join("") + " "+ Object.values(data[index].apellidoMat1).join("") +"</label></div>");
                        yaestanombre = true;
                    }

                    if(Object.values(data[index].email1).join("") != "<?php echo $_SESSION["email"] ?>" && Object.values(data[index].contra1).join("") != "<?php echo $_SESSION["contrasena"] ?>"){
                        $(".mensajes").append("<div class='divmensaje' style='text-align: right;'><label class='contacto' for='' style='background-color: #6495ED;'>"+ Object.values(data[index].mensaje).join("") +"</label></div><br>");
                    }
                    else{
                        $(".mensajes").append("<div class='divmensaje' style='text-align: left;'><label class='contacto' for='' style='background-color: #8FBC8F;'>"+ Object.values(data[index].mensaje).join("") +"</label></div><br>");
                    }
                }

            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
        }

        function mandaMensaje(mensaje1){
            // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "mandaMensaje",
            mensaje: mensaje1,
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
                alert("Se mando el mensaje");

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


    <div class="seccion-completa">
        <div class="chatsContactos">
            <div class="buscarContacto">
                <form class="form-inline my-2 my-lg-0">
                    <input id="stringaBuscar" class="form-control mr-sm-2" type="search" placeholder="Buscar usuarios..." aria-label="search" />

                    <button id="btnBuscar" class="btn btn-primary uni">
                        <i class="fas fa-search uni"></i>
                    </button>
                </form>
            </div>

            <div class="contactosBuscados" id="contactosBuscados">
                
            </div>

            <label for="" class="labelcontactos">Contactos</label>

            <div class="contactosEstablecidos" id="contactosEstablecidos">
                
            </div>
            
        </div>

        <div class="chatActual">
            <div class="datosDelContacto" id="datosDelContacto">
                
            </div>
            <div class="mensajes" id="mensajes">
               
            </div>
            <div class="opcionesMensaje" id="opcionesMensaje">
                <input id="mensajeEnviar" for="" placeholder="Mensaje a enviar..."></input>
                <button class='btnEnviar' id='btnEnviar' onclick="crearMensaje()">Enviar</button>
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