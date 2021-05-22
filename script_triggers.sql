DELIMITER //
CREATE TRIGGER tg_calculaValoracion AFTER INSERT ON comentariosencursos
FOR EACH ROW
BEGIN
	DECLARE valor FLOAT;
    
    DROP temporary table IF EXISTS temp1;
	CREATE temporary table IF NOT EXISTS temp1
    SELECT DISTINCT(C.idCursoComent) AS esteCurso, fn_calculaValoracion(C.idCursoComent) AS valor
    FROM comentariosencursos AS C;

END// 
delimiter ;

DROP TRIGGER tg_calculaValoracion;

DELIMITER //
CREATE TRIGGER tg_calculaVentasTotales AFTER INSERT ON estudiantescursando
FOR EACH ROW
BEGIN
	
    DECLARE valor FLOAT;
    
			DROP temporary table IF EXISTS temp;
			CREATE temporary table IF NOT EXISTS temp
			SELECT fn_calculaVentasTotales(E.idCursoCursado) 
			FROM estudiantescursando AS E;

	
    
    
END// 
delimiter ;

DROP TRIGGER tg_calculaVentasTotales;