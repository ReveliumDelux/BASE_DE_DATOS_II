-- ========================================
-- CASO 2: SISTEMA DE PUNTO DE VENTAS
-- VISTAS SQL
-- ========================================

USE punto_ventas;

-- ========================================
-- VISTA 1: VISTA DE NEGOCIO
-- Nombre: v_resumen_ventas_por_cliente
-- ========================================
-- Propósito: Consolidación de datos de clientes, órdenes y pagos para análisis
-- Nivel: Gerentes de ventas, Analistas comerciales
-- Información: Clientes + Órdenes + Pagos + Productos
-- Utilidad: Inteligencia de negocios, análisis de ventas, identificar VIP

CREATE OR REPLACE VIEW v_resumen_ventas_por_cliente AS
SELECT 
    c.id_cliente,
    c.empresa,
    CONCAT(c.apellido, ', ', c.nombre) AS cliente_nombre,
    c.tipo_cliente,
    c.limiteCredito,
    p.nombre_pais,
    c.ciudad,
    COUNT(DISTINCT o.id_orden) AS total_ordenes,
    SUM(CASE WHEN o.completada = TRUE THEN 1 ELSE 0 END) AS ordenes_completadas,
    SUM(CASE WHEN o.completada = FALSE THEN 1 ELSE 0 END) AS ordenes_pendientes,
    COALESCE(SUM(det.cantidadPedida * det.valorUnitario), 0) AS monto_ordenes,
    COALESCE(SUM(pag.totalPago), 0) AS monto_pagos,
    COALESCE(SUM(det.cantidadPedida * det.valorUnitario), 0) - COALESCE(SUM(pag.totalPago), 0) AS saldo_pendiente,
    MAX(o.fechaRecibido) AS ultima_orden,
    CONCAT(e.nombre, ' ', e.apellido) AS empleado_responsable,
    c.activo,
    CASE 
        WHEN c.activo = TRUE THEN 'ACTIVO'
        ELSE 'INACTIVO'
    END AS estado_cliente,
    CASE 
        WHEN COALESCE(SUM(det.cantidadPedida * det.valorUnitario), 0) > 10000 THEN 'CLIENTE_ALTO_VALOR'
        WHEN COALESCE(SUM(det.cantidadPedida * det.valorUnitario), 0) > 5000 THEN 'CLIENTE_MEDIO_VALOR'
        ELSE 'CLIENTE_BAJO_VALOR'
    END AS segmento_valor
FROM clientes c
LEFT JOIN paises p ON c.id_pais = p.id_pais
LEFT JOIN empleados e ON c.empleadoAtiende = e.id_empleado
LEFT JOIN ordenes o ON c.id_cliente = o.id_cliente
LEFT JOIN detalle_ordenes det ON o.id_orden = det.id_orden
LEFT JOIN pagos pag ON c.id_cliente = pag.id_cliente
GROUP BY c.id_cliente, c.empresa
ORDER BY monto_ordenes DESC;

-- CONSULSA DE EJEMPLO: Top 10 clientes por volumen de ventas
SELECT 
    cliente_nombre,
    empresa,
    tipo_cliente,
    segmento_valor,
    total_ordenes,
    monto_ordenes,
    monto_pagos,
    saldo_pendiente,
    ultima_orden
FROM v_resumen_ventas_por_cliente
WHERE estado_cliente = 'ACTIVO'
ORDER BY monto_ordenes DESC
LIMIT 10;

-- ========================================
-- VISTA 2: VISTA DE SEGURIDAD
-- Nombre: v_transacciones_pagos_verificadas
-- ========================================
-- Propósito: Mostrar información de pagos sin detalles de cuentas bancarias
-- Nivel: Tesorería, Analistas de riesgo
-- Información: Pagos confirmados, métodos, estados sin datos sensibles
-- Utilidad: Auditoría de pagos, control de tesorería, prevención de fraude

CREATE OR REPLACE VIEW v_transacciones_pagos_verificadas AS
SELECT 
    pag.id_pago,
    pag.id_cliente,
    c.empresa,
    CONCAT(c.apellido, ', ', c.nombre) AS cliente_nombre,
    c.tipo_cliente,
    pag.numeroFactura,
    pag.fechaPago,
    pag.totalPago,
    pag.metodo_pago,
    pag.confirmado,
    CASE 
        WHEN pag.confirmado = TRUE THEN '✓ CONFIRMADO'
        WHEN pag.confirmado = FALSE THEN '✗ PENDIENTE'
    END AS estado_pago,
    pag.codigo_pago,
    -- Hash del número de transacción (primeros 4 caracteres + asteriscos)
    CONCAT(
        SUBSTR(pag.codigo_pago, 1, 4),
        '****',
        SUBSTR(pag.codigo_pago, -4)
    ) AS codigo_pago_enmascarado,
    pag.fecha_vencimiento,
    DATEDIFF(pag.fecha_vencimiento, CURDATE()) AS dias_vencimiento,
    CASE 
        WHEN DATEDIFF(pag.fecha_vencimiento, CURDATE()) < 0 THEN '✗ VENCIDO'
        WHEN DATEDIFF(pag.fecha_vencimiento, CURDATE()) <= 7 THEN '⚠ POR_VENCER'
        ELSE '✓ VIGENTE'
    END AS estado_vencimiento,
    -- Referencia de orden asociada
    COALESCE(pag.id_orden, 'N/A') AS id_orden_ref,
    pag.created_at AS fecha_registro
FROM pagos pag
INNER JOIN clientes c ON pag.id_cliente = c.id_cliente
ORDER BY pag.fechaPago DESC;

-- NOTA: No incluye datos bancarios, IPs de transacción ni información sensible
-- Solo números enmascarados y estados verificables

-- CONSULTA DE EJEMPLO: Pagos pendientes de confirmación
SELECT 
    cliente_nombre,
    empresa,
    numeroFactura,
    totalPago,
    metodo_pago,
    estado_pago,
    estado_vencimiento,
    dias_vencimiento
FROM v_transacciones_pagos_verificadas
WHERE confirmado = FALSE
  AND dias_vencimiento >= -7
ORDER BY dias_vencimiento ASC;

-- ========================================
-- VISTA 3: VISTA DE AUDITORÍA
-- Nombre: v_movimientos_inventario_ordenes
-- ========================================
-- Propósito: Rastrear movimientos de inventario y estados de órdenes
-- Nivel: Jefes de almacén, Supervisores de inventario
-- Información: Órdenes, productos, cantidades, entregas
-- Utilidad: Control de inventario, rastreo de órdenes, auditoría de stock

CREATE OR REPLACE VIEW v_movimientos_inventario_ordenes AS
SELECT 
    o.id_orden,
    o.codigo_orden,
    o.fechaRecibido,
    o.fechaLimiteEntrega,
    o.fechaEntrega,
    o.estado AS estado_orden,
    o.tipo_orden,
    o.completada,
    c.empresa,
    CONCAT(c.apellido, ', ', c.nombre) AS cliente,
    c.tipo_cliente,
    e.nombre AS empleado_vendedor,
    det.id_detalle,
    prod.nombreProducto,
    cat.nombre_categoria,
    det.cantidadPedida,
    det.valorUnitario,
    (det.cantidadPedida * det.valorUnitario) AS subtotal_detalle,
    det.tipo_detalle,
    det.entregado,
    CASE 
        WHEN det.entregado = TRUE THEN '✓ ENTREGADO'
        WHEN det.entregado = FALSE AND o.estado = 'Entregada' THEN '✗ NO_ENTREGADO'
        WHEN det.entregado = FALSE THEN '⏳ PENDIENTE'
    END AS estado_producto,
    prod.cantidad AS stock_actual,
    CASE 
        WHEN prod.cantidad < 10 THEN '✗ STOCK_BAJO'
        WHEN prod.cantidad < 20 THEN '⚠ STOCK_MEDIO'
        ELSE '✓ STOCK_NORMAL'
    END AS nivel_stock,
    DATEDIFF(CURDATE(), o.fechaRecibido) AS dias_desde_orden,
    DATEDIFF(o.fechaLimiteEntrega, CURDATE()) AS dias_para_vencimiento
FROM ordenes o
INNER JOIN clientes c ON o.id_cliente = c.id_cliente
INNER JOIN empleados e ON c.empleadoAtiende = e.id_empleado
INNER JOIN detalle_ordenes det ON o.id_orden = det.id_orden
INNER JOIN productos prod ON det.id_producto = prod.id_producto
INNER JOIN categorias_productos cat ON prod.id_categoria = cat.id_categoria
ORDER BY o.fechaRecibido DESC, det.id_detalle;

-- CONSULTA DE EJEMPLO 1: Órdenes atrasadas
SELECT 
    DISTINCT codigo_orden,
    cliente,
    empleado_vendedor,
    fechaRecibido,
    fechaLimiteEntrega,
    DATEDIFF(CURDATE(), fechaLimiteEntrega) AS dias_atraso,
    estado_orden,
    COUNT(*) AS productos_en_orden
FROM v_movimientos_inventario_ordenes
WHERE estado_orden != 'Entregada'
  AND DATEDIFF(CURDATE(), fechaLimiteEntrega) > 0
GROUP BY id_orden
ORDER BY dias_atraso DESC;

-- CONSULTA DE EJEMPLO 2: Productos con stock bajo
SELECT 
    DISTINCT nombreProducto,
    nombre_categoria,
    stock_actual,
    nivel_stock,
    COUNT(*) AS ordenes_pendientes
FROM v_movimientos_inventario_ordenes
WHERE nivel_stock IN ('✗ STOCK_BAJO', '⚠ STOCK_MEDIO')
  AND estado_orden != 'Entregada'
GROUP BY id_producto
ORDER BY stock_actual ASC;

-- CONSULTA DE EJEMPLO 3: Auditoría de entregas pendientes
SELECT 
    codigo_orden,
    cliente,
    nombreProducto,
    cantidadPedida,
    estado_producto,
    fechaRecibido,
    estado_orden,
    empleado_vendedor
FROM v_movimientos_inventario_ordenes
WHERE entregado = FALSE
  AND estado_orden = 'Entregada'
ORDER BY fechaRecibido ASC;

-- ========================================
-- RESUMEN DE VISTAS IMPLEMENTADAS
-- ========================================
-- VISTA 1: v_resumen_ventas_por_cliente (NEGOCIO)
--   → Consolidación de clientes, órdenes, pagos y segmentación
--   → Para análisis de ventas y comportamiento de clientes
--
-- VISTA 2: v_transacciones_pagos_verificadas (SEGURIDAD)
--   → Pagos sin exponer datos bancarios sensibles
--   → Información enmascarada para auditoría segura
--   → Para control de tesorería y prevención de fraude
--
-- VISTA 3: v_movimientos_inventario_ordenes (AUDITORÍA)
--   → Rastreo completo de órdenes y movimientos de stock
--   → Con estados de entregas y niveles de inventario
--   → Para auditoría de almacén y control de operaciones

-- Listar todas las vistas creadas
SHOW FULL TABLES IN punto_ventas WHERE TABLE_TYPE = 'VIEW';
