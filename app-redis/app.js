const express = require("express");
const { createClient } = require("redis");
const path = require("path");

const app = express();
const PORT = 3002;
const REDIS_URL = "redis://localhost:6379";
const LEADERBOARD_KEY = "leaderboard:mentors";

// set up the redis client
const redis = createClient({ url: REDIS_URL });
redis.on("error", (err) => console.error("Redis error:", err));

// connect to redis when the server starts
(async () => {
  await redis.connect();
  console.log("Connected to Redis");

  app.listen(PORT, () => {
    console.log(`MentorBridge (Redis) running at http://localhost:${PORT}`);
  });
})();


// ejs setup
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.urlencoded({ extended: true })); // lets us read form posts

// send people straight to the leaderboard
app.get("/", (req, res) => res.redirect("/leaderboard"));


// Leaderboard

// list all mentors ranked highest score first
app.get("/leaderboard", async (req, res) => {
  // ZREVRANGE with WITHSCORES gives us everyone in descending order
  const raw = await redis.sendCommand([
    "ZREVRANGE", LEADERBOARD_KEY, "0", "-1", "WITHSCORES"
  ]);
  // raw comes back as [name1, score1, name2, score2, ...] so we pair them
  const entries = [];
  for (let i = 0; i < raw.length; i += 2) {
    entries.push({ name: raw[i], score: Number(raw[i + 1]) });
  }
  res.render("leaderboard", { entries });
});

// blank form for adding a mentor
app.get("/leaderboard/new", (req, res) => {
  res.render("leaderboard-form", { entry: null });
});

// add a mentor to the leaderboard
app.post("/leaderboard", async (req, res) => {
  const { name, score } = req.body;
  await redis.zAdd(LEADERBOARD_KEY, { score: Number(score), value: name });
  res.redirect("/leaderboard");
});

// load existing mentor data into the edit form
app.get("/leaderboard/:name/edit", async (req, res) => {
    const { name } = req.params;
    const score = await redis.zScore(LEADERBOARD_KEY, name);
    if (score === null) return res.status(404).send("Mentor not on leaderboard");
    res.render("leaderboard-form", { entry: { name, score } });
});

// save edits back (if name changed remove old member first)
app.post("/leaderboard/:name/update", async (req, res) => {
  const oldName = req.params.name;
  const { name, score } = req.body;
  if (name !== oldName) await redis.zRem(LEADERBOARD_KEY, oldName);
  await redis.zAdd(LEADERBOARD_KEY, { score: Number(score), value: name });
  res.redirect("/leaderboard");
});

// remove a mentor from the leaderboard
app.post("/leaderboard/:name/delete", async (req, res) => {
  await redis.zRem(LEADERBOARD_KEY, req.params.name);
  res.redirect("/leaderboard");
});
