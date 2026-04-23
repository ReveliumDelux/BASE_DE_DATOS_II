# 🚀 HEALTH-CONNECT: GUÍA COMPLETA DE INSTALACIÓN

## 📋 Requisitos Previos

- **Node.js** v14+ (descargar de nodejs.org)
- **MySQL** 8.0+ o MariaDB 10.5+
- **MySQL Workbench** o DBeaver (para visualizar BD)
- **Navegador moderno** (Chrome, Firefox, Safari, Edge)
- **Editor de código** (VS Code recomendado)

---

## 📁 Carpeta del Proyecto

Todos los archivos están en:
```
C:\Users\User\OneDrive\Escritorio\UIP 2K26\Poryecto_Final_Base_Datos\
```

---

## ✅ PASO 1: CREAR LA BASE DE DATOS

### 1.1 Abrir MySQL Workbench

1. Abre **MySQL Workbench**
2. Conecta con tu usuario root (configuración local)
3. Ve a **File** → **Open SQL Script**
4. Selecciona el archivo: `health_connect_database.sql`

### 1.2 Ejecutar el script SQL

1. El script completo se abre en el editor
2. Presiona **Ctrl + Shift + Enter** o haz clic en el ⚡ para ejecutar
3. Espera a que termine (toma ~5-10 segundos)

### 1.3 Verificar que la BD fue creada

1. En el panel izquierdo de Workbench, haz clic en **refresh** 🔄
2. Deberías ver la base de datos `health_connect`
3. Expándela y verifica que contiene las tablas:
   - ✓ usuarios
   - ✓ pacientes
   - ✓ signos_vitales
   - ✓ captura_clinica
   - ✓ triajes
   - ✓ cola_urgencias
   - ✓ expedientes
   - ✓ notas_clinicas
   - ✓ etc.

**Usuarios de prueba creados:**
- Email: `juan.diaz@hospital.com` | Contraseña: `password123` | Rol: Médico
- Email: `pablo.morales@hospital.com` | Contraseña: `password123` | Rol: Enfermero
- Email: `fernando.lopez@hospital.com` | Contraseña: `password123` | Rol: Administrador

---

## ✅ PASO 2: INSTALAR LA API (BACKEND)

### 2.1 Preparar la carpeta del backend

```bash
# Crear carpeta de backend si no existe
cd "C:\Users\User\OneDrive\Escritorio\UIP 2K26\Poryecto_Final_Base_Datos"
mkdir backend
cd backend
```

### 2.2 Copiar archivos necesarios

Copiar los siguientes archivos a la carpeta `backend/`:

```
backend/
├── package.json              (desde: backend-package.json)
├── server.js                 (desde: backend-server.js)
├── .env.example              (desde: .env.example)
├── config/
│   ├── database.js           (desde: backend-config-database.js)
│   └── auth.js
├── utils/
│   ├── triageAI.js           (desde: backend-utils-triageAI.js)
│   ├── logger.js
│   └── emailService.js
├── routes/
│   ├── auth.js
│   ├── pacientes.js
│   ├── triaje.js
│   ├── queue.js
│   ├── records.js
│   └── users.js
├── controllers/
│   ├── authController.js
│   ├── pacientesController.js
│   ├── triageController.js
│   ├── queueController.js
│   ├── recordsController.js
│   └── usersController.js
├── middleware/
│   ├── auth.js
│   ├── errorHandler.js
│   └── validator.js
└── logs/
    └── .gitkeep
```

### 2.3 Instalar dependencias

```bash
# Desde la carpeta backend/
npm install

# Esto instalará:
# ✓ express
# ✓ mysql2
# ✓ jsonwebtoken
# ✓ bcryptjs
# ✓ dotenv
# ✓ cors
# ✓ y más...
```

**Tiempo esperado:** 2-3 minutos

### 2.4 Configurar variables de entorno

1. Renombra `.env.example` a `.env`:
```bash
copy .env.example .env
```

2. Abre `.env` y verifica/actualiza:
```
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=                    # Tu contraseña de MySQL (si la tienes)
DB_NAME=health_connect
NODE_ENV=development
PORT=3000
```

### 2.5 Iniciar el servidor

```bash
# Con nodemon (recomendado para desarrollo)
npm run dev

# O directamente
npm start
```

**Deberías ver:**
```
╔════════════════════════════════════════╗
║   HEALTH-CONNECT API INICIADO          ║
║   Puerto: 3000
║   Ambiente: development
║   Hora: 22/04/2026 14:45:30
╚════════════════════════════════════════╝
```

### 2.6 Verificar que la API está funcionando

Abre en tu navegador:
- http://localhost:3000/health

Deberías ver:
```json
{
  "status": "OK",
  "timestamp": "2026-04-22T14:45:30.123Z",
  "uptime": 5.234
}
```

---

## ✅ PASO 3: ABRIR EL FRONTEND (PROTOTIPO WEB)

### 3.1 Abrir el archivo HTML

**Opción 1: Desde el explorador de archivos**
1. Ve a la carpeta del proyecto
2. Busca el archivo: `health-connect-index.html`
3. Haz clic derecho → **Abrir con** → Elige tu navegador (Chrome recomendado)

**Opción 2: Desde la línea de comandos**
```bash
# En Windows
start "C:\Users\User\OneDrive\Escritorio\UIP 2K26\Poryecto_Final_Base_Datos\health-connect-index.html"

# O en una terminal:
cd "C:\Users\User\OneDrive\Escritorio\UIP 2K26\Poryecto_Final_Base_Datos"
start health-connect-index.html
```

### 3.2 La aplicación está lista

Se abrirá en tu navegador mostrando:
- ✓ Sidebar de navegación
- ✓ Dashboard principal
- ✓ Todas las páginas del sistema

---

## 🎯 FLUJO DE DEMOSTRACIÓN INTERACTIVA

### Prueba el flujo completo:

1. **Dashboard**
   - Ver métricas en tiempo real
   - Ver actividad reciente

2. **Pacientes**
   - Haz clic en botón "Registrar Nuevo Paciente"
   - Completa el formulario
   - Busca pacientes por cédula/nombre

3. **Triaje**
   - Busca un paciente
   - Completa signos vitales (ejemplo: TA 120/80, FC 85, SpO2 98, Temp 36.5)
   - Añade síntomas (ejemplo: "dolor abdominal leve")
   - Haz clic en "Analizar con IA"
   - **La IA sugiere una prioridad**
   - Valida manualmente (acepta o modifica)
   - Confirma el triaje

4. **Cola de Urgencias**
   - El paciente aparece en la cola priorizada
   - Filtrar por prioridad
   - Ver tiempo de espera

5. **Expedientes**
   - Busca el paciente
   - Ver historial completo
   - Timeline de eventos

6. **Reportes**
   - Dashboard de estadísticas
   - Gráficas de distribución de triajes

7. **Administración**
   - Gestionar usuarios
   - Ver roles y permisos
   - Configuración del sistema

---

## 📊 ESTRUCTURA COMPLETA DEL PROYECTO

```
Poryecto_Final_Base_Datos/
│
├── 📄 health-connect-index.html         ← FRONTEND (Abrir en navegador)
│
├── 📄 health_connect_database.sql       ← BASE DE DATOS (Ejecutar en MySQL)
│
├── 📁 backend/                          ← API REST
│   ├── server.js                        (Punto de entrada)
│   ├── package.json                     (Dependencias)
│   ├── .env                             (Variables de entorno)
│   ├── config/
│   │   ├── database.js
│   │   └── auth.js
│   ├── routes/                          (Endpoints)
│   ├── controllers/                     (Lógica de negocio)
│   ├── utils/
│   │   └── triageAI.js                 (Sistema de IA)
│   └── middleware/
│
├── 📄 DATABASE_DIAGRAM.md               ← Diagrama ER de BD
├── 📄 README.md                         ← Documentación general
├── 📄 .env.example                      ← Plantilla de variables
│
└── 📁 logs/                             (Logs de la aplicación)
```

---

## 🔧 SOLUCIÓN DE PROBLEMAS

### ❌ Error: "Cannot find module mysql2"

**Solución:**
```bash
cd backend/
npm install mysql2
```

### ❌ Error: "ECONNREFUSED: Connection refused"

**Causas posibles:**
1. MySQL no está ejecutándose
2. Las credenciales en `.env` son incorrectas

**Solución:**
```bash
# Verificar que MySQL está corriendo
# En Windows: Buscar "Servicios" → MySQL80 debe estar "En ejecución"
# O iniciar desde línea de comandos: mysql -u root -p
```

### ❌ Error: "Database does not exist"

**Solución:**
1. Ejecuta nuevamente el archivo SQL completo
2. Verifica en MySQL Workbench que `health_connect` aparece

### ❌ El frontend no se carga

**Solución:**
1. Verifica la ruta del archivo HTML es correcta
2. Intenta abrir directamente con: `Ctrl + O` en el navegador
3. Selecciona el archivo `health-connect-index.html`

### ❌ API no responde

**Solución:**
1. Verifica que Node.js está ejecutándose: `npm run dev`
2. Verifica el puerto 3000 no esté en uso: `netstat -ano | findstr :3000`
3. Si está en uso, cambia PORT en `.env`

---

## 📱 ACCESO A LA APLICACIÓN

### Producción (cuando esté implementada)

- **Sitio web:** https://health-connect.hospital.com
- **API:** https://api.health-connect.hospital.com
- **Documentación:** https://docs.health-connect.hospital.com

### Desarrollo (local)

- **Sitio web:** file:///C:/Users/User/OneDrive/Escritorio/UIP 2K26/Poryecto_Final_Base_Datos/health-connect-index.html
- **API:** http://localhost:3000
- **Base de Datos:** localhost:3306 (MySQL Workbench)

---

## 📊 ESTADÍSTICAS DEL PROTOTIPO

| Aspecto | Cantidad |
|--------|---------|
| Pantallas principales | 7 |
| Componentes UI | 30+ |
| Tablas de BD | 14 |
| Endpoints API | 25+ |
| Usuarios de prueba | 6 |
| Pacientes de prueba | 5 |
| Líneas de código HTML | 2,000+ |
| Líneas de código CSS | 1,500+ |
| Líneas de código JavaScript | 1,000+ |
| Líneas de código SQL | 800+ |

---

## ✅ CHECKLIST DE VERIFICACIÓN

Marca cada paso completado:

- [ ] MySQL instalado y ejecutándose
- [ ] Base de datos `health_connect` creada
- [ ] Node.js instalado
- [ ] Carpeta `backend/` con archivos copiados
- [ ] `npm install` ejecutado exitosamente
- [ ] Archivo `.env` configurado
- [ ] API iniciada (`npm run dev`)
- [ ] API responde en http://localhost:3000/health
- [ ] Archivo HTML abierto en navegador
- [ ] Dashboard funciona correctamente
- [ ] Puedo navegar entre páginas
- [ ] Puedo agregar pacientes
- [ ] Puedo ejecutar análisis de IA
- [ ] Sistema de triaje funciona

---

## 📞 SOPORTE

Si tienes problemas:

1. **Revisa los logs:**
   ```bash
   # En la terminal donde corre API
   npm run dev
   ```

2. **Consulta la documentación:**
   - `README.md` - Overview general
   - `DATABASE_DIAGRAM.md` - Estructura de datos
   - `.env.example` - Variables disponibles

3. **Verifica la configuración:**
   - MySQL está corriendo
   - Base de datos fue creada
   - Variables `.env` son correctas
   - Puerto 3000 está disponible

---

## 🎉 ¡LISTO!

**Tu sistema Health-Connect está listo para usar.**

Ahora puedes:
✓ Gestionar pacientes
✓ Usar triaje asistido por IA
✓ Visualizar cola de urgencias
✓ Mantener expedientes clínicos
✓ Generar reportes
✓ Administrar usuarios

---

**Health-Connect © 2026 - Prototipo de Triaje Hospitalario Asistido por IA**
