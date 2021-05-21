$(document).ready(function(){

    cargaFotoUsuario();
    cargaCategor();
    cargaInfoUsuario();
    cargaHistorial();
    cargaCursosProfesor();

    var file;

    $("#image").change(function(e){
        file = e.target.files[0].name;
    });

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

    $("#btnEnviarFoto").click(function(){


        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "modificarFoto",
            file: file,
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
                alert("Se subio imagen");

                
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });

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
                //alert("Se cargao la info de usuario");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#nombreDelUsuario").append("<h2 class='username'>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") +" "+ Object.values(data[index].apellidoMat).join("") + " <svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='#F29849' width='24px' height='24px'><path d='M0 0h24v24H0z' fill='none' /><path d='M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z' /></svg></h2><br>");
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

    function cargaHistorial(){

        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getHistorialUser",
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
                //alert("Se cargo el historial de usuario");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    if(Object.values(data[index].cursoFinalizado).join("") == 1){
                        $("#seccion_historial").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header'>"+ Object.values(data[index].nombreCurso).join("") +"</div><img src="+ Object.values(data[index].fotoCurso).join("") +" class='card-img' alt="+ Object.values(data[index].nombreCurso).join("") +"><div class='card-body'><p class='card-text'>"+ Object.values(data[index].descCortaCurso).join("") +"</p><label class='progreso'>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><a href='curso.php' target='_blank'><button class='btnInfoCurso btn-primary' onclick='buscaCurso(this.value)' type='submit' value="+ Object.values(data[index].idCurso).join("") + " style='border-radius: 5px;'>Más información</button></a><br><a href='diploma.php' target='_blank'><button class='btnInfoCurso btn-primary' onclick='buscaCurso(this.value)' type='submit' value="+ Object.values(data[index].idCurso).join("") + " style='border-radius: 5px;'>Ver diploma</button></a></div><div class='card-footer'><div class='categoria'>"+ Object.values(data[index].nombreCat).join("") + "</div><div class='fecha'>"+ Object.values(data[index].fechaInicio).join("") +" - "+ Object.values(data[index].fechaFinal).join("") +"</div></div></div>");
                    }
                    else{
                        $("#seccion_historial").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header'>"+ Object.values(data[index].nombreCurso).join("") +"</div><img src="+ Object.values(data[index].fotoCurso).join("") +" class='card-img' alt="+ Object.values(data[index].nombreCurso).join("") +"><div class='card-body'><p class='card-text'>"+ Object.values(data[index].descCortaCurso).join("") +"</p><label class='progreso'>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><a href='curso.php' target='_blank'><button class='btnInfoCurso btn-primary' onclick='buscaCurso(this.value)' type='submit' value="+ Object.values(data[index].idCurso).join("") + " style='border-radius: 5px;'>Más información</button></a><br></div><div class='card-footer'><div class='categoria'>"+ Object.values(data[index].nombreCat).join("") + "</div><div class='fecha'>"+ Object.values(data[index].fechaInicio).join("") +"</div></div></div>");
                    }
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }


    function cargaCursosProfesor(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getCursosProfesor",
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "cursos.php",
            async: true,
            type: "POST",
            data: dataToSend,
            dataType: 'json',
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Se cargaron los cursos del profe");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;
                var totaltotal = false;

                for (let index = 0; index < objectLength; index++) {
                    
                    if(totaltotal == false){
                        $("#totalVentas").append("<label class='labelTotalVentas' for=''>Total de ventas: $"+ Object.values(data[index].ventaTotalTotal).join("") +"</label>");
                        totaltotal = true;
                    }
                    $("#divGestorCursos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header'>"+ Object.values(data[index].nombreCurso).join("") +"</div><img src="+ Object.values(data[index].fotoCurso).join("") +" class='card-img' alt="+ Object.values(data[index].nombreCurso).join("") +"><div class='card-body'><p class='card-text'>"+ Object.values(data[index].descCortaCurso).join("") +"</p><label for='' id='costo'>Costo: $"+ Object.values(data[index].costo).join("") +"</label><br><label for='' id='valoracion'>Popularidad: "+ Object.values(data[index].valoracion).join("") +"%</label><br><label for='' id='ventasPorCurso'>Total de ventas: $"+ Object.values(data[index].ventasTotales).join("") +"</label><br><a href='curso.php' target='_blank'><button class='btnInfoCurso btn-primary' onclick='buscaCurso(this.value)' type='submit' value="+ Object.values(data[index].idCurso).join("") + " style='border-radius: 5px;'>Más información</button></a><br><a href='alumnosdeCurso.php' target='_blank'><button class='btnAlumnosCurso btn-primary' onclick='buscaCurso(this.value)' type='submit' value="+ Object.values(data[index].idCurso).join("") + " style='border-radius: 5px;'>Ver alumnos</button></a></div><div class='card-footer'><div class='categoria'>"+ Object.values(data[index].nombreCat).join("") +"</div></div></div>");
                    
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }
    
    function cargaCategor(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getCategor"
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "categoria.php",
            async: true,
            type: "POST",
            data: dataToSend,
            dataType: 'json',
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Se cargaron las categorias en dropdown");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {

                    
                    //$(".noticias-row").append("<div class='card col-12 col-sm-6 col-md-3 d-none d-sm-block' style='display: inline-flex;'><span class='badge badge-info etiqueta'>" + Object.values(data[index].nombreCat).join("") + "</span><a href='curso.php' target='_blank'><img src=" + Object.values(data[index].fotoCurso).join("") + " class='card-img-top' alt='no se pudo cargar esta imagen' /></a><div class='Tarjeta-texto'><p style='margin-top: 15px'><strong>" + Object.values(data[index].nombreCurso).join("") + "</strong></p><p class='lead' style='font-size: 15px'>" + Object.values(data[index].descCortaCurso).join("") + "</p><a class='linkCurso' href='curso.php' target='_blank'><button class='btnInfoCurso btn-primary' onclick='buscaCurso(this.value)' type='submit' value="+ Object.values(data[index].idCurso).join("") + " style='border-radius: 5px; margin-left: 40%;'>Más información</button></a></div><div class='row empty'></div><div class='container_iconos row'><span class='material-icons md-xx'>thumb_up</span><i class='fas' :hover>" + Object.values(data[index].valoracion).join("") + "%</i><i class='fas fa-comment' :hover>"+ Object.values(data[index].cantComentarios).join("") +"</i></div><input type='hidden' name='idCurso' value=" + Object.values(data[index].idCurso).join("") + "></div>");
                    $("#categor").append("<a class='dropdown-item' href='categorias.php' target='_blank'><button class='btnInfoCurso' onclick='buscaCategor(this.value)' type='submit' value="+ Object.values(data[index].idCat1).join("") +" style='border-radius: 5px; margin-left: 40%;'>"+ Object.values(data[index].nombreCat1).join("") +"</button></a>");

                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }


    function cargaFotoUsuario(){

        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getFotoUsuario",
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
                alert("Se cargo la foto");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#btnfotoperfil").append("<img class='fotoPerfil' id='fotoPerfil' src='uploads/"+ Object.values(data[index].foto).join("") +"' alt='avatar'>");
                    $("#espacioFoto2").append("<img class='avatar' src='uploads/"+ Object.values(data[index].foto).join("") +"' alt='avatar'/>");
                    
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }


});

