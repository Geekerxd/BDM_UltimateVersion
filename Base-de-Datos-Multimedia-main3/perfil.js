$(document).ready(function(){

    cargaInfoUsuario();

    $("#btnModificar").click(function(){
        if($("#inputInfoNombre").val() != ""){
            if($("#inputInfoApellidoPat").val() != ""){
                if($("#inputInfoApellidoMat").val() != ""){
                    if($("#inputInfoEmail").val() != ""){
                        if($("#inputInfoTelefono").val() != ""){
                            if($("#inputInfoContrasena").val() != ""){
                                if($("#inputInfoContrasena2").val() != ""){

                                    var modificarNombre = $("#inputInfoNombre").val();
                                    var modificarApellidoPat = $("#inputInfoApellidoPat").val();
                                    var modificarApellidoMat = $("#inputInfoApellidoMat").val();
                                    var modificarEmail = $("#inputInfoEmail").val();
                                    var modificarTelefono = $("#inputInfoTelefono").val();
                                    var modificarContrasena = $("#inputInfoContrasena").val();
                                    var modificarContrasena2 = $("#inputInfoContrasena2").val();

                                    if(validateAlfabeto(modificarNombre)){
                                        if(validateAlfabeto(modificarApellidoPat)){
                                            if(validateAlfabeto(modificarApellidoMat)){
                                                if(validarTel(modificarTelefono)){
                                                    if(validateContra(modificarContrasena)){
                                                        if(validateContra2(modificarContrasena, modificarContrasena2)){

                                                            var modificateUsuario = new ModificateUsuario(modificarNombre, modificarApellidoPat, modificarApellidoMat, modificarContrasena, modificarEmail, modificarTelefono);

                                                            modificarUsuario(modificateUsuario);
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
                                                    alert("El numero telefonico solamente acepta caracteres numéricos");
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
                                    alert ("Debe llenar los campos requeridos.");
                                }
                            }
                            else{
                                alert ("Debe llenar los campos requeridos.");
                            }
                        }
                        else{
                            alert ("Debe llenar los campos requeridos.");
                        }
                    }
                    else{
                        alert ("Debe llenar los campos requeridos.");
                    }
                }
                else{
                    alert ("Debe llenar los campos requeridos.");
                }
            }
            else{
                alert ("Debe llenar los campos requeridos.");
            }
        }
        else{
            alert ("Debe llenar los campos requeridos.");
        }
    });

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

    function cargaInfoUsuario(){

        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getInfoUser",
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
                alert("Se cargao la info de usuario");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#InfoNombre1").append("<input type='text' class='form-control' id='inputInfoNombre' placeholder=" + Object.values(data[index].nombre).join("") + " />");
                    $("#InfoApellidoPat1").append("<input type='text' class='form-control' id='inputInfoApellidoPat' placeholder=" + Object.values(data[index].apellidoPat).join("") + " />");
                    $("#InfoApellidoMat1").append("<input type='text' class='form-control' id='inputInfoApellidoMat' placeholder=" + Object.values(data[index].apellidoMat).join("") + " />");
                    $("#inputInfoEmail1").append("<input type='email' class='form-control' id='inputInfoEmail' placeholder=" + Object.values(data[index].email).join("") + " />");
                    $("#inputInfoTelefono1").append("<input type='text' class='form-control' id='inputInfoTelefono' placeholder=" + Object.values(data[index].telefono).join("") + " />");
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }



    function modificarUsuario(modificateUsuario) {
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "modificateUser",
            nombre: modificateUsuario.modNombre,
            apellidoPat: modificateUsuario.modApellidoPat,
            apellidoMat: modificateUsuario.modApellidoMat,
            contrasena: modificateUsuario.modContrasena,
            email: modificateUsuario.modEmail,
            telefono: modificateUsuario.modTelefono,
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
                alert("Se modifico usuario: "+data);
            },
            error: function(x,y,z){
                alert("Error en webservice: " + x + y + z);
            }
        });
    }
    
});

