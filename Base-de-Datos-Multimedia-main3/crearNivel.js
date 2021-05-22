$(document).ready(function(){

    var file;
    var file2;

    $("#video").change(function(e){
        file = e.target.files[0].name;
    });

    $("#archivo").change(function(e){
        file2 = e.target.files[0].name;
    });

    $("#btnCrearNivel").click(function(){
        if($("#inputnombre").val() != ""){
            if($("#inputdesc").val() != ""){

                var nombre = $("#inputnombre").val();
                var desc = $("#inputdesc").val();
                var file_1 = file;
                var file_2 = file2;

                var nivel = new Nivel(nombre, desc, file_1, file_2);

                sendNivel(nivel);

            }
            else{
                alert ("Debe llenar los campos requeridos.");
            }
        }
        else{
            alert ("Debe llenar los campos requeridos.");
        }


        function sendNivel(nivel) {
            // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
            var dataToSend = {
                action: "addNivel",
                nombreNivel: nivel.nombre,
                descNivel: nivel.desc,
                video: nivel.video,
                archivo: nivel.archivo,
            };
    
            //var objetoEnJSON = JSON.stringify(sendProduct);
    
            //var objetoDesdeJSON = JSON.parse(objetoEnJSON);
    
            $.ajax({
                //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
                url: "niveles.php",
                async: true,
                type: "POST",
                data: dataToSend,
                success: function(data) {
                    //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                    alert("Se agrego el nivel");
                    
                },
                error: function(x, y, z) {
                    alert("Error en webservice: " + x + y + z);
                },
            });
        }

    });

   

});