const mysql2 = require('mysql2/promise');

const pool = mysql2.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_SCHEMA,
});

(async () => {
    try {
        const connection = await pool.getConnection();
        console.log("DB connected successfully");
        connection.release();
    } catch (err) {
        console.error("DB not connected:", err.message);
    }
})();

module.exports = pool;
