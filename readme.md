# MentorBridge: a simple system to connect students with alumni mentors and keep mentorship organized
**Members:** Abhinav Nadupalli and Keegan Carey

**Short Description:**
MentorBridge is a database system that helps students connect with alumni mentors in a more organized and reliable way. Right now, mentorship often happens through scattered emails or LinkedIn messages, which makes it hard to track conversations and follow ups. Our system stores mentor profiles, student interests, session requests, and meeting history in one place. Students can search for mentors by industry or career path, and mentors can manage their availability and see their past sessions. This project addresses a real need for clearer, more transparent mentorship connections within a university community.

**User Personas:**

Students looking for career guidance
Alumni mentors who want to give back
University staff tracking mentorship engagement

**User Stories:**

* As a student, I want to search mentors by industry so I can find someone aligned with my goals.
* As a student, I want to request a meeting so I can receive advice and guidance.
* As a mentor, I want to set my availability so students can schedule times that work for me.
* As a mentor, I want to see my session history so I can keep track of who I have supported.
* As a staff member, I want to view overall mentorship activity so I can understand engagement levels.


# Crows Foot ERD diagram
```mermaid

erDiagram
    SESSION {
        int session_id PK
        int student_id FK
        int mentor_id FK
        date session_date
        int duration_minutes
        string status
        string topic
    }
    
    STUDENT {
        int student_id PK
        string first_name
        string last_name
        string email
        string major
        int graduation_year
    }
    
    MENTOR {
        int mentor_id PK
        string first_name
        string last_name
        string email
        string company
        string job_title
        int years_experience
    }
    
    FEEDBACK {
        int feedback_id PK
        int session_id FK
        int rating
        string comment
        datetime submitted_at
    }
    
    STUDENT_INDUSTRY {
        int student_id PK,FK
        int industry_id PK,FK
    }
    
    MENTOR_INDUSTRY {
        int mentor_id PK,FK
        int industry_id PK,FK
    }
    
    INDUSTRY {
        int industry_id PK
        string industry_name
        string description
    }
    
    STUDENT ||--o{ SESSION : "is associated with"
    MENTOR ||--o{ SESSION : "conducts"
    SESSION ||--o| FEEDBACK : "receives"
    STUDENT ||--o{ STUDENT_INDUSTRY : "is interested in"
    STUDENT_INDUSTRY }o--|| INDUSTRY : "interests"
    MENTOR ||--o{ MENTOR_INDUSTRY : "belongs to"
    MENTOR_INDUSTRY }o--|| INDUSTRY : "contains"
```

# UML Diagram
```mermaid
classDiagram
    direction LR

    class Session {
        <<Entity>>
        +int session_id PK
        date session_date
        int duration_minutes
        string status
        string topic
    }

    class Student {
        <<Entity>>
        +int student_id PK
        string first_name
        string last_name
        string email
        string major
        int graduation_year
    }

    class Mentor {
        <<Entity>>
        +int mentor_id PK
        string first_name
        string last_name
        string email
        string company
        string job_title
        int years_experience
    }

    class Feedback {
        <<Entity>>
        +int feedback_id PK
        int rating
        string comment
        datetime submitted_at
    }

    class Industry {
        <<Entity>>
        +int industry_id PK
        string industry_name
        string description
    }

    Student "1" --> "0..*" Session : books
    Mentor "1" --> "0..*" Session : conducts
    Session "1" --> "0..1" Feedback : receives
    Student "0..*" --> "0..*" Industry : is interested in
    Mentor "0..*" --> "0..*" Industry : works in
```


# Node App Interface

Because we have no experience with HTML, we used Claude Haiku to assist in the generation of the styling of the web pages for the interface. We directed it as to what we wanted the UI to look like and it helped us create it.
Additionally, Gemini was used to assist in the generation of some parts of the js backend and figuring out how to use node as it was entirely new to us.

## AI Citations

Anthropic. "Claude." *Claude*, Anthropic, 2025, claude.ai/. Accessed 10 Mar. 2026.
Google. "Gemini." *Gemini*, Google, 2025, gemini.google.com. Accessed 10 Mar. 2026