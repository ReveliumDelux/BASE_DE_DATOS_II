-- ========================================
-- CASO 1: SISTEMA EMPRESARIAL
-- VISTAS SQL
-- ========================================

USE sistema_empresarial_servicios;

-- ========================================
-- VISTA 1: VISTA DE NEGOCIO
-- Nombre: v_resumen_servicios_contratados
-- ========================================
-- Propósito: Consolidación de datos relevantes para toma de decisiones
-- Nivel: Ejecutivos, Gerentes de negocio
-- Información: Empresas + Servicios contratados + Pagos realizados
-- Utilidad: Análisis de ingresos, servicios más vendidos, clientes con más gasto

CREATE OR REPLACE VIEW v_resumen_servicios_contratados AS
SELECT 
    e.id_empresa,
    e.nombre_empresa,
    e.nit,
    e.sector,
    e.plan_suscripcion,
    e.es_cliente_premium,
    e.estado AS estado_empresa,
    s.id_servicio,
    s.nombre_servicio,
    s.tipo_servicio,
    c.id_contratacion,
    c.fecha_inicio,
    COALESCE(c.fecha_fin, 'Vigente') AS fecha_fin_contratacion,
    c.estado AS estado_contratacion,
    c.cantidad_licencias,
    c.precio_vigente,
    (c.precio_vigente * c.cantidad_licencias) AS subtotal_contratacion,
    COUNT(p.id_pago) AS cantidad_pagos,
    COALESCE(SUM(p.monto), 0) AS monto_total_pagado,
    CASE 
        WHEN c.estado = 'Activa' THEN 'EN VIGENCIA'
        WHEN c.estado = 'Cancelada' THEN 'CANCELADA'
        WHEN c.estado = 'Suspendida' THEN 'SUSPENDIDA'
    END AS estado_contrato
FROM empresas e
INNER JOIN contrataciones c ON e.id_empresa = c.id_empresa
INNER JOIN servicios s ON c.id_servicio = s.id_servicio
LEFT JOIN pagos p ON c.id_contratacion = p.id_contratacion
GROUP BY 
    e.id_empresa,
    e.nombre_empresa,
    s.id_servicio,
    s.nombre_servicio,
    c.id_contratacion
ORDER BY e.nombre_empresa, s.nombre_servicio;

-- CONSULTA DE EJEMPLO: Ingresos mensuales por servicio
SELECT 
    nombre_servicio,
    tipo_servicio,
    COUNT(DISTINCT id_empresa) AS clientes_activos,
    SUM(monto_total_pagado) AS ingresos_totales,
    AVG(precio_vigente) AS precio_promedio,
    COUNT(DISTINCT id_contratacion) AS total_contratos
FROM v_resumen_servicios_contratados
WHERE estado_empresa = 'Activa'
GROUP BY nombre_servicio, tipo_servicio
ORDER BY ingresos_totales DESC;

-- ========================================
-- VISTA 2: VISTA DE SEGURIDAD
-- Nombre: v_usuarios_seguridad_activos
-- ========================================
-- Propósito: Ocultar datos sensibles (contraseñas, tokens, etc.)
-- Nivel: Analistas de seguridad, Administradores
-- Información: Usuarios con datos de cumplimiento, SIN contraseñas
-- Utilidad: Auditoría de accesos, control de permisos, compliance

CREATE OR REPLACE VIEW v_usuarios_seguridad_activos AS
SELECT 
    u.id_usuario,
    u.nombre_usuario,
    u.apellido_usuario,
    u.email,
    u.tipo_usuario,
    u.rol,
    e.nombre_empresa,
    u.activo,
    u.fecha_creacion,
    YEAR(CURDATE()) - YEAR(u.fecha_creacion) AS anios_en_sistema,
    CASE 
        WHEN u.activo = TRUE THEN 'AUTORIZADO'
        WHEN u.activo = FALSE THEN 'DESAUTORIZADO'
    END AS estado_acceso,
    -- Verificar si el usuario tiene credenciales válidas
    CASE 
        WHEN c.id_credencial IS NOT NULL AND c.activa = TRUE THEN 'CREDENCIALES_ACTIVAS'
        WHEN c.id_credencial IS NOT NULL AND c.activa = FALSE THEN 'CREDENCIALES_INACTIVAS'
        ELSE 'SIN_CREDENCIALES'
    END AS estado_credencial,
    -- Número de sesiones activas
    COALESCE(s.sesiones_activas, 0) AS sesiones_abiertas,
    s.ultima_sesion
FROM usuarios u
INNER JOIN empresas e ON u.id_empresa = e.id_empresa
LEFT JOIN credenciales c ON u.id_usuario = c.id_usuario
LEFT JOIN (
    SELECT 
        id_usuario,
        COUNT(CASE WHEN activa = TRUE THEN 1 END) AS sesiones_activas,
        MAX(fecha_inicio) AS ultima_sesion
    FROM sesiones
    GROUP BY id_usuario
) s ON u.id_usuario = s.id_usuario
WHERE u.activo = TRUE
ORDER BY u.nombre_usuario;

-- Nota: NO incluye contraseña_hash, salt ni información de tokens
-- Los datos sensibles permanecen en la tabla credenciales

