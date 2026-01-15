const express=require("express");
const app=express();
const env=require("dotenv").config();
const PORT=process.env.PORT;
const cors=require("cors");

const db=require('./config/db');

const userRoute=require('./routers/userRouter');

app.use(express.json());
app.use(cors());
app.use((req,res,next)=>{
    console.log(req.path);
    next();
});

app.use("/user",userRoute);

app.listen(PORT,()=>{
    console.log(`server is running on ${PORT}`);
    
});