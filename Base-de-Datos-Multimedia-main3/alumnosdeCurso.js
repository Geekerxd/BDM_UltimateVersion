$(document).ready(function(){

    cargaFotoUsuario();
    cargaCategor();
    cargaAlumnosDeCurso();

    function cargaAlumnosDeCurso(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getAlumnosDeCurso",
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
               // alert("Se cargaron los alumnos del curso");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    //$("#nombreCurso").append("<h1>"+ Object.values(data[index].nombreCurso).join("") + "</h1>");
                    if(Object.values(data[index].cursoFinalizado).join("") == 1){
                        $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px green'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='uploads/"+ Object.values(data[index].foto).join("") + "' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><label id='labelfechafinal' class='labelDatos' for=''>Fecha de finalización: "+ Object.values(data[index].fechaFinal1).join("") +"</label><br><br><a class='linkCurso' href='chat.php' target='_blank'><button class='btnCreaChat btn-primary' id='btnCreaChat' onclick='creaChat(this.value)' type='submit' value="+ Object.values(data[index].id).join("") + " style='border-radius: 5px; color: #275d8c'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat' viewBox='0 0 16 16'><path d='M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z'/></svg> Chat</button></a></div></div>");
                    }
                    else{
                        if(Object.values(data[index].progreso).join("") < 100 && Object.values(data[index].progreso).join("") >= 70){
                            $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px rgb(0, 216, 0)'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='uploads/"+ Object.values(data[index].foto).join("") + "' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><br><a class='linkCurso' href='chat.php' target='_blank'><button class='btnCreaChat btn-primary' id='btnCreaChat' onclick='creaChat(this.value)' type='submit' value="+ Object.values(data[index].id).join("") + " style='border-radius: 5px; color: #275d8c'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat' viewBox='0 0 16 16'><path d='M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z'/></svg> Chat</button></a></div></div>");
                        }
                        else if(Object.values(data[index].progreso).join("") < 70 && Object.values(data[index].progreso).join("") >= 50){
                            $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px #ec9614'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='uploads/"+ Object.values(data[index].foto).join("") + "' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><br><a class='linkCurso' href='chat.php' target='_blank'><button class='btnCreaChat btn-primary' id='btnCreaChat' onclick='creaChat(this.value)' type='submit' value="+ Object.values(data[index].id).join("") + " style='border-radius: 5px; color: #275d8c'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat' viewBox='0 0 16 16'><path d='M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z'/></svg> Chat</button></a></div></div>");
                        }
                        else{
                            $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px red'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='uploads/"+ Object.values(data[index].foto).join("") + "' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><br><a class='linkCurso' href='chat.php' target='_blank'><button class='btnCreaChat btn-primary' id='btnCreaChat' onclick='creaChat(this.value)' type='submit' value="+ Object.values(data[index].id).join("") + " style='border-radius: 5px; color: #275d8c'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat' viewBox='0 0 16 16'><path d='M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z'/></svg> Chat</button></a></div></div>");
                        }
                    }
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
              //  alert("Se cargaron las categorias en dropdown");

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
                //alert("Se cargo la foto");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#btnfotoperfil").append("<img class='fotoPerfil' id='fotoPerfil' src='uploads/"+ Object.values(data[index].foto).join("") +"' alt='avatar'>");
                    
                    
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

});