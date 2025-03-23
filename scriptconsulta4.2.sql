-- 4.2 listar todas las personas con su nombre completo e email, 
-- los cuales le queden menos de 15 días para tener que volver a pagar una nueva subscripción (13+ registros)



SELECT 
  CONCAT(u.firstname, ' ', u.lastname) AS full_name,
  ci.value AS email,
  DATEDIFF(
    CASE 
      WHEN pp.recurrencyType = 'YEAR' THEN DATE_ADD(ppp.adquisition, INTERVAL 365 DAY)
      WHEN pp.recurrencyType = 'MONTH' THEN DATE_ADD(ppp.adquisition, INTERVAL 30 DAY)
      ELSE DATE_ADD(ppp.adquisition, INTERVAL 30 DAY)
    END,
    CURDATE()
  ) AS days_left
FROM Usuarios u
JOIN ContactInfo ci 
  ON ci.ownerID = u.userid AND ci.contactInfoTypeId = 1
JOIN PlanPerPerson ppp 
  ON ppp.userid = u.userid
JOIN PlanPrices pp 
  ON pp.planPriceID = ppp.planPriceID
WHERE ppp.enable = 1
HAVING days_left < 15 AND days_left >= 0;
