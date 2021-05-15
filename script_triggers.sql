DELIMITER //
CREATE TRIGGER tg_calculaValoracion AFTER INSERT ON comentariosencursos
FOR EACH ROW
BEGIN
	DECLARE valor FLOAT;
    
    SELECT DISTINCT(C.idCursoComent) AS esteCurso, fn_calculaValoracion(C.idCursoComent) AS valor
    FROM comentariosencursos AS C;

END// 
delimiter ;

DROP TRIGGER tg_calculaValoracion;