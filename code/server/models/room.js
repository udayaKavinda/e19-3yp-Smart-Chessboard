const mongoose = require('mongoose');
const playerSchema = require('./players');

const roomSchema =new mongoose.Schema({
    gameModeOnline:{
        required:true,
        type:Boolean,
        default:true,
    },
    players:[playerSchema],

    isJoin:{
        type:Boolean,
        default:true,
    },
    isWhite:{
        type:Boolean,
        default:true,
    },

    });

    const roomModel = mongoose.model('Room',roomSchema);
    module.exports =roomModel;
