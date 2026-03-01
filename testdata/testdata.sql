-- =============================================
-- MentorBridge Sample Data (with Edge Cases)
-- =============================================

-- STUDENTS (18 records)
INSERT INTO Student (student_id, first_name, last_name, email, major, graduation_year) VALUES
(1, 'Emma', 'Chen', 'emma.chen@university.edu', 'Computer Science', 2025),
(2, 'Marcus', 'Johnson', 'marcus.j@university.edu', 'Finance', 2024),
(3, 'Sofia', 'Rodriguez', 'sofia.r@university.edu', 'Marketing', 2025),
(4, 'Aiden', 'Patel', 'aiden.p@university.edu', 'Computer Science', 2026),
(5, 'Olivia', 'Kim', 'olivia.kim@university.edu', 'Data Science', 2024),
(6, 'Ethan', 'Williams', 'ethan.w@university.edu', 'Mechanical Engineering', 2025),
(7, 'Ava', 'Thompson', 'ava.t@university.edu', 'Business Administration', 2024),
(8, 'Noah', 'Garcia', 'noah.g@university.edu', 'Information Systems', 2026),
(9, 'Isabella', 'Martinez', 'isabella.m@university.edu', 'Finance', 2025),
(10, 'Liam', 'Brown', 'liam.b@university.edu', 'Computer Science', 2024),
(11, 'Mia', 'Davis', 'mia.d@university.edu', 'UX Design', 2025),
(12, 'James', 'Wilson', 'james.w@university.edu', 'Electrical Engineering', 2026),
(13, 'Charlotte', 'Lee', 'charlotte.l@university.edu', 'Economics', 2024),
(14, 'Benjamin', 'Taylor', 'ben.t@university.edu', 'Data Science', 2025),
(15, 'Amelia', 'Anderson', 'amelia.a@university.edu', 'Marketing', 2024),
-- EDGE CASE: Student with MANY interests (5 industries)
(16, 'Jordan', 'Rivera', 'jordan.r@university.edu', 'Undeclared', 2027),
-- EDGE CASE: Student with NO sessions (new to platform)
(17, 'Taylor', 'Hughes', 'taylor.h@university.edu', 'Philosophy', 2025),
-- EDGE CASE: Student with NO industry interests selected
(18, 'Casey', 'Morgan', 'casey.m@university.edu', 'Computer Science', 2024);

-- MENTORS (10 records)
INSERT INTO Mentor (mentor_id, first_name, last_name, email, company, job_title, years_experience) VALUES
(1, 'David', 'Mitchell', 'david.mitchell@google.com', 'Google', 'Senior Software Engineer', 12),
(2, 'Sarah', 'Foster', 'sarah.foster@jpmorgan.com', 'JPMorgan Chase', 'Vice President, Investment Banking', 15),
(3, 'Michael', 'Chang', 'michael.chang@meta.com', 'Meta', 'Product Manager', 8),
(4, 'Jennifer', 'O''Brien', 'jennifer.obrien@deloitte.com', 'Deloitte', 'Senior Consultant', 10),
(5, 'Robert', 'Nguyen', 'robert.nguyen@amazon.com', 'Amazon', 'Engineering Manager', 14),
(6, 'Lisa', 'Patel', 'lisa.patel@goldmansachs.com', 'Goldman Sachs', 'Associate Director', 11),
(7, 'Christopher', 'Wright', 'chris.wright@microsoft.com', 'Microsoft', 'Principal PM', 16),
(8, 'Amanda', 'Santos', 'amanda.santos@airbnb.com', 'Airbnb', 'UX Design Lead', 9),
(9, 'Daniel', 'Kim', 'daniel.kim@tesla.com', 'Tesla', 'Mechanical Engineer', 7),
(10, 'Rachel', 'Green', 'rachel.green@mckinsey.com', 'McKinsey & Company', 'Engagement Manager', 13),
-- EDGE CASE: Mentor with NO sessions (just joined platform)
(11, 'Kevin', 'Park', 'kevin.park@stripe.com', 'Stripe', 'Software Engineer', 3),
-- EDGE CASE: Mentor with 0 years experience (recent grad)
(12, 'Priya', 'Sharma', 'priya.sharma@startup.io', 'TechStartup Inc', 'Junior Developer', 0);

-- INDUSTRIES (8 records)
INSERT INTO Industry (industry_id, industry_name, description) VALUES
(1, 'Technology', 'Software development, IT services, and tech startups'),
(2, 'Finance', 'Banking, investment management, and financial services'),
(3, 'Consulting', 'Management consulting and advisory services'),
(4, 'Healthcare', 'Healthcare providers, pharma, and biotech'),
(5, 'Marketing', 'Digital marketing, advertising, and brand management'),
(6, 'Engineering', 'Mechanical, electrical, and civil engineering'),
(7, 'Data Science', 'Analytics, machine learning, and AI'),
(8, 'Product Management', 'Product strategy and development');

