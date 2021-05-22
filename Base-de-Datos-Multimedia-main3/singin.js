
$(document).ready(function () {

    /*
    
    
        function statusChangeCallback(response) {  // Called with the results from FB.getLoginStatus().
            console.log('statusChangeCallback');
            console.log(response);                   // The current login status of the person.
            if (response.status === 'connected') {   // Logged into your webpage and Facebook.
                testAPI();
            } else {                                 // Not logged into your webpage or we are unable to tell.
                document.getElementById('status').innerHTML = 'Please log ' +
                    'into this webpage.';
            }
        }
    
    
        function checkLoginState() { 
            
            
            
            
            
            // Called when a person is finished with the Login Button.
            FB.getLoginStatus(function (response) {   // See the onlogin handler
                statusChangeCallback(response);
            });
        }
    
    
        window.fbAsyncInit = function () {
            FB.init({
                appId: '220548132908778',
                cookie: true,                     // Enable cookies to allow the server to access the session.
                xfbml: true,                     // Parse social plugins on this webpage.
                version: 'v2.9'           // Use this Graph API version for this call.
            });
    
    
            FB.getLoginStatus(function (response) {   // Called after the JS SDK has been initialized.
                statusChangeCallback(response);        // Returns the login status.
            });
        };
    
        function testAPI() {                      // Testing Graph API after login.  See statusChangeCallback() for when this call is made.
            console.log('Welcome!  Fetching your information.... ');
            FB.api('/me', function (response) {
                console.log('Successful login for: ' + response.name);
                document.getElementById('status').innerHTML =
                    'Thanks for logging in, ' + response.name + '!';
            });
        }
    
    */
        var app_id = '220548132908778';
        var scopes = 'email, public_profile';
    
        var btn_login = '<a href="#" id="login" class="btn btn-primary">Iniciar sesión</a>';
    
        var div_session = "<div id='facebook-session'>"+
                          "<strong></strong>"+
                          "<img>"+
                          "<a href='#' id='logout' class='btn btn-danger'>Cerrar sesión</a>"+
                          "</div>";
    
        window.fbAsyncInit = function() {
    
              FB.init({
                appId      : app_id,
                status     : true,
                cookie     : true, 
                xfbml      : true, 
                version    : 'v2.1'
              });
    
    
              FB.getLoginStatus(function(response) {
                statusChangeCallback(response, function() {});
              });
          };
    
          var statusChangeCallback = function(response, callback) {
              console.log(response);
               
            if (response.status === 'connected') {
                  getFacebookData();
            } else {
                 callback(false);
            }
          }
    
          var checkLoginState = function(callback) {
            FB.getLoginStatus(function(response) {
                  callback(response);
            });
          }
    
          var getFacebookData =  function() {
              FB.api('/me', function(response) {
                  $('#login').after(div_session);
                  $('#login').remove();
                 
                  document.getElementById("inputNombre").value = response.name;

                  alert("tus datos:  "+response.first_name+" "+response.last_name+" "+response.middle_name+" "+response.name+" "+response.name_format+" "+response.picture+" "+response.short_name)
                  //$('#facebook-session img').attr('src','http://graph.facebook.com/'+response.id+'/picture?type=large');
              });
          }
    
          var facebookLogin = function() {
              checkLoginState(function(data) {
                  if (data.status !== 'connected') {
                      FB.login(function(response) {
                          if (response.status === 'connected')
                              getFacebookData();
                      }, {scope: scopes});
                  }
              })
          }
    
          var facebookLogout = function() {
              checkLoginState(function(data) {
                  if (data.status === 'connected') {
                    FB.logout(function(response) {
                        $('#facebook-session').before(btn_login);
                        $('#facebook-session').remove();
                    })
                }
              })
    
          }
    
    
    
          $(document).on('click', '#login', function(e) {
              e.preventDefault();
    
              facebookLogin();
          })
    
          $(document).on('click', '#logout', function(e) {
              e.preventDefault();
    
              if (confirm("¿Está seguro?"))
                  facebookLogout();
              else 
                  return false;
          })
    
    ///////////////// FCAEBOOK



    /*$("#imageInput").on('change', function(){
        var file = this.files[0], formData = new FormData(), formData.append('file',file);
        alert (file);
    });*/

    //var file = new FormData();

    /*$("#inputImagen").change(function(e){
        file = e.target.files[0];
    });*/

    function validateContra(contrasena) {
        var hayMayuscula = false;
        var haySimbolo = false;
        var hayNumero = false;

        input = contrasena;
        if (input.length >= 8) {
            const pattern = new RegExp('^[A-Z]+$');
            const pattern2 = new RegExp('^[0-9]+$');
            //const pattern3 = new RegExp('^[¡”#$%&/=’?¡¿:;,.-_+*{}]+$');

            for (var i = 0; i < input.length; i++) {
                var ch = input.charAt(i);
                if (pattern.test(ch)) {
                    hayMayuscula = true;
                }
                if (pattern2.test(ch)) {
                    hayNumero = true;
                }
                if (ch == "¡" || ch == "#" || ch == "$" || ch == "%" || ch == "&" || ch == "/" || ch == "=" ||
                    ch == "´" || ch == "?" || ch == "¿" || ch == "!" || ch == ":" || ch == ";" || ch == "," ||
                    ch == "." || ch == "+" || ch == "-" || ch == "_" || ch == "{" || ch == "}" || ch == "[" ||
                    ch == "]") {
                    haySimbolo = true;
                }
            }
            if (hayMayuscula != true || haySimbolo != true || hayNumero != true) {
                alert("Por cuestiones de seguridad, la contraseña debe tener al menos una letra mayuscula, un número y uno de los siguientes simbolos ¡”#$%&/=’?¡¿:;,.-_+*{][}");
                return false;
            }
            else {
                return true;
            }
        }
        else {
            return false;
        }
    }

    function validateContra2(contrasena1, contrasena2) {

        if (contrasena2 != contrasena1) {
            return false;
        } else {
            return true;
        }
    }

    function validateAlfabeto(temp) {
        var esAlfabeto = true;
        for (var i = 0; i < temp.length; i++) {
            var ch = temp.charAt(i);
            const pattern = new RegExp('^[A-Z]+$', 'i');
            if (!pattern.test(ch)) {
                // Si queremos agregar letras acentuadas y/o letra ñ debemos usar
                // codigos de Unicode (ejemplo: Ñ: \u00D1  ñ: \u00F1)
                esAlfabeto = false;
            }
        }

        if (esAlfabeto == true) {
            //alert("si son letras")
            return true;
        }
        else {
            //alert("no son letras")
            return false;
        }
    }

    function validarTel(tel) {
        var esNumero = true;
        for (var i = 0; i < tel.length; i++) {
            var num = tel.charAt(i);
            if (num != 0 && num != 1 && num != 2 && num != 3 && num != 4 && num != 5 && num != 6 && num != 7
                && num != 8 && num != 9) {
                esNumero = false;
            }
        }

        if (esNumero == true) {
            return true;
        }
        else {
            return false;
        }
    }

    $("#Registrarse").click(function () {
        //alert("todo bien");
        var UnError = false


        // obteniendo los valores
        if ($('input:radio[name=tipo_usuario]:checked').val() != "") {
            if ($("#inputNombre").val() != "") {
                if ($("#inputApellidoP").val() != "") {
                    if ($("#inputApellidoM").val() != "") {
                        if ($("#inputPassword").val() != "") {
                            if ($("#inputPassword2").val() != "") {
                                if ($("#ElEmail").val() != "") {
                                    if ($("#inputTel").val() != "") {
                                        if ($("#inputNombreUsuario").val() != "") {





                                            var tipo_usuario = $('input:radio[name=tipo_usuario]:checked').val();
                                            var nombre = $("#inputNombre").val();
                                            var apellidoP = $("#inputApellidoP").val();
                                            var apellidoM = $("#inputApellidoM").val();
                                            var correo = $("#ElEmail").val();
                                            var contrasena = $("#inputPassword").val();
                                            var contrasena2 = $("#inputPassword2").val();
                                            var tel = $("#inputTel").val();
                                            var nombreUsuario = $("#inputNombreUsuario").val();
                                            //var fileFoto = file;

                                            if (validateAlfabeto(nombre)) {
                                                if (validateAlfabeto(apellidoP)) {
                                                    if (validateAlfabeto(apellidoM)) {
                                                        if (validateContra(contrasena)) {
                                                            if (validateContra2(contrasena, contrasena2)) {
                                                                if (validarTel(tel)) {
                                                                    alert("Bien, los datos han sido capturados correctamente")

                                                                    var usuario = new Usuario(tipo_usuario, nombre, apellidoP, apellidoM, contrasena, correo, tel);

                                                                    /*if (!usuario.isValid()) {
                                                                    alert("Faltan datos.");
                                                                    return;			
                                                                    }*/

                                                                    sendUsuario(usuario);

                                                                    //clearDataSignUp();

                                                                }
                                                                else {
                                                                    alert("El numero telefonico solamente acepta caracteres numéricos");
                                                                }
                                                            }
                                                            else {
                                                                alert("No coincide la contraseña de verificación.");
                                                            }
                                                        }
                                                        else {
                                                            alert("La contraseña no tiene el formato correcto.");
                                                        }
                                                    }
                                                    else {
                                                        alert("Los apellidos no deben contener caracteres no alfabéticos.");
                                                    }
                                                }
                                                else {
                                                    alert("Los apellidos no deben contener caracteres no alfabéticos.");
                                                }
                                            }
                                            else {
                                                alert("El nombre no debe contener caracteres no alfabéticos.");
                                            }

                                        }
                                        else {
                                            alert("Debes llenar los campos requeridos.");
                                        }
                                    }
                                    else {
                                        alert("Debes llenar los campos requeridos.");
                                    }
                                }
                                else {
                                    alert("Debes llenar los campos requeridos.");
                                }
                            }
                            else {
                                alert("Debes llenar los campos requeridos.");
                            }
                        }
                        else {
                            alert("Debes llenar los campos requeridos.");
                        }
                    }
                    else {
                        alert("Debes llenar los campos requeridos.");
                    }
                }
                else {
                    alert("Debes llenar los campos requeridos.");
                }
            }
            else {
                alert("Debes llenar los campos requeridos.");
            }
        }
        else {
            alert("Es requisito seleccionar el tipo de usuario que eres.");
        }

        function sendUsuario(usuario) {
            // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
            var dataToSend = {
                action: "addUser",
                rol: usuario.rol,
                nombre: usuario.nombre,
                apellidoPat: usuario.apellidoPat,
                apellidoMat: usuario.apellidoMat,
                contrasena: usuario.contrasena,
                email: usuario.email,
                telefono: usuario.telefono,
                foto: usuario.foto,
            };

            //var objetoEnJSON = JSON.stringify(sendProduct);

            //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

            $.ajax({
                //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
                url: "user.php",
                async: true,
                type: 'POST',
                data: dataToSend,
                success: function (data) {
                    //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                    alert(data);
                },
                error: function (x, y, z) {
                    alert("Error en webservice: " + x + y + z);
                }
            });
        }

    });
    /*
        $("#Iniciaface").click(function () {
    
    
            //  e.preventDefault();
    
            facebookLogin();
            alert("inicia con facebook");
        });
    */
    $(document).on('click', '#SalirFace', function (e) {

        e.preventDefault();

        facebookLogin();
        alert("inicia con facebook");

    })

    $("#logout").click(function () {


        //  e.preventDefault();

        facebookLogout();
        alert("se sale de face");
    });
});
