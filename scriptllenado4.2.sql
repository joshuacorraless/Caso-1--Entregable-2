
-- 4.2 
-- Agarro la base de datos caso1 para asegurarse de que todas las operaciones se realicen en la base de datos correcta.
USE caso1;

DROP PROCEDURE IF EXISTS add_subscription_users;
DELIMITER //

CREATE PROCEDURE add_subscription_users()
BEGIN
    -- Declarar variables al inicio
    DECLARE i INT DEFAULT 1;
    DECLARE planRand INT;
    DECLARE daysLeft INT;
    DECLARE adquisitionDate DATE;
    DECLARE firstName VARCHAR(50);
    DECLARE lastName VARCHAR(50);
    
    -- inserto tres planes de suscripción con descripciones y URL de los logotipos. Si los planes ya existen, se actualizan sus descripciones y logotipos.s
    INSERT INTO Suscripcion (suscriptionid, description, logoURL)
    VALUES 
        (1, 'Plan Mensual', 'https://example.com/logo_mensual.png'),
        (2, 'Plan Anual', 'https://example.com/logo_anual.png'),
        (3, 'Plan Familiar', 'https://example.com/logo_familiar.png')
    ON DUPLICATE KEY UPDATE 
        description = VALUES(description),
        logoURL = VALUES(logoURL);

	--  inserto los precios de los tres planes de suscripción (mensual, anual y familiar). Si ya existen, solo se actualiza el monto de los planes.
    INSERT INTO PlanPrices (planPriceID, amount, recurrencyType, postTime, endDate, current, suscriptionid)
    VALUES 
        (1, 5000,   'MONTH', NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 1, 1),
        (2, 45000,  'YEAR',  NOW(), DATE_ADD(NOW(), INTERVAL 365 DAY), 1, 2),
        (3, 12000,  'MONTH', NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 1, 3)
    ON DUPLICATE KEY UPDATE 
        amount = VALUES(amount);
        
	-- inserto las características asociadas a cada plan de suscripción, asegurando que estén habilitadas. Si las características ya existen, se actualizan.
    INSERT INTO FeaturePerPlan (featurePerPlanID, value, enabled, suscriptionid)
    VALUES
        (1, 'Acceso ilimitado', 1, 1),
        (2, 'Soporte Premium',  1, 2),
        (3, 'Acceso Familiar',  1, 3)
    ON DUPLICATE KEY UPDATE
        value = VALUES(value),
        enabled = VALUES(enabled);

    -- insertar 20 nuevos usuarios y asignarles un plan de suscripción con vencimiento en < 15 días
    SET @first_names = 'Carlos,Juan,Andrés,Pedro,José,Manuel,Francisco,David,Diego,Ricardo,Martin,Raul,Alberto,Felipe,Guillermo,Roberto,Oscar,Sergio,Armando,Eduardo';
    SET @last_names  = 'Sanchez,Martinez,Rodriguez,Gomez,Lopez,Diaz,Garcia,Romero,Fernandez,Torres,Castro,Alvarez,Silva,Ramirez,Morales,Perez,Rivera,Ruiz,Mendoza,Vargas';
     -- se utiliza un bucle para crear 20 usuarios. En cada iteración, se genera un nombre y apellido aleatorio para un nuevo usuario. el profe pedia 13+.
    WHILE i <= 20 DO
        SET firstName = SUBSTRING_INDEX(SUBSTRING_INDEX(@first_names, ',', i), ',', -1);
        SET lastName  = SUBSTRING_INDEX(SUBSTRING_INDEX(@last_names, ',', i), ',', -1);
        
        INSERT INTO Usuarios (firstname, lastname, password, createdAt, lastupdate)
        VALUES (firstName, lastName, 'defaultpass', NOW(), NOW());
        SET @uid = LAST_INSERT_ID();
        
        INSERT INTO ContactInfo (value, isPrincipal, contactInfoTypeId, lastupdate, ownerTipo, ownerID)
        VALUES (LOWER(CONCAT(firstName, '.', lastName, '@example.com')), 1, 1, NOW(), 'Usuarios', @uid);
        
        -- selecciona aleatoriamente un plan de suscripción (mensual, anual o familiar) para cada usuario.
        SET planRand = FLOOR(1 + RAND()*3);
        -- dependiendo del plan aleatorio seleccionado, se calcula la fecha de adquisición y 
        -- los días restantes hasta la expiración del plan, asegurando que el usuario tenga un tiempo de suscripción menor a 15 días.
        IF planRand = 2 THEN
            SET daysLeft = FLOOR(RAND()*15);
            SET adquisitionDate = DATE_SUB(CURDATE(), INTERVAL (365 - daysLeft) DAY);
        ELSE
            SET daysLeft = FLOOR(RAND()*15);
            SET adquisitionDate = DATE_SUB(CURDATE(), INTERVAL (30 - daysLeft) DAY);
        END IF;
        
        INSERT INTO PlanPerPerson (enable, adquisition, userid, planPriceID)
        VALUES (1, adquisitionDate, @uid, planRand);
        
        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

CALL add_subscription_users();
