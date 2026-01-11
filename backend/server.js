const express=require('express');
const app=express();
const cors=require('cors');
const env=require('dotenv').config();
const db=require('./config/db');
const PORT=process.env.PORT||9200;


const signUpRouter=require('./router/signUpRouter');

app.use(cors());
app.use(express.json());


app.use((req,res,next)=>{
    console.log(req.path);
    next();
});

app.use('/signup',signUpRouter);

app.listen(PORT,()=>{
    console.log(`server is running on PORT: ${PORT}`);
    db;
});

