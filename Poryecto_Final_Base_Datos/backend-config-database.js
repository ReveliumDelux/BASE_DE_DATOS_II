// ============================================================
// CONFIG/DATABASE.JS - CONEXIÓN MYSQL
// ============================================================

const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'health_connect',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

pool.on('connection', (connection) => {
    console.log('✓ Conexión a BD establecida');
});

pool.on('error', (err) => {
    console.error('✗ Error en pool de conexiones:', err.message);
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
        console.log('→ Reconectando a la base de datos...');
    }
});

module.exports = pool;
