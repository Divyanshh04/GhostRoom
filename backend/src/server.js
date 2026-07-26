const express = require("express");

const roomRoutes = require("./routes/roomRoutes");

const app = express();

const PORT = 3000;

app.use(express.json());

app.get("/", (req, res) => {
    res.send("🚀 GhostRoom Backend Running");
});

app.use("/rooms", roomRoutes);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});