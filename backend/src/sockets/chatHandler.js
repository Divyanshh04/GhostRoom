const socketUsers = require("../data/socketStore");
const { getRoomByCode } = require("../services/roomService");

function registerChatEvents(io, socket) {

    socket.on("join-room", ({ roomCode, userId, username }) => {

        const room = getRoomByCode(roomCode);

        if (!room) {
            socket.emit("error-message", "Room not found");
            return;
        }

        const participant = room.participants.find(
            participant => participant.userId === userId
        );

        if (!participant) {
            socket.emit("error-message", "You are not a participant of this room");
            return;
        }

        socket.join(roomCode);

        socketUsers.set(socket.id, {
            userId: participant.userId,
            username: participant.username,
            roomCode
        });

        console.log(`${participant.username} joined room ${roomCode}`);

        socket.to(roomCode).emit("user-joined", {
            userId: participant.userId,
            username: participant.username
        });
        io.to(roomCode).emit("participant-count", {
    count: room.participants.length
});

    });

    socket.on("send-message", ({ message }) => {

        const user = socketUsers.get(socket.id);

        if (!user) {
            return;
        }

        io.to(user.roomCode).emit("receive-message", {
            userId: user.userId,
            username: user.username,
            message,
            timestamp: new Date().toISOString()
        });

    });

}

module.exports = registerChatEvents;