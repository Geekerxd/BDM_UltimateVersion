$(document).ready(function(){

    cargaDatosCurso();

    $("#btnIncribirse").click(function(){
        inscribirAlumno();
    });

    function cargaDatosCurso(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getDatosCurso",
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
                //alert("Se cargo los datos de curso a pagar");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#nombreCurso").append("<label id='primerLabel' for=''>Nombre del curso: " + Object.values(data[index].nombreCurso).join("") +"</label><br><br>");
                    $("#cantidadNiveles").append("<label for=''>Cantidad de niveles: "+ Object.values(data[index].cantidad).join("") +"</label><br><br>");
                    $("#costoCurso").append("<label for=''>Costo del curso: $"+ Object.values(data[index].costo).join("") +"</label><br><br>");
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

    function inscribirAlumno(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "inscribirAlumno",
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
                alert("Se inscribio alumno: "+data);

            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

});