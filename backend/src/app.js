const express = require("express");

const app = express();

app.get("/", (req, res) => {
    res.send("GhostRoom is alive!");
});

module.exports = app;