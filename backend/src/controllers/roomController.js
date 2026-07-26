const roomService = require("../services/roomService");

function createRoom(req, res) {
    const room = roomService.createRoom();
    res.status(201).json(room);
}

function getAllRooms(req, res) {
    const rooms = roomService.getAllRooms();
    res.status(200).json(rooms);
}

module.exports = {
    createRoom,
    getAllRooms
};