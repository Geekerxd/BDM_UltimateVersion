CREATE DATABASE webstudy;
USE webstudy;

CREATE TABLE IF NOT EXISTS usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(15) NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    apellidoPat VARCHAR(80) NOT NULL,
    apellidoMat VARCHAR(80) NOT NULL,
    contrasena VARCHAR(16) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(10),
    foto BLOB,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE usuario;
DELETE FROM usuario WHERE usuario.id = 1;

INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono) VALUES ("escuela", "Javier", "Lopez", "Gonzalez", "123456J_", "javier@gmail.com", "8123432981");
UPDATE usuario SET contrasena = "123456Q_" WHERE id=4;

SELECT* FROM usuario;

CREATE TABLE IF NOT EXISTS categoria (
	idCat INT AUTO_INCREMENT PRIMARY KEY,
    nombreCat VARCHAR(80) NOT NULL,
    descripcionCat VARCHAR(1000),
    fotoCat BLOB
);

DROP TABLE categoria;

SELECT* FROM categoria;

CREATE TABLE IF NOT EXISTS curso (
	idCurso INT AUTO_INCREMENT PRIMARY KEY,
    nombreCurso VARCHAR(80) NOT NULL,
    descripcionCurso VARCHAR(1000),
    descCortaCurso VARCHAR(200),
    costo FLOAT NOT NULL,
    videoCurso BLOB,
    fotoCurso BLOB,
    valoracion FLOAT DEFAULT 0.0,
    ventasTotales FLOAT DEFAULT 0.0,
    idUsuarioCreador INT NOT NULL,
    idCategoria INT NOT NULL,
    FOREIGN KEY (idUsuarioCreador) REFERENCES usuario(id),
    FOREIGN KEY (idCategoria) REFERENCES categoria (idCat)
);


DROP TABLE curso;

DELETE FROM curso WHERE curso.idCurso = 15;

SELECT* FROM curso;

CREATE TABLE IF NOT EXISTS nivel (
	idNivel INT AUTO_INCREMENT PRIMARY KEY,
    nombreNivel VARCHAR(80) NOT NULL,
    descripcionNivel VARCHAR(1000),
    fotoNivel BLOB,
    videoNivel BLOB,
    archivoNivel BLOB,
    idCursoNivel INT NOT NULL,
    FOREIGN KEY (idCursoNivel) REFERENCES curso (idCurso)
);

DROP TABLE nivel;
DELETE FROM nivel WHERE nivel.idNivel = 2;
SELECT* FROM nivel;

CREATE TABLE IF NOT EXISTS estudiantesCursando (
	idEstudiante INT NOT NULL,
    idCursoCursado INT NOT NULL,
    idMaestro INT NOT NULL,
    FOREIGN KEY (idEstudiante) REFERENCES usuario (id),
    FOREIGN KEY (idCursoCursado) REFERENCES curso (idCurso),
    FOREIGN KEY (idMaestro) REFERENCES curso (idUsuarioCreador),
    PRIMARY KEY(idEstudiante, idCursoCursado),
    nivelCursado INT DEFAULT 1,
    cursoFinalizado BIT DEFAULT 0,
    fechaInicioCurso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fechaFinalCurso TIMESTAMP DEFAULT NULL,
    ultimoNivel BIT DEFAULT 0,
    progreso FLOAT DEFAULT 0
);

SELECT* FROM estudiantesCursando;

DELETE FROM estudiantesCursando WHERE idEstudiante = 5;

DROP TABLE estudiantesCursando;

CREATE TABLE IF NOT EXISTS comentariosEnCursos (
	idEstudianteComentCurso INT NOT NULL,
    idCursoComent INT NOT NULL,
    FOREIGN KEY (idEstudianteComentCurso) REFERENCES usuario (id),
    FOREIGN KEY (idCursoComent) REFERENCES curso (idCurso),
    PRIMARY KEY(idEstudianteComentCurso, idCursoComent),
    comentarioEnCurso VARCHAR(5000) NOT NULL,
    fechaComentCurso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valoracionComent FLOAT DEFAULT 0.0
);
SELECT* FROM comentariosEnCursos;

DELETE FROM comentariosEnCursos WHERE idEstudianteComentCurso = 3;

DROP TABLE comentariosEnCursos;

CREATE TABLE IF NOT EXISTS chat (
	idChat INT AUTO_INCREMENT PRIMARY KEY,
    inactivo BIT DEFAULT 0,
	idUsuario1 INT NOT NULL,
    idUsuario2 INT NOT NULL,
    FOREIGN KEY (idUsuario1) REFERENCES usuario(id),
    FOREIGN KEY (idUsuario2) REFERENCES usuario(id)
);

