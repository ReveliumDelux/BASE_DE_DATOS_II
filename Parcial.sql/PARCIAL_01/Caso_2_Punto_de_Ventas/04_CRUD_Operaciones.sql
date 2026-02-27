-- ========================================
-- CASO 2: SISTEMA DE PUNTO DE VENTAS
-- CRUD OPERACIONES - Entidad Principal: CLIENTES
-- ========================================

USE punto_ventas;

-- ========================================
-- 1. CREATE (Insertar nuevo cliente)
-- ========================================
-- Propósito: Registrar un nuevo cliente en el sistema
-- Justificación: Base para todas las operaciones comerciales (pedidos, pagos)
-- Requisitos: Email único, empleado válido, datos coherentes

INSERT INTO clientes (
    empresa,
    apellido,
    nombre,
    telefono,
    direccion,
    ciudad,
    departamento,
    codigoPostal,
    id_pais,
    empleadoAtiende,
    limiteCredito,
    tipo_cliente,
    activo,
    email_unico
) VALUES (
    'NewTech Solutions',
    'Álvarez',
    'Francisco',
    '(1) 3000005',
    'Cra 50 No 15-30',
    'Bogotá',
    'Cundinamarca',
    '110111',
    1,
    1,              -- García, Juan (Gerente)
    45000,
    'Premium',
    TRUE,
    'francisco.alvarez@newtech.com'
);

-- Obtener el ID del cliente recién creado
SET @nuevo_cliente_id = LAST_INSERT_ID();

-- Verificar creación
SELECT * FROM clientes WHERE id_cliente = @nuevo_cliente_id;

-- ========================================
-- 2. READ (Consultar clientes con filtros)
-- ========================================
-- Propósito: Recuperar información de clientes con búsquedas específicas
-- Justificación: Esencial para búsquedas rápidas, reportes comerciales

-- Consulta 2A: Todos los clientes VIP activos
SELECT 
    c.id_cliente,
    c.empresa,
    CONCAT(c.apellido, ', ', c.nombre) AS cliente_nombre,
    c.email_unico,
    c.telefono,
    c.ciudad,
    c.tipo_cliente,
    c.limiteCredito,
    CONCAT(e.nombre, ' ', e.apellido) AS empleado_atiende
FROM clientes c
INNER JOIN empleados e ON c.empleadoAtiende = e.id_empleado
WHERE c.tipo_cliente = 'VIP'
  AND c.activo = TRUE
ORDER BY c.empresa;

-- Consulta 2B: Clientes por ciudad
SELECT 
    c.id_cliente,
    c.empresa,
    CONCAT(c.apellido, ', ', c.nombre) AS cliente_nombre,
    c.ciudad,
    c.tipo_cliente,
    COUNT(o.id_orden) AS total_ordenes,
    COALESCE(SUM(det.cantidadPedida * det.valorUnitario), 0) AS monto_total_ordenes
FROM clientes c
LEFT JOIN ordenes o ON c.id_cliente = o.id_cliente
LEFT JOIN detalle_ordenes det ON o.id_orden = det.id_orden
WHERE c.ciudad = 'Bogotá'
  AND c.activo = TRUE
GROUP BY c.id_cliente
ORDER BY monto_total_ordenes DESC;

-- Consulta 2C: Búsqueda de cliente por email
SELECT 
    c.id_cliente,
    c.empresa,
    c.nombre,
    c.email_unico,
    c.limiteCredito,
    c.tipo_cliente,
    c.activo
FROM clientes c
WHERE c.email_unico = 'juan.empresa@techcorp.com';

-- Consulta 2D: Clientes sin órdenes (potenciales inactivos)
SELECT 
    c.id_cliente,
    c.empresa,
    CONCAT(c.apellido, ', ', c.nombre) AS cliente_nombre,
    c.fecha_creacion,
    c.activo
FROM clientes c
LEFT JOIN ordenes o ON c.id_cliente = o.id_cliente
WHERE o.id_orden IS NULL
  AND c.activo = TRUE
ORDER BY c.fecha_creacion DESC;

-- ========================================
-- 3. UPDATE (Actualizar datos del cliente)
-- ========================================
-- Propósito: Modificar información del cliente
-- Justificación: Cambios de datos de contacto, límite crédito, tipo cliente
-- Requisito: Mantener integridad de referencia

