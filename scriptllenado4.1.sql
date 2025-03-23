
-- Agarro la base de datos caso1 para asegurarse de que todas las operaciones se realicen en la base de datos correcta.
USE caso1;

-- Elimina el procedimiento populate_data si ya existe para evitar errores al intentar crear un nuevo procedimiento con el mismo nombre. 
-- Esto ya que tuve que rehacerlo varias veces.
DROP PROCEDURE IF EXISTS populate_data;


-- Defino el procedimiento populate_data que es el encargado de insertar 25 usuarios con nombres ticos, agregar información de contacto, asociar un método de pago y registrar pagos aleatorios.
DELIMITER //

CREATE PROCEDURE populate_data()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE num_payments INT;
    DECLARE j INT;
    DECLARE random_amount DECIMAL(10,2);
    DECLARE payment_date DATE;
    DECLARE randIndex INT;
    DECLARE country VARCHAR(50);
    DECLARE countries VARCHAR(255);
    DECLARE diffDays INT;
    
    -- defino una lista de países que será utilizada más adelante para asignar un país aleatorio a cada usuario.
    SET countries = 'Costa Rica,Estados Unidos,México,Guatemala,Panamá';
    
    -- 25 nombres y apellidos ticos
    SET @tico_first_names = 'Charlie,Rodrigo,Joshua,Pepe,Juan,José,Carlos,Luis,Daniel,David,Andrés,Gustavo,Adrián,Fernando,Alberto,Jorge,Rodolfo,Pedro,Esteban,Marco,Diego,Mario,Oscar,Edgar,Felipe';
    SET @tico_last_names  = 'Sánchez,Solano,Jiménez,Mora,Vargas,Chaves,Aguilar,Castro,Quesada,López,Ramírez,Hernández,Rojas,Porras,Salazar,Alvarado,Fernández,Calderón,Gómez,Bolaños,Navarro,González,Barquero,Cordero,Soto';
    
    -- aca me aseguro que los tipos de contacto, como 'email' exista en la tabla ContactInfoTypes antes de usarlo.
    INSERT INTO ContactInfoTypes (ContactInfoTypesId, name)
        VALUES (1, 'email')
        ON DUPLICATE KEY UPDATE name = 'email';
    INSERT INTO ContactInfoTypes (ContactInfoTypesId, name)
        VALUES (2, 'country')
        ON DUPLICATE KEY UPDATE name = 'country';
    -- aseguro que la moneda de Costa Rica (colones) esté presente en la base de datos antes de asociarla con los pagos
    INSERT INTO Moneda (monedaid, simbolo, acronym)
        VALUES (1, '₡', 'CRC')
        ON DUPLICATE KEY UPDATE simbolo = '₡';
    -- bucle para poder tener 20+ registros como pide el profe
    WHILE i <= 25 DO
        --  segun investigacion, utilizando funciones SUBSTRING_INDEX puedo extraer los nombres y apellidos correspondientes de las listas definidas previamente .
        SET @first_name = SUBSTRING_INDEX(SUBSTRING_INDEX(@tico_first_names, ',', i), ',', -1);
        SET @last_name  = SUBSTRING_INDEX(SUBSTRING_INDEX(@tico_last_names , ',', i), ',', -1);
		-- inserto un nuevo usuario con un nombre, apellido y contraseña predeterminados.
        INSERT INTO Usuarios (firstname, lastname, password, createdAt, lastupdate)
        VALUES (@first_name, @last_name, 'defaultpass', NOW(), NOW());
        
        SET @uid = LAST_INSERT_ID();
        
        -- genero un correo electrónico único para cada usuario combinando su nombre y apellido, y se inserta en la tabla ContactInfo.
        INSERT INTO ContactInfo (value, isPrincipal, contactInfoTypeId, lastupdate, ownerTipo, ownerID)
        VALUES (
            CONCAT(LOWER(@first_name), '.', LOWER(@last_name), '@example.com'), 
            1, 
            1, 
            NOW(), 
            'Usuarios', 
            @uid
        );
        
        -- esto lo hago para escoger un país aleatorio
        SET randIndex = FLOOR(1 + RAND() * 5);  -- 1 a 5
        SET country = SUBSTRING_INDEX(SUBSTRING_INDEX(countries, ',', randIndex), ',', -1);
        
        INSERT INTO ContactInfo (value, isPrincipal, contactInfoTypeId, lastupdate, ownerTipo, ownerID)
        VALUES (country, 1, 2, NOW(), 'Usuarios', @uid);
        
        -- me aseguro que el proveedor de pago (en este caso un proveedor de banco) exista antes de asociarlo con los usuarios.
        INSERT INTO Proveedor (proveedorid, proveedorname, tipo, lastupdate, sitioWeb, config, datosFiscales)
        VALUES (1, 'Proveedor Test', 'banco', NOW(), 'https://proveedor.com', '{}', '123456789')
        ON DUPLICATE KEY UPDATE lastupdate = NOW();
        
        SET @first_userid = (SELECT MIN(userid) FROM Usuarios);
        --  inserto un método de pago por defecto para el primer usuario, incluyendo detalles como el token y fecha de expiración.
        INSERT INTO MetodoPago (metodoPagoid, token, expirationdate, checksum, lastupdate, userid, tipoPagoid, proveedorid, refreshToken, detalles)
        VALUES (1, 'default-token', '2025-12-31', NULL, NOW(), @first_userid, 1, 1, NULL, '{}')
        ON DUPLICATE KEY UPDATE lastupdate = NOW();
        
        -- como el profe, genero un número aleatorio de pagos entre 1 y 3 para cada usuario.
        SET num_payments = FLOOR(1 + RAND() * 3);
        SET j = 1;
        
        WHILE j <= num_payments DO
            -- Monto aleatorio entre 1000 y 5000
            SET random_amount = 1000 + RAND() * 4000;
            
            -- Fecha de pago aleatoria entre 2024-01-01 y hoy
            SET diffDays = DATEDIFF(CURDATE(), '2024-01-01');
            SET payment_date = DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * diffDays) DAY);
            --  genero pagos aleatorios para cada usuario, con montos y fechas aleatorias dentro de un rango específico.
            INSERT INTO Pagos (
                monto, userid, monedaid, actualMonto, 
                result, auth, referencia, chargeToken, 
                description, error, fecha, checksum, metodoPagoid
            )
            VALUES (
                random_amount,
                @uid,
                1,
                random_amount,
                'Success',
                'auth',
                CONCAT('ref', i, '-', j),
                NULL,
                'Subscription Payment',
                NULL,
                payment_date,
                NULL,
                1
            );
            
            SET j = j + 1;
        END WHILE;
        
        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

-- ejecuto el procedimiento para insertar los 25 usuarios con sus pagos y datos asociados.
CALL populate_data();
-- fin
