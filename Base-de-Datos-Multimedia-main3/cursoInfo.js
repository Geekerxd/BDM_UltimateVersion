$(document).ready(function(){

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
                    $("#imgCurso").append("<img src="+ Object.values(data[index].fotoCurso).join("") +" alt='no se cargo la imagen' style='margin-top: 40px;margin-bottom: 40px;width: 597px;margin-left: auto;margin-right: auto;border-style: outset;border-width: 5px;border-left-color: #204c73;border-top-color: #204c73;border-right-color: #F29849;border-bottom-color: #F29849;border-radius: 5px;'>");
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
                        $("#comentariosEnCurso").append("<div id='list-item-1' class='card-comentarios text-left'><div class='card-header'><img src='https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg' alt='foto'><label for='usuario'>" + Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") + "</label></div><div class='card-body'><label class='card-text' type='text' style='width:100%'>"+ Object.values(data[index].comentarioEnCurso).join("") + "</label></div><div class='card-footer'><label for='fecha-hora' class='fecha-hora'>"+ Object.values(data[index].fechaAmandar).join("") +"</label></div></div>");
                    }
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }
    

});