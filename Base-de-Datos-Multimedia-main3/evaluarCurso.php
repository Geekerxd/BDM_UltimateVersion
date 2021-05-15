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
    <link rel="stylesheet" href="CSS/evaluarCurso.css">

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
    <script type="text/javascript" src="js/comentarioCurso.js"></script>
    <script type="text/javascript" src="evaluarCurso.js"></script>
    
    
</head>

<body>

<div class="container">
        <!--Letras -->
        <h1 class="Subtitles">¡Felicidades!</h1>
        <!-- icono
        <div class="icono">
            <img class="icon" src="Assets/KineCineNaranja.png" alt="error-en-al-capa-8" />
        </div>
        -->
        <div class="icono">

            <img class="icon" src="recursos/HiramiSVG_02.svg" alt="error-en-al-capa-8">
        </div>

        <div class="info">
            <h4>Has concluido el curso</h4>
            <div class="nombreCurso" id="nombreCurso">
                
            </div>
            <h4>y se te ha otorgado un diploma que podrás consultar en tu historial.</h4><br>
            
            <label for="" class="renglon"></label><br><br>

            <h4>¡Ahora te toca a ti! Evalúanos para saber tu opinión sobre el curso.</h4><br>
            

            <h4>¿Qué te pareció la integridad del curso?</h4><br>
            
            <div class="evaluacion" id="evaluacion">
                <form action="">

                    <div class="calificacion" id="calificacion">
                        <input type="radio" id="Excelente" name="calificacion" value=100.0>
                        <label for="Excelente">Excelente</label><br>

                        <input type="radio" id="Muy bueno" name="calificacion" value=80.0>
                        <label for="Muy bueno">Muy bueno</label><br>

                        <input type="radio" id="Bueno" name="calificacion" value=60.0>
                        <label for="Bueno">Bueno</label><br>

                        <input type="radio" id="Regular" name="calificacion" value=40.0>
                        <label for="Regular">Regular</label><br>

                        <input type="radio" id="Malo" name="calificacion" value=20.0>
                        <label for="Malo">Malo</label><br>

                        <input type="radio" id="Deficiente" name="calificacion" value=0>
                        <label for="Deficiente">Deficiente</label><br>
                    </div>

                    <div class="comentario" id="comentario">
                        <input class="comentarioCurso" id="comentarioCurso" type="text" placeholder="Deja aqui tu comentario sobre el curso">
                    </div>

                    <div class="linkEnviar">
                        <a href="curso.php" >
                        <button class="btnEnviar btn-primary" id="btnEnviar">
                            Enviar
                        </button>
                        </a>
                    </div>
                    

                </form>
            </div>
        </div>

</div>

    




    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
</body>

</html>