$(document).ready(function(){

    cargaInfoDiploma();

    function cargaInfoDiploma(){

        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getDiploma",
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
                alert("Se genero el diploma");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    $("#nombre").append("<label class='labelNombreUsuario' for=''>"+ Object.values(data[index].nombre).join("") +" " + Object.values(data[index].apellidoPat).join("") +" "+ Object.values(data[index].apellidoMat).join("") +"</label>");
                    $("#curso").append("<label class='labelNombreCurso' for=''>"+ Object.values(data[index].nombreCurso).join("") +"</label>");
                    $("#fecha").append("<label class='labelFechaFinal' for=''>"+ Object.values(data[index].fechaFinalCurso).join("") +"</label>");
                    $("#nombreProfe").append("<label class='usuarioProfesor' for=''>Lic. "+ Object.values(data[index].nombreUsuario).join("") +" "+ Object.values(data[index].apellidoPatUser).join("") +" "+ Object.values(data[index].apellidoMatUser).join("") +"</label>");

                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

});