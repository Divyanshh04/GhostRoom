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

                console.log(`${user.username} left room ${user.roomCode}`);
            }

            console.log(`User disconnected: ${socket.id}`);

        });

    });

}

module.exports = initializeSocket;