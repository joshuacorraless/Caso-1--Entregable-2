-- 4.4 


-- inserto tipos de error comunes en eventoPagoTipo
INSERT INTO eventoPagoTipo (nombre) VALUES
('Falla en reconocer nombres de proveedores'),
('Malinterpretación de montos'),
('Errores en fechas de pagos'),
('Confusión de comandos de voz'),
('Problemas con acentos o dialectos'),
('Ruido ambiental'),
('Errores en identificación de cuentas'),
('Falta de contexto'),
('Alucinaciones de la IA'),
('Procesamiento de moneda extranjera');



-- inserto 10 sesiones que procesa la ia de ejemplo
INSERT INTO SesionProcesamientoIA (horaIncio, horaFin, status, S3audio, userid, lastupdate)
SELECT 
    TIMESTAMP('2023-10-01') + INTERVAL FLOOR(RAND() * 60) DAY,  -- Fechas entre octubre y noviembre
    TIMESTAMP('2023-10-01') + INTERVAL FLOOR(RAND() * 60) DAY + INTERVAL 1 HOUR,
    ELT(FLOOR(RAND() * 3) + 1, 'active', 'completed', 'failed'),
    CONCAT('s3://audio/', UUID()),
    FLOOR(RAND() * 5) + 1,
    NOW()
FROM (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) dummy
LIMIT 10;

SELECT * FROM SesionProcesamientoIA;





-- insertar 100 registros de errores (ajustable)
INSERT INTO InteracionLogsIA (sessionID, contenido, eventoPagoID, tipo, infoAdicional)
SELECT 
    s.sessionID,  -- IDs válidos de SesionProcesamientoIA
    CONCAT('Error: ', e.nombre),
    e.eventoPagoID,
    'error',
    JSON_OBJECT('severidad', 'alta', 'origen', 'voz')
FROM eventoPagoTipo e
CROSS JOIN SesionProcesamientoIA s  -- Combinar errores con sesiones
CROSS JOIN (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) dummy  -- Multiplicador
WHERE s.horaIncio BETWEEN '2023-10-01' AND '2023-11-30'  -- Rango de fechas
ORDER BY RAND()
LIMIT 100;  -- Total de registros