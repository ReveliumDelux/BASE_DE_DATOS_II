# NORMALIZACIÓN HASTA 3FN (TERCERA FORMA NORMAL)

---

## 📚 CONCEPTOS CLAVE

### **Primera Forma Normal (1FN)**
- ✅ Todos los atributos contienen valores atómicos (no repetidos)
- ✅ Sin grupos repetitivos o arrays
- ✅ Todos los registros del mismo tamaño

### **Segunda Forma Normal (2FN)**
- ✅ Cumple 1FN
- ✅ Todos los atributos dependen totalmente de la clave primaria
- ✅ Sin dependencias parciales

### **Tercera Forma Normal (3FN)**
- ✅ Cumple 2FN
- ✅ Ningún atributo no-clave depende de otro atributo no-clave
- ✅ Sin dependencias transitivas

---

## 🎯 CASO 1: SISTEMA EMPRESARIAL

### **PROBLEMA INICIAL**
Si almacenáramos todo en una tabla grande `USUARIOS_SERVICIOS`:
```
id_usuario | nombre | email | contraseña | rol | id_empresa | empresa_nombre | 
telefono_empresa | id_servicio | nombre_servicio | precio | fecha_contratacion | 
sesiones_activas | ultima_accion | ip_acceso
```

**Problemas identificados**:
1. ❌ Datos de sesión se repiten (para cada usuario-servicio)
2. ❌ La contraseña en tabla grande = RIESGO DE SEGURIDAD
3. ❌ Información de empresa se repite por usuario
4. ❌ Dependencias transitorias (nombre_servicio depende de id_servicio, no de id_usuario)

### **APLICACIÓN DE 1FN**

**Separamos en múltiples tablas**, eliminando grupos repetitivos:

```
USUARIOS: id_usuario, nombre, email, rol, id_empresa
CREDENCIALES: id_credencial, id_usuario, contraseña_hash, salt
SERVICIOS: id_servicio, nombre_servicio, precio, descripcion
EMPRESAS: id_empresa, nombre_empresa, nit, pais
CONTRATACIONES: id_contratacion, id_empresa, id_servicio, fecha_inicio
```

**Resultado**: ✅ Todos los valores son atómicos. Cumple 1FN.

### **APLICACIÓN DE 2FN**

**Problema**: En la tabla anterior, `nombre_servicio` y `precio` dependen de `id_servicio`, no de la clave primaria de la tabla.

**Solución**: 
- CONTRATACIONES solo almacena: `id_contratacion, id_empresa, id_servicio, fecha_inicio`
- SERVICIOS almacena: `id_servicio, nombre_servicio, precio, descripcion`
- EMPRESAS almacena: `id_empresa, nombre_empresa, nit, pais`

**Resultado**: ✅ Cada atributo depende COMPLETAMENTE de la clave primaria. Cumple 2FN.

### **APLICACIÓN DE 3FN**

**Problema**: En EMPRESAS, si almacenáramos `id_empresa, nombre, pais, continente_pais`, entonces `continente_pais` depende de `pais`, no de `id_empresa`.

**Solución**:
```
EMPRESAS: id_empresa, nombre_empresa, nit, id_pais
PAISES: id_pais, nombre_pais, continente
```

Además, separamos CREDENCIALES porque las contraseñas son datos sensibles que no deben estar en la tabla principal.

**Resultado**: ✅ Ningún atributo no-clave depende de otro atributo no-clave. Cumple 3FN.

### **DISEÑO FINAL EN 3FN**

```
EMPRESAS
├─ id_empresa (PK)
├─ nombre_empresa
├─ nit
├─ id_pais (FK)
└─ otros datos específicos de la empresa

PAISES
├─ id_pais (PK)
├─ nombre_pais
└─ continente

USUARIOS
├─ id_usuario (PK)
├─ id_empresa (FK)
├─ nombre_usuario
├─ email
└─ rol

CREDENCIALES
├─ id_credencial (PK)
├─ id_usuario (FK, UNIQUE)
├─ contraseña_hash
└─ salt

SERVICIOS
├─ id_servicio (PK)
├─ nombre_servicio
├─ precio_mensual
└─ descripcion

CONTRATACIONES (N:M entre EMPRESAS y SERVICIOS)
├─ id_contratacion (PK)
├─ id_empresa (FK)
├─ id_servicio (FK)
├─ fecha_inicio
└─ estado

PAGOS
├─ id_pago (PK)
├─ id_empresa (FK)
├─ id_contratacion (FK)
├─ fecha_pago
├─ monto
└─ estado_pago

SESIONES
├─ id_sesion (PK)
├─ id_usuario (FK)
├─ fecha_inicio
├─ fecha_cierre
├─ direccion_ip
└─ activa

AUDITORIA_ACCIONES
├─ id_auditoria (PK)
├─ id_usuario (FK)
├─ fecha_accion
├─ tipo_accion
├─ tabla_afectada
└─ resultado
```

---

## 🎯 CASO 2: SISTEMA DE PUNTO DE VENTAS

### **ANÁLISIS DE NORMALIZACIÓN**

El SQL que proporcionaste ya está bien normalizado. Analicemos:

### **Verificación 1FN**
```sql
-- Tabla OFICINAS
CREATE TABLE oficinas (
    id_oficina INT AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(50),
    telefono VARCHAR(50),
    -- ✅ Todos atómicos: ciudad es UN valor, no múltiples ciudades
);
```
✅ **Cumple 1FN**: No hay grupos repetitivos.

### **Verificación 2FN**
```sql
-- Tabla EMPLEADOS
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,  -- Clave primaria
    nombre VARCHAR(50),                          -- Depende de id_empleado ✅
    id_oficina INT NOT NULL,                     -- Es dato de la oficina, PERO...
    FOREIGN KEY (id_oficina) REFERENCES oficinas(id_oficina)
);
```
⚠️ **Potencial problema 2FN**: En una tabla de empleados, `id_oficina` podría ser una dependencia parcial si la tabla tuviera MÚLTIPLES claves primarias. Pero como `id_empleado` es la ÚNICA clave primaria, está bien.

✅ **Cumple 2FN**: Cada atributo depende de la clave primaria completa.

### **Verificación 3FN**
```sql
-- Tabla CLIENTES
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(50),      -- Depende de id_cliente ✅
    nombre VARCHAR(50),       -- Depende de id_cliente ✅
    pais VARCHAR(50),         -- Depende de id_cliente ✅
    -- Pero... ¿depende del país como atributo independiente?
);
```

**Análisis transitivo**:
- `id_cliente` → cliente específico
- Cliente vive en un `pais`
- El `pais` tiene propiedades (capital, población, región)

Si almacenáramos: `id_cliente, nombre, pais, region_pais`, entonces `region_pais` depende de `pais`, no de `id_cliente`.

**Solución 3FN:**
```sql
CREATE TABLE paises (
    id_pais INT PRIMARY KEY,
    nombre VARCHAR(50),
    region VARCHAR(50),
    continente VARCHAR(50)
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(50),
    apellido VARCHAR(50),
    nombre VARCHAR(50),
    id_pais INT,  -- En lugar de VARCHAR pais
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);
```

**¿Por qué?**: Así, `pais` es una clave foránea que apunta a su tabla, y no hay dependencias transitivas.

### **MEJORA RECOMENDADA: CREAR TABLA CATEGORÍAS**

El campo `categoria ENUM(...)` funciona, pero para máxima normalización 3FN:

```sql
CREATE TABLE categorias_productos (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombreProducto VARCHAR(70),
    id_categoria INT,  -- En lugar de ENUM categoria
    -- ...
    FOREIGN KEY (id_categoria) REFERENCES categorias_productos(id_categoria)
);
```

**Ventaja**: Si necesitas agregar nuevas categorías, no modificas la estructura de PRODUCTOS.

### **DISEÑO FINAL EN 3FN (PUNTO DE VENTAS)**

```
PAISES
├─ id_pais (PK)
├─ nombre
├─ region
└─ continente

OFICINAS
├─ id_oficina (PK)
├─ ciudad
├─ id_pais (FK)
└─ detalles

EMPLEADOS
├─ id_empleado (PK)
├─ nombre, apellido
├─ id_oficina (FK)
├─ jefe (FK → id_empleado, para supervisores)
└─ tipo_empleado

CLIENTES
├─ id_cliente (PK)
├─ empresa, nombre, apellido
├─ id_pais (FK)
├─ id_empleado_atiende (FK)
└─ tipo_cliente

CATEGORIAS_PRODUCTOS
├─ id_categoria (PK)
└─ nombre_categoria

PRODUCTOS
├─ id_producto (PK)
├─ nombreProducto
├─ id_categoria (FK)
├─ precioVenta
└─ MSRP

ORDENES
├─ id_orden (PK)
├─ id_cliente (FK)
├─ fechas y estados
└─ tipo_orden

DETALLE_ORDENES
├─ id_detalle (PK)
├─ id_orden (FK)
├─ id_producto (FK)
├─ cantidadPedida
└─ valorUnitario

PAGOS
├─ id_pago (PK)
├─ id_cliente (FK)
├─ id_orden (FK)  ← AÑADIDO
├─ monto
└─ metodo_pago
```

---

## 🎓 JUSTIFICACIÓN TÉCNICA

### **Por qué nuestros diseños son óptimos:**

1. **Integridad referencial**: Todas las FKs garantizan que no hay datos huérfanos
2. **Mínima redundancia**: No se repite información
3. **Escalabilidad**: Agregar nuevos datos es fácil (ej: nuevo país, nueva categoría)
4. **Seguridad** (Caso 1): CREDENCIALES separadas protegen contraseñas
5. **Flexibilidad**: Pueden modificarse detalles sin afectar la estructura principal
6. **Rendimiento**: Las búsquedas por FK son rápidas con índices
7. **Mantenibilidad**: JOINs claros entre tablas relacionadas

### **Errores que evitamos:**

- ❌ No almacenamos datos derivados (total_orden = SUM de detalles)
- ❌ No repetimos información (nombre_servicio en cada contratación)
- ❌ No mezclamos conceptos (credenciales separadas de usuarios)
- ❌ No tenemos datos huérfanos (claves foráneas obligatorias donde corresponde)

