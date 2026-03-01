-- calculate the average rating for each mentor
SELECT
    CONCAT(m.first_name, ' ', m.last_name) AS mentor_name,
    m.company,
    COUNT(f.feedback_id) AS total_reviews,
    
    ROUND(AVG(f.rating), 2) AS average_rating
FROM Mentor m
JOIN Session se ON m.mentor_id = se.mentor_id
JOIN Feedback f ON se.session_id = f.session_id
GROUP BY m.mentor_id, m.first_name, m.last_name, m.company

ORDER BY average_rating DESC;