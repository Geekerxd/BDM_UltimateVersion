$(document).ready(function(){

    cargaCursos();

    function cargaCursos(){
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getCursos"
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
                alert("Se cargaron los cursos");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < 4; index++) {

                    $(".noticias-row").append("<div class='card col-12 col-sm-6 col-md-3 d-none d-sm-block'><span class='badge badge-info etiqueta'>" + Object.values(data[index].nombreCat).join("") + "</span><a href='curso.php' target='_blank'><img src=" + Object.values(data[index].fotoCurso).join("") + " class='card-img-top' alt='no se pudo cargar esta imagen' /></a><div class='Tarjeta-texto'><p style='margin-top: 15px'><strong>" + Object.values(data[index].nombreCurso).join("") + "</strong></p><p class='lead' style='font-size: 15px'>" + Object.values(data[index].descCortaCurso).join("") + "<a class='linkColor' href='curso.php'>Más información</a></p></div><div class='row empty'></div><div class='container_iconos row'><span class='material-icons md-xx'>thumb_up</span><i class='fas' :hover>" + Object.values(data[index].valoracion).join("") + "%</i><i class='fas fa-comment' :hover>138</i></div></div>");
                   
                   
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }

});