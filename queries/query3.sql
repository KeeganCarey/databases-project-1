-- Show each session's full details
SELECT 
-- concat is just concatenation so we can show full names instead of just first or last name
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    CONCAT(m.first_name, ' ', m.last_name) AS mentor_name,
    se.session_date,
    se.topic,
    f.rating,
    f.comment
FROM Session se
JOIN Student s ON se.student_id = s.student_id
JOIN Mentor m ON se.mentor_id = m.mentor_id
LEFT JOIN Feedback f ON se.session_id = f.session_id
WHERE se.status = 'completed'
ORDER BY se.session_date DESC;