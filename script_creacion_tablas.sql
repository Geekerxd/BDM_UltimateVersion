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
DELETE FROM usuario WHERE usuario.id = 7;

INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono) VALUES ("escuela", "Javier", "Lopez", "Gonzalez", "123456B_", "javier@gmail.com", "8123432981");

SELECT* FROM usuario;

CREATE TABLE IF NOT EXISTS categoria (
	idCat INT AUTO_INCREMENT PRIMARY KEY,
    nombreCat VARCHAR(80) NOT NULL,
    descripcionCat VARCHAR(1000),
    fotoCat VARCHAR(2000)
);

DROP TABLE categoria;

SELECT* FROM categoria;

CREATE TABLE IF NOT EXISTS curso (
	idCurso INT AUTO_INCREMENT PRIMARY KEY,
    nombreCurso VARCHAR(80) NOT NULL,
    descripcionCurso VARCHAR(1000),
    descCortaCurso VARCHAR(200),
    costo FLOAT NOT NULL,
    videoCurso VARCHAR(2000),
    fotoCurso VARCHAR(2000),
    valoracion FLOAT DEFAULT 0.0,
    idUsuarioCreador INT NOT NULL,
    idCategoria INT NOT NULL,
    FOREIGN KEY (idUsuarioCreador) REFERENCES usuario(id),
    FOREIGN KEY (idCategoria) REFERENCES categoria (idCat)
);

DROP TABLE curso;

DELETE FROM curso WHERE curso.id = 14;

SELECT* FROM curso;

CREATE TABLE IF NOT EXISTS nivel (
	idNivel INT AUTO_INCREMENT PRIMARY KEY,
    nombreNivel VARCHAR(80) NOT NULL,
    descripcionNivel VARCHAR(1000),
    fotoNivel VARCHAR(2000),
    videoNivel VARCHAR(2000) NOT NULL,
    archivoNivel VARCHAR(2000) NOT NULL,
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

DROP TABLE estudiantesCursando;

CREATE TABLE IF NOT EXISTS comentariosEnCursos (
	idEstudianteComentCurso INT NOT NULL,
    idCursoComent INT NOT NULL,
    FOREIGN KEY (idEstudianteComentCurso) REFERENCES usuario (id),
    FOREIGN KEY (idCursoComent) REFERENCES curso (idCurso),
    PRIMARY KEY(idEstudianteComentCurso, idCursoComent),
    comentarioEnCurso VARCHAR(300) NOT NULL,
    fechaComentCurso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valoracionComent FLOAT DEFAULT 0.0
);
SELECT* FROM comentariosEnCursos;

DROP TABLE comentariosEnCursos;

CREATE TABLE IF NOT EXISTS chat (
	idChat INT AUTO_INCREMENT PRIMARY KEY,
	idUsuario1 INT NOT NULL,
    idUsuario2 INT NOT NULL,
    FOREIGN KEY (idUsuario1) REFERENCES usuario(id),
    FOREIGN KEY (idUsuario2) REFERENCES usuario(id)
);

DROP TABLE chat;

CREATE TABLE IF NOT EXISTS mensajeChat (
	numMensaje BIGINT AUTO_INCREMENT PRIMARY KEY,
    idChat INT NOT NULL,
    FOREIGN KEY (idChat) REFERENCES chat(idChat),
    mensaje VARCHAR(300) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE mensajeChat;

CALL `webstudy`.`sp_signupUsuario`("escuela", "Omar", "Alvarado", "Rodriguez", "123456O_", "Omar@gmail.com", "8123432981");
CALL `webstudy`.`sp_loginUsuario`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");
CALL `webstudy`.`sp_createCategory`("base de datos","muchas cosas");
CALL `webstudy`.`sp_getCategorias`();

CALL `webstudy`.`sp_createCurso`("css", "estilos", "lalalalalallalalalala", "2000", 1, "escuela", "123456B_", "javier@gmail.com");

CALL `webstudy`.`sp_getCursos`();

CALL `webstudy`.`sp_traeInfoUsuario`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");

CALL `webstudy`.`sp_modificarUsuario`("Aron", "Almaraz", "Caballero", "123456A_", "Aron@gmail.com", "8126854888", "escuela", "Luis@gmail.com", "123456L_");

CALL `webstudy`.`sp_traeInfoCurso`(4);

CALL `webstudy`.`sp_createNivel`("drop table mysql", "aqui veras drop table de mysql", 4);

CALL `webstudy`.`sp_verificaIdUsuarioCreador`("escuela", "javier@gmail.com", "123456B_", 1);

CALL `webstudy`.`sp_inscribeUsuario`("dani_g.mazatan@hotmail.com", "123456A_", 1);

CALL `webstudy`.`sp_traeDatosCurso`(2);

CALL `webstudy`.`sp_verificaEstudianteEnCurso`("dani_g.mazatan@hotmail.com", "123456A_", 2);