SELECT * FROM chat;

delete FROM chat where idChat = 6;
INSERT INTO chat(idUsuario1, idUsuario2) VALUES(2,4);

DROP TABLE chat;

CREATE TABLE IF NOT EXISTS mensajeChat (
	numMensaje BIGINT AUTO_INCREMENT PRIMARY KEY,
    idChatMensajes INT NOT NULL,
    FOREIGN KEY (idChatMensajes) REFERENCES chat(idChat),
    esIdUsuario1 BIT DEFAULT 0,
    esIdUsuario2 BIT DEFAULT 0,
    mensaje VARCHAR(1000) NOT NULL,
    fechaMensajeChat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM mensajeChat;

delete FROM mensajeChat where numMensaje = 3;

INSERT INTO mensajeChat(idChatMensajes, esIdUsuario1, esIdUsuario2, mensaje) VALUES(1,1,0,"hola soy Aron");

DROP TABLE mensajeChat;

CALL `webstudy`.`sp_signupUsuario`("escuela", "Omar", "Alvarado", "Rodriguez", "123456O_", "Omar@gmail.com", "8123432981");
CALL `webstudy`.`sp_loginUsuario`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");
CALL `webstudy`.`sp_createCategory`("base de datos","muchas cosas");
CALL `webstudy`.`sp_getCategorias`();

CALL `webstudy`.`sp_createCurso`("css", "estilos", "lalalalalallalalalala", "2000", 1, "escuela", "123456B_", "javier@gmail.com");

CALL `webstudy`.`sp_getCursos`();

CALL `webstudy`.`sp_traeInfoUsuario`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");

CALL `webstudy`.`sp_modificarUsuario`("Aron", "Almaraz", "Caballero", "123456A_", "Aron@gmail.com", "8126854888", "escuela", "Luis@gmail.com", "123456L_");

CALL `webstudy`.`sp_traeInfoCurso`(1);

CALL `webstudy`.`sp_createNivel`("drop table mysql", "aqui veras drop table de mysql", 4);

CALL `webstudy`.`sp_verificaIdUsuarioCreador`("escuela", "javier@gmail.com", "123456B_", 4);

CALL `webstudy`.`sp_inscribeUsuario`("fer@gmail.com", "123456F_", 4);

CALL `webstudy`.`sp_traeDatosCurso`(2);

CALL `webstudy`.`sp_verificaEstudianteEnCurso`("dani_g.mazatan@hotmail.com", "123456A_", 1);

CALL `webstudy`.`sp_pasarNivel`("karina@gmail.com", "123456K_", 16);

CALL `webstudy`.`sp_cargaNombreCursoEvaluar`(4);

CALL `webstudy`.`sp_createComentarioCurso`(60.0, "hay mejores", "karina@gmail.com", "123456K_", 16);
SELECT usuario.id 
    FROM usuario
    WHERE usuario.email = "karina@gmail.com" AND usuario.contrasena = "123456K_";



CALL `webstudy`.`sp_cargaComentariosCurso`(4);
    
CALL `webstudy`.`sp_calculaProgreso`("dani_g.mazatan@hotmail.com", "123456A_", 1);

CALL `webstudy`.`sp_cargaHistorial`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");

CALL `webstudy`.`sp_getDiploma`("dani_g.mazatan@hotmail.com", "123456A_", 4);

SHOW TRIGGERS;

CALL `webstudy`.`sp_cargaCursosProfesor`("Omar@gmail.com", "123456O_");

CALL `webstudy`.`sp_getAlumnosDeCurso`(4);

CALL `webstudy`.`sp_buscadorUsuarios`("r", "Aron@gmail.com", "123456A_");

CALL `webstudy`.`sp_cargaChats`("Aron@gmail.com", "123456A_");

CALL `webstudy`.`sp_estableceChat`(1);

CALL `webstudy`.`sp_creaChat`("3", "Aron@gmail.com", "123456A_");

CALL `webstudy`.`sp_creaMensaje`("tambien bien",1, "Aron@gmail.com", "123456A_");
CALL `webstudy`.`sp_creaMensaje`("hola, yo Daniel",1, "dani_g.mazatan@hotmail.com", "123456A_");

CALL `webstudy`.`sp_getDatosCat`(2);

CALL `webstudy`.`sp_getCursosCat`(1);

CALL `webstudy`.`sp_traeFotoUsuario`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");