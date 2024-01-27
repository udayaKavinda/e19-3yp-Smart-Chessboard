const mongoose = require('mongoose');
const eprofileSchema = require('./eprofile');

const roomSchema =new mongoose.Schema({
    gameModeOnline:{
        required:true,
        type:Boolean,
        default:true,
    },
    players:[eprofileSchema],

    isWhite:{
        type:Boolean,
        default:true,
    },

    });

    const roomModel = mongoose.model('Room',roomSchema);
    module.exports =roomModel;
