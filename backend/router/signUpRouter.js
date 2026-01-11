const express=require('express');
const router=express.Router();
const mid=require('../middleware/authMiddleware');

const{createUser,changePassword,loginUser,add}=require('../controller/signUpController');

router.post('',createUser);

router.post('/changePassword',changePassword);

router.post('/login',loginUser);


router.post('/add',mid,add);

module.exports=router;