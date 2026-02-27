# CASO 2: SISTEMA DE PUNTO DE VENTAS
## Análisis y DER Completo

---

## 📊 ANÁLISIS DEL NEGOCIO

El sistema gestiona:
- **Oficinas**: Sucursales de la empresa
- **Empleados**: Personal de cada oficina
- **Clientes**: Personas/empresas que compran
- **Productos**: Catálogo de ítems disponibles
- **Ordenes/Pedidos**: Registros de compras
- **Detalles de Ordenes**: Productos en cada orden
- **Pagos**: Transacciones completadas

---

## 🎯 ENTIDADES Y ATRIBUTOS (OPTIMIZADO)

### 1. **OFICINAS**
```
Responsabilidad: Guardar sucursales de la empresa
- id_oficina (PK, INT AUTO_INCREMENT)
- ciudad (VARCHAR 50)
- telefono (VARCHAR 50)
- direccion (VARCHAR 50)
- departamento (VARCHAR 50)
- pais (VARCHAR 50)
- codigoPostal (VARCHAR 15)
- continente (VARCHAR 10)
- tipo_oficina (ENUM: Regional, Central, Sucursal) ← Campo Tipo Catálogo
- activa (BOOLEAN DEFAULT TRUE) ← Campo Booleano
- codigo_unico (VARCHAR 20, UNIQUE) ← Restricción UNIQUE
```

**Relaciones**:
- 1 Oficina → N Empleados
- 1 Oficina → N Clientes (puede haber sucursales preferentes)

---

### 2. **EMPLEADOS**
```
Responsabilidad: Registrar trabajadores de cada oficina
- id_empleado (PK, INT AUTO_INCREMENT)
- apellido (VARCHAR 50)
- nombre (VARCHAR 50)
- extension (VARCHAR 10) - Extensión telefónica
- email (VARCHAR 100)
- id_oficina (FK → OFICINAS) - Dónde trabaja
- jefe (FK → EMPLEADOS) - Referencia recursiva para supervisores
- cargo (VARCHAR 50)
- tipo_empleado (ENUM: Administrativo, Ventas, Gerente) ← Campo Tipo Catálogo
- activo (BOOLEAN DEFAULT TRUE) ← Campo Booleano
- correo_unico (VARCHAR 100, UNIQUE) ← Restricción UNIQUE
```

**Relaciones**:
- N Empleados → 1 Oficina
- N Empleados → 1 Empleado (jefe)
- 1 Empleado → N Clientes (atiende)

---

### 3. **CLIENTES**
```
Responsabilidad: Guardar datos de personas/empresas compradoras
- id_cliente (PK, INT AUTO_INCREMENT)
- empresa (VARCHAR 50)
- apellido (VARCHAR 50)
- nombre (VARCHAR 50)
- telefono (VARCHAR 50)
- direccion (VARCHAR 50)
- ciudad (VARCHAR 50)
- departamento (VARCHAR 50)
- codigoPostal (VARCHAR 15)
- pais (VARCHAR 50)
- empleadoAtiende (FK → EMPLEADOS)
- limiteCredito (DOUBLE)
- tipo_cliente (ENUM: Regular, Premium, VIP) ← Campo Tipo Catálogo
- activo (BOOLEAN DEFAULT TRUE) ← Campo Booleano
- email_unico (VARCHAR 100, UNIQUE) ← Restricción UNIQUE
```

**Relaciones**:
- N Clientes → 1 Empleado
- 1 Cliente → N Ordenes
- 1 Cliente → N Pagos

---

### 4. **PRODUCTOS**
```
Responsabilidad: Almacenar catálogo de artículos disponibles
- id_producto (PK, INT AUTO_INCREMENT)
- nombreProducto (VARCHAR 70)
- id_lineaProducto (INT) - Categoría
- escala (VARCHAR 10) - Medida/tamaño
- cantidad (INT) - Stock disponible
- precioVenta (DOUBLE)
- MSRP (DOUBLE) - Precio sugerido
- categoria (ENUM: Tecnologia, Oficina, Hogar) ← Campo Tipo Catálogo
- disponible (BOOLEAN DEFAULT TRUE) ← Campo Booleano
- codigo_producto (VARCHAR 50, UNIQUE) ← Restricción UNIQUE
```

**Relaciones**:
- 1 Producto → N DetalleOrdenes

---

### 5. **ORDENES**
```
Responsabilidad: Registrar pedidos/compras de clientes
- id_orden (PK, INT AUTO_INCREMENT)
- fechaRecibido (DATE)
- fechaLimiteEntrega (DATE)
- fechaEntrega (DATE, NULL si aún no se entrega)
- estado (VARCHAR 15) - Pendiente, En proceso, Entregada, Cancelada
- observacion (TEXT)
- id_cliente (FK → CLIENTES)
- tipo_orden (ENUM: Online, Presencial) ← Campo Tipo Catálogo
- completada (BOOLEAN DEFAULT FALSE) ← Campo Booleano
- codigo_orden (VARCHAR 50, UNIQUE) ← Restricción UNIQUE
```

**Regla**: Una orden debe tener al menos un detalle de orden (control en aplicación).

---

### 6. **DETALLE_ORDENES** (Entidad Asociativa)
```
Responsabilidad: Desglose de productos en cada orden
- id_detalle (PK, INT AUTO_INCREMENT)
- id_orden (FK → ORDENES)
- id_producto (FK → PRODUCTOS)
- cantidadPedida (INT)
- valorUnitario (DOUBLE)
- ordenEntrega (INT) - Posición en la secuencia
- tipo_detalle (ENUM: Normal, Promocion) ← Campo Tipo Catálogo
- entregado (BOOLEAN DEFAULT FALSE) ← Campo Booleano
- codigo_detalle (VARCHAR 50, UNIQUE) ← Restricción UNIQUE
```

**Cálculos derivados** (no almacenan):
- Subtotal = cantidadPedida × valorUnitario
- Total orden = SUM(subtotal de todos detalles)

---

### 7. **PAGOS**
```
Responsabilidad: Registrar transacciones de clientes
- id_pago (PK, INT AUTO_INCREMENT)
- id_cliente (FK → CLIENTES)
- numeroFactura (VARCHAR 50)
- fechaPago (DATE)
- totalPago (DOUBLE)
- metodo_pago (ENUM: Tarjeta, Transferencia, Efectivo) ← Campo Tipo Catálogo
- confirmado (BOOLEAN DEFAULT TRUE) ← Campo Booleano
- codigo_pago (VARCHAR 50, UNIQUE) ← Restricción UNIQUE
```

**Nota**: Idealmente, PAGOS debería referenciar ORDENES también.

---

## 📈 CARDINALIDADES

```
OFICINAS
    │
    └─ (1) ─── (N) EMPLEADOS
                    │
                    ├─ (1) Jefe ─┐
                    │             ├─ (N) EMPLEADOS
                    │             └─ (1) Empleado
                    │
                    └─ (1) Atiende ─── (N) CLIENTES
                                            │
                                            ├─ (1) ─── (N) ORDENES
                                            │              │
                                            │              └─ (N) DETALLE_ORDENES ─ (N) PRODUCTOS
                                            │                      │
                                            │                      └─ (1) ─── (N) PRODUCTOS
                                            │
                                            └─ (1) ─── (N) PAGOS
```

---

## 🔒 REGLAS DE NEGOCIO

1. **Clientes**:
   - Cada cliente tiene un empleado que lo atiende
   - Los clientes VIP tienen límites de crédito especiales
   - No pueden estar activos sin empleado asignado

2. **Ordenes**:
   - Una orden requiere 1+ detalle de orden
   - La fecha de entrega no puede ser anterior a fecha límite
   - El estado actualiza automáticamente al entregar

3. **Productos**:
   - El stock debe actualizarse al completar una orden
   - Los productos pueden tener promociones (tipo_detalle)
   - El MSRP es informativo

4. **Pagos**:
   - Los pagos deben ser posteriores a la fecha de la orden
   - Los pagos en efectivo no requieren confirmación
   - Las transferencias sí requieren confirmación

---

## ✅ MEJORAS AL DISEÑO ORIGINAL

El SQL que proporcionaste está bien estructurado. Las mejoras sugeridas:

- ✅ Campos ENUM para tipos de datos limitados (tipo_oficina, tipo_empleado, etc.)
- ✅ Campos BOOLEAN para estados sí/no
- ✅ Restricciones UNIQUE para códigos identificadores
- ✅ Claves foráneas con integridad referencial
- ❓ **Sugerencia**: Agregar `id_orden` a PAGOS para vincular pagos con ordenes específicas

