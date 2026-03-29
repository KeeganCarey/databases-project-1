const express = require("express");
const sqlite3 = require("sqlite3").verbose();
const path = require("path");

const app = express();
const PORT = 3000;

// connecting to our mentorbridge database with sqlite3
const db = new sqlite3.Database(path.join(__dirname, "..", "mentorbridge.db"));
db.run("PRAGMA foreign_keys = ON"); // this was breaking stuff before we added it

// we need these wrapper functions because sqlite3 doesnt support promises by default
// and we want to use async await instead of callbacks everywhere
function queryAll(sql, params = []) {
  return new Promise((resolve, reject) => {
    db.all(sql, params, (err, rows) => (err ? reject(err) : resolve(rows)));
  });
}

function queryOne(sql, params = []) {
    return new Promise((resolve, reject) => {
        db.get(sql, params, (err, row) => (err ? reject(err) : resolve(row)));
    });
}

function runQuery(sql, params = []) {
  return new Promise((resolve, reject) => {
    db.run(sql, params, function (err) {
      err ? reject(err) : resolve(this);
    });
  });
}


// ejs setup
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.urlencoded({ extended: true }));

// home page route
app.get("/", (req, res) => {
  res.render("index");
});


// STUDENT 

app.get("/students", async (req, res) => {
  const students = await queryAll("SELECT * FROM Student ORDER BY student_id");
  res.render("students/list", { students });
});

// show the blank form for adding a student
app.get("/students/new", (req, res) => {
  res.render("students/form", { student: null });
});

app.post("/students", async (req, res) => {
  const { first_name, last_name, email, major, graduation_year } = req.body;

  // we have to manually get the next id since we dont have autoincrement set up
  const row = await queryOne("SELECT MAX(student_id) AS m FROM Student");
  const nextId = (row.m || 0) + 1;

  await runQuery(
    "INSERT INTO Student (student_id, first_name, last_name, email, major, graduation_year) VALUES (?, ?, ?, ?, ?, ?)",
    [nextId, first_name, last_name, email, major, Number(graduation_year)]
  );
  res.redirect("/students");
});

app.get("/students/:id/edit", async (req, res) => {
    const student = await queryOne("SELECT * FROM Student WHERE student_id = ?", [req.params.id]);
    if (!student) return res.status(404).send("Student not found");
    res.render("students/form", { student });
});

// save the edited student back to db
app.post("/students/:id/update", async (req, res) => {
  const { first_name, last_name, email, major, graduation_year } = req.body;
  await runQuery(
    "UPDATE Student SET first_name=?, last_name=?, email=?, major=?, graduation_year=? WHERE student_id=?",
    [first_name, last_name, email, major, Number(graduation_year), req.params.id]
  );
  res.redirect("/students");
});

app.post("/students/:id/delete", async (req, res) => {
  // delete feedback for any sessions this student has
  await runQuery("DELETE FROM Feedback WHERE session_id IN (SELECT session_id FROM Session WHERE student_id = ?)", [req.params.id]);
  // delete sessions tied to this student
  await runQuery("DELETE FROM Session WHERE student_id = ?", [req.params.id]);
  // delete student-industry links
  await runQuery("DELETE FROM Student_industry WHERE student_id = ?", [req.params.id]);
  await runQuery("DELETE FROM Student WHERE student_id = ?", [req.params.id]);
  res.redirect("/students");
});


// SESSION

// this query joins student and mentor names so we can display them in the table
app.get("/sessions", async (req, res) => {
  const sessions = await queryAll(`
    SELECT s.*,
           st.first_name || ' ' || st.last_name AS student_name,
           m.first_name || ' ' || m.last_name AS mentor_name
    FROM Session s
    JOIN Student st ON s.student_id = st.student_id
    JOIN Mentor m ON s.mentor_id = m.mentor_id
    ORDER BY s.session_date DESC
  `);
  res.render("sessions/list", { sessions });
});

// need to grab students and mentors so the form dropdowns work
app.get("/sessions/new", async (req, res) => {
    const students = await queryAll("SELECT * FROM Student ORDER BY last_name");
    const mentors = await queryAll("SELECT * FROM Mentor ORDER BY last_name");
    res.render("sessions/form", { session: null, students, mentors });
});

// create session - same id thing as students
app.post("/sessions", async (req, res) => {
  const { student_id, mentor_id, session_date, duration_minutes, status, topic } = req.body;
  const row = await queryOne("SELECT MAX(session_id) AS m FROM Session");
  const nextId = (row.m || 0) + 1;
  await runQuery(
    "INSERT INTO Session (session_id, student_id, mentor_id, session_date, duration_minutes, status, topic) VALUES (?, ?, ?, ?, ?, ?, ?)",
    [nextId, Number(student_id), Number(mentor_id), session_date, Number(duration_minutes), status, topic]
  );
  res.redirect("/sessions");
});

app.get("/sessions/:id/edit", async (req, res) => {
  const session = await queryOne("SELECT * FROM Session WHERE session_id = ?", [req.params.id]);
  if (!session) return res.status(404).send("Session not found");
  const students = await queryAll("SELECT * FROM Student ORDER BY last_name");
  const mentors = await queryAll("SELECT * FROM Mentor ORDER BY last_name");
  res.render("sessions/form", { session, students, mentors });
});

app.post("/sessions/:id/update", async (req, res) => {
  const { student_id, mentor_id, session_date, duration_minutes, status, topic } = req.body;
  await runQuery(
    "UPDATE Session SET student_id=?, mentor_id=?, session_date=?, duration_minutes=?, status=?, topic=? WHERE session_id=?",
    [Number(student_id), Number(mentor_id), session_date, Number(duration_minutes), status, topic, req.params.id]
  );
  res.redirect("/sessions");
});

//todo: maybe chekc for feedback
app.post("/sessions/:id/delete", async (req, res) => {
  await runQuery("DELETE FROM Feedback WHERE session_id = ?", [req.params.id]);
  await runQuery("DELETE FROM Session WHERE session_id = ?", [req.params.id]);
  res.redirect("/sessions");
});


app.listen(PORT, () => {
  console.log(`MentorBridge running at http://localhost:${PORT}`);
});
