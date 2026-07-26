const crypto = require("crypto");
const rooms = require("../data/roomStore");

function generateRoomCode() {
    let roomCode;

    do {
        roomCode = Math.floor(100000 + Math.random() * 900000);
    } while (rooms.some(room => room.roomCode === roomCode));

    return roomCode;
}

function createRoom() {

    const room = {
        roomCode: generateRoomCode(),
        hostId: crypto.randomUUID(),
        maxParticipants: 5,
        participants: [],
        createdAt: new Date(),
        expiresAt: new Date(Date.now() + 60 * 60 * 1000),
        status: "active"
    };

    rooms.push(room);

    return {
        success: true,
        message: "Room created successfully",
        room
    };
}

function getAllRooms() {
    return rooms;
}

module.exports = {
    createRoom,
    getAllRooms
};