// ============================================================
// HEALTH-CONNECT: SERVER.JS (API PRINCIPAL)
// ============================================================

require('dotenv').config();
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const compression = require('compression');
const bodyParser = require('body-parser');
const logger = require('./utils/logger');

// Importar rutas
const authRoutes = require('./routes/auth');
const pacientesRoutes = require('./routes/pacientes');
const triageRoutes = require('./routes/triaje');
const queueRoutes = require('./routes/queue');
const recordsRoutes = require('./routes/records');
const usersRoutes = require('./routes/users');

// Inicializar app
const app = express();

// ============================================================
// MIDDLEWARE DE SEGURIDAD
// ============================================================

app.use(helmet());
app.use(cors({
    origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
    credentials: true
}));

// Rate limiting
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutos
    max: 100, // límite de 100 solicitudes
    message: 'Demasiadas solicitudes, por favor intente más tarde.'
});
app.use('/api/', limiter);

// ============================================================
// MIDDLEWARE DE PARSEO Y LOGGING
// ============================================================

app.use(compression());
app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));
app.use(morgan('combined', { stream: { write: message => logger.info(message) } }));

// ============================================================
// RUTAS DE LA API
// ============================================================

// Autenticación
app.use('/api/auth', authRoutes);

// Pacientes
app.use('/api/pacientes', pacientesRoutes);

// Triaje
app.use('/api/triaje', triageRoutes);

// Cola de urgencias
app.use('/api/queue', queueRoutes);

// Expedientes clínicos
app.use('/api/expedientes', recordsRoutes);

// Usuarios y administración
app.use('/api/usuarios', usersRoutes);

// ============================================================
// RUTA DE SALUD
// ============================================================

app.get('/health', (req, res) => {
    res.status(200).json({
        status: 'OK',
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// ============================================================
// MANEJO DE ERRORES
// ============================================================

// 404 - Not found
app.use((req, res) => {
    res.status(404).json({
        success: false,
        message: 'Ruta no encontrada',
        path: req.originalUrl
    });
});

// Error handler global
app.use((err, req, res, next) => {
    logger.error(err.message);
    
    const status = err.status || 500;
    const message = err.message || 'Error interno del servidor';

    res.status(status).json({
        success: false,
        message: message,
        ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
    });
});

// ============================================================
// INICIAR SERVIDOR
// ============================================================

const PORT = process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';

app.listen(PORT, () => {
    logger.info(`
    ╔════════════════════════════════════════╗
    ║   HEALTH-CONNECT API INICIADO          ║
    ║   Puerto: ${PORT}
    ║   Ambiente: ${NODE_ENV}
    ║   Hora: ${new Date().toLocaleString('es-CO')}
    ╚════════════════════════════════════════╝
    `);
});

module.exports = app;
