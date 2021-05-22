$(document).ready(function () {

    buscaCategorias();

    var file;
    var file2;

    $("#image").change(function(e){
        file = e.target.files[0].name;
    });

    $("#video").change(function(e){
        file2 = e.target.files[0].name;
    });

    $("#btnCrear").click(function(){

        if ($("input:radio[name=categoria]:checked").val() != "") {
            if ($("#inputNombre").val() != "") {
                if ($("#inputDesc").val() != "") {
                    if ($("#inputDescCorta").val() != "") {
                        if ($("#inputCosto").val() != "") {

                            var categoria = $("input:radio[name=categoria]:checked").val();
                            var nombre = $("#inputNombre").val();
                            var desc = $("#inputDesc").val();
                            var descCorta = $("#inputDescCorta").val();
                            var costo = $("#inputCosto").val();

                            var file_1 = file;
                            var file_2 = file2;
                        
                            if(validarPrecio(costo)){

                                var curso = new Curso(nombre, desc, descCorta, costo, categoria, file_1, file_2);

                                crearCurso(curso);

                            }
                            else{
                                alert ("Debe ingresar solo números y un solo punto decimal.")
                            }
                        }
                        else{
                            alert ("Debe llenar los campos requeridos.");
                        }
                    }
                    else{
                        alert ("Debe llenar los campos requeridos.");
                    }
                }
                else{
                    alert ("Debe llenar los campos requeridos.");
                }
            }
            else{
                alert ("Debe llenar los campos requeridos.");
            }
        }
        else{
            alert ("Debe seleccionar una categoria.");
        }

    });


    function validarPrecio(costo){
        var esNumero = true;
        var puntoDecimal = 0;
        for(var i = 0; i<costo.length; i++){
            var num = costo.charAt(i);
            if(num != 0 && num != 1 && num != 2 && num != 3 && num != 4 && num != 5 && num != 6 && num != 7 
                && num != 8 && num != 9){
                    if(num != "."){
                        esNumero = false;
                    }
                    else{
                        puntoDecimal += 1;
                    }
            }
        }

        if(esNumero == true && puntoDecimal < 2){
            return true;
        }
        else{
            return false;
        }
    }


    function buscaCategorias() {
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "getCategorias"
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "categoria.php",
            async: true,
            type: "POST",
            data: dataToSend,
            dataType: 'json',
            success: function(data) {
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                //alert("Se cargaron las categorias");

                console.log(Object.values(data));
                var objectLength = Object.keys(data).length;

                for (let index = 0; index < objectLength; index++) {

                    $(".curso-categoria").append("<input type='radio' id= inputCategoria" + Object.values(data[index].idCat).join("") + " name='categoria' value=" + Object.values(data[index].idCat).join("") + "><label for= inputCategoria" + Object.values(data[index].idCat).join("") + ">" + Object.values(data[index].nombreCat).join("") + "</label><br>");
                }
            },
            error: function(x, y, z) {
                alert("Error en webservice: " + x + y + z);
            },
        });
    }


    function crearCurso(curso) {
        // Objeto en formato JSON el cual le enviaremos al webservice (PHP)
        var dataToSend = {
            action: "addCurso",
            categoria: curso.categoria,
            nombre: curso.nombre,
            descripcion: curso.desc,
            descripcionCorta: curso.descCorta,
            costo: curso.costo,
            foto: curso.foto,
            video: curso.video
        };

        //var objetoEnJSON = JSON.stringify(sendProduct);

        //var objetoDesdeJSON = JSON.parse(objetoEnJSON);

        $.ajax({
            //url: "https://miwebservices.000webhostapp.com/webservice/webservice.php",
            url: "cursos.php",
            async: true,
            type: 'POST',
            data: dataToSend,
            success: function (data){
                //obtenemos el mensaje enviado desde el servidor SIN formato JSON
                alert("Se creó el curso");
            },
            error: function(x,y,z){
                alert("Error en webservice: " + x + y + z);
            }
        });
    }

});