
$(document).ready(function () {
   
    function validateContra(contrasena){
        var hayMayuscula = false;
        var haySimbolo = false;
        var hayNumero = false;
         
        input=contrasena;
        if (input.length >= 8){
            const pattern = new RegExp('^[A-Z]+$');
            const pattern2 = new RegExp('^[0-9]+$');
            //const pattern3 = new RegExp('^[¡”#$%&/=’?¡¿:;,.-_+*{}]+$');

            for(var i = 0; i<input.length; i++){
                var ch = input.charAt(i);
                if(pattern.test(ch)){ 
                    hayMayuscula = true;
                }
                if(pattern2.test(ch)){
                    hayNumero = true;
                }
                if(ch == "¡" || ch == "#" || ch == "$" || ch == "%" || ch == "&" || ch == "/" || ch == "=" || 
                    ch == "´" || ch == "?" || ch == "¿" || ch == "!" || ch == ":" || ch == ";" || ch == "," || 
                    ch == "." || ch == "+" || ch == "-" || ch == "_" || ch == "{" || ch == "}" || ch == "[" || 
                    ch == "]")
                    {
                    haySimbolo = true;
                }
            }
            if(hayMayuscula != true || haySimbolo != true || hayNumero != true){
                alert("Por cuestiones de seguridad, la contraseña debe tener al menos una letra mayuscula, un número y uno de los siguientes simbolos ¡”#$%&/=’?¡¿:;,.-_+*{][}");
                return false;
            }
            else{
                return true;
            }  
        }
        else {
            return false;
        }
    }

    function validateContra2(contrasena1, contrasena2){
         
        if (contrasena2 != contrasena1){
            return false;
        }else {
            return true;
        }
    }

    function validateAlfabeto(temp){
        var esAlfabeto = true;
        for(var i = 0; i<temp.length; i++){
            var ch = temp.charAt(i);
            const pattern = new RegExp('^[A-Z]+$', 'i');
            if(!pattern.test(ch)){ 
                // Si queremos agregar letras acentuadas y/o letra ñ debemos usar
                // codigos de Unicode (ejemplo: Ñ: \u00D1  ñ: \u00F1)
                esAlfabeto = false;
            } 
        }

        if(esAlfabeto == true){
            //alert("si son letras")
            return true;
        }
        else{
            //alert("no son letras")
            return false;
        }
    }

    function validarTel(tel){
        var esNumero = true;
        for(var i = 0; i<tel.length; i++){
            var num = tel.charAt(i);
            if(num != 0 && num != 1 && num != 2 && num != 3 && num != 4 && num != 5 && num != 6 && num != 7 
                && num != 8 && num != 9){
                esNumero = false;
            }
        }

        if(esNumero == true){
            return true;
        }
        else{
            return false;
        }
    }

    $("#Registrarse").click(function () {
        //alert("todo bien");
        var UnError = false


        // obteniendo los valores
        if($('input:radio[name=tipo_usuario]:checked').val() != ""){
            if($("#inputNombre").val() != ""){
                if($("#inputApellidoP").val() != ""){
                    if($("#inputApellidoM").val() != ""){
                        if($("#inputPassword").val() != ""){
                            if($("#inputPassword2").val() != ""){
                                if($("#ElEmail").val() != ""){
                                    if($("#inputTel").val() != ""){
                                        if($("#inputNombreUsuario").val() != ""){
                                            var tipo_usuario = $('input:radio[name=tipo_usuario]:checked').val();
                                            var nombre = $("#inputNombre").val();
                                            var apellidoP = $("#inputApellidoP").val();
                                            var apellidoM = $("#inputApellidoM").val();
                                            var correo = $("#ElEmail").val();
                                            var contrasena = $("#inputPassword").val();
                                            var contrasena2 = $("#inputPassword2").val();
                                            var tel = $("#inputTel").val();
                                            var nombreUsuario = $("#inputNombreUsuario").val();

                                            if(validateAlfabeto(nombre)){
                                                if(validateAlfabeto(apellidoP)){
                                                    if(validateAlfabeto(apellidoM)){
                                                        if (validateContra(contrasena)) {
                                                            if(validateContra2(contrasena,contrasena2)){
                                                                if(validarTel(tel)){
                                                                    alert("Bien, los datos han sido capturados correctamente")

                                                                    var usuario = new Usuario(tipo_usuario, nombre, apellidoP, apellidoM, contrasena, correo, tel);	

                                                                    /*if (!usuario.isValid()) {
                                                                        alert("Faltan datos.");
                                                                        return;			
                                                                    }*/	
					
                                                                    sendUsuario(usuario);

                                                                    //clearDataSignUp();

                                                                }
                                                                else{
                                                                    alert("El numero telefonico solamente acepta caracteres numéricos");
                                                                }
                                                            }
                                                            else{
                                                                alert("No coincide la contraseña de verificación.");
                                                            }
                                                        }
                                                        else{
                                                            alert("La contraseña no tiene el formato correcto.");
                                                        }
                                                    }
                                                    else{
                                                        alert("Los apellidos no deben contener caracteres no alfabéticos.");
                                                    }
                                                }
                                                else{
                                                    alert("Los apellidos no deben contener caracteres no alfabéticos.");
                                                }
                                            }
                                            else{
                                                alert("El nombre no debe contener caracteres no alfabéticos.");
                                            }
                                        }
                                        else{
                                            alert("Debes llenar los campos requeridos.");
                                        }
                                    }
                                    else{
                                        alert("Debes llenar los campos requeridos.");
                                    }
                                }
                                else{
                                    alert("Debes llenar los campos requeridos.");
                                }
                            }
                            else{
                                alert("Debes llenar los campos requeridos.");
                            }
                        }
                        else{
                            alert("Debes llenar los campos requeridos.");
                        }
                    }
                    else{
                        alert("Debes llenar los campos requeridos.");
                    }
                }
                else{
                    alert("Debes llenar los campos requeridos.");
                }
            }
            else{
                alert("Debes llenar los campos requeridos.");
            }
        }
        else{
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
            };

            //var objetoEnJSON = JSON.stringify(sendProduct);

            //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

            $.ajax({
                //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
                url: "user.php",
                async: true,
                type: 'POST',
                data: dataToSend,
                success: function (data){
                    //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                    alert(data);
                },
                error: function(x,y,z){
                    alert("Error en webservice: " + x + y + z);
                }
            });
        }
        
    });


});
