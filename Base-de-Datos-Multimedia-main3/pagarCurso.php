<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pago de curso</title>
    <!-- 
        
        <link rel="stylesheet" href="css/bootstrap.css" />

        
    -->
    <link rel="stylesheet" href="bootstrap/bootstrap.css" />

    <link rel="stylesheet" href="pagarCurso.css" />
</head>
<body>
    <div class="container">
        <!--Letras -->
        <h1 class="Subtitles">Inscripción</h1>
        <!-- icono -->
        <div class="icono">
            
            <img class="icon" src="recursos/HiramiSVG_02.svg" alt="error-en-al-capa-8">
        </div>
      <!-- form-->

    </div>

    <div class="container peque">
      <form class="form-signin">
      
        <div class="form-label-group">
            <label id="primerLabel" for="">Nombre del curso: php</label><br><br>
            <label for="">Cantidad de niveles: 6</label><br><br>
            
            <p>Este curso cuenta con los primeros 3 niveles completamente gratis. No pierdas tiempo y aprende 
                desarrollo web ahora mismo. 
            </p><br>

            <label for="">Costo del curso: $5,000</label><br><br>

            <div class="metodosPago">
                <label>Método de pago</label><br>
                <input type="radio" id="VISA" name="metodoPago" value="VISA">
                <img class="imgMetodoPago" for="VISA" src="https://logos-marcas.com/wp-content/uploads/2020/04/Visa-Logo.png" alt="VISA">
                <label for="VISA">VISA</label><br>
                <input type="radio" id="MasterCard" name="metodoPago" value="MasterCard">
                <img class="imgMetodoPago" for="VISA" src="https://upload.wikimedia.org/wikipedia/commons/7/72/MasterCard_early_1990s_logo.png" alt="MasterCard">
                <label for="MasterCard">MasterCard</label><br>
                <input type="radio" id="PayPal" name="metodoPago" value="PayPal">
                <img class="imgMetodoPago" for="VISA" src="https://www.eneba.com/blog/wp-content/uploads/2020/12/paypal_mb8k.png" alt="PayPal">
                <label for="PayPal">PayPal</label>
            </div><br>

            <label for="input">Número de cuenta</label>
            <input type="text" id="input" class="form-control" placeholder="" required required>
           
        </div>
        
        <button   class="btn btn-lg btn-primary btn-block" type="submit">Confirmar pago</button>
        
        <p class="mt-5 mb-3 text-muted text-center">&copy;Hiromi 2017-2021</p>
      </form>

    </div>


    <script src="jquery/jquery.js"></script>
    <script src="bootstrap/bootstrap.min.js"></script>
  </body>
</html>
