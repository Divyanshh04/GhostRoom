const registerChatEvents = require("./chatHandler");
const socketUsers = require("../data/socketStore");
const { removeParticipant } = require("../services/roomService");

function initializeSocket(io) {

    io.on("connection", (socket) => {

        console.log(`User connected: ${socket.id}`);

        registerChatEvents(io, socket);

        socket.on("disconnect", () => {

            const user = socketUsers.get(socket.id);

            if (user) {

                removeParticipant(user.roomCode, user.userId);

                socketUsers.delete(socket.id);

                io.to(user.roomCode).emit("user-left", {
                    userId: user.userId,
                    username: user.username
                });
                const room = require("../services/roomService")
    .getRoomByCode(user.roomCode);

io.to(user.roomCode).emit("participant-count", {
    count: room ? room.participants.length : 0
});

                console.log(`${user.username} left room ${user.roomCode}`);
            }

            console.log(`User disconnected: ${socket.id}`);

        });

    });

}

module.exports = initializeSocket;