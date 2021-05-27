-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2021 at 01:26 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webstudy`
--

DELIMITER $$
--
-- Procedures
--
CREATE PROCEDURE `sp_buscadorUsuarios` (IN `palabra` VARCHAR(100), IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16))  BEGIN

    DECLARE idUsuarioActual INT;

    SELECT id INTO idUsuarioActual
    FROM usuario
    WHERE usuario.email = inEmail AND usuario.contrasena = inContra;

    SELECT U.id, U.nombre, U.apellidoPat, U.apellidoMat, U.email
    FROM usuario AS U
    WHERE U.id != idUsuarioActual AND 
        (U.nombre LIKE CONCAT("%",palabra,"%") OR U.apellidoPat LIKE CONCAT("%",palabra,"%") OR U.apellidoMat LIKE CONCAT("%",palabra,"%") OR U.email LIKE CONCAT("%",palabra,"%")); 

END$$

CREATE PROCEDURE `sp_calculaProgreso` (IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16), IN `inIdCurso` INT)  BEGIN
    DECLARE nivelActual INT;
    DECLARE progress INT;
    DECLARE idAlumno INT;

    SELECT DISTINCT(E.nivelCursado) INTO nivelActual
    FROM estudiantescursando AS E
    INNER JOIN usuario as U
    ON E.idEstudiante = U.id
    WHERE U.email = inEmail AND U.contrasena = inContra AND E.idCursoCursado = inIdCurso;

    SELECT U.id INTO idAlumno
    FROM estudiantescursando AS E
    INNER JOIN usuario as U
    ON E.idEstudiante = U.id
    WHERE U.email = inEmail AND U.contrasena = inContra AND E.idCursoCursado = inIdCurso;

    SET progress = IF(nivelActual - 1 > fn_cantidadDeNivelesCurso(inIdCurso), 100, ROUND(((nivelActual-1)*100)/fn_cantidadDeNivelesCurso(inIdCurso)));

    UPDATE estudiantescursando AS E
    SET E.progreso = progress
    WHERE E.idEstudiante = idAlumno AND E.idCursoCursado = inIdCurso ;
END$$

CREATE PROCEDURE `sp_cargaChats` (IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16))  BEGIN

    DECLARE idUsuario INT;
    DECLARE idDelOtro INT;

    SELECT id INTO idUsuario
    FROM usuario
    WHERE usuario.email = inEmail AND usuario.contrasena = inContra;

    DROP temporary table IF EXISTS temp;
    CREATE temporary table IF NOT EXISTS temp
    SELECT IF(chat.idUsuario1 = idUsuario, chat.idUsuario2, chat.idUsuario1) AS idDelOtro, chat.idChat AS idChat1
    FROM chat
    WHERE chat.idUsuario1 = idUsuario OR chat.idUsuario2 = idUsuario;

    SELECT temp.idChat1, usuario.nombre, usuario.apellidoPat, usuario.apellidoMat, usuario.email, usuario.foto
    FROM usuario
    INNER JOIN temp
    ON temp.idDelOtro = usuario.id
    WHERE usuario.id = temp.idDelOtro;

END$$

CREATE  PROCEDURE `sp_cargaComentariosCurso` (IN `inIdCurso` INT)  BEGIN

    SELECT U.nombre, U.apellidoPat, U.apellidoMat, U.foto, C.comentarioEnCurso, fn_fechaDiaMesAnio(inIdCurso, U.id) AS fechaAmandar
    FROM comentariosencursos AS C
    LEFT JOIN usuario AS U
    ON U.id = C.idEstudianteComentCurso
    WHERE inIdCurso = C.idCursoComent
    ORDER BY C.fechaComentCurso;
END$$

CREATE  PROCEDURE `sp_cargaCursosProfesor` (IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16))  BEGIN

    DECLARE idProfesor INT;

    SELECT id INTO idProfesor
    FROM usuario
    WHERE usuario.email = inEmail AND usuario.contrasena = inContra;

    SELECT C.idCurso, C.nombreCurso, C.fotoCurso, C.descCortaCurso, C.valoracion, C.costo, C.ventasTotales, A.nombreCat, fn_calculaTotalVentasTodosCursos(idProfesor) AS ventaTotalTotal
    FROM curso AS C
    INNER JOIN categoria AS A
    ON A.idCat = C.idCategoria
    WHERE C.idUsuarioCreador = idProfesor
    ORDER BY C.nombreCurso ASC;

END$$

CREATE  PROCEDURE `sp_cargaHistorial` (IN `INRol` VARCHAR(15), IN `INEmail` VARCHAR(100), IN `INContrasena` VARCHAR(16))  BEGIN

    DECLARE idAlumno INT;

    SELECT id INTO idAlumno
    FROM usuario
    WHERE usuario.rol = INRol AND usuario.email = INEmail AND usuario.contrasena = INContrasena;



    SELECT C.nombreCurso, A.nombreCat, C.fotoCurso, C.idCurso, E.cursoFinalizado, fn_fechaDiaMesAnioInicio(E.idCursoCursado, E.idEstudiante) AS fechaInicio, fn_fechaDiaMesAnioFinal(E.idCursoCursado, E.idEstudiante) AS fechaFinal, C.descCortaCurso, E.progreso
    FROM estudiantescursando AS E
    INNER JOIN curso AS C
    ON C.idCurso = E.idCursoCursado
    INNER JOIN categoria AS A
    ON C.idCategoria = A.idCat
    WHERE E.idEstudiante = idAlumno
    ORDER BY E.fechaInicioCurso DESC;
END$$

CREATE PROCEDURE `sp_cargaNombreCursoEvaluar` (IN `inIdCurso` INT)  BEGIN
    SELECT nombreCurso
    FROM curso
    WHERE curso.idCurso = inIdCurso;
END$$

CREATE PROCEDURE `sp_creaChat` (IN `inIdDelOtro` INT, IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16))  BEGIN

    DECLARE idUsuarioActual INT;
    DECLARE idChat1 INT;
    DECLARE ok VARCHAR(2);

    SELECT id INTO idUsuarioActual
    FROM usuario
    WHERE usuario.email = inEmail AND usuario.contrasena = inContra;

    SELECT chat.idChat INTO idChat1
    FROM chat
    WHERE (chat.idUsuario1 = idUsuarioActual OR chat.idUsuario2 = idUsuarioActual) AND (chat.idUsuario1 = inIdDelOtro OR chat.idUsuario2 = inIdDelOtro);

    SELECT IF(idChat1 != "", "ok", fn_creaChat(idUsuarioActual, inIdDelOtro)) AS ok;

END$$

CREATE  PROCEDURE `sp_creaMensaje` (IN `inMensaje` VARCHAR(1000), IN `inIdChat` INT, IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16))  BEGIN
    DECLARE idUsuario INT;
    DECLARE esUser1 BIT;
    DECLARE esUser2 BIT;

    SELECT id INTO idUsuario
    FROM usuario
    WHERE usuario.email = inEmail AND usuario.contrasena = inContra;

    SELECT IF(C.idUsuario1 = idUsuario, 1, 0) INTO esUser1
    FROM chat AS C
    WHERE C.idChat = inIdChat;

    SELECT IF(C.idUsuario2 = idUsuario, 1, 0) INTO esUser2
    FROM chat AS C
    WHERE C.idChat = inIdChat;

    INSERT INTO mensajeChat(idChatMensajes, mensaje, esIdUsuario1, esIdUsuario2)
    VALUES(inIdChat, inMensaje, esUser1, esUser2);

END$$

CREATE  PROCEDURE `sp_createCategory` (IN `inNombre` VARCHAR(80), IN `inDesc` VARCHAR(1000), IN `inFoto` BLOB)  BEGIN

    INSERT INTO categoria(nombreCat, descripcionCat, fotoCat)
    VALUES(inNombre, inDesc, inFoto);

END$$

CREATE  PROCEDURE `sp_createComentarioCurso` (IN `inValoracion` FLOAT, IN `inContenido` VARCHAR(5000), IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16), IN `inIdCurso` INT)  BEGIN
    DECLARE idUsuario INT;

    SELECT usuario.id INTO idUsuario
    FROM usuario
    WHERE usuario.email = inEmail AND usuario.contrasena = inContra;

    INSERT INTO comentariosEnCursos(idEstudianteComentCurso, idCursoComent, comentarioEnCurso, valoracionComent)
    VALUES(idUsuario, inIdCurso, inContenido, inValoracion);
END$$

CREATE  PROCEDURE `sp_createCurso` (IN `inNombre` VARCHAR(80), IN `inDescripcionCorta` VARCHAR(200), IN `inDescripcion` VARCHAR(1000), IN `inCosto` FLOAT, IN `inCategoria` INT, IN `inRolUsuarioCreador` VARCHAR(15), IN `inContraUsuarioCreador` VARCHAR(16), IN `inEmailUsuarioCreador` VARCHAR(100), IN `inFoto` BLOB, IN `inVideo` BLOB)  BEGIN

    DECLARE idUC INT;

    SELECT id INTO idUC
    FROM usuario
    WHERE usuario.rol = inRolUsuarioCreador AND usuario.email = inEmailUsuarioCreador AND usuario.contrasena = inContraUsuarioCreador;

    INSERT INTO curso(nombreCurso, descripcionCurso, descCortaCurso, costo, fotoCurso, videoCurso, idUsuarioCreador, idCategoria)
    VALUES (inNombre, inDescripcion, inDescripcionCorta, inCosto, inFoto, inVideo, idUC,  inCategoria);
END$$

CREATE  PROCEDURE `sp_createNivel` (IN `inNombre` VARCHAR(80), IN `inDesc` VARCHAR(1000), IN `inIdCurso` INT, IN `inVideo` BLOB, IN `inArchivo` BLOB)  BEGIN
    INSERT INTO nivel(nombreNivel, descripcionNivel, videoNivel, archivoNivel, idCursoNivel)
    VALUES (inNombre, inDesc, inVideo, inArchivo, inIdCurso);
END$$

CREATE PROCEDURE `sp_estableceChat` (IN `inIdChat` INT)  BEGIN

    SELECT chat.idChat, M.mensaje, IF(M.esIdUsuario2 = 1, fn_buscaEmailCreadorMensaje(chat.idUsuario1), fn_buscaEmailCreadorMensaje(chat.idUsuario2)) AS email1, IF(M.esIdUsuario2 = 1, fn_buscaContraCreadorMensaje(chat.idUsuario1), fn_buscaContraCreadorMensaje(chat.idUsuario2)) AS contra1, chat.idChat, IF(M.esIdUsuario2 = 1, fn_buscaAPCreadorMensaje(chat.idUsuario1), fn_buscaAPCreadorMensaje(chat.idUsuario2)) AS apellidoPat1, IF(M.esIdUsuario2 = 1, fn_buscaAMCreadorMensaje(chat.idUsuario1), fn_buscaAMCreadorMensaje(chat.idUsuario2)) AS apellidoMat1, IF(M.esIdUsuario2 = 1, fn_buscaNombreCreadorMensaje(chat.idUsuario1), fn_buscaNombreCreadorMensaje(chat.idUsuario2)) AS nombre1,IF(M.esIdUsuario2 = 1, fn_buscaFotoCreadorMensaje(chat.idUsuario1), fn_buscaFotoCreadorMensaje(chat.idUsuario2)) AS foto1 
    FROM mensajeChat AS M
    INNER JOIN chat
    ON chat.idChat = M.idChatMensajes
    WHERE M.idChatMensajes = inIdChat
    ORDER BY M.fechaMensajeChat ASC;

END$$

CREATE  PROCEDURE `sp_getAlumnosDeCurso` (IN `inIdCurso` INT)  BEGIN

    SELECT U.id, U.nombre, U.apellidoPat, U.apellidoMat, U.email, U.telefono, E.progreso, U.foto, fn_fechaDiaMesAnioInicio(inIdCurso, U.id) AS fechaInicio1, fn_fechaDiaMesAnioFinal(inIdCurso, U.id) AS fechaFinal1, E.cursoFinalizado
    FROM estudiantescursando AS E
    INNER JOIN usuario AS U
    ON U.id = E.idEstudiante
    WHERE E.idCursoCursado = inIdCurso
    ORDER BY E.progreso ASC;

END$$

CREATE PROCEDURE `sp_getCategorias` ()  BEGIN
    SELECT nombreCat, idCat
    FROM categoria;
END$$

CREATE PROCEDURE `sp_getCursos` ()  BEGIN

    SELECT curso.idCurso, categoria.nombreCat, curso.nombreCurso, curso.descCortaCurso, curso.fotoCurso, curso.valoracion, fn_cantidadComentariosCurso(curso.idCurso) AS cantComentarios
    FROM curso
    INNER JOIN categoria
    ON curso.idCategoria = categoria.idCat
    ORDER BY curso.valoracion DESC;
END$$

CREATE PROCEDURE `sp_getCursosCat` (IN `inIdCat` INT)  BEGIN

    SELECT categoria.nombreCat, curso.idCurso, curso.nombreCurso, curso.descCortaCurso, curso.fotoCurso, curso.valoracion, fn_cantidadComentariosCurso(curso.idCurso) AS cantComentarios
    FROM curso
    INNER JOIN categoria
    ON categoria.idCat = curso.idCategoria
    WHERE curso.idCategoria = inIdCat;

END$$

CREATE  PROCEDURE `sp_getDatosCat` (IN `inIdCat` INT)  BEGIN
    SELECT C.nombreCat, C.descripcionCat, C.fotoCat
    FROM categoria AS C
    WHERE C.idCat = inIdCat;
END$$

CREATE  PROCEDURE `sp_getDiploma` (IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16), IN `inIdCurso` INT)  BEGIN

    SELECT U.nombre, U.apellidoPat, U.apellidoMat, V.nombreCurso, fn_fechaDesarrollada(U.id, V.idCursoCursado) AS fechaFinalCurso, V.nombreUsuario, V.apellidoPatUser, V.apellidoMatUser
    FROM usuario AS U
    INNER JOIN vw_cursoscursados AS V
    ON V.idEstudiante = U.id
    WHERE U.email = inEmail AND U.contrasena = inContra AND V.idCursoCursado = inIdCurso;

END$$

CREATE  PROCEDURE `sp_inscribeUsuario` (IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16), IN `inIdCurso` INT)  BEGIN
    DECLARE idAlumno INT;
    DECLARE idProfesor INT;

    SELECT usuario.id INTO idAlumno
    FROM usuario
    WHERE inEmail = usuario.email AND inContra = usuario.contrasena;

    SELECT curso.idUsuarioCreador INTO idProfesor
    FROM curso
    WHERE inIdCurso = curso.idCurso;

    INSERT INTO estudiantesCursando(idEstudiante, idCursoCursado, idMaestro)
    VALUES(idAlumno, inIdCurso, idProfesor);
END$$

CREATE  PROCEDURE `sp_loginUsuario` (IN `INRol` VARCHAR(15), IN `INEmail` VARCHAR(100), IN `INContrasena` VARCHAR(16))  BEGIN
SELECT usuario.id,
    usuario.rol,
    usuario.nombre,
    usuario.apellidoPat,
    usuario.apellidoMat,
    usuario.contrasena,
    usuario.email,
    usuario.telefono,
    usuario.foto,
    usuario.fecha_registro
FROM webstudy.usuario 
WHERE usuario.rol = INRol AND usuario.email = INEmail AND usuario.contrasena = INContrasena;
END$$

CREATE  PROCEDURE `sp_modificarFotoUsuario` (IN `inFoto` BLOB, IN `inRol` VARCHAR(15), IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16))  BEGIN
    DECLARE idUser INT;

    SELECT id INTO idUser
    FROM usuario
    WHERE usuario.email = inEmail AND usuario.contrasena = inContra AND usuario.rol = inRol;

    UPDATE usuario
    SET usuario.foto = inFoto
    WHERE idUser = usuario.id;

END$$

CREATE  PROCEDURE `sp_modificarUsuario` (IN `inNombre` VARCHAR(80), IN `inApellidoPat` VARCHAR(80), IN `inApellidoMat` VARCHAR(80), IN `inContra` VARCHAR(16), IN `inEmail` VARCHAR(100), IN `inTel` VARCHAR(10), IN `inSessionRol` VARCHAR(15), IN `inSessionEmail` VARCHAR(100), IN `inSessionContra` VARCHAR(16))  BEGIN
    UPDATE usuario
    SET usuario.nombre = inNombre,
        usuario.apellidoPat = inApellidoPat,
        usuario.apellidoMat = inApellidoMat,
        usuario.contrasena = inContra,
        usuario.email = inEmail,
        usuario.telefono = inTel
    WHERE usuario.rol = inSessionRol 
        AND usuario.email = inSessionEmail 
        AND usuario.contrasena = inSessionContra;
END$$

CREATE  PROCEDURE `sp_pasarNivel` (IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16), IN `inIdCurso` INT)  BEGIN
    DECLARE idAlumno INT;

    SELECT id INTO idAlumno
    FROM usuario
    WHERE inEmail = usuario.email AND inContra = usuario.contrasena;

    UPDATE estudiantescursando AS E
    SET E.nivelCursado = fn_pasarNivel(idAlumno, inIdCurso),
        E.cursoFinalizado = fn_revisaFinalCurso(idAlumno, inIdCurso),
        E.ultimoNivel = fn_revisaUltimoNivel(idAlumno, inIdCurso),
        E.fechaFinalCurso = IF(E.cursoFinalizado = 1, NOW(), NULL)
    WHERE E.idEstudiante = idAlumno AND E.idCursoCursado = inIdCurso AND E.cursoFinalizado < 1;

    CALL sp_calculaProgreso(inEmail, inContra, inIdCurso);
END$$

CREATE  PROCEDURE `sp_signupUsuario` (IN `inRol` VARCHAR(15), IN `inNombre` VARCHAR(80), IN `inApellidoPat` VARCHAR(80), IN `inApellidoMat` VARCHAR(80), IN `inContra` VARCHAR(16), IN `inEmail` VARCHAR(100), IN `inTel` VARCHAR(10))  BEGIN
    INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono, foto) 
    VALUES(inRol, inNombre, inApellidoPat, inApellidoMat, inContra, inEmail, inTel, "foto_perfil_default.jpg");
END$$

CREATE  PROCEDURE `sp_traeDatosCurso` (IN `inIdCurso` INT)  BEGIN
    DECLARE cantidad INT;
    SELECT fn_cantidadNivelesDelCurso(inIdCurso) INTO cantidad;

    SELECT curso.nombreCurso, curso.costo, cantidad
    FROM curso
    WHERE inIdCurso = curso.idCurso;
END$$

CREATE PROCEDURE `sp_traeFotoUsuario` (IN `inRol` VARCHAR(15), IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16))  BEGIN

    SELECT usuario.foto 
    FROM usuario 
    WHERE usuario.rol = inRol AND usuario.email = inEmail AND usuario.contrasena = inContra;
END$$

CREATE  PROCEDURE `sp_traeInfoCurso` (IN `inIdCurso` INT)  BEGIN
    SELECT curso.nombreCurso, curso.descripcionCurso, curso.fotoCurso, curso.videoCurso, categoria.nombreCat
    FROM curso
    INNER JOIN categoria
    ON curso.idCategoria = categoria.idCat
    WHERE curso.idCurso = inIdCurso;
END$$

CREATE  PROCEDURE `sp_traeInfoUsuario` (IN `INRol` VARCHAR(15), IN `INEmail` VARCHAR(100), IN `INContrasena` VARCHAR(16))  BEGIN
    SELECT id, nombre, apellidoPat, apellidoMat, contrasena, email, telefono, foto
    FROM usuario
    WHERE usuario.rol = INRol AND usuario.email = INEmail AND usuario.contrasena = INContrasena;
END$$

CREATE  PROCEDURE `sp_traeTodasCategorias` ()  BEGIN
    SELECT idCat1, nombreCat1
    FROM vw_categorias;
END$$

CREATE  PROCEDURE `sp_verificaEstudianteEnCurso` (IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16), IN `inIdCurso` INT)  BEGIN
    DECLARE idAlumno INT;

    SELECT id INTO idAlumno
    FROM usuario
    WHERE inEmail = usuario.email AND inContra = usuario.contrasena;

    SELECT E.idEstudiante, E.idMaestro, E.idCursoCursado, E.nivelCursado, E.cursoFinalizado, E.ultimoNivel, N.idNivel, N.nombreNivel, N.descripcionNivel, N.videoNivel, N.archivoNivel
    FROM estudiantesCursando AS E
    INNER JOIN nivel AS N
    ON E.idCursoCursado = N.idCursoNivel
    WHERE E.idCursoCursado = inIdCurso AND idAlumno = E.idEstudiante;

END$$

CREATE  PROCEDURE `sp_verificaIdUsuarioCreador` (IN `inRol` VARCHAR(15), IN `inEmail` VARCHAR(100), IN `inContra` VARCHAR(16), IN `inIdCurso` INT)  BEGIN
    SELECT usuario.id, curso.idUsuarioCreador
    FROM usuario
    INNER JOIN curso
    ON curso.idUsuarioCreador = usuario.id
    WHERE inRol = usuario.rol AND inEmail = usuario.email AND inContra = usuario.contrasena AND curso.idCurso = inIdCurso;
END$$

--
-- Functions
--
CREATE  FUNCTION `fn_buscaAMCreadorMensaje` (`idUsuario` INT) RETURNS VARCHAR(80) CHARSET utf8mb4 BEGIN
    DECLARE salAM VARCHAR(80);

    SELECT usuario.apellidoMat INTO salAM
    FROM usuario
    WHERE usuario.id = idUsuario;
RETURN salAM;
END$$

CREATE  FUNCTION `fn_buscaAPCreadorMensaje` (`idUsuario` INT) RETURNS VARCHAR(80) CHARSET utf8mb4 BEGIN
    DECLARE salAP VARCHAR(80);

    SELECT usuario.apellidoPat INTO salAP
    FROM usuario
    WHERE usuario.id = idUsuario;
RETURN salAP;
END$$

CREATE  FUNCTION `fn_buscaContraCreadorMensaje` (`idUsuario` INT) RETURNS VARCHAR(16) CHARSET utf8mb4 BEGIN
    DECLARE salContra VARCHAR(16);

    SELECT usuario.contrasena INTO salContra
    FROM usuario
    WHERE usuario.id = idUsuario;

RETURN salContra;
END$$

CREATE  FUNCTION `fn_buscaEmailCreadorMensaje` (`idUsuario` INT) RETURNS VARCHAR(100) CHARSET utf8mb4 BEGIN
    DECLARE salEmail VARCHAR(100);

    SELECT usuario.email INTO salEmail
    FROM usuario
    WHERE usuario.id = idUsuario;

RETURN salEmail;
END$$

CREATE  FUNCTION `fn_buscaFotoCreadorMensaje` (`idUsuario` INT) RETURNS BLOB BEGIN

    DECLARE salFoto BLOB;

    SELECT usuario.foto INTO salFoto
    FROM usuario
    WHERE usuario.id = idUsuario;

RETURN salFoto;
END$$

CREATE  FUNCTION `fn_buscaNombreCreadorMensaje` (`idUsuario` INT) RETURNS VARCHAR(80) CHARSET utf8mb4 BEGIN
    DECLARE salNombre VARCHAR(80);

    SELECT usuario.nombre INTO salNombre
    FROM usuario
    WHERE usuario.id = idUsuario;
RETURN salNombre;
END$$

CREATE  FUNCTION `fn_calculaProgreso` (`inIdEstudiante` INT, `inIdCurso` INT) RETURNS INT(11) BEGIN

    DECLARE nivelActual INT;
    DECLARE totalNiveles INT;
    DECLARE progress INT;

    SELECT E.nivelCursado INTO nivelActual
    FROM estudiantescursando AS E
    WHERE E.idEstudiante = inIdEstudiante AND E.idCursoCursado = inIdCurso;

    SELECT count(idNivel) INTO totalNiveles
    FROM nivel
    WHERE inIdCurso = nivel.idCursoNivel;

    SET progress = ROUND((nivelActual*100)/totalNiveles);

    UPDATE estudiantescursando AS E
    SET E.progreso = progress
    WHERE E.idEstudiante = inIdEstudiante AND E.idCursoCursado = inIdCurso;

RETURN progress;
END$$

CREATE  FUNCTION `fn_calculaTotalVentasTodosCursos` (`idProfesor` INT) RETURNS FLOAT BEGIN
    DECLARE total FLOAT;

    SELECT SUM(C.ventasTotales) INTO total
    FROM curso AS C
    WHERE C.idUsuarioCreador = idProfesor;

RETURN total;
END$$

CREATE  FUNCTION `fn_calculaValoracion` (`inIdCurso` INT) RETURNS FLOAT BEGIN


    DECLARE suma FLOAT;
    DECLARE cantidad INT;
    DECLARE total FLOAT;



    SELECT SUM(C.valoracionComent) INTO suma
    FROM comentariosencursos AS C
    WHERE C.idCursoComent = inIdCurso;

    SELECT count(C.idEstudianteComentCurso) INTO cantidad
    FROM comentariosencursos AS C
    WHERE C.idCursoComent = inIdCurso;

    SET total = suma/cantidad;

    UPDATE curso
    SET curso.valoracion = total
    WHERE curso.idCurso = inIdCurso;

RETURN total;
END$$

CREATE  FUNCTION `fn_calculaVentasTotales` (`inIdCurso` INT) RETURNS FLOAT BEGIN

    DECLARE cantidad FLOAT;

    SELECT SUM(V.precio) INTO cantidad
    FROM vw_costocursos AS V 
    WHERE V.idCurso1 = inIdCurso;

    UPDATE curso
    SET curso.ventasTotales = cantidad
    WHERE curso.idCurso = inIdCurso;

RETURN cantidad;
END$$

CREATE  FUNCTION `fn_cantidadComentariosCurso` (`inIdCurso` INT) RETURNS INT(11) BEGIN
    DECLARE cantidad INT;

    SELECT count(idEstudianteComentCurso) INTO cantidad
    FROM comentariosencursos
    WHERE inIdCurso = comentariosencursos.idCursoComent;

RETURN cantidad;
END$$

CREATE  FUNCTION `fn_cantidadDeNivelesCurso` (`inIdCurso` INT) RETURNS INT(11) BEGIN

    DECLARE totalNiveles INT;

    SELECT count(idNivel) INTO totalNiveles
    FROM nivel
    WHERE inIdCurso = nivel.idCursoNivel;

RETURN totalNiveles;
END$$

CREATE  FUNCTION `fn_cantidadNivelesDelCurso` (`idCurso` INT) RETURNS INT(11) BEGIN

    DECLARE cantidad INT;

    SELECT count(idNivel) into cantidad
    FROM nivel
    WHERE idCurso = nivel.idCursoNivel;

RETURN cantidad;
END$$

CREATE  FUNCTION `fn_comparaBuscador` (`inPalabra` VARCHAR(100), `inVariable` VARCHAR(100)) RETURNS INT(11) BEGIN

    DECLARE coincide BIT;
    DECLARE mininVariable VARCHAR(100);
    DECLARE mininPalabra VARCHAR(100);

    SET mininVariable = lower(inVariable);
    SET mininPalabra = lower(inPalabra);

    CASE 
        WHEN mininVariable LIKE '%mininPalabra%' THEN SET coincide = 1;
        WHEN mininVariable LIKE '%mininPalabra' THEN SET coincide = 1;
        WHEN mininVariable LIKE 'mininPalabra%' THEN SET coincide = 1;
    END CASE;


RETURN coincide;
END$$

CREATE  FUNCTION `fn_creaChat` (`idUsuarioActual` INT, `inIdDelOtro` INT) RETURNS VARCHAR(3) CHARSET utf8mb4 BEGIN
    INSERT INTO chat(idUsuario1, idUsuario2) VALUES(idUsuarioActual, inIdDelOtro);
RETURN "ok1";
END$$

CREATE  FUNCTION `fn_fechaDesarrollada` (`inIdUsuario` INT, `inIdCurso` INT) RETURNS VARCHAR(24) CHARSET utf8mb4 BEGIN

    DECLARE dia VARCHAR(2);
    DECLARE mes VARCHAR(2);
    DECLARE mesBien VARCHAR(10);
    DECLARE anio VARCHAR(4);
    DECLARE fechaFinal VARCHAR(24);

    SELECT substring(E.fechaFinalCurso, 9, 2) INTO dia
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT substring(E.fechaFinalCurso, 6, 2) INTO mes
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    CASE mes
        WHEN "01" THEN SET mesBien = "enero";
        WHEN "02" THEN SET mesBien = "febrero";
        WHEN "03" THEN SET mesBien = "marzo";
        WHEN "04" THEN SET mesBien = "abril";
        WHEN "05" THEN SET mesBien = "mayo";
        WHEN "06" THEN SET mesBien = "junio";
        WHEN "07" THEN SET mesBien = "julio";
        WHEN "08" THEN SET mesBien = "agosto";
        WHEN "09" THEN SET mesBien = "septiembre";
        WHEN "10" THEN SET mesBien = "octubre";
        WHEN "11" THEN SET mesBien = "noviembre";
        ELSE SET mesBien = "diciembre";
    END CASE;


    SELECT substring(E.fechaFinalCurso, 1, 4) INTO anio
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT CONCAT(dia," de ",mesBien," de ",anio) INTO fechaFinal;

RETURN fechaFinal;
END$$

CREATE  FUNCTION `fn_fechaDiaMesAnio` (`inIdCurso` INT, `inIdUsuario` INT) RETURNS VARCHAR(10) CHARSET utf8mb4 BEGIN
    DECLARE dia VARCHAR(2);
    DECLARE mes VARCHAR(2);
    DECLARE anio VARCHAR(4);
    DECLARE fechaFinal VARCHAR(10);

    SELECT substring(C.fechaComentCurso, 9, 2) INTO dia
    FROM comentariosencursos AS C
    INNER JOIN usuario AS U
    ON U.id = C.idEstudianteComentCurso
    WHERE inIdCurso = C.idCursoComent AND inIdUsuario = C.idEstudianteComentCurso;

    SELECT substring(C.fechaComentCurso, 6, 2) INTO mes
    FROM comentariosencursos AS C
    INNER JOIN usuario AS U
    ON U.id = C.idEstudianteComentCurso
    WHERE inIdCurso = C.idCursoComent AND inIdUsuario = C.idEstudianteComentCurso;

    SELECT substring(C.fechaComentCurso, 1, 4) INTO anio
    FROM comentariosencursos AS C
    INNER JOIN usuario AS U
    ON U.id = C.idEstudianteComentCurso
    WHERE inIdCurso = C.idCursoComent AND inIdUsuario = C.idEstudianteComentCurso;

    SELECT CONCAT(dia,"/",mes,"/",anio) INTO fechaFinal;

RETURN fechaFinal;
END$$

CREATE  FUNCTION `fn_fechaDiaMesAnioFinal` (`inIdCurso` INT, `inIdUsuario` INT) RETURNS VARCHAR(23) CHARSET utf8mb4 BEGIN

    DECLARE dia VARCHAR(2);
    DECLARE mes VARCHAR(2);
    DECLARE anio VARCHAR(4);
    DECLARE fechaFinal VARCHAR(10);

    SELECT substring(E.fechaFinalCurso, 9, 2) INTO dia
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT substring(E.fechaFinalCurso, 6, 2) INTO mes
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT substring(E.fechaFinalCurso, 1, 4) INTO anio
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT CONCAT(dia,"/",mes,"/",anio) INTO fechaFinal;

RETURN fechaFinal;
END$$

CREATE  FUNCTION `fn_fechaDiaMesAnioInicio` (`inIdCurso` INT, `inIdUsuario` INT) RETURNS VARCHAR(23) CHARSET utf8mb4 BEGIN

    DECLARE dia VARCHAR(2);
    DECLARE mes VARCHAR(2);
    DECLARE anio VARCHAR(4);
    DECLARE fechaFinal VARCHAR(10);

    SELECT substring(E.fechaInicioCurso, 9, 2) INTO dia
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT substring(E.fechaInicioCurso, 6, 2) INTO mes
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT substring(E.fechaInicioCurso, 1, 4) INTO anio
    FROM estudiantescursando AS E
    WHERE inIdCurso = E.idCursoCursado AND inIdUsuario = E.idEstudiante;

    SELECT CONCAT(dia,"/",mes,"/",anio) INTO fechaFinal;

RETURN fechaFinal;
END$$

CREATE  FUNCTION `fn_pasarNivel` (`inIdEstudiante` INT, `inIdCurso` INT) RETURNS INT(11) BEGIN
    DECLARE nuevoNivel INT;

    SELECT E.nivelCursado INTO nuevoNivel
    FROM estudiantesCursando as E
    WHERE inIdEstudiante = E.idEstudiante AND inIdCurso = E.idCursoCursado;

    SET nuevoNivel = nuevoNivel + 1;
RETURN nuevoNivel;
END$$

CREATE  FUNCTION `fn_revisaFinalCurso` (`inIdEstudianteCursando` INT, `inIdCurso` INT) RETURNS BIT(1) BEGIN

    DECLARE esElFinal BIT;

    SELECT IF(E.nivelCursado >= fn_cantidadNivelesDelCurso(inIdCurso), 1, 0) INTO esElFinal
    FROM estudiantescursando as E
    WHERE E.idEstudiante = inIdEstudianteCursando AND inIdCurso = E.idCursoCursado;

RETURN esElFinal;
END$$

CREATE  FUNCTION `fn_revisaNivelFinal` (`inIdEstudianteCursando` INT, `inIdCurso` INT) RETURNS BIT(1) BEGIN

    DECLARE esElFinal BIT;

    SELECT IF(E.nivelCursado >= fn_cantidadNivelesDelCurso(inIdCurso), 1, 0) INTO esElFinal
    FROM estudiantescursando as E
    WHERE E.idEstudiante = inIdEstudianteCursando AND inIdCurso = E.idCursoCursado;

RETURN esElFinal;
END$$

CREATE  FUNCTION `fn_revisaUltimoNivel` (`inIdEstudianteCursando` INT, `inIdCurso` INT) RETURNS BIT(1) BEGIN

    DECLARE esElFinal BIT;

    SELECT IF(E.nivelCursado + 1 >= fn_cantidadNivelesDelCurso(inIdCurso), 1, 0) INTO esElFinal
    FROM estudiantescursando as E
    WHERE E.idEstudiante = inIdEstudianteCursando AND inIdCurso = E.idCursoCursado;

RETURN esElFinal;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE IF NOT EXISTS `categoria` (
  `idCat` int(11) NOT NULL,
  `nombreCat` varchar(80) NOT NULL,
  `descripcionCat` varchar(1000) DEFAULT NULL,
  `fotoCat` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`idCat`, `nombreCat`, `descripcionCat`, `fotoCat`) VALUES
(1, 'Programacion', 'mucho codigo', 0x7469706f732d64652d706c616e6f2d63616265636572612d6f6b2e6a7067),
(2, 'Bases de Datos', 'querys', 0x6d7973716c5f6c6f676f2e706e67);

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE IF NOT EXISTS`chat` (
  `idChat` int(11) NOT NULL,
  `inactivo` bit(1) DEFAULT b'0',
  `idUsuario1` int(11) NOT NULL,
  `idUsuario2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`idChat`, `inactivo`, `idUsuario1`, `idUsuario2`) VALUES
