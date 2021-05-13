$(document).ready(function(){

    cargaInfoCurso();
    verificaCreadorCurso();
    

   

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

    

});