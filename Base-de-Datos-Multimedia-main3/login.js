$(document).ready(function() {



    $("#btnLogin").click(function() {
        //alert("todo bien");
        var UnError = false;

        // obteniendo los valores
        if ($("input:radio[name=tipo_usuario]:checked").val() != "") {
            if ($("#inputPassword").val() != "") {
                if ($("#inputEmail").val() != "") {
                    var tipo_usuario = $("input:radio[name=tipo_usuario]:checked").val();
                    var correo = $("#inputEmail").val();
                    var contrasena = $("#inputPassword").val();
                    alert("Los datos de login estan siendo enviados");

                    var usuariologin = new UsuarioLogIn(tipo_usuario, contrasena, correo);

                    loginUsuario(usuariologin);

                } else {
                    alert("Debes llenar los campos requeridos.");
                }
            } else {
                alert("Debes llenar los campos requeridos.");
            }
        } else {
            alert("Es requisito seleccionar el tipo de usuario que eres.");
        }

        function loginUsuario(usuariologin) {

            var tipoUsuarioLogin;

            // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
            var dataToSend = {
                action: "getUser",
                rol: usuariologin.rol,
                contrasena: usuariologin.contrasena,
                email: usuariologin.email,
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
                    if (data != null){
                        alert("Ingreso el usuario.");
                    }
                    else{
                        alert("Hubo un error al iniciar sesion, cierre sesion y vuelva a ingresar.");
                    }

                    
                },
                error: function(x, y, z) {
                    alert("Error en webservice: " + x + y + z);
                },
            });
        }
    });
});