(1, b'0', 1, 2),
(2, b'0', 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `comentariosencursos`
--

CREATE TABLE IF NOT EXISTS`comentariosencursos` (
  `idEstudianteComentCurso` int(11) NOT NULL,
  `idCursoComent` int(11) NOT NULL,
  `comentarioEnCurso` varchar(5000) NOT NULL,
  `fechaComentCurso` timestamp NOT NULL DEFAULT current_timestamp(),
  `valoracionComent` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comentariosencursos`
--

INSERT INTO `comentariosencursos` (`idEstudianteComentCurso`, `idCursoComent`, `comentarioEnCurso`, `fechaComentCurso`, `valoracionComent`) VALUES
(2, 3, 'Muy bueno', '2021-05-22 17:45:56', 80);

--
-- Triggers `comentariosencursos`
--
DELIMITER $$
CREATE TRIGGER `tg_calculaValoracion` AFTER INSERT ON `comentariosencursos` FOR EACH ROW BEGIN
	DECLARE valor FLOAT;
    
    DROP temporary table IF EXISTS temp1;
	CREATE temporary table IF NOT EXISTS temp1
    SELECT DISTINCT(C.idCursoComent) AS esteCurso, fn_calculaValoracion(C.idCursoComent) AS valor
    FROM comentariosencursos AS C;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `curso`
--

CREATE TABLE IF NOT EXISTS`curso` (
  `idCurso` int(11) NOT NULL,
  `nombreCurso` varchar(80) NOT NULL,
  `descripcionCurso` varchar(1000) DEFAULT NULL,
  `descCortaCurso` varchar(200) DEFAULT NULL,
  `costo` float NOT NULL,
  `videoCurso` blob DEFAULT NULL,
  `fotoCurso` blob DEFAULT NULL,
  `valoracion` float DEFAULT 0,
  `ventasTotales` float DEFAULT 0,
  `idUsuarioCreador` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `curso`
--

INSERT INTO `curso` (`idCurso`, `nombreCurso`, `descripcionCurso`, `descCortaCurso`, `costo`, `videoCurso`, `fotoCurso`, `valoracion`, `ventasTotales`, `idUsuarioCreador`, `idCategoria`) VALUES
(1, 'MAD', 'base de datos', 'Modelos de blabal', 88, 0x437572736f5f64655f4d7953514c2d5175655f65735f4d7953514c5f2e6d7034, 0x5048505f6c6f676f2e6a7067, 0, 88, 1, 1),
(3, 'SQL server', ' aqui veremos como gestionar bases de dats y mucho mas', 'aqui veremos como gestionar basesde datos', 1000, 0x437572736f5f64655f4d7953514c2d5175655f65735f4d7953514c5f2e6d7034, 0x6d7973716c5f6c6f676f2e706e67, 80, 1000, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `estudiantescursando`
--

CREATE TABLE IF NOT EXISTS`estudiantescursando` (
  `idEstudiante` int(11) NOT NULL,
  `idCursoCursado` int(11) NOT NULL,
  `idMaestro` int(11) NOT NULL,
  `nivelCursado` int(11) DEFAULT 1,
  `cursoFinalizado` bit(1) DEFAULT b'0',
  `fechaInicioCurso` timestamp NULL DEFAULT current_timestamp(),
  `fechaFinalCurso` timestamp NULL DEFAULT NULL,
  `ultimoNivel` bit(1) DEFAULT b'0',
  `progreso` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `estudiantescursando`
--

INSERT INTO `estudiantescursando` (`idEstudiante`, `idCursoCursado`, `idMaestro`, `nivelCursado`, `cursoFinalizado`, `fechaInicioCurso`, `fechaFinalCurso`, `ultimoNivel`, `progreso`) VALUES
(2, 1, 1, 1, b'0', '2021-05-22 05:03:50', NULL, b'0', 0),
(2, 3, 4, 4, b'1', '2021-05-22 17:44:05', '2021-05-22 17:45:28', b'1', 100);

--
-- Triggers `estudiantescursando`
--
DELIMITER $$
CREATE TRIGGER `tg_calculaVentasTotales` AFTER INSERT ON `estudiantescursando` FOR EACH ROW BEGIN
	
    DECLARE valor FLOAT;
    
			DROP temporary table IF EXISTS temp;
			CREATE temporary table IF NOT EXISTS temp
			SELECT fn_calculaVentasTotales(E.idCursoCursado) 
			FROM estudiantescursando AS E;

	
    
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mensajechat`
--

CREATE TABLE IF NOT EXISTS`mensajechat` (
  `numMensaje` bigint(20) NOT NULL,
  `idChatMensajes` int(11) NOT NULL,
  `esIdUsuario1` bit(1) DEFAULT b'0',
  `esIdUsuario2` bit(1) DEFAULT b'0',
  `mensaje` varchar(1000) NOT NULL,
  `fechaMensajeChat` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mensajechat`
--

INSERT INTO `mensajechat` (`numMensaje`, `idChatMensajes`, `esIdUsuario1`, `esIdUsuario2`, `mensaje`, `fechaMensajeChat`) VALUES
(2, 1, b'1', b'0', 'hey', '2021-05-22 05:05:53'),
(3, 1, b'0', b'1', 'como te va en tu curso jovenazo?', '2021-05-22 05:07:18'),
(4, 2, b'1', b'0', 'hola felicidades por concluir el curso', '2021-05-22 17:50:21'),
(5, 2, b'0', b'1', 'gracias', '2021-05-22 17:51:21');

-- --------------------------------------------------------

--
-- Table structure for table `nivel`
--

CREATE TABLE IF NOT EXISTS`nivel` (
  `idNivel` int(11) NOT NULL,
  `nombreNivel` varchar(80) NOT NULL,
  `descripcionNivel` varchar(1000) DEFAULT NULL,
  `fotoNivel` blob DEFAULT NULL,
  `videoNivel` blob DEFAULT NULL,
  `archivoNivel` blob DEFAULT NULL,
  `idCursoNivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nivel`
--

INSERT INTO `nivel` (`idNivel`, `nombreNivel`, `descripcionNivel`, `fotoNivel`, `videoNivel`, `archivoNivel`, `idCursoNivel`) VALUES
(1, 'Create tables', 'aquí se enseña como crear tablas', NULL, 0x437572736f5f48544d4c5f416772656761725f426f6f7473747261702e6d7034, 0x677569615f6d7973716c2e706466, 3),
(2, 'Update, Delete, Insert', 'aqui se ensenaran las funciones update, delete, Insert', NULL, 0x437572736f5f4d7953514c5f5570646174652c5f44656c6574655f795f5472756e636174652e6d7034, 0x677569615f6d7973716c2e706466, 3),
(3, 'Stored procedures', 'aqui aprenderemos a crear stored procedures', NULL, 0x437572736f5f4d7953514c5f53746f7265645f50726f6365647572652e6d7034, 0x677569615f6d7973716c2e706466, 3);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE IF NOT EXISTS`usuario` (
  `id` int(11) NOT NULL,
  `rol` varchar(15) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `apellidoPat` varchar(80) NOT NULL,
  `apellidoMat` varchar(80) NOT NULL,
  `contrasena` varchar(16) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `foto` blob DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `rol`, `nombre`, `apellidoPat`, `apellidoMat`, `contrasena`, `email`, `telefono`, `foto`, `fecha_registro`) VALUES
(1, 'escuela', 'gonzalo', 'Aguilar', 'Galeana', 'Gonzi123_', 'gonzi@gmail.com', '8186846391', 0x62656e2d6e6963686f6c61732d62656e6e6963686f6c61732d6475736b2d646561646f726269742d30322e6a7067, '2021-05-22 04:53:16'),
(2, 'estudiante', 'Dieguin', 'Alberto', 'Yes', 'Diego123_', 'diego@gmail.com', '8186846386', 0x7265747261746f2d7072696d65722d706c616e6f2d686f6d6272652d6a6f76656e5f3135383539352d353134392e6a7067, '2021-05-22 05:02:45'),
(3, 'escuela', 'Pedro', 'Villarreal', 'Martinez', 'Pedro123_', 'pedro@gmail.com', '8186846391', 0x666f746f5f70657266696c5f64656661756c742e6a7067, '2021-05-22 16:57:26'),
(4, 'escuela', 'Karina', 'Aguilar', 'Dolores', '123456K_', 'karina@gmail.com', '8126854720', 0x36316139653866373963653639333165643137386133663264386664616336332e6a7067, '2021-05-22 17:25:08');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_categorias`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS`vw_categorias` (
`idCat1` int(11)
,`nombreCat1` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_costocursos`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS`vw_costocursos` (
`precio` float
,`idCurso1` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_cursoscursados`
-- (See below for the actual view)
--
CREATE TABLE IF NOT EXISTS`vw_cursoscursados` (
`idEstudiante` int(11)
,`nombreCurso` varchar(80)
,`fechaFinalCurso` timestamp
,`nombreUsuario` varchar(80)
,`apellidoPatUser` varchar(80)
,`apellidoMatUser` varchar(80)
,`idCursoCursado` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_categorias`
--
DROP TABLE IF EXISTS `vw_categorias`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vw_categorias`  AS SELECT `categoria`.`idCat` AS `idCat1`, `categoria`.`nombreCat` AS `nombreCat1` FROM `categoria` ;

-- --------------------------------------------------------

--
-- Structure for view `vw_costocursos`
--
DROP TABLE IF EXISTS `vw_costocursos`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vw_costocursos`  AS SELECT `c`.`costo` AS `precio`, `c`.`idCurso` AS `idCurso1` FROM (`estudiantescursando` `e` join `curso` `c` on(`c`.`idCurso` = `e`.`idCursoCursado`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_cursoscursados`
--
DROP TABLE IF EXISTS `vw_cursoscursados`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vw_cursoscursados`  AS SELECT `e`.`idEstudiante` AS `idEstudiante`, `c`.`nombreCurso` AS `nombreCurso`, `e`.`fechaFinalCurso` AS `fechaFinalCurso`, `u`.`nombre` AS `nombreUsuario`, `u`.`apellidoPat` AS `apellidoPatUser`, `u`.`apellidoMat` AS `apellidoMatUser`, `e`.`idCursoCursado` AS `idCursoCursado` FROM ((`estudiantescursando` `e` join `curso` `c` on(`c`.`idCurso` = `e`.`idCursoCursado`)) join `usuario` `u` on(`u`.`id` = `e`.`idMaestro`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCat`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`idChat`),
  ADD KEY `idUsuario1` (`idUsuario1`),
  ADD KEY `idUsuario2` (`idUsuario2`);

--
-- Indexes for table `comentariosencursos`
--
ALTER TABLE `comentariosencursos`
  ADD PRIMARY KEY (`idEstudianteComentCurso`,`idCursoComent`),
  ADD KEY `idCursoComent` (`idCursoComent`);

--
-- Indexes for table `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`idCurso`),
  ADD KEY `idUsuarioCreador` (`idUsuarioCreador`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indexes for table `estudiantescursando`
--
ALTER TABLE `estudiantescursando`
  ADD PRIMARY KEY (`idEstudiante`,`idCursoCursado`),
  ADD KEY `idCursoCursado` (`idCursoCursado`),
  ADD KEY `idMaestro` (`idMaestro`);

--
-- Indexes for table `mensajechat`
--
ALTER TABLE `mensajechat`
  ADD PRIMARY KEY (`numMensaje`),
  ADD KEY `idChatMensajes` (`idChatMensajes`);

--
-- Indexes for table `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`idNivel`),
  ADD KEY `idCursoNivel` (`idCursoNivel`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `idChat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `curso`
--
ALTER TABLE `curso`
  MODIFY `idCurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mensajechat`
--
ALTER TABLE `mensajechat`
  MODIFY `numMensaje` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nivel`
--
ALTER TABLE `nivel`
  MODIFY `idNivel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`idUsuario1`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `chat_ibfk_2` FOREIGN KEY (`idUsuario2`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `comentariosencursos`
--
ALTER TABLE `comentariosencursos`
  ADD CONSTRAINT `comentariosencursos_ibfk_1` FOREIGN KEY (`idEstudianteComentCurso`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `comentariosencursos_ibfk_2` FOREIGN KEY (`idCursoComent`) REFERENCES `curso` (`idCurso`);

--
-- Constraints for table `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`idUsuarioCreador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `curso_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCat`);

--
-- Constraints for table `estudiantescursando`
--
ALTER TABLE `estudiantescursando`
  ADD CONSTRAINT `estudiantescursando_ibfk_1` FOREIGN KEY (`idEstudiante`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `estudiantescursando_ibfk_2` FOREIGN KEY (`idCursoCursado`) REFERENCES `curso` (`idCurso`),
  ADD CONSTRAINT `estudiantescursando_ibfk_3` FOREIGN KEY (`idMaestro`) REFERENCES `curso` (`idUsuarioCreador`);

--
-- Constraints for table `mensajechat`
--
ALTER TABLE `mensajechat`
  ADD CONSTRAINT `mensajechat_ibfk_1` FOREIGN KEY (`idChatMensajes`) REFERENCES `chat` (`idChat`);

--
-- Constraints for table `nivel`
--
ALTER TABLE `nivel`
  ADD CONSTRAINT `nivel_ibfk_1` FOREIGN KEY (`idCursoNivel`) REFERENCES `curso` (`idCurso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
