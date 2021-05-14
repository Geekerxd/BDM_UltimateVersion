$(document).ready(function(){

    cargaNombreCursoEvaluar();

    $("#btnEnviar").click(function(){

        if ($("input:radio[name=calificacion]:checked").val() != "") {
            
            var calif = $("input:radio[name=calificacion]:checked").val();
            var coment = $("#comentarioCurso").val();

            var comentarioEnCurso = new ComentarioCurso(calif, coment);

            mandaDatosComentario(comentarioEnCurso);

        }
        else {
            alert("Es obligatorio seleccionar una calificación para el curso.");
        }

    });

    function cargaNombreCursoEvaluar(){
        var dataToSend = {
            action: "cargaNombreCursoEvaluar",
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
                alert("Se cargo nombre de curso");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                        
                    $("#nombreCurso").append("<h1>" + Object.values(data[index].nombreCurso).join("") + "</h1>");
                            
                }
                    
                
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

    function mandaDatosComentario(comentarioEnCurso){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "addComentarioCurso",
            valoracion: comentarioEnCurso.valoracion,
            contenido: comentarioEnCurso.contenido,
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "comentarioCurso.php",
            async: true,
            type: "POST",
            data: dataToSend,
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Realizo el comentario: "+data);
   
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

});