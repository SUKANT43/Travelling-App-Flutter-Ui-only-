const pool = require('../config/db');
const bcrypt = require('bcrypt');
const jwt=require('jsonwebtoken');

const createUser = async (req, res) => {
    const { name, email, password, confirmPassword } = req.body;

    if (!name || !email || !password || !confirmPassword) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    if (password !== confirmPassword) {
        return res.status(400).json({ message: 'Passwords do not match' });
    }

    try {
        const [existingUser] = await pool.query(
            'SELECT id FROM user WHERE email = ?',
            [email]
        );

        if (existingUser.length > 0) {
            return res.status(409).json({ message: 'Email already registered' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const [result] = await pool.query(
            'INSERT INTO user (name, email, password) VALUES (?, ?, ?)',
            [name, email, hashedPassword]
        );

        res.status(201).json({
            message: 'User created successfully',
            userId: result.insertId
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
};


const changePassword = async (req, res) => {
    const { email, oldPassword, password, confirmPassword } = req.body;

    if (!email || !oldPassword || !password || !confirmPassword) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    if (password !== confirmPassword) {
        return res.status(400).json({ message: 'Passwords do not match' });
    }

    try {
        const [rows] = await pool.query(
            'SELECT password FROM user WHERE email = ?',
            [email]
        );

        if (rows.length === 0) {
            return res.status(404).json({ message: 'Email not registered' });
        }

        const isMatch = await bcrypt.compare(oldPassword, rows[0].password);
        if (!isMatch) {
            return res.status(401).json({ message: 'Old password is incorrect' });
        }

        const newHash = await bcrypt.hash(password, 10);

        await pool.query(
            'UPDATE user SET password = ? WHERE email = ?',
            [newHash, email]
        );

        res.json({ message: 'Password updated successfully' });

    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
};


const loginUser=async(req,res)=>{
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
    }
try{
const [rows]=await pool.query(
    'SELECT id,password FROM user WHERE email = ?',
    [email]
);

        if (rows.length === 0) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        const isMatch = await bcrypt.compare(password, rows[0].password);

                if (!isMatch) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }
const token =jwt.sign({userId:rows[0].id,email:email},process.env.JWT_SECRET,{expiresIn:'1h'});

res.json({
            message: 'Login successful',
            token
        });

}
catch(err){
    console.error(err);
    res.status(500).json({ message: 'Server error' });
}
};

const add = async (req, res) => {
    const { text } = req.body;
    const userId = req.user.userId; // comes from JWT

    if (!text) {
        return res.status(400).json({ message: 'Text is required' });
    }

    try {
        const [result] = await pool.query(
            'INSERT INTO user_data (id, text) VALUES (?, ?)',
            [userId, text]
        );

        res.status(201).json({
            message: 'Data added successfully',
            id: result.insertId
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
};


module.exports = { createUser,changePassword,loginUser,add };
