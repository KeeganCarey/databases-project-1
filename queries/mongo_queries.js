// MentorBridge MongoDB Queries
// Run these in mongosh after connecting to the mentorbridge database:
//   mongosh
//   use mentorbridge

// Query 1: Count sessions per student and calculate average session duration
db.students.aggregate([
  // flatten the sessions array so each session is its own document
  { $unwind: "$sessions" },
  {
    // group by student name and compute totals
    $group: {
      _id: { first_name: "$first_name", last_name: "$last_name" },
      total_sessions: { $sum: 1 },
      avg_duration_minutes: { $avg: "$sessions.duration_minutes" }
    }
  },
  // sort by most sessions first
  { $sort: { total_sessions: -1 } }
]);

// Query 2: Find students who are CS majors or graduating before 2026
db.students.find({
  // match either condition
  $or: [
    { major: "Computer Science" },
    { graduation_year: { $lt: 2026 } }
  ]
},
{
  // only return these fields
  first_name: 1,
  last_name: 1,
  major: 1,
  graduation_year: 1,
  _id: 0
});

// Query 3: Count how many sessions Maya Patel has
db.students.aggregate([
  // find the specific student
  { $match: { first_name: "Maya", last_name: "Patel" } },
  { $project: {
      _id: 0,
      // combine first and last name into one field
      student: { $concat: ["$first_name", " ", "$last_name"] },
      // count the number of sessions in the array
      session_count: { $size: "$sessions" }
    }
  }
]);

// Query 4: Set a student's is_active status to true
db.students.updateOne(
  // find by email
  { email: "liam.chen@university.edu" },
  // update the is_active field
  { $set: { is_active: true } }
);

// verify the update worked
db.students.find(
  { email: "liam.chen@university.edu" },
  { first_name: 1, last_name: 1, is_active: 1, _id: 0 }
);

// Query 5: Find mentors in Software Engineering with more than 5 years experience
db.mentors.find({
  // dot notation to search inside the embedded industries array
  "industries.industry_name": "Software Engineering",
  // only mentors with more than 5 years
  years_experience: { $gt: 5 }
},
{
  first_name: 1,
  last_name: 1,
  company: 1,
  job_title: 1,
  years_experience: 1,
  _id: 0
});

// Query 6 (Bonus): Find students with a completed session rated 4 or higher
db.students.find({
  // elemMatch checks for a single session that meets both conditions
  sessions: {
    $elemMatch: {
      status: "completed",
      // dot notation into the nested feedback object
      "feedback.rating": { $gte: 4 }
    }
  }
},
{
  first_name: 1,
  last_name: 1,
  "sessions.topic": 1,
  "sessions.feedback.rating": 1,
  _id: 0
});
