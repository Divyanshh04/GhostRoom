const express = require("express");
const router = express.Router();

const roomController = require("../controllers/roomController");

router.get("/", roomController.getAllRooms);
router.post("/", roomController.createRoom);
router.post("/:roomCode/join", roomController.joinRoom);

module.exports = router;