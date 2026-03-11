-- Show all completed sessions with student names
SELECT 
    s.first_name,
    s.last_name,
    se.session_date,
    se.topic,
    se.duration_minutes
    
FROM Session se
JOIN Student s ON se.student_id = s.student_id
WHERE se.status = 'completed'
ORDER BY se.session_date DESC;