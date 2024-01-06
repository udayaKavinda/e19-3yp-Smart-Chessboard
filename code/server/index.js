const express = require("express");
const app = express();
const http = require("http");
const { mongoose } = require("mongoose");
const { Socket } = require("socket.io");
const Room = require("./models/room");

const port=process.env.PORT || 3000;
var server =http.createServer(app);

var io=require("socket.io")(server);

app.use(express.json());

// database
const DB="mongodb+srv://<userName>:<password>@cluster0.jovzlek.mongodb.net/?retryWrites=true&w=majority";
mongoose.connect(DB).then(()=>{
    console.log("DB connection established");
}).catch(err => console.log(err) );
//database

io.on("connection",(socket)=>{
    try{
        console.log("IO connection established");
        socket.on("createOrJoinRoom",async ()=>{
        let room =await Room.findOne({isJoin:true});
        if(room){
            const roomId=room._id.toString();
            room.isJoin = false;
            let player = {
                socketID:socket.id,
                playerType:"Black",
            }
            room.players.push(player);
            room = await room.save();
            socket.join(roomId);
            const roomSockets = io.sockets.adapter.rooms.get(roomId);
            const allSocketIds = Array.from(roomSockets);
            const otherSocketId = allSocketIds.find(socketId => socketId !== socket.id);
            io.to(otherSocketId).emit("joinRoomSuccess",room);
            room.isWhite=false;
            io.to(socket.id).emit("joinRoomSuccess",room); 
            console.log(roomId);
        }else{
            room =new Room();
            const roomId=room._id.toString();
            let player ={
                socketID:socket.id,
                playerType:"White",
            }
            room.players.push(player);
            room.isWhite=true;
            room=await room.save();
            socket.join(roomId);
            io.to(roomId).emit("createRoomSuccess",room);
            console.log(roomId);
        }
        });
        }catch(e){
        console.log(e);
        }


    socket.on('chessMove', (data) => {
        try{
            console.log(data);
            socket.join(data.roomId);
            io.to(data.roomId).emit('chessMove', data);
        }catch(e){
            console.log(e);
        }
    });
    

});



// app.get("/", function(req, res) {
//     res.send("no"+process.env.PORT);
// });

server.listen(port, "0.0.0.0", () => {
    console.log("udaya " +port);
});
