# CASO 1: SISTEMA EMPRESARIAL DE SERVICIOS DIGITALES
## PARTE I - Diagrama Entidad Relación (DER)

---

## 📊 ANÁLISIS DEL NEGOCIO

El Sistema Empresarial de Servicios Digitales requiere:
- **Gestión de usuarios**: Almacenar empleados, clientes, administradores
- **Autenticación**: Controlar acceso con credenciales seguras
- **Servicios contratados**: Gestionar qué servicios compra cada empresa cliente
- **Pagos**: Registrar transacciones y saldos
- **Auditoría de accesos**: Rastrear quién accede, cuándo y desde dónde

---

## 🎯 ENTIDADES IDENTIFICADAS

### 1. **EMPRESAS**
Clientes que contratan servicios.
- `id_empresa` (PK)
- `nombre_empresa`
- `nit`
- `sector`
- `pais`
- `ciudad`
- `direccion`
- `telefono`
- `email`
- `fecha_registro`
- `estado` (ENUM: Activa, Inactiva, Suspendida)
- `plan_suscripcion` (ENUM: Básico, Profesional, Empresarial)
- `es_cliente_premium` (BOOLEAN)

---

### 2. **USUARIOS**
Personas que acceden al sistema. Pueden ser empleados de la empresa o de nuestra plataforma.
- `id_usuario` (PK)
- `id_empresa` (FK - Para empleados de empresas clientes)
- `nombre_usuario`
- `apellido_usuario`
- `email`
- `tipo_usuario` (ENUM: Administrador, Gerente, Usuario)
- `rol` (ENUM: Admin_Sistema, Gerente_Empresa, Usuario_Final)
- `fecha_creacion`
- `activo` (BOOLEAN)
- `email_unico` (UNIQUE)

---

### 3. **CREDENCIALES (Autenticación)**
Datos sensibles de acceso. Separado de USUARIOS por seguridad.
- `id_credencial` (PK)
- `id_usuario` (FK)
- `contraseña_hash`
- `salt`
- `ultima_actualizacion`
- `activa` (BOOLEAN)

---

### 4. **SERVICIOS**
Productos digitales que ofrece la plataforma.
- `id_servicio` (PK)
- `nombre_servicio`
- `descripcion`
- `precio_mensual`
- `precio_anual`
- `tipo_servicio` (ENUM: Cloud, Analytics, Seguridad, Backup, Consultoría)
- `disponible` (BOOLEAN)
- `codigo_servicio` (UNIQUE)
- `limite_usuarios` (INT - Cuántos usuarios máximo puede tener)

---

### 5. **CONTRATACIONES (Entidad Asociativa N:M)**
Relación entre EMPRESAS y SERVICIOS (una empresa puede contratar múltiples servicios).
- `id_contratacion` (PK)
- `id_empresa` (FK)
- `id_servicio` (FK)
- `fecha_inicio`
- `fecha_fin`
- `estado` (ENUM: Activa, Cancelada, Suspendida)
- `cantidad_licencias` (INT)
- `precio_vigente` (DOUBLE)
- `es_automatica` (BOOLEAN - renovación automática)

---

### 6. **PAGOS**
Registro de transacciones e ingresos.
- `id_pago` (PK)
- `id_empresa` (FK)
- `id_contratacion` (FK)
- `fecha_pago`
- `monto`
- `metodo_pago` (ENUM: Tarjeta, Transferencia, PayPal)
- `estado_pago` (ENUM: Pendiente, Confirmado, Rechazado)
- `numero_transaccion` (UNIQUE)
- `confirmado` (BOOLEAN)
- `fecha_vencimiento`

---

### 7. **SESIONES (Auditoría de Accesos)**
Registro de accesos para auditoría y seguridad.
- `id_sesion` (PK)
- `id_usuario` (FK)
- `id_empresa` (FK)
- `fecha_inicio` (DATETIME)
- `fecha_cierre` (DATETIME - NULL si sesión activa)
- `direccion_ip`
- `dispositivo` (VARCHAR - navegador, SO)
- `tipo_sesion` (ENUM: Web, Mobile, API)
- `activa` (BOOLEAN)

---

### 8. **AUDITORIA_ACCIONES**
Bitácora de todas las acciones importantes en el sistema.
- `id_auditoria` (PK)
- `id_usuario` (FK)
- `id_empresa` (FK)
- `fecha_accion` (DATETIME)
- `tipo_accion` (ENUM: LOGIN, LOGOUT, CREATE, UPDATE, DELETE, PAGO)
- `tabla_afectada` (VARCHAR - Qué tabla fue modificada)
- `descripcion`
- `ip_origen`
- `resultado` (ENUM: Exitosa, Fallida)

---

## 📈 CARDINALIDADES Y RELACIONES

```
EMPRESAS (1) ─── (N) USUARIOS
    │
    ├─ (1) ─── (N) CONTRATACIONES
    │              │
    │              └─ (1) ─── (N) SERVICIOS
    │
    ├─ (1) ─── (N) PAGOS
    │
    ├─ (1) ─── (N) SESIONES
    │
    └─ (1) ─── (N) AUDITORIA_ACCIONES

USUARIOS (1) ─── (1) CREDENCIALES
    │
    ├─ (1) ─── (N) SESIONES
    │
    └─ (1) ─── (N) AUDITORIA_ACCIONES

CONTRATACIONES (N) ─── (1) PAGOS
```

---

## 🔒 REGLAS DE NEGOCIO

1. **Seguridad**:
   - Las contraseñas se almacenan hashadas en CREDENCIALES
   - Los datos sensibles se separan de la información pública

2. **Auditoría**:
   - Toda acción de INSERT, UPDATE, DELETE se registra en AUDITORIA_ACCIONES
   - Las sesiones se rastrea para detectar accesos no autorizados

3. **Pagos**:
   - Un pago está vinculado a una contratación específica
   - Los pagos deben ser confirmados antes de activar el servicio
   - Las contrataciones pueden ser automáticas (renovación anual)

4. **Servicios**:
   - Una empresa puede contratar múltiples servicios
   - Un servicio puede ser contratado por múltiples empresas
   - Se registra límite de usuarios por contratación

5. **Usuarios**:
   - Cada usuario pertenece a una empresa (excepto administradores del sistema)
   - Los usuarios tienen roles que determinan sus permisos
   - Las credenciales se actualizan cuando hay cambios de contraseña

---

## ✅ JUSTIFICACIÓN DEL DISEÑO

- **Separación de CREDENCIALES**: Por seguridad, los datos de acceso están en tabla separada
- **Entidad CONTRATACIONES (N:M)**: Permite que una empresa contrate múltiples servicios
- **SESIONES y AUDITORIA_ACCIONES**: Para cumplir requisitos de auditoría y compliance
- **PAGOS con fecha_vencimiento**: Permite gestionar renovaciones automáticas
- **Tipos ENUM**: Optimizan almacenamiento vs opciones limitadas

