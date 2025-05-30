const jwt = require("jsonwebtoken");

const verifyToken = (socket, next) => {
  
    const token = socket.handshake.headers["authorization"] ?? socket.handshake.query.token;
    
    if (!token) {
        return next(new Error('Authentication error: No token provided'));
    }

    jwt.verify(token, process.env.SecretKey, (err, decoded) => {
        if (err) {
            return next(new Error('Authentication error: Invalid token'));
        }
       
        socket.user = decoded;
        next();
    });
};


module.exports = verifyToken;