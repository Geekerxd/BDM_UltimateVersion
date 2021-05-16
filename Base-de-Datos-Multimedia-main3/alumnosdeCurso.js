$(document).ready(function(){

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
                alert("Se cargaron los alumnos del curso");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {
                    
                    //$("#nombreCurso").append("<h1>"+ Object.values(data[index].nombreCurso).join("") + "</h1>");
                    if(Object.values(data[index].cursoFinalizado).join("") == 1){
                        $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px green'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='https://seeklogo.com/images/E/ElePHPant_-_Mascot_PHP-logo-4C78D1AC4E-seeklogo.com.jpg' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><label id='labelfechafinal' class='labelDatos' for=''>Fecha de finalización: "+ Object.values(data[index].fechaFinal1).join("") +"</label><br></div></div>");
                    }
                    else{
                        if(Object.values(data[index].progreso).join("") < 100 && Object.values(data[index].progreso).join("") >= 70){
                            $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px rgb(0, 216, 0)'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='https://seeklogo.com/images/E/ElePHPant_-_Mascot_PHP-logo-4C78D1AC4E-seeklogo.com.jpg' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><br></div></div>");
                        }
                        else if(Object.values(data[index].progreso).join("") < 70 && Object.values(data[index].progreso).join("") >= 50){
                            $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px #ec9614'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='https://seeklogo.com/images/E/ElePHPant_-_Mascot_PHP-logo-4C78D1AC4E-seeklogo.com.jpg' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><br></div></div>");
                        }
                        else{
                            $("#progresoAlumnos").append("<div id='list-item-1' class='card-curso text-left'><div class='card-header' style='border-right: solid 20px red'><label id='labelnombre' class='labelDatos1' for=''>"+ Object.values(data[index].nombre).join("") + " " + Object.values(data[index].apellidoPat).join("") + " " + Object.values(data[index].apellidoMat).join("") +"</label></div><img src='https://seeklogo.com/images/E/ElePHPant_-_Mascot_PHP-logo-4C78D1AC4E-seeklogo.com.jpg' class='card-img' alt='foto'><div class='card-body'><label id='labelemail' class='labelDatos' for=''>Correo: "+ Object.values(data[index].email).join("") +"</label><br><label id='labeltelefono' class='labelDatos' for=''>Teléfono: "+ Object.values(data[index].telefono).join("") +"</label><br><label id='labelprogreso' class='labelDatos' for=''>Progreso: "+ Object.values(data[index].progreso).join("") +"%</label><br><label id='labelfechainicial' class='labelDatos' for=''>Fecha de inicio: "+ Object.values(data[index].fechaInicio1).join("") +"</label><br><br></div></div>");
                        }
                    }
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

});