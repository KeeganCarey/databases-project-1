-- Find students who have never booked a session
SELECT student_id, first_name, last_name, email, major
FROM Student

WHERE student_id NOT IN (
    SELECT DISTINCT student_id 
    FROM Session
);