-- CONSULTA DE EJEMPLO: Auditoría de usuarios con credenciales inactivas
SELECT 
    id_usuario,
    nombre_usuario,
    nombre_empresa,
    estado_credencial,
    sesiones_abiertas,
    ultima_sesion
FROM v_usuarios_seguridad_activos
WHERE estado_credencial = 'CREDENCIALES_INACTIVAS'
   OR (estado_acceso = 'DESAUTORIZADO' AND sesiones_abiertas > 0);

-- ========================================
-- VISTA 3: VISTA DE AUDITORÍA
-- Nombre: v_auditoria_actividades_usuario
-- ========================================
-- Propósito: Mostrar accesos, fechas, estado de usuarios o transacciones
-- Nivel: Auditoría interna, Cumplimiento, Seguridad
-- Información: Historial completo de acceso y cambios
-- Utilidad: Rastrear acciones, identificar anomalías, compliance regulatorio

CREATE OR REPLACE VIEW v_auditoria_actividades_usuario AS
SELECT 
    a.id_auditoria,
    a.id_usuario,
    a.id_empresa,
    u.nombre_usuario,
    u.apellido_usuario,
    e.nombre_empresa,
    a.fecha_accion,
    DATE(a.fecha_accion) AS fecha,
    TIME(a.fecha_accion) AS hora,
    DAYNAME(a.fecha_accion) AS dia_semana,
    a.tipo_accion,
    a.tabla_afectada,
    a.descripcion,
    a.ip_origen,
    CASE 
        WHEN a.ip_origen LIKE '192.168.%' THEN 'RED_INTERNA'
        WHEN a.ip_origen LIKE '10.%' THEN 'RED_INTERNA'
        WHEN a.ip_origen LIKE '172.%' THEN 'RED_PRIVADA'
        ELSE 'RED_EXTERNA'
    END AS origen_conexion,
    a.resultado,
    CASE 
        WHEN a.resultado = 'Exitosa' THEN '✓ EXITOSA'
        WHEN a.resultado = 'Fallida' THEN '✗ FALLIDA'
    END AS estado_accion,
    DATEDIFF(CURDATE(), DATE(a.fecha_accion)) AS dias_atras
FROM auditoria_acciones a
LEFT JOIN usuarios u ON a.id_usuario = u.id_usuario
LEFT JOIN empresas e ON a.id_empresa = e.id_empresa
ORDER BY a.fecha_accion DESC;

-- CONSULTA DE EJEMPLO 1: Intentos fallidos de login en últimas 24 horas
SELECT 
    id_usuario,
    nombre_usuario,
    fecha_accion,
    ip_origen,
    origen_conexion,
    COUNT(*) AS intentos_fallidos
FROM v_auditoria_actividades_usuario
WHERE tipo_accion = 'LOGIN'
  AND estado_accion = '✗ FALLIDA'
  AND fecha_accion >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
GROUP BY id_usuario, ip_origen
HAVING COUNT(*) >= 3
ORDER BY intentos_fallidos DESC;

-- CONSULTA DE EJEMPLO 2: Actividades de administradores en últimas 7 días
SELECT 
    fecha_accion,
    nombre_usuario,
    tipo_accion,
    tabla_afectada,
    descripcion,
    ip_origen,
    estado_accion
FROM v_auditoria_actividades_usuario
WHERE id_usuario IN (
    SELECT id_usuario FROM usuarios 
    WHERE tipo_usuario = 'Administrador'
)
  AND fecha_accion >= DATE_SUB(NOW(), INTERVAL 7 DAY)
ORDER BY fecha_accion DESC;

-- CONSULTA DE EJEMPLO 3: Cambios en datos de empresas o servicios
SELECT 
    fecha_accion,
    nombre_usuario,
    nombre_empresa,
    tipo_accion,
    tabla_afectada,
    descripcion,
    ip_origen,
    estado_accion
FROM v_auditoria_actividades_usuario
WHERE tipo_accion IN ('CREATE', 'UPDATE', 'DELETE')
  AND tabla_afectada IN ('empresas', 'servicios', 'contrataciones', 'pagos')
ORDER BY fecha_accion DESC;

-- ========================================
-- RESUMEN DE VISTAS IMPLEMENTADAS
-- ========================================
-- VISTA 1: v_resumen_servicios_contratados (NEGOCIO)
--   → Consolidación de empresas, servicios, contratos y pagos
--   → Para análisis de ingresos y reportes ejecutivos
--
-- VISTA 2: v_usuarios_seguridad_activos (SEGURIDAD)
--   → Usuarios sin exponer contraseñas/tokens
--   → Incluye estado de credenciales y sesiones
--   → Para auditoría de accesos y cumplimiento
--
-- VISTA 3: v_auditoria_actividades_usuario (AUDITORÍA)
--   → Log completo de acciones en el sistema
--   → Con clasificación de origen IP y estado
--   → Para rastreo, compliance y análisis de seguridad

-- Listar todas las vistas creadas
SHOW FULL TABLES IN sistema_empresarial_servicios WHERE TABLE_TYPE = 'VIEW';