-- STUDENT_INDUSTRY (30 records - students can have multiple interests)
INSERT INTO Student_industry (student_id, industry_id) VALUES
(1, 1), (1, 7),           -- Emma: Tech, Data Science
(2, 2), (2, 3),           -- Marcus: Finance, Consulting
(3, 5), (3, 8),           -- Sofia: Marketing, Product
(4, 1), (4, 7),           -- Aiden: Tech, Data Science
(5, 7), (5, 1),           -- Olivia: Data Science, Tech
(6, 6),                   -- Ethan: Engineering
(7, 3), (7, 2),           -- Ava: Consulting, Finance
(8, 1), (8, 8),           -- Noah: Tech, Product
(9, 2),                   -- Isabella: Finance
(10, 1), (10, 7),         -- Liam: Tech, Data Science
(11, 8), (11, 5),         -- Mia: Product, Marketing
(12, 6), (12, 1),         -- James: Engineering, Tech
(13, 2), (13, 3),         -- Charlotte: Finance, Consulting
(14, 7), (14, 1),         -- Benjamin: Data Science, Tech
(15, 5),                  -- Amelia: Marketing
-- EDGE CASE: Jordan has 5 interests (exploring everything)
(16, 1), (16, 2), (16, 3), (16, 7), (16, 8),
-- EDGE CASE: Casey only has 1 niche interest
(18, 7);
-- NOTE: Taylor (student_id=17) has NO industry interests (edge case)

-- MENTOR_INDUSTRY (17 records)
INSERT INTO Mentor_industry (mentor_id, industry_id) VALUES
(1, 1), (1, 7),           -- David (Google): Tech, Data Science
(2, 2),                   -- Sarah (JPMorgan): Finance
(3, 8), (3, 1),           -- Michael (Meta): Product, Tech
(4, 3),                   -- Jennifer (Deloitte): Consulting
(5, 1), (5, 6),           -- Robert (Amazon): Tech, Engineering
(6, 2),                   -- Lisa (Goldman): Finance
(7, 8), (7, 1),           -- Christopher (Microsoft): Product, Tech
(8, 8), (8, 5),           -- Amanda (Airbnb): Product, Marketing
(9, 6),                   -- Daniel (Tesla): Engineering
(10, 3), (10, 2),         -- Rachel (McKinsey): Consulting, Finance
(11, 1);                  -- Kevin (Stripe): Tech
-- NOTE: Priya (mentor_id=12) has NO industries set (edge case - incomplete profile)

-- SESSIONS (28 records)
INSERT INTO Session (session_id, student_id, mentor_id, session_date, duration_minutes, status, topic) VALUES
(1, 1, 1, '2024-09-15', 45, 'completed', 'Breaking into tech as a new grad'),
(2, 2, 2, '2024-09-18', 30, 'completed', 'Investment banking recruiting timeline'),
(3, 3, 8, '2024-09-20', 45, 'completed', 'Transitioning from marketing to product'),
(4, 5, 1, '2024-09-22', 60, 'completed', 'Data science interview preparation'),
(5, 7, 4, '2024-09-25', 30, 'completed', 'Consulting case interview tips'),
(6, 10, 5, '2024-10-01', 45, 'completed', 'Amazon leadership principles'),
(7, 6, 9, '2024-10-05', 30, 'completed', 'Mechanical engineering at Tesla'),
(8, 4, 1, '2024-10-10', 45, 'completed', 'Internship search strategies'),
(9, 9, 6, '2024-10-12', 30, 'completed', 'Goldman Sachs application process'),
(10, 11, 8, '2024-10-15', 45, 'completed', 'Building a UX portfolio'),
(11, 13, 10, '2024-10-18', 60, 'completed', 'McKinsey recruiting process'),
(12, 1, 3, '2024-10-22', 30, 'completed', 'Product management career path'),
(13, 14, 1, '2024-10-25', 45, 'completed', 'ML engineer vs data scientist roles'),
(14, 8, 7, '2024-11-01', 30, 'completed', 'Microsoft PM interview prep'),
(15, 12, 5, '2024-11-05', 45, 'completed', 'Hardware vs software engineering'),
(16, 2, 10, '2024-11-10', 30, 'scheduled', 'Consulting vs banking decision'),
(17, 15, 8, '2024-11-15', 45, 'scheduled', 'Marketing roles at tech companies'),
(18, 4, 5, '2024-11-18', 30, 'requested', 'AWS internship opportunities'),
(19, 5, 7, '2024-11-20', 45, 'requested', 'Data science at Microsoft'),
(20, 3, 3, '2024-11-22', 30, 'cancelled', 'Product marketing discussion'),
-- EDGE CASE: Same student (Emma) with MANY sessions (power user - 5 total)
(21, 1, 5, '2024-11-01', 30, 'completed', 'Amazon internship advice'),
(22, 1, 7, '2024-11-08', 45, 'completed', 'Microsoft culture and growth'),
-- EDGE CASE: Same student-mentor pair meeting MULTIPLE times (Emma & David)
(23, 1, 1, '2024-11-12', 30, 'completed', 'Follow-up: Resume review after changes'),
-- EDGE CASE: Very SHORT session (15 min quick call)
(24, 10, 1, '2024-11-14', 15, 'completed', 'Quick question about offer negotiation'),
-- EDGE CASE: Very LONG session (120 min deep dive)
(25, 14, 5, '2024-11-16', 120, 'completed', 'Full system design interview practice'),
-- EDGE CASE: Multiple sessions on the SAME DAY (busy mentor)
(26, 4, 1, '2024-11-20', 30, 'scheduled', 'Morning check-in'),
(27, 8, 1, '2024-11-20', 30, 'scheduled', 'Afternoon session'),
-- EDGE CASE: Session with NO feedback even though completed
(28, 18, 1, '2024-10-28', 45, 'completed', 'Getting started in data science');
-- NOTE: Taylor (17), Jordan (16) have NO sessions
-- NOTE: Kevin (mentor 11), Priya (mentor 12) have NO sessions

-- FEEDBACK (17 records - only for completed sessions)
INSERT INTO Feedback (feedback_id, session_id, rating, comment, submitted_at) VALUES
(1, 1, 5, 'David was incredibly helpful! He gave me specific advice on tailoring my resume for Google and shared insider tips on the interview process.', '2024-09-15 18:30:00'),
(2, 2, 5, 'Sarah explained the IB recruiting timeline clearly and helped me understand what to prioritize. Highly recommend!', '2024-09-18 16:00:00'),
(3, 3, 4, 'Great session on product management. Amanda shared useful resources for learning more about the field.', '2024-09-20 17:15:00'),
(4, 4, 5, 'Excellent mock interview practice. David asked realistic questions and gave constructive feedback.', '2024-09-22 19:00:00'),
(5, 5, 5, 'Jennifer walked me through case frameworks step by step. Feel much more confident now.', '2024-09-25 15:45:00'),
(6, 6, 4, 'Good overview of Amazon culture. Would have liked more technical interview tips.', '2024-10-01 17:30:00'),
(7, 7, 5, 'Daniel was super passionate about his work at Tesla. Really inspiring conversation!', '2024-10-05 16:30:00'),
(8, 8, 5, 'Perfect advice for a sophomore looking for internships. David is a great mentor.', '2024-10-10 18:00:00'),
(9, 10, 5, 'Amanda reviewed my portfolio and gave actionable feedback. Already implementing her suggestions!', '2024-10-15 17:45:00'),
(10, 11, 4, 'Comprehensive overview of consulting recruiting. Rachel was very professional and knowledgeable.', '2024-10-18 19:30:00'),
(11, 12, 5, 'Michael helped me understand the PM role much better. Great career advice!', '2024-10-22 16:15:00'),
(12, 13, 5, 'Clarified the differences between ML and DS roles. Now I know which path to pursue.', '2024-10-25 18:45:00'),
-- EDGE CASE: LOW rating (1 star) with negative feedback
(13, 21, 1, 'Mentor seemed distracted and kept checking their phone. Did not feel like they prepared for our session at all. Would not recommend.', '2024-11-01 17:00:00'),
-- EDGE CASE: LOW rating (2 stars) with constructive criticism
(14, 22, 2, 'The advice was very generic and could apply to anyone. I was hoping for more personalized guidance based on my background.', '2024-11-08 18:30:00'),
-- EDGE CASE: Middle rating (3 stars)
(15, 23, 3, 'Decent follow-up session. Some helpful points but felt a bit rushed.', '2024-11-12 16:45:00'),
-- EDGE CASE: VERY LONG comment (stress testing VARCHAR limit)
(16, 25, 5, 'This was absolutely the best mentorship session I have ever had! Robert spent a full two hours with me going through system design concepts. We covered everything from load balancers to database sharding to caching strategies. He even drew out architecture diagrams and shared his screen to show me real examples from his work at Amazon. I learned more in this single session than I did in my entire systems course. He also gave me a reading list and offered to do a follow-up session next month. I cannot recommend Robert highly enough - he is patient, knowledgeable, and genuinely cares about helping students succeed. This platform is amazing for connecting students with mentors like him. Thank you MentorBridge!', '2024-11-16 20:00:00'),
-- EDGE CASE: MINIMAL comment (just barely there)
(17, 24, 4, 'Good.', '2024-11-14 15:30:00');
-- NOTE: Session 28 (Casey with David) is completed but has NO feedback (edge case)