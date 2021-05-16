$(document).ready(function(){

    cargaChatsExistentes();

    $("#btnBuscar").click(function(){

        if($("#stringaBuscar").val() != ""){

            var seBusca = $("#stringaBuscar").val();

            enviaraBuscar(seBusca);

        }
        else{
            alert ("No se ha enviado nada para buscar.")
        }

    });

    function enviaraBuscar(seBusca){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "buscadorChat",
            stringaBuscar: seBusca,
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "chats.php",
            async: true,
            type: 'POST',
            data: dataToSend,
            dataType: 'json',
            success: function (data){
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Se encontró");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;
                $("#contactosBuscados div").remove();

                for (let index = 0; index < objectLength; index++) {

                    $("#contactosBuscados").append("<div class='usuarioContacto'><div id='imgUsuarioBuscado'><img src='https://image.flaticon.com/icons/png/512/17/17004.png' alt='foto'></div><div id='datosUsuarioBuscado' class='datosUsuarioBuscado'><label for='' id='nombre'>"+ Object.values(data[index].nombre).join("") +" "+ Object.values(data[index].apellidoPat).join("") +" "+ Object.values(data[index].apellidoMat).join("") +"</label><br><label for='' id='correo'>"+ Object.values(data[index].email).join("") +"</label><br></div><div><button class='comenzarChat btn-primary uni' id='comenzarChat' value="+ Object.values(data[index].id).join("") + " onclick='crearChat(this.value)'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat' viewBox='0 0 16 16'><path d='M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z'/></svg></button></div></div>");
                }
            },
            error: function(x,y,z){
                alert("Error en webservice: " + x + y + z);
            }
        });
    }

    function cargaChatsExistentes(){
        var dataToSend = {
            action: "cargaChats",
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "chats.php",
            async: true,
            type: 'POST',
            data: dataToSend,
            dataType: 'json',
            success: function (data){
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Se cargaron los chats");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {

                    $("#contactosEstablecidos").append("<div class='usuarioContacto'><div id='imgUsuarioBuscado'><img src='https://image.flaticon.com/icons/png/512/17/17004.png' alt='foto'></div><div id='datosUsuarioBuscado' class='datosUsuarioBuscado'><label for='' id='nombre'>"+ Object.values(data[index].nombre).join("") +" "+ Object.values(data[index].apellidoPat).join("") +" "+ Object.values(data[index].apellidoMat).join("") +"</label><br><label for='' id='correo'>"+ Object.values(data[index].email).join("") +"</label><br></div><div><button class='comenzarChat btn-primary uni' id='comenzarChat' value="+ Object.values(data[index].idChat1).join("") + " onclick='establecerChat(this.value)'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat' viewBox='0 0 16 16'><path d='M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z'/></svg></button></div></div>");
                }
            },
            error: function(x,y,z){
                alert("Error en webservice: " + x + y + z);
            }
        });
    }

});