-- Actualización 3A: Cambiar tipo de cliente a VIP (por volumen de compra)
UPDATE clientes
SET tipo_cliente = 'VIP'
WHERE id_cliente = 1;

-- Verificar cambio
SELECT id_cliente, empresa, tipo_cliente FROM clientes WHERE id_cliente = 1;

-- Actualización 3B: Aumentar límite de crédito
UPDATE clientes
SET limiteCredito = 95000
WHERE id_cliente = 10
  AND activo = TRUE;

-- Actualización 3C: Cambiar empleado que atiende al cliente
UPDATE clientes
SET empleadoAtiende = 2
WHERE id_cliente = 3;

-- Verificar cambio
SELECT id_cliente, empresa, empleadoAtiende FROM clientes WHERE id_cliente = 3;

-- Actualización 3D: Actualizar teléfono e información de contacto
UPDATE clientes
SET telefono = '(1) 3009999',
    email_unico = 'nuevo.contacto@techcorp.com'
WHERE id_cliente = 2
  AND activo = TRUE;

-- ========================================
-- 4. DELETE (Eliminación de cliente)
-- ========================================
-- Propósito: Remover cliente del sistema
-- DECISIÓN: ELIMINACIÓN LÓGICA vs ELIMINACIÓN FÍSICA

-- ========== OPCIÓN 1: ELIMINACIÓN LÓGICA (RECOMENDADA) ==========
-- Beneficios:
--   ✓ Mantiene integridad referencial (las órdenes siguen siendo válidas)
--   ✓ Conserva historial completo de transacciones
--   ✓ Permite recuperación si es necesario
--   ✓ Cumple requisitos de auditoría y compliance
--   ✓ No se pierden datos para análisis histórico

UPDATE clientes
SET activo = FALSE
WHERE id_cliente = 11;

-- Verificar que cliente quedó desactivado pero con datos intactos
SELECT 
    id_cliente,
    empresa,
    email_unico,
    activo,
    DATE(created_at) AS fecha_desactivacion
FROM clientes
WHERE id_cliente = 11;

-- ========== OPCIÓN 2: ELIMINACIÓN FÍSICA (NO RECOMENDADA) ==========
-- Desventajas:
--   ✗ Viola integridad referencial (las órdenes quedarían huérfanas)
--   ✗ Pierde información histórica importante
--   ✗ Complica auditoría y cumplimiento regulatorio
--   ✗ Difícil de revertir accidentalmente

-- Para eliminar físicamente (NO HACER EN PRODUCCIÓN):
-- 1. Primero eliminar detalles de orden del cliente
--    DELETE FROM detalle_ordenes 
--    WHERE id_orden IN (SELECT id_orden FROM ordenes WHERE id_cliente = 11);
--
-- 2. Luego eliminar órdenes del cliente
--    DELETE FROM ordenes WHERE id_cliente = 11;
--
-- 3. Luego eliminar pagos del cliente
--    DELETE FROM pagos WHERE id_cliente = 11;
--
-- 4. Finalmente eliminar cliente
--    DELETE FROM clientes WHERE id_cliente = 11;

-- CONCLUSIÓN: Se PREFIERE eliminación lógica
-- El cliente es desactivado (activo = FALSE) en lugar de eliminado

-- ========================================
-- VERIFICACIÓN DE CAMBIOS CRUD
-- ========================================

-- Ver clientes modificados
SELECT 
    c.id_cliente,
    c.empresa,
    c.tipo_cliente,
    c.limiteCredito,
    c.activo,
    c.fecha_creacion
FROM clientes c
WHERE c.id_cliente IN (1, 2, 3, 10, 11)
ORDER BY c.id_cliente;

-- Ver historial de órdenes del cliente actualizado
SELECT 
    c.id_cliente,
    c.empresa,
    COUNT(o.id_orden) AS total_ordenes,
    SUM(det.cantidadPedida * det.valorUnitario) AS monto_total,
    MAX(o.fechaRecibido) AS ultima_orden
FROM clientes c
LEFT JOIN ordenes o ON c.id_cliente = o.id_cliente
LEFT JOIN detalle_ordenes det ON o.id_orden = det.id_orden
WHERE c.id_cliente IN (1, 2, 3, 10)
GROUP BY c.id_cliente;

-- Información de clientes activos vs desactivados
SELECT 
    activo,
    COUNT(*) AS total_clientes,
    AVG(limiteCredito) AS promedio_credito
FROM clientes
GROUP BY activo;
