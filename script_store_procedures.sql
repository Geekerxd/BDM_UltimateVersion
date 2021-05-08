CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_loginUsuario`(
IN INEmail varchar(100),
IN INContrasena varchar(8)
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
WHERE email = INEmail AND contrasena = INContrasena;

END;