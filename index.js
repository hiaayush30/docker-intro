const express = require("express");

const app = express();

app.get("/",(req,res)=>{
    return res.json({
        message:"I am a nodejs app in a container"
    })
})

app.listen(process.env.SERVER_PORT || 8000,()=>{
    console.log("server running on port:"+process.env.SERVER_PORT ? process.env.PORT : 8000)
})