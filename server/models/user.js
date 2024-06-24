const mongoose= require('mongoose');

const userSchema =mongoose.Schema({

    name:{
        required: true,
        type: String,
        trim: true,
    },

    email:{
        required:true,
        type:String,
        trim:true,
        unique:true,
        validate:{
            validator:(value)=>{
                const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message:'Please enter valid email address'
        }
    },

    password:{
        required:true,
        type:String,validate:{
            validator:(value)=>{
                return value.length > 5;
            },
            message:'Please enter a long password'
        }
    },

    address:{
        type:String,
        default:''
    },

    type:{
        type:String,
        default:'user,'
    },

    //cart

})  

const User = mongoose.model("user",userSchema);

module.exports=User;