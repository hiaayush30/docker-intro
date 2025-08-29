const express = require("express");

const app = express();

app.get("/",(req,res)=>{
    return res.json({
        message:"I am a nodejs app in a container"
    })
})

app.listen(8000,()=>{
    console.log("server running on port:"+8000)
})