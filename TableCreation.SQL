-- student information
CREATE TABLE Student (
    student_id INT PRIMARY KEY,        -- unique student id
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    major VARCHAR(255),
    graduation_year INT
);

-- mentor information
CREATE TABLE Mentor (
    mentor_id INT PRIMARY KEY,         -- unique mentor id
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    company VARCHAR(255),
    job_title VARCHAR(255),
    years_experience INT
);

-- industries students and mentors are connected to
CREATE TABLE Industry (
    industry_id INT PRIMARY KEY,
    industry_name VARCHAR(255),
    description VARCHAR(255)
);

-- connects students to industries they are interested in
CREATE TABLE Student_industry (
    student_id INT,
    industry_id INT,
    PRIMARY KEY (student_id, industry_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (industry_id) REFERENCES Industry(industry_id)
);

-- connects mentors to industries they work in
CREATE TABLE Mentor_industry (
    mentor_id INT,
    industry_id INT,
    PRIMARY KEY (mentor_id, industry_id),
    FOREIGN KEY (mentor_id) REFERENCES Mentor(mentor_id),
    FOREIGN KEY (industry_id) REFERENCES Industry(industry_id)
);

-- sessions between students and mentors
CREATE TABLE Session (
    session_id INT PRIMARY KEY,
    student_id INT,
    mentor_id INT,
    session_date DATE,
    duration_minutes INT,
    status VARCHAR(50),
    topic VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (mentor_id) REFERENCES Mentor(mentor_id)
);

-- feedback left after a session
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    session_id INT,
    rating INT,
    comment VARCHAR(1000),
    submitted_at DATETIME,
    FOREIGN KEY (session_id) REFERENCES Session(session_id)
);