-- 4.1 listar todos los usuarios de la plataforma que esten activos con su 
-- nombre completo, email, país de procedencia, y el total de cuánto han pagado 
-- en subscripciones desde el 2024 hasta el día de hoy, dicho monto debe ser en colones (20+ registros)

SELECT 
    CONCAT(u.firstname, ' ', u.lastname) AS full_name,
    email.value AS email,
    country.value AS country,
    SUM(p.monto) AS total_paid_colones
FROM Usuarios u
JOIN ContactInfo email ON email.ownerID = u.userid AND email.contactInfoTypeId = 1
JOIN ContactInfo country ON country.ownerID = u.userid AND country.contactInfoTypeId = 2
JOIN Pagos p ON p.userid = u.userid
WHERE p.fecha >= '2024-01-01'
GROUP BY u.userid, u.firstname, u.lastname, email.value, country.value;