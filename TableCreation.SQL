-- 1. Create the main tables that don't depend on anything else

-- This table stores basic information about each student
CREATE TABLE Student (
    student_id INT PRIMARY KEY,        -- unique ID for each student
    first_name VARCHAR(255),           -- student's first name
    last_name VARCHAR(255),            -- student's last name
    email VARCHAR(255),                -- student's email address
    major VARCHAR(255),                -- what the student is studying
    graduation_year INT                -- expected graduation year
);

-- This table stores information about mentors
CREATE TABLE Mentor (
    mentor_id INT PRIMARY KEY,         -- unique ID for each mentor
    first_name VARCHAR(255),           -- mentor's first name
    last_name VARCHAR(255),            -- mentor's last name
    email VARCHAR(255),                -- mentor's email
    company VARCHAR(255),              -- company they work at
    job_title VARCHAR(255),            -- their job title
    years_experience INT               -- years of experience in their field
);

-- This table stores different industries students or mentors might be connected to
CREATE TABLE Industry (
    industry_id INT PRIMARY KEY,       -- unique ID for each industry
    industry_name VARCHAR(255),        -- name of the industry
    description VARCHAR(255)           -- short description of the industry
);

-- 2. Create junction tables to handle many-to-many relationships

-- A student can be interested in multiple industries
-- and each industry can have many students
CREATE TABLE Student_industry (
    student_id INT,
    industry_id INT,
    PRIMARY KEY (student_id, industry_id),  -- ensures the combination is unique
    FOREIGN KEY (student_id) REFERENCES Student(student_id),   -- links to Student table
    FOREIGN KEY (industry_id) REFERENCES Industry(industry_id) -- links to Industry table
);

-- A mentor can work in multiple industries
-- and an industry can have many mentors
CREATE TABLE Mentor_industry (
    mentor_id INT,
    industry_id INT,
    PRIMARY KEY (mentor_id, industry_id),   -- prevents duplicate connections
    FOREIGN KEY (mentor_id) REFERENCES Mentor(mentor_id),      -- links to Mentor table
    FOREIGN KEY (industry_id) REFERENCES Industry(industry_id) -- links to Industry table
);

-- 3. Create the session table that tracks meetings between students and mentors

-- Each session represents a meeting between a student and a mentor
CREATE TABLE Session (
    session_id INT PRIMARY KEY,        -- unique ID for each session
    student_id INT,                    -- which student attended
    mentor_id INT,                     -- which mentor hosted the session
    session_date DATE,                 -- date the session happened
    duration_minutes INT,              -- how long the session lasted
    status VARCHAR(50),                -- status like scheduled, completed, or canceled
    topic VARCHAR(255),                -- topic discussed during the session
    FOREIGN KEY (student_id) REFERENCES Student(student_id),  -- connects to student
    FOREIGN KEY (mentor_id) REFERENCES Mentor(mentor_id)      -- connects to mentor
);

-- 4. Create the feedback table

-- After a session, students can leave feedback about it
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,       -- unique ID for each feedback entry
    session_id INT,                    -- which session the feedback is for
    rating INT,                        -- rating score (for example 1–5)
    comment VARCHAR(1000),             -- written feedback or thoughts
    submitted_at DATETIME,             -- when the feedback was submitted
    FOREIGN KEY (session_id) REFERENCES Session(session_id)   -- connects feedback to a session
);