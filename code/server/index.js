const express = require("express");
const app = express();
const http = require("http");
const { mongoose } = require("mongoose");
const { Socket } = require("socket.io");
const Room = require("./models/room");
const { on } = require("events");
const Eprofile = mongoose.model('Eprofile',require("./models/eprofile"));

const port=process.env.PORT || 3000;
var server =http.createServer(app);

var io=require("socket.io")(server);

app.use(express.json());

// database
const DB="mongodb+srv://namal:qazxnmlp@cluster0.jovzlek.mongodb.net/?retryWrites=true&w=majority";

mongoose.connect(DB).then(()=>{
    console.log("DB connection established");
}).catch(err => console.log(err) );
//database

const onlinePlayers = [];
const onlineCommunityPlayers=[];
let room;

io.on("connection",(socket)=>{
    console.log("IO connection established");
    socket.on('init', async ({profileId}) => {
        try {
            console.log(profileId);
            let eprofile =await Eprofile.findOne({"profileId":profileId});
            if(eprofile){
                eprofile.socketId=socket.id;
            }else{
                eprofile =new Eprofile({"profileId":profileId,"socketId":socket.id});
                }
            await eprofile.save();
            socket.emit('initDone',eprofile);
        } catch (e) {
            console.log(e);
        }
    });

    socket.on('disconnect', async () => {
        try {
            console.log("Disconnect");
            handleCommunityDisconnect(socket.id);
            handleGameMenuDisconnect(socket.id);
            handleGameDisconnect(socket.id);

        } catch (e) {
            console.log(e);
        }
    });

    //game-menu screen
    try{
        socket.on("createOrJoinRoom",async ()=>{
            console.log("onlinegame");
        
        if(onlinePlayers.length==0){
            room =new Room();
            const roomId=room._id.toString();
            onlinePlayers.push([roomId,socket.id]);
            socket.join(roomId);
        }else{
            const [roomId,otherSocketId]=onlinePlayers.pop();
            if(otherSocketId!=socket.id){
            socket.join(roomId);
            room.players.push(await Eprofile.findOne({"socketId":socket.id}));
            room.players.push(await Eprofile.findOne({"socketId":otherSocketId}));
            room = await room.save();
            io.to(roomId).emit("joinRoomSuccess",room);
            console.log(room);
            }else{
                onlinePlayers.push([roomId,otherSocketId]);
            }
        }
        });
        }catch(e){
        console.log(e);
        }

        socket.on('gameMenuDisconnect', async () => {
            try {handleGameMenuDisconnect(socket.id);} catch (e) {console.log(e);}
        });

    //game screnn
    socket.on('chessMove', (data) => {
        try{
            console.log(data);
            socket.join(data.roomId);
            io.to(data.roomId).emit('chessMove', data);
        }catch(e){
            console.log(e);
        }
    });
    socket.on('gameDisconnect', async () => {
        handleGameDisconnect(socket.id);
    });
    socket.on('askCommunityGame', async ({profileId}) => {
        try {
            let eprofile =await Eprofile.findOne({"profileId":profileId});
            console.log(eprofile);
            io.to(eprofile.socketId).emit('communityGameAcceptorWithdraw', {"profileId":profileId});

        } catch (e) {
            console.log(e);
        }
    });

    //community screen
    socket.on('communityDisconnect', async () => {
        try {handleCommunityDisconnect(socket.id);} catch (e) {console.log(e);}
        let eprofiles = await Eprofile.find({ socketId: { $in: onlineCommunityPlayers } });
        io.emit('community', eprofiles);
    });
    
    socket.on('communityConnect', async () => {
        try {
            console.log("communityConnect");
            onlineCommunityPlayers.push(socket.id);
            let eprofiles = await Eprofile.find({ socketId: { $in: onlineCommunityPlayers } });
            io.emit('community', eprofiles);
        } catch (e) {
            console.log(e);
        }
    });
    
    function handleGameDisconnect(socketId) {
        // const rooms = io.sockets.adapter.room;
    
        // for (const roomId in rooms) {
        //     console.log("Game disconnected"+rooms.first);

        // }
    } 

    function handleCommunityDisconnect(socketId) {
        console.log("Community disconnected"+socketId);
        const indexToRemove = onlineCommunityPlayers.indexOf(socketId);
        if (indexToRemove !== -1) {
            onlineCommunityPlayers.splice(indexToRemove, 1);
            }
    }   

    function handleGameMenuDisconnect(socketId) {
        console.log("Game menu disconnected"+socketId);
        if(onlinePlayers.length!=0){
            const [roomId,otherSocketId]=onlinePlayers.pop();
            if(otherSocketId!=socketId){
                onlinePlayers.push([roomId,otherSocketId]);
        }}
    }
});


server.listen(port, "0.0.0.0", () => {
    console.log("udaya " +port);
});
