const { io } = require("socket.io-client");

const socket = io("http://localhost:3000");

socket.on("connect", () => {

    console.log("Connected:", socket.id);

    socket.emit("join-room", {
    roomCode: "828234",
    userId: "1c9f4f79-4f0e-4894-ab46-079f713fbf81",
    username: "Bob"
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