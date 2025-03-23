
-- 4.4



SELECT
  DATE_FORMAT(s.horaIncio, '%Y-%m-%d') AS Fecha,
  e.nombre AS 'tipo Error',
  COUNT(*) AS 'cantidad Ocurrencias'
FROM InteracionLogsIA il
JOIN eventoPagoTipo e ON il.eventoPagoID = e.eventoPagoID
JOIN SesionProcesamientoIA s ON il.sessionID = s.sessionID
WHERE s.horaIncio BETWEEN '2023-10-01' AND '2025-11-30'
GROUP BY e.nombre, Fecha
ORDER BY 
  COUNT(*) DESC,  -- ordena por cantidad de ocurrencias (mayor a menor)
  Fecha DESC;     -- luego por fecha (más reciente a más antigua) por eso aveces salen intercaladas