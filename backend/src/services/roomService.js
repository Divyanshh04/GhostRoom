const crypto = require("crypto");
const rooms = require("../data/roomStore");

function generateRoomCode() {
    let roomCode;

    do {
        roomCode = Math.floor(100000 + Math.random() * 900000);
    } while (rooms.some(room => room.roomCode === roomCode));

    return roomCode;
}

function createRoom(username = "Host") {

    const hostId = crypto.randomUUID();

    const room = {
        roomCode: generateRoomCode(),
        hostId,
        maxParticipants: 5,
        participants: [
            {
                userId: hostId,
                username
            }
        ],
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

function joinRoom(roomCode, username) {

    const room = rooms.find(room => room.roomCode === Number(roomCode));

    if (!room) {
        return {
            success: false,
            status: 404,
            message: "Room not found."
        };
    }

    if (!username) {
        return {
            success: false,
            status: 400,
            message: "Username is required."
        };
    }

    if (room.participants.length >= room.maxParticipants) {
        return {
            success: false,
            status: 409,
            message: "Room is full."
        };
    }

    const usernameExists = room.participants.some(
        participant => participant.username === username
    );

    if (usernameExists) {
        return {
            success: false,
            status: 409,
            message: "Username already exists."
        };
    }

    const participant = {
        userId: crypto.randomUUID(),
        username
    };

    room.participants.push(participant);

    return {
        success: true,
        message: "Joined room successfully.",
        room
    };
}

function leaveRoom(roomCode, userId) {

    const room = rooms.find(room => room.roomCode === Number(roomCode));

    if (!room) {
        return {
            success: false,
            status: 404,
            message: "Room not found."
        };
    }

    const participantIndex = room.participants.findIndex(
        participant => participant.userId === userId
    );

    if (participantIndex === -1) {
        return {
            success: false,
            status: 404,
            message: "Participant not found."
        };
    }

    room.participants.splice(participantIndex, 1);

    if (room.participants.length === 0) {

        const roomIndex = rooms.findIndex(
            room => room.roomCode === Number(roomCode)
        );

        rooms.splice(roomIndex, 1);

        return {
            success: true,
            message: "Room deleted because it became empty."
        };
    }

    if (room.hostId === userId) {
        room.hostId = room.participants[0].userId;
    }

    return {
        success: true,
        message: "Left room successfully.",
        room
    };
}

module.exports = {
    createRoom,
    getAllRooms,
    joinRoom,
    leaveRoom
};