# Health-Connect: API + Base de Datos + Frontend
## Prototipo Web de Alta Fidelidad para Triaje Hospitalario

---

## 📁 Estructura del Proyecto

```
health-connect/
├── frontend/                    # Prototipo web interactivo
│   ├── index.html              # Aplicación principal (HTML + CSS + JS)
│   ├── assets/
│   │   ├── css/
│   │   │   └── styles.css      # Estilos principales
│   │   └── js/
│   │       └── app.js          # Lógica de la aplicación
│   └── README.md
│
├── backend/                     # API REST
│   ├── config/
│   │   ├── database.js         # Configuración MySQL
│   │   └── auth.js             # Configuración JWT
│   ├── controllers/            # Lógica de negocio
│   │   ├── authController.js
│   │   ├── pacientesController.js
│   │   ├── triageController.js
│   │   ├── queueController.js
│   │   ├── recordsController.js
│   │   └── usersController.js
│   ├── models/                 # Modelos de datos
│   │   ├── Usuario.js
│   │   ├── Paciente.js
│   │   ├── Triaje.js
│   │   ├── ColaUrgencias.js
│   │   └── Expediente.js
│   ├── routes/                 # Rutas de la API
│   │   ├── auth.js
│   │   ├── pacientes.js
│   │   ├── triaje.js
│   │   ├── queue.js
│   │   ├── records.js
│   │   └── users.js
│   ├── middleware/
│   │   ├── auth.js             # Validación JWT
│   │   ├── errorHandler.js
│   │   └── validator.js        # Validaciones
│   ├── utils/
│   │   ├── triageAI.js         # Lógica de IA para triaje
│   │   ├── emailService.js     # Servicio de emails
│   │   └── logger.js           # Sistema de logs
│   ├── server.js               # Punto de entrada
│   ├── package.json
│   ├── .env.example
│   └── README.md
│
├── database/
│   ├── health_connect_database.sql  # Esquema completo
│   ├── seeds/                       # Datos iniciales
│   │   └── initial_data.sql
│   └── migrations/
│       ├── 001_initial_schema.sql
│       └── 002_views_procedures.sql
│
├── docs/
│   ├── ARQUITECTURA.md          # Arquitectura del sistema
│   ├── API_ENDPOINTS.md         # Documentación de endpoints
│   ├── DATABASE_DIAGRAM.md      # Diagrama ER
│   └── SETUP.md                 # Guía de instalación
│
└── README.md                     # Documentación principal
```

---

## 🗄️ Base de Datos

### Tablas principales:

1. **usuarios** - Personal del hospital (rol, credenciales)
2. **pacientes** - Datos demográficos y antecedentes
3. **signos_vitales** - Registro de TA, FC, FR, SpO2, Temp
4. **captura_clinica** - Síntomas y motivo de consulta
5. **sugerencias_triaje_ia** - Recomendaciones de IA
6. **triajes** - Triaje validado por personal médico
7. **cola_urgencias** - Pacientes en espera ordenados por prioridad
8. **expedientes** - Historial clínico digital
9. **notas_clinicas** - Evolución del paciente
10. **procedimientos** - Intervenciones realizadas
11. **prescripciones** - Medicamentos prescritos
12. **derivaciones** - Derivaciones a especialidades
13. **auditoria** - Logs de acciones
14. **reportes_estadisticas** - Analytics

### Características:
- **Relaciones normalizadas** (3FN)
- **Índices optimizados** para búsquedas rápidas
- **Vistas pre-calculadas** para reportes
- **Procedimientos almacenados** para operaciones críticas
- **Triggers de auditoría** automáticos

---

## 🚀 API REST (Node.js + Express)

### Endpoints principales:

#### Autenticación
```
POST   /api/auth/login               # Iniciar sesión
POST   /api/auth/logout              # Cerrar sesión
POST   /api/auth/refresh             # Renovar token
POST   /api/auth/reset-password      # Resetear contraseña
```

#### Pacientes
```
GET    /api/pacientes                # Listar pacientes
GET    /api/pacientes/:id            # Obtener paciente
POST   /api/pacientes                # Registrar nuevo paciente
PUT    /api/pacientes/:id            # Actualizar paciente
GET    /api/pacientes/search/:query  # Buscar paciente
```

#### Triaje
```
POST   /api/triaje/captura           # Guardar captura clínica
POST   /api/triaje/analizar-ia       # Análisis IA del triaje
POST   /api/triaje/validar           # Validar y guardar triaje
GET    /api/triaje/historial/:id     # Historial de triajes
```

#### Cola de Urgencias
```
GET    /api/queue                    # Obtener cola actual
GET    /api/queue/:id                # Obtener paciente en cola
POST   /api/queue/start-attention    # Iniciar atención
POST   /api/queue/finish-attention   # Completar atención
GET    /api/queue/stats              # Estadísticas de cola
```

#### Expedientes
```
GET    /api/expedientes/:id          # Obtener expediente
POST   /api/expedientes              # Crear nuevo expediente
POST   /api/expedientes/:id/notas    # Añadir nota clínica
POST   /api/expedientes/:id/procedimiento  # Registrar procedimiento
POST   /api/expedientes/:id/prescripcion   # Hacer prescripción
```

#### Reportes
```
GET    /api/reportes/hoy             # Estadísticas del día
GET    /api/reportes/rango           # Reportes por rango fechas
GET    /api/reportes/ocupacion       # Ocupación hospitalaria
GET    /api/reportes/triajes         # Análisis de triajes
```

#### Administración
```
GET    /api/usuarios                 # Listar usuarios
POST   /api/usuarios                 # Crear usuario
PUT    /api/usuarios/:id             # Editar usuario
DELETE /api/usuarios/:id             # Desactivar usuario
GET    /api/usuarios/:id/permisos    # Obtener permisos
```

### Características de seguridad:
- JWT token authentication
- Role-based access control (RBAC)
- Password hashing (bcrypt)
- CORS configuration
- Rate limiting
- Input validation
- SQL injection prevention
- Audit logging

---

## 🎨 Frontend (HTML + CSS + JavaScript)

### Características:

**Diseño:**
- Desktop-first responsive
- Sistema de diseño modular
- Paleta: Blanco/Gris + Azul médico + Colores de triaje
- Tipografía sans-serif moderna
- Transiciones suaves y animaciones

**Funcionalidades:**
- Autenticación con email/contraseña
- Dashboard con métricas en tiempo real
- Búsqueda y registro de pacientes
- Captura interactiva de signos vitales
- Sugerencia de triaje asistida por IA
- Validación manual del triaje
- Visualización de cola priorizada
- Expediente clínico digital
- Pantalla de atención médica
- Dashboard administrativo
- Gestión de usuarios y roles

**Páginas principales:**
1. **Login** - Autenticación
2. **Dashboard** - Vista general
3. **Pacientes** - Registro y búsqueda
4. **Triaje** - Captura y IA
5. **Cola** - Priorización
6. **Expedientes** - Historiales
7. **Reportes** - Analytics
8. **Administración** - Usuarios y config

---

## 🤖 Sistema de IA para Triaje

### Algoritmo de priorización:

El sistema evalúa automáticamente:

1. **Signos vitales críticos:**
   - SpO2 < 90% → ROJO
   - FC > 110 o < 40 → ROJO
   - PAS > 180 o < 70 → ROJO
   - Temperatura > 40°C → ROJO

2. **Síntomas reportados:**
   - Dolor torácico, dificultad respiratoria → ROJO
   - Pérdida de conciencia, convulsiones → ROJO

3. **Rangos intermedios:**
   - Anormal pero no crítico → NARANJA
   - Ligeramente anormal → AMARILLO
   - Normal o leve → VERDE/AZUL

**Nota importante:** El sistema asiste la priorización inicial. La decisión final es siempre del personal médico.

---

## 📋 Flujo Completo del Sistema

```
1. LOGIN
   ↓
2. DASHBOARD (vista general)
   ↓
3. REGISTRO PACIENTE
   ├─ Búsqueda (¿existe?)
   ├─ Si existe → ir a triaje
   └─ Si no → registrar nuevo
   ↓
4. CAPTURA CLÍNICA
   ├─ Signos vitales (TA, FC, FR, SpO2, Temp)
   ├─ Síntomas principales
   ├─ Alergias y medicamentos
   └─ Antecedentes relevantes
   ↓
5. ANÁLISIS IA
   ├─ Sugerencia automática de prioridad
   ├─ Criterios evaluados
   └─ Confianza del modelo
   ↓
6. VALIDACIÓN MÉDICA
   ├─ Personal revisa sugerencia
   ├─ Puede aceptar o modificar
   └─ Escribe justificación
   ↓
7. INGRESO A COLA
   ├─ Paciente entra a cola priorizada
   ├─ Se asigna número de posición
   └─ Se notifica al equipo médico
   ↓
8. ATENCIÓN MÉDICA
   ├─ Médico inicia atención
   ├─ Registra procedimientos
   ├─ Prescribe medicamentos
   └─ Registra observaciones
   ↓
9. EXPEDIENTE DIGITAL
   ├─ Información guardada automáticamente
   ├─ Disponible para futuras consultas
   └─ Genera reporte de atención
```

---

## 🔐 Seguridad

- **Autenticación:** JWT tokens con expiración
- **Autorización:** RBAC por rol
- **Encriptación:** Contraseñas hasheadas (bcrypt)
- **Validación:** Inputs sanitizados
- **Auditoría:** Registro de todas las acciones
- **Cumplimiento:** Consideraciones HIPAA básicas

---

## 📊 Tecnologías

### Backend:
- Node.js + Express.js
- MySQL 8.0+
- JWT authentication
- bcrypt password hashing
- Joi validation
- Morgan logging
- CORS support

### Frontend:
- HTML5 semántico
- CSS3 (Grid, Flexbox, Variables)
- JavaScript vanilla (ES6+)
- Responsive design
- Accesibilidad WCAG AA

### Base de datos:
- MySQL 8.0+
- Procedures almacenados
- Vistas pre-calculadas
- Triggers de auditoría

---

## 🚀 Instalación y Uso

### 1. Base de Datos
```bash
# Crear base de datos
mysql -u root -p < health_connect_database.sql

# O usar MySQL Workbench:
# Abrir: health_connect_database.sql → Ejecutar
```

### 2. Backend API
```bash
cd backend/
npm install
npm start
# La API corre en http://localhost:3000
```

### 3. Frontend
```bash
# Abrir en navegador:
# file:///C:/Users/User/OneDrive/Escritorio/UIP%202K26/Poryecto_Final_Base_Datos/health-connect-index.html
```

---

## 📚 Documentación Adicional

- `docs/ARQUITECTURA.md` - Diseño del sistema
- `docs/API_ENDPOINTS.md` - Endpoints detallados
- `docs/DATABASE_DIAGRAM.md` - Diagrama ER
- `docs/SETUP.md` - Guía de instalación

---

## 👨‍💼 Usuarios de Prueba (después de correr BD)

| Email | Contraseña | Rol |
|-------|-----------|-----|
| juan.diaz@hospital.com | password123 | Médico |
| maria.santos@hospital.com | password123 | Médico |
| pablo.morales@hospital.com | password123 | Enfermero |
| carmen.ruiz@hospital.com | password123 | Recepcionista |
| fernando.lopez@hospital.com | password123 | Administrador |
| ana.garcia@hospital.com | password123 | Triajista |

---

## 📞 Contacto y Soporte

Para problemas o preguntas sobre el sistema, contactar al equipo de desarrollo.

---

**Sistema Health-Connect © 2026 - Prototipo de Triaje Hospitalario Asistido por IA**
