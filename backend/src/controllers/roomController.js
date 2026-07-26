const roomService = require("../services/roomService");

function createRoom(req, res) {
    const room = roomService.createRoom();
    res.status(201).json(room);
}

function getAllRooms(req, res) {
    const rooms = roomService.getAllRooms();
    res.status(200).json(rooms);
}

function joinRoom(req, res) {

    const { roomCode } = req.params;
    const { username } = req.body;

    const result = roomService.joinRoom(roomCode, username);

    res.status(result.status || 200).json(result);
}

module.exports = {
    createRoom,
    getAllRooms,
    joinRoom
};