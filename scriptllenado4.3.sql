
-- 4.3 

-- Agarro la base de datos caso1 para asegurarse de que todas las operaciones se realicen en la base de datos correcta.
USE caso1;

-- aseguro que el tipo de evento de log 'Login' exista en la tabla LogTypes. Si ya existe, actualiza su nombre. Esto es necesario para las claves foráneas en la tabla Logs.
INSERT INTO LogTypes (logtypeID, name, ref1Desc, ref2Desc, val1Desc, val2Desc, last_update)
VALUES (1, 'Login', 'User login event', 'N/A', 'N/A', 'N/A', NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

--  inserto un registro de fuente de log 'Application' en la tabla LogSources, asegurando que exista para las claves foráneas en Logs.
INSERT INTO LogSources (logsource_id, name, last_update)
VALUES (1, 'Application', NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- me aseguro de que el nivel de severidad 'Low' esté presente en la tabla LogSeverity, para ser usado como referencia en los registros de log.
INSERT INTO LogSeverity (logseverity_id, name, last_update)
VALUES (1, 'Low', NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

DROP PROCEDURE IF EXISTS populate_login_logs;
DELIMITER $$

CREATE PROCEDURE populate_login_logs()
BEGIN
    -- Declarar variables al inicio
    DECLARE uid INT;
    DECLARE uemail VARCHAR(100);
    DECLARE counter INT;
    DECLARE loginCount INT;
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR 
        SELECT userid, LOWER(CONCAT(firstname, '.', lastname, '@example.com'))
        FROM Usuarios;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- aca me aseguro de que existan los registros en las tablas referenciadas
    INSERT INTO LogTypes (logtypeID, name, ref1Desc, ref2Desc, val1Desc, val2Desc, last_update)
    VALUES (1, 'Login', 'User login event', 'N/A', 'N/A', 'N/A', NOW())
    ON DUPLICATE KEY UPDATE name = VALUES(name);
    
    INSERT INTO LogSources (logsource_id, name, last_update)
    VALUES (1, 'Application', NOW())
    ON DUPLICATE KEY UPDATE name = VALUES(name);
    
    INSERT INTO LogSeverity (logseverity_id, name, last_update)
    VALUES (1, 'Low', NOW())
    ON DUPLICATE KEY UPDATE name = VALUES(name);
    
    -- despues de invistigar mas metodos por mi cuenta, escogi el de abrir el cursor cur para 
    -- recorrer todos los usuarios de la tabla Usuarios, obteniendo su ID y correo electrónico para crear registros de log.
    OPEN cur;
    my_loop: LOOP
        FETCH cur INTO uid, uemail;
        IF done = 1 THEN
            LEAVE my_loop;
        END IF;
        
        -- genero un número aleatorio de eventos de login (entre 1 y 10)
        SET loginCount = FLOOR(1 + RAND()*10);
        SET counter = 1;
        WHILE counter <= loginCount DO
            INSERT INTO Logs (
                description, 
                postTime, 
                computer, 
                username, 
                trace, 
                referenceID1, 
                last_update, 
                logtypeID, 
                logsource_id, 
                logseverity_id
            )
            VALUES (
                'User login', 
                NOW(), 
                'PC', 
                uemail, 
                '',           -- le deje valor vacío a trace
                uid, 
                NOW(), 
                1,            -- logtypeID (de LogTypes)
                1,            -- logsource_id (de LogSources)
                1             -- logseverity_id (de LogSeverity)
            );
            SET counter = counter + 1;
        END WHILE;
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;

CALL populate_login_logs();