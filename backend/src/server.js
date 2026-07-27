const http = require("http");
const app = require("./app");
const { Server } = require("socket.io");
const initializeSocket = require("./sockets/socketHandler");
const redisClient = require("./config/redis");

const PORT = 3000;

const server = http.createServer(app);

const io = new Server(server, {
    cors: {
        origin: "*"
    }
});

initializeSocket(io);

async function startServer() {

    try {

        await redisClient.connect();

        console.log("✅ Connected to Redis");

        server.listen(PORT, () => {
            console.log(`Server running on http://localhost:${PORT}`);
        });

    } catch (error) {

        console.error("Failed to connect to Redis:", error);
        process.exit(1);

    }

}

startServer();