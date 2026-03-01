-- find sessions from October 2024 that were longer than 30 min Or had a 5 rating
SELECT 
    se.session_id,
    se.session_date,
    se.topic,
    se.duration_minutes,
    f.rating
FROM Session se
LEFT JOIN Feedback f ON se.session_id = f.session_id

WHERE se.status = 'completed'
-- dates are a numerical string sowe can compare it to find sessions in October 2024
  AND se.session_date BETWEEN '2024-10-01' AND '2024-10-31'
  -- sort for long or rating of 5
  AND (se.duration_minutes > 30 OR f.rating = 5);
