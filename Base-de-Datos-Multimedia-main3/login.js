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
                success: function(data) {
                    //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                    alert(data);

                    console.log(Usuario.values(data));
                    var objectLength = Usuario.keys(data).length;
                    for (let index = 0; index < objectLength; index++) {
                        $(".product-list").append(
                            "<div class='product'><p>" + Object.values(data[index].p_name).join("") + "</p><p>" +
                            Usuario.values(data[index].p_detail).join("") + "</p><p>$" +
                            Usuario.values(data[index].p_price).join("") + "</p><button class='btnEliminar'>Eliminar<p class='ID' style='visibility: hidden; display: none;'>" +
                            Usuario.values(data[index].id_product).join("") +
                            "</p></button></div>");
                    }
                },
                error: function(x, y, z) {
                    alert("Error en webservice: " + x + y + z);
                },
            });
        }
    });
});