$(document).ready(function () {

    var file;

    $("#image").change(function(e){
        file = e.target.files[0].name;
    });

    $("#btnCrear").click(function(){

        if($("#nombre").val() != ""){
            if($("#desc").val() != ""){

                var nombre = $("#nombre").val();
                var desc = $("#desc").val();
                var file1 = file;

                if(validateAlfabeto(nombre)){

                    alert("Los datos de categoria han sido capturados correctamente");

                    var categoria = new Categoria(nombre, desc, file1);

                    sendCategoria(categoria);

                }
                else{
                    alert("El nombre no debe contener caracteres no alfabéticos.");
                }

            }
            else{
                alert("Debes llenar los campos requeridos.");
            }
        }
        else{
            alert("Debes llenar los campos requeridos.");
        }

    });


    function validateAlfabeto(temp){
        var esAlfabeto = true;
        for(var i = 0; i<temp.length; i++){
            var ch = temp.charAt(i);
            const pattern = new RegExp('^[A-Z]+$', 'i');
            if(!pattern.test(ch) && ch != " "){ 
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


    function sendCategoria(categoria) {
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "addCategoria",
            nombre: categoria.nombre,
            descripcion: categoria.desc,
            foto: categoria.foto
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "categoria.php",
            async: true,
            type: 'POST',
            data: dataToSend,
            success: function (data){
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Se creó categoría");
            },
            error: function(x,y,z){
                alert("Error en webservice: " + x + y + z);
            }
        });
    }

});