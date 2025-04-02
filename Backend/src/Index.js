const DATABASE_CONNECTION = require('./Database/Connection.database')
const PORT = 5000
const app = require('./App');
const dotenv = require('dotenv');
const http = require("http");
const { initializeSocket } = require("./Utils/Socket");

const server = http.createServer(app);

initializeSocket(server);

dotenv.config({
    path: './.env'
})

DATABASE_CONNECTION()
    .then(() => {
        server.listen(PORT, () => {
            console.log(`Server connected on port :${PORT}`)
        })
    })
    .catch(() => {
        console.log('error while connecting to server')
    })
