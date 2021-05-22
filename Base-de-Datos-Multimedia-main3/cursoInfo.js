$(document).ready(function(){

    cargaFotoUsuario();
    cargaCategor();
    cargaInfoCurso();
    verificaCreadorCurso();
    cargaComentariosCurso();

   

    function cargaInfoCurso(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getInfoCurso",
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
                //alert("Se cargao la info de curso");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#nombreCurso").append("<h1>"+ Object.values(data[index].nombreCurso).join("") + "</h1>");
                    $("#categoriaCurso").append("<h6>"+ Object.values(data[index].nombreCat).join("") + "</h6>");
                    $("#descCurso").append("<p>"+ Object.values(data[index].descripcionCurso).join("") + "</p>");
                    $("#imgCurso").append("<img src='uploads/"+ Object.values(data[index].fotoCurso).join("") +"' alt='no se cargo la imagen' style='margin-top: 40px;margin-bottom: 40px;width: 597px;margin-left: auto;margin-right: auto;border-style: outset;border-width: 5px;border-left-color: #204c73;border-top-color: #204c73;border-right-color: #F29849;border-bottom-color: #F29849;border-radius: 5px;'>");
                    $("#videoCurso").append("<iframe width='560' height='315' src='uploads/"+ Object.values(data[index].videoCurso).join("") +"' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>");
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

    function verificaCreadorCurso(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "verificaCreadorCurso",
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
                //alert("Se cargo el boton de crear nivel");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#botonCrearNivel").append("<a href='crearNivel.php' target='_blank'><button class='btnCrearNivel btn-primary' id='btnCrearNivel'>+ Crear nivel</button></a>");
                    
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

    function cargaComentariosCurso(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "cargaComentariosCurso",
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "comentarioCurso.php",
            async: true,
            type: "POST",
            data: dataToSend,
            dataType: 'json',
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                //alert("Se cargo el boton de crear nivel");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    if(Object.values(data[index].comentarioEnCurso).join("") != ""){
                        $("#comentariosEnCurso").append("<div id='list-item-1' class='card-comentarios text-left'><div class='card-header'><img src='uploads/"+ Object.values(data[index].foto).join("") +"' alt='foto'><label for='usuario'>" + Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") + "</label></div><div class='card-body'><label class='card-text' type='text' style='width:100%'>"+ Object.values(data[index].comentarioEnCurso).join("") + "</label></div><div class='card-footer'><label for='fecha-hora' class='fecha-hora'>"+ Object.values(data[index].fechaAmandar).join("") +"</label></div></div>");
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
                //alert("Se cargaron las categorias en dropdown");

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