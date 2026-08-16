# PROCEDIMIENTO QUE INDIQUE SI ES POSIBLE
# INSERTAR UN EMPLEADO EN UNA OFICINA, se debe verificar que exista la oficina previamente
# y que existe el supervisor 
DELIMITER $
CREATE PROCEDURE verificarInsertarEmp(in numeroEmp int, in apellido varchar(50), in exten varchar(10), 
in email varchar(100), in codOfi int, in supervisor int, in titulo varchar(50))
    BEGIN
    DECLARE numeroOfi int default 0;
    DECLARE numeroSuper int default 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END; 
    
    Set numeroOfi = (select officeCode from offices where officeCode = codOFi);
    set numeroSuper = (select reportsTo from employees where reportsTo = supervisor);
    
    START TRANSACTION;
    IF numeroOfi is not null AND numeroSuper is not null THEN
		insert into employees values(numeroEmp, apellido, exten, email, codOfi, supervisor, titulo);
        COMMIT;
	ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN LOS DATOS' ;
    END IF;

End;
$
DELIMITER ;

