/*
	///////////////////////////////////////Sign up Usuario////////////////////////////////////////////////
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_signupUsuario`(
IN inRol varchar(15),
IN inNombre varchar(80),
IN inApellidoPat varchar(80),
IN inApellidoMat varchar(80),
IN inContra varchar(16),
IN inEmail varchar(100),
IN inTel varchar(10)
)
BEGIN
	INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono) 
    VALUES(inRol, inNombre, inApellidoPat, inApellidoMat, inContra, inEmail, inTel);
END

/*
	////////////////////////////////////Log in Usuario/////////////////////////////////////////////////////
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_loginUsuario`(
IN INRol varchar(15),
IN INEmail varchar(100),
IN INContrasena varchar(16)
 )
BEGIN
SELECT `usuario`.`id`,
    `usuario`.`rol`,
    `usuario`.`nombre`,
    `usuario`.`apellidoPat`,
    `usuario`.`apellidoMat`,
    `usuario`.`contrasena`,
    `usuario`.`email`,
    `usuario`.`telefono`,
    `usuario`.`foto`,
    `usuario`.`fecha_registro`
FROM `webstudy`.`usuario` 
WHERE `usuario`.`rol` = INRol AND `usuario`.`email` = INEmail AND `usuario`.`contrasena` = INContrasena;
END

/*
	////////////////////////////////////Create categoria/////////////////////////////////////////////////////
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createCategory`(
IN inNombre VARCHAR(80),
IN inDesc VARCHAR(1000)
)
BEGIN
    
	INSERT INTO categoria(nombreCat, descripcionCat)
    VALUES(inNombre, inDesc);
    
END

/*
	////////////////////////////////////Get categorias/////////////////////////////////////////////////////
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getCategorias`()
BEGIN
	SELECT nombreCat, idCat
    FROM categoria;
END

/*
	////////////////////////////////////Create Curso/////////////////////////////////////////////////////
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createCurso`(
IN inNombre VARCHAR(80),
IN inDescripcionCorta VARCHAR(200),
IN inDescripcion VARCHAR(1000),
IN inCosto FLOAT,
IN inCategoria INT,
IN inRolUsuarioCreador VARCHAR(15),
IN inContraUsuarioCreador VARCHAR(16),
IN inEmailUsuarioCreador VARCHAR(100)
)
BEGIN

	DECLARE idUC INT;
    
    SELECT id INTO idUC
    FROM usuario
    WHERE usuario.rol = inRolUsuarioCreador AND usuario.email = inEmailUsuarioCreador AND usuario.contrasena = inContraUsuarioCreador;

	INSERT INTO curso(nombreCurso, descripcionCurso, descCortaCurso, costo, fotoCurso, idUsuarioCreador, idCategoria)
    VALUES (inNombre, inDescripcion, inDescripcionCorta, inCosto, "https://seeklogo.com/images/E/ElePHPant_-_Mascot_PHP-logo-4C78D1AC4E-seeklogo.com.jpg", idUC,  inCategoria);
END

/*
	////////////////////////////////////Get Cursos/////////////////////////////////////////////////////
*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getCursos`()
BEGIN

	SELECT curso.idCurso, categoria.nombreCat, curso.nombreCurso, curso.descCortaCurso, curso.fotoCurso, curso.valoracion
    FROM curso
    LEFT JOIN categoria
    ON curso.idCategoria = categoria.idCat
    ORDER BY curso.valoracion DESC;
END