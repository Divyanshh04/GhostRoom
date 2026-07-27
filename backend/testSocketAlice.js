const { io } = require("socket.io-client");

const socket = io("http://localhost:3000");

socket.on("connect", () => {

    console.log("Connected:", socket.id);

    socket.emit("join-room", {
    roomCode: "828234",
    userId: "c3fccb32-2e08-4041-b6eb-e3154b945b91",
    username: "Alice"
});

    setTimeout(() => {
        socket.emit("send-message", {
            message: "Hello GhostRoom!"
        });
    }, 1000);

});

socket.on("receive-message", (data) => {
    console.log(data);
});

socket.on("user-left", (data) => {
    console.log("User Left:", data);
});

socket.on("user-joined", (data) => {
    console.log("User Joined:", data);
});