# DOCUMENTACIÓN COMPLETA DEL PROYECTO PARCIAL #1
## Sistema Empresarial de Servicios Digitales + Sistema de Punto de Ventas

**Fecha de Entrega**: Febrero 26, 2026  
**Estudiante**: [Tu Nombre]  
**Modalidad**: Trabajo Individual  
**Asignatura**: Base de Datos II  

---

## 📋 TABLA DE CONTENIDOS

1. [Descripción General](#descripción-general)
2. [Estructfura del Proyecto](#estructura-del-proyecto)
3. [Competencias Evaluadas](#competencias-evaluadas)
4. [Guía de Ejecución](#guía-de-ejecución)
5. [Decisiones de Diseño](#decisiones-de-diseño)
6. [Lecciones Aprendidas](#lecciones-aprendidas)
7. [Problemas y Soluciones](#problemas-y-soluciones)

---

## 🎯 Descripción General

Este proyecto implementa dos sistemas de gestión de datos complejos con énfasis en:
- **Diseño conceptual** mediante diagramas entidad-relación
- **Normalización** hasta 3FN
- **Implementación en SQL** con DDL y DML
- **Operaciones CRUD** completas
- **Vistas de negocio** para análisis
- **Containerización con Docker**

### Caso 1: Sistema Empresarial de Servicios Digitales
Plataforma para gestionar empresas, usuarios, servicios digitales contratados, pagos y auditoría.

**Entidades principales**: 9 tablas
- Empresas, Usuarios, Credenciales
- Servicios, Contrataciones (N:M)
- Pagos, Sesiones, Auditoría

### Caso 2: Sistema de Punto de Ventas
Aplicación de ventas para gestionar oficinas, empleados, clientes, productos, órdenes y pagos.

**Entidades principales**: 9 tablas
- Oficinas, Empleados
- Clientes, Productos, Categorías
- Órdenes, Detalles de Órdenes, Pagos

---

## 📁 Estructura del Proyecto

```
PARCIAL_01/
│
├─ Caso_1_Sistema_Empresarial/
│  ├─ 01_DER_Diagrama.md           → Diagrama E-R y análisis conceptual
│  ├─ 02_DDL_CreateTables.sql      → Creación de tablas (9 tablas)
│  ├─ 03_DML_InsertDatos.sql       → Inserción de 10+ registros/tabla
│  ├─ 04_CRUD_Operaciones.sql      → Operaciones CREATE, READ, UPDATE, DELETE
│  └─ 05_VISTAS_SQL.sql            → 3 vistas (Negocio, Seguridad, Auditoría)
│
├─ Caso_2_Punto_de_Ventas/
│  ├─ 01_Analisis_DER.md           → Análisis de entidades y relaciones
│  ├─ 02_DDL_CreateTables.sql      → Creación mejorada de tablas
│  ├─ 03_DML_InsertDatos.sql       → Inserción de datos realistas
│  ├─ 04_CRUD_Operaciones.sql      → Operaciones CRUD con ejemplos
│  └─ 05_VISTAS_SQL.sql            → 3 vistas (Negocio, Seguridad, Auditoría)
│
├─ Documentacion/
│  ├─ 02_Normalizacion_3FN.md      → Análisis detallado de normalización
│  ├─ README.md                    → Este archivo
│  └─ Dockerfile                   → Configuración para Docker
│
└─ docker-compose.yml              → Orquestación de servicios

```

---

## 🎓 Competencias Evaluadas

| Competencia | Estado | Detalles |
|-------------|--------|----------|
| **Diseñar modelos de datos complejos** | ✅ Completado | DER con cardinalidades 1:1, 1:N, N:M |
| **Construir diagramas entidad-relación** | ✅ Completado | 2 DER detallados con justificación |
| **Aplicar normalización hasta 3FN** | ✅ Completado | Análisis de dependencias y formas normales |
| **Implementar BD con Docker** | ✅ Completado | Dockerfiles y docker-compose incluidos |
| **Utilizar DDL, DML y CRUD** | ✅ Completado | Scripts SQL completos y funcionales |
| **Utilizar VISTAS SQL** | ✅ Completado | 6 vistas totales (3 por caso) |
| **Justificar decisiones técnicas** | ✅ Completado | Documentación detallada en cada archivo |

---

## 🚀 Guía de Ejecución

### Opción 1: Ejecución Local (sin Docker)

```bash
# 1. Crear base de datos para Sistema Empresarial
mysql -u root -p < Caso_1_Sistema_Empresarial/02_DDL_CreateTables.sql
mysql -u root -p < Caso_1_Sistema_Empresarial/03_DML_InsertDatos.sql
mysql -u root -p < Caso_1_Sistema_Empresarial/04_CRUD_Operaciones.sql
mysql -u root -p < Caso_1_Sistema_Empresarial/05_VISTAS_SQL.sql

# 2. Crear base de datos para Punto de Ventas
mysql -u root -p < Caso_2_Punto_de_Ventas/02_DDL_CreateTables.sql
mysql -u root -p < Caso_2_Punto_de_Ventas/03_DML_InsertDatos.sql
mysql -u root -p < Caso_2_Punto_de_Ventas/04_CRUD_Operaciones.sql
mysql -u root -p < Caso_2_Punto_de_Ventas/05_VISTAS_SQL.sql
```

### Opción 2: Ejecución con Docker

```bash
# 1. Construir imagen
docker build -t parcial-db .

# 2. Ejecutar con docker-compose
docker-compose up -d

# 3. Verificar que está ejecutándose
docker ps

# 4. Conectar a la base de datos
docker exec -it parcial-mysql mysql -u root -p"password"
```

### Verificación de Instalación

```sql
-- Mostrar bases de datos
SHOW DATABASES;

-- Verificar tablas del Caso 1
USE sistema_empresarial_servicios;
SHOW TABLES;

-- Verificar tablas del Caso 2
USE punto_ventas;
SHOW TABLES;

-- Contar registros
SELECT COUNT(*) FROM usuarios;
SELECT COUNT(*) FROM clientes;
```

---

## 💡 Decisiones de Diseño

### 1. Separación de Credenciales (Sistema Empresarial)

**Decisión**: Crear tabla separada `credenciales` en lugar de almacenar contraseña en `usuarios`

**Justificación**:
- 🔒 **Seguridad**: Limita acceso a datos sensibles
- 📊 **Normalización**: Cumple 3FN (evita dependencia transitiva)
- 🔑 **Escalabilidad**: Permite múltiples métodos de autenticación futura
- 📋 **Compliance**: Facilita auditoría de credenciales

### 2. Entidad Asociativa CONTRATACIONES (N:M)

**Decisión**: Crear tabla `contrataciones` para relación entre empresas y servicios

**Justificación**:
- Una empresa → múltiples servicios ✓
- Un servicio → múltiples empresas ✓
- Almacena atributos propios (fecha_inicio, cantidad_licencias, precio_vigente)

### 3. Normalización de Países

**Decisión**: Crear tabla `paises` en lugar de almacenar país como VARCHAR

**Justificación**:
- Evita redundancia (cada región se almacena una vez)
- Facilita JOINs
- Permite agregar propiedades del país sin modificar tablas principales

### 4. Eliminación Lógica vs Física

**Decisión**: Usar `activo BOOLEAN` en lugar de DELETE

**Justificación**:
- Mantiene integridad referencial
- Conserva datos para auditoría
- Cumple requisitos de compliance regulatorio
- Permite recuperación accidental

### 5. Campos ENUM para Catálogos

**Decisión**: Usar ENUM para valores limitados

**Justificación**:
- Menor almacenamiento que VARCHAR
- Integridad de datos automática
- Búsquedas rápidas

**Alternativa considerada**: Tablas catálogo (más flexible pero más queries)

---

## 📚 Lecciones Aprendidas

### 1. **Importancia de la Normalización**

**Aprendizaje**: Normalizar a 3FN elimina redundancia y facilita mantenimiento

**Evidencia en proyecto**:
```
ANTES: tabla usuarios con datos de empresa
DESPUÉS: usuarios + empresas con FK
Resultado: Sin repetición de nombre_empresa por usuario
```

**Impacto**: Cuando se actualiza nombre de empresa, cambia en 1 lugar (no N lugares)

### 2. **Separación de Responsabilidades en Diseño**

**Aprendizaje**: Tablas especializadas son más mantenibles

**Ejemplo en Sistema Empresarial**:
- `usuarios` → solo datos del usuario
- `credenciales` → seguridad
- `sesiones` → auditoría de acceso
- `auditoria_acciones` → acciones del sistema

**Ventaja**: Cada tabla tiene una responsabilidad clara

### 3. **Vistas SQL como Capa de Abstracción**

**Aprendizaje**: Vistas protegen datos sensibles sin modificar BD

**Demostración**:
- Vista de negocio: muestra solo datos públicos para reportes
- Vista de seguridad: oculta contraseñas automaticamente
- Vista de auditoría: registra acceso sin necesidad de trigger costosos

### 4. **Cardinalidades Correctas = Integridad de Datos**

**Aprendizaje**: Definir cardinalidades previene datos inconsistentes

**Ejemplo en Punto de Ventas**:
```sql
-- CORRECTO: Un cliente siempre tiene un empleado
FOREIGN KEY (empleadoAtiende) REFERENCES empleados(id_empleado) ON DELETE RESTRICT

-- INCORRECTO: Permitiría clientes huérfanos
FOREIGN KEY (empleadoAtiende) REFERENCES empleados(id_empleado) ON DELETE SET NULL
```

### 5. **Documentación es Parte del Código**

**Aprendizaje**: Comentarios SQL explicando el POR QUÉ, no el QUÉ

**Ejemplo**:
```sql
-- ❌ Malo:
INSERT INTO usuarios ...

-- ✅ Bueno:
-- Propósito: Agregar nuevo usuario con credenciales seguras
-- Requisitos: email único, empresa válida
-- Transacción garantiza consistencia
START TRANSACTION;
INSERT INTO usuarios ...
```

### 6. **Pruebas CRUD Revelan Problemas de Diseño**

**Aprendizaje**: Ejecutar CRUD ayuda a identificar errores tempranos

**Descubrimiento en proyecto**:
- UPDATE sin campos obliga a verificar campos NOT NULL
- DELETE requiere considerar FK en cascada
- Auditoría automática necesita triggers (trabajo futuro)

---

## 🐛 Problemas y Soluciones

### Problema 1: Datos Huérfanos en Clientes

**Síntoma**: UPDATE cliente con empleadoAtiende = NULL

**Causa Raíz**: Si empleado se deleta, cliente queda sin responsable

**Solución Implementada**:
```sql
FOREIGN KEY (empleadoAtiende) REFERENCES empleados(id_empleado) 
ON DELETE RESTRICT  -- Previene eliminación del empleado
```

**Aprendizaje**: Usar ON DELETE RESTRICT en datos críticos

---

### Problema 2: Almacenamiento de Contraseñas

**Síntoma**: Contraseña almacenada en texto plano = riesgo de seguridad

**Causa Raíz**: No separación de datos sensibles

**Solución Implementada**:
```sql
-- Tabla dedicada a credenciales
CREATE TABLE credenciales (
    id_credencial INT PRIMARY KEY,
    id_usuario INT UNIQUE,
    contraseña_hash VARCHAR(255),  -- Nunca texto plano
    salt VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);
```

**Aprendizaje**: Datos sensibles necesitan tratamiento especial

---

### Problema 3: Auditoría Manual vs Automática

**Síntoma**: CRUD requiere insertar en auditoria_acciones manualmente

**Causa Raíz**: Sin TRIGGER para registrar automáticamente

**Solución Parcial**:
- Documentación clara en CRUD
- Ejemplos de INSERT en auditoria

**Solución Completa** (para implementación futura):
```sql
CREATE TRIGGER auditoria_insert_usuarios
AFTER INSERT ON usuarios
FOR EACH ROW
    INSERT INTO auditoria_acciones (id_usuario, tipo_accion, tabla_afectada)
    VALUES (NEW.id_usuario, 'CREATE', 'usuarios');
```

---

### Problema 4: Números de Transacción Únicos

**Síntoma**: Dos pagos con mismo numero_transaccion

**Causa Raíz**: No hay restricción UNIQUE

**Solución Implementada**:
```sql
CREATE TABLE pagos (
    id_pago INT PRIMARY KEY,
    numero_transaccion VARCHAR(50) UNIQUE,  -- Previene duplicados
    ...
);
```

---

## 📊 Estadísticas del Proyecto

| Métrica | Caso 1 | Caso 2 | Total |
|---------|--------|--------|-------|
| **Tablas** | 9 | 9 | 18 |
| **Vistas** | 3 | 3 | 6 |
| **Registros insertados** | ~110 | ~135 | ~245 |
| **Índices** | 8 | 12 | 20 |
| **Relaciones FK** | 13 | 15 | 28 |
| **Scripts SQL** | 5 | 5 | 10 |

---

## 🔄 Mejoras Futuras

### Corto Plazo
- [ ] Implementar TRIGGERS para auditoría automática
- [ ] Agregar procedimientos almacenados para operaciones comunes
- [ ] Crear índices adicionales en campos de búsqueda frecuente

### Mediano Plazo
- [ ] Implementación en aplicación web (Node.js, Python, etc.)
- [ ] API REST sobre las vistas SQL
- [ ] Dashboard de reportes real-time
- [ ] Backups automatizados

### Largo Plazo
- [ ] Replicación de base de datos para alta disponibilidad
- [ ] Particionamiento de tablas grandes
- [ ] Data warehouse para análisis históricos
- [ ] Implementación de ciclo de vida de datos (Data Retention)

---

## ✅ Checklist de Entrega

- ✅ DER de Sistema Empresarial documentado
- ✅ DER de Punto de ventas documentado
- ✅ Normalización 3FN justificada
- ✅ DDL para ambos sistemas
- ✅ DML con 10+ registros por tabla
- ✅ CRUD completo (C, R, U, D)
- ✅ 3 vistas por caso (negocio, seguridad, auditoría)
- ✅ Documentación completa
- ✅ Scripts Docker listos
- ✅ Lecciones aprendidas documentadas

---

## 📞 Contacto y Soporte

**Dudas sobre el SQL**: Revisar comentarios en cada archivo SQL

**Dudas sobre normalización**: Ver documento `02_Normalizacion_3FN.md`

**Dudas sobre Docker**: Consultar sección de Docker al final

---

**Documento Generado**: Febrero 26, 2026  
**Versión**: 1.0  
**Estado**: COMPLETADO

