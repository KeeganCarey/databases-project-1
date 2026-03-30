const express = require("express");
const { MongoClient, ObjectId } = require("mongodb");
const path = require("path");

const app = express();
const PORT = 3001;
const MONGO_URL = "mongodb://localhost:27017";
const DB_NAME = "mentorbridge";

let db;

// connect to mongo when the server starts
MongoClient.connect(MONGO_URL).then((client) => {
  db = client.db(DB_NAME);
  console.log("Connected to MongoDB");

  app.listen(PORT, () => {
    console.log(`MentorBridge (Mongo) running at http://localhost:${PORT}`);
  });
}).catch((err) => {
  console.error("Failed to connect to MongoDB:", err);
  process.exit(1);
});

// ejs setup
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.urlencoded({ extended: true }));

// home page
app.get("/", (req, res) => {
  res.render("index");
});


// ==================== STUDENTS ====================

// list all students
app.get("/students", async (req, res) => {
  const students = await db.collection("students")
    .find()
    .sort({ last_name: 1 })
    .toArray();
  res.render("students/list", { students });
});

// show blank form for new student
app.get("/students/new", (req, res) => {
  res.render("students/form", { student: null });
});

// create student
app.post("/students", async (req, res) => {
  const { first_name, last_name, email, major, graduation_year } = req.body;
  await db.collection("students").insertOne({
    first_name,
    last_name,
    email,
    major,
    graduation_year: Number(graduation_year),
    is_active: true,
    industries: [],
    sessions: []
  });
  res.redirect("/students");
});

// edit student form
app.get("/students/:id/edit", async (req, res) => {
  const student = await db.collection("students")
    .findOne({ _id: new ObjectId(req.params.id) });
  if (!student) return res.status(404).send("Student not found");
  res.render("students/form", { student });
});

// update student
app.post("/students/:id/update", async (req, res) => {
  const { first_name, last_name, email, major, graduation_year } = req.body;
  await db.collection("students").updateOne(
    { _id: new ObjectId(req.params.id) },
    { $set: { first_name, last_name, email, major, graduation_year: Number(graduation_year) } }
  );
  res.redirect("/students");
});

// delete student
app.post("/students/:id/delete", async (req, res) => {
  await db.collection("students").deleteOne({ _id: new ObjectId(req.params.id) });
  res.redirect("/students");
});


// ==================== MENTORS ====================

// list all mentors
app.get("/mentors", async (req, res) => {
  const mentors = await db.collection("mentors")
    .find()
    .sort({ last_name: 1 })
    .toArray();
  res.render("mentors/list", { mentors });
});

// show blank form for new mentor
app.get("/mentors/new", (req, res) => {
  res.render("mentors/form", { mentor: null });
});

// create mentor
app.post("/mentors", async (req, res) => {
  const { first_name, last_name, email, company, job_title, years_experience } = req.body;
  await db.collection("mentors").insertOne({
    first_name,
    last_name,
    email,
    company,
    job_title,
    years_experience: Number(years_experience),
    is_active: true,
    industries: [],
    sessions: []
  });
  res.redirect("/mentors");
});

// edit mentor form
app.get("/mentors/:id/edit", async (req, res) => {
  const mentor = await db.collection("mentors")
    .findOne({ _id: new ObjectId(req.params.id) });
  if (!mentor) return res.status(404).send("Mentor not found");
  res.render("mentors/form", { mentor });
});

// update mentor
app.post("/mentors/:id/update", async (req, res) => {
  const { first_name, last_name, email, company, job_title, years_experience } = req.body;
  await db.collection("mentors").updateOne(
    { _id: new ObjectId(req.params.id) },
    { $set: { first_name, last_name, email, company, job_title, years_experience: Number(years_experience) } }
  );
  res.redirect("/mentors");
});

// delete mentor
app.post("/mentors/:id/delete", async (req, res) => {
  await db.collection("mentors").deleteOne({ _id: new ObjectId(req.params.id) });
  res.redirect("/mentors");
});
