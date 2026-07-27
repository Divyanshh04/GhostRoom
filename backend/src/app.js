const express = require("express");
const roomRoutes = require("./routes/roomRoutes");

const app = express();

app.use(express.json());

app.get("/", (req, res) => {
    res.json({
        message: "GhostRoom API is running"
    });
});

app.use("/rooms", roomRoutes);

module.exports = app;