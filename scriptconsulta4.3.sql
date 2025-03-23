-- 4.3
-- top 15 mas uso
SELECT 
    u.userid,
    CONCAT(u.firstname, ' ', u.lastname) AS full_name,
    COUNT(l.log_id) AS login_count
FROM Usuarios u
JOIN Logs l ON l.referenceID1 = u.userid
WHERE l.description = 'User login'
GROUP BY u.userid, full_name
ORDER BY login_count DESC
LIMIT 15;


-- top 15 menos uso
SELECT 
    u.userid,
    CONCAT(u.firstname, ' ', u.lastname) AS full_name,
    COUNT(l.log_id) AS login_count
FROM Usuarios u
LEFT JOIN Logs l ON l.referenceID1 = u.userid AND l.description = 'User login'
GROUP BY u.userid, full_name
ORDER BY login_count ASC
LIMIT 15;
