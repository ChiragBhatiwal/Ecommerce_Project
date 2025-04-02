const socketIo = require('socket.io');
const { handleOrderStatusSocketEvents } = require("../Controllers/Order.controller");
const verifyToken = require('../Middlewares/Socket.middleware');

let io;
let connectedClients = {};

// Initializing Socket Through Index.js
const initializeSocket = (server) => {
    io = socketIo(server);

    io.use((socket, next) => {
        try {
            verifyToken(socket, next);
        } catch (error) {
            console.error("Socket authentication error:", error.message);
            next(new Error("Authentication error"));
        }
    });

    io.on('connection', (socket) => {

        const userId = socket.user._id;
        connectedClients[userId] = socket.id;

        socket.on('disconnect', () => {
            delete connectedClients[userId];
        });

        socket.on('message', (data) => {
            console.log(`Message from ${userId}:`, data);
        });

        handleOrderStatusSocketEvents(socket);
    });

    return io;
};

// Get connected client by user ID
const getUserSocket = (userId) => {
    const socketId = connectedClients[userId];
    return socketId ? io.sockets.sockets.get(socketId) : null;
};

module.exports = { initializeSocket, getUserSocket };