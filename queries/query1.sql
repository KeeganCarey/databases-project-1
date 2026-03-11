-- List all mentors and their companies, ordered by experience
SELECT first_name, last_name, company, job_title, years_experience
FROM Mentor

ORDER BY years_experience DESC;