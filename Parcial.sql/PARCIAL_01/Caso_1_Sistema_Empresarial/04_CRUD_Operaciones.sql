-- ========================================
-- CASO 1: SISTEMA EMPRESARIAL
-- CRUD OPERACIONES - Entidad Principal: USUARIOS
-- ========================================

USE sistema_empresarial_servicios;

-- ========================================
-- 1. CREATE (Insertar nuevo usuario)
-- ========================================
-- Propósito: Agregar un nuevo usuario al sistema
-- Justificación: Es la operación fundamental para onboarding de nuevos empleados
-- Requisitos: email único, empresa válida, tipo_usuario y rol válidos

-- Transacción para insertar usuario con credenciales de forma segura
START TRANSACTION;

INSERT INTO usuarios (
    id_empresa,
    nombre_usuario,
    apellido_usuario,
    email,
    tipo_usuario,
    rol,
    fecha_creacion,
    activo,
    email_unico
) VALUES (
    1,                              -- TechCorp Solutions
    'Fernando',
    'Soto',
    'fernando.soto@techcorp.com',
    'Usuario',
    'Usuario_Final',
    CURDATE(),
    TRUE,
    'fernando.soto@techcorp.com'
);

-- Obtener el ID del usuario recién creado
SET @nuevo_usuario_id = LAST_INSERT_ID();

-- Insertar las credenciales de forma segura (contraseña hasheada)
-- NOTA: En producción, la contraseña se hashea en la aplicación
INSERT INTO credenciales (
    id_usuario,
    contraseña_hash,
    salt,
    ultima_actualizacion,
    activa
) VALUES (
    @nuevo_usuario_id,
    '$2b$12$SejbJhFzIaZ6vZiJuPwZMuFBj4Z9pK3L8hAs6qW3xYmN0pT8vQ1rG',  -- Hash de "Password123!"
    'salt_aleatorio_unico',
    CURDATE(),
    TRUE
);

COMMIT;

-- Verificar que el usuario fue creado correctamente
SELECT u.id_usuario, u.nombre_usuario, u.apellido_usuario, u.email, u.tipo_usuario, u.activo
FROM usuarios u
WHERE u.id_usuario = @nuevo_usuario_id;

-- ========================================
-- 2. READ (Consultar usuarios con filtros)
-- ========================================
-- Propósito: Recuperar información de usuarios con búsquedas específicas
-- Justificación: Esencial para búsquedas de usuarios, reportes y auditoría

-- Consulta 2A: Todos los usuarios activos de una empresa específica
SELECT 
    u.id_usuario,
    u.nombre_usuario,
    u.apellido_usuario,
    u.email,
    u.tipo_usuario,
    u.rol,
    u.activo,
    e.nombre_empresa
FROM usuarios u
INNER JOIN empresas e ON u.id_empresa = e.id_empresa
WHERE u.activo = TRUE 
  AND e.id_empresa = 1
ORDER BY u.apellido_usuario, u.nombre_usuario;

-- Consulta 2B: Usuarios gerentes del sistema
SELECT 
    u.id_usuario,
    u.nombre_usuario,
    u.email,
    u.rol,
    e.nombre_empresa,
    u.fecha_creacion
FROM usuarios u
LEFT JOIN empresas e ON u.id_empresa = e.id_empresa
WHERE u.tipo_usuario = 'Gerente'
ORDER BY u.nombre_usuario;

-- Consulta 2C: Búsqueda De usuario por email (para login)
SELECT 
    u.id_usuario,
    u.nombre_usuario,
    u.email,
    u.activo,
    u.id_empresa,
    c.id_credencial
FROM usuarios u
LEFT JOIN credenciales c ON u.id_usuario = c.id_usuario
WHERE u.email = 'juan.garcia@techcorp.com'
  AND u.activo = TRUE;

-- ========================================
-- 3. UPDATE (Actualizar datos del usuario)
-- ========================================
-- Propósito: Modificar información del usuario
-- Justificación: Cambios de rol, estado, información de contacto
-- Requisito: Registrar en auditoría cualquier cambio importante

-- Actualización 3A: Cambiar rol de usuario
UPDATE usuarios
SET rol = 'Gerente_Empresa'
WHERE id_usuario = 2
  AND activo = TRUE;

-- Registrar la acción en auditoría
INSERT INTO auditoria_acciones (
    id_usuario,
    id_empresa,
    fecha_accion,
    tipo_accion,
    tabla_afectada,
    descripcion,
    ip_origen,
    resultado
) VALUES (
    1,              -- Usuario que realiza la acción
    1,              -- Empresa afectada
    NOW(),
    'UPDATE',
    'usuarios',
    'Cambio de rol: Usuario_Final -> Gerente_Empresa para usuario ID 2',
    '192.168.1.100',
    'Exitosa'
);

-- Actualización 3B: Desactivar usuario (sin eliminación física)
-- Esta es una ELIMINACIÓN LÓGICA - se prefiere a la eliminación física
UPDATE usuarios
SET activo = FALSE
WHERE id_usuario = 11;

-- Registrar la acción
INSERT INTO auditoria_acciones (
    id_usuario,
    id_empresa,
    fecha_accion,
    tipo_accion,
    tabla_afectada,
    descripcion,
    ip_origen,
    resultado
) VALUES (
    1,
    6,
    NOW(),
    'UPDATE',
    'usuarios',
    'Desactivación de usuario ID 11 - Miguel Ramos',
    '192.168.1.100',
    'Exitosa'
);

-- Actualización 3C: Actualizar email de usuario (con validación de unicidad)
UPDATE usuarios
SET email = 'nuevo.email@techcorp.com',
    email_unico = 'nuevo.email@techcorp.com'
WHERE id_usuario = 3
  AND activo = TRUE;

-- Registrar la acción
INSERT INTO auditoria_acciones (
    id_usuario,
    id_empresa,
    fecha_accion,
    tipo_accion,
    tabla_afectada,
    descripcion,
    ip_origen,
    resultado
) VALUES (
    1,
    2,
    NOW(),
    'UPDATE',
    'usuarios',
    'Actualización de email para usuario ID 3',
    '192.168.1.100',
    'Exitosa'
);

-- ========================================
-- 4. DELETE (Eliminación de usuario)
-- ========================================
-- Propósito: Remover usuario del sistema
-- Justificación: Cuando un empleado se va o requiere eliminación completa
-- DECISIÓN: ELIMINACIÓN LÓGICA (preferida) vs ELIMINACIÓN FÍSICA

-- ALTERNATIVA 1: ELIMINACIÓN LÓGICA (RECOMENDADA)
-- Beneficios:
--   ✓ Mantiene integridad referencial
--   ✓ Conserva datos para auditoría
--   ✓ Permite recuperación
--   ✓ Cumple requisitos de compliance

-- Ya lo hicimos arriba con UPDATE activo = FALSE

-- ALTERNATIVA 2: ELIMINACIÓN FÍSICA (RIESGOSA)
-- Desventajas:
--   ✗ Rompe integridad referencial
--   ✗ Pierde datos de auditoría
--   ✗ Difícil de recuperar

-- Para eliminar credenciales del usuario primero (por FK):
-- DELETE FROM credenciales WHERE id_usuario = 11;
-- 
-- Luego eliminar sesiones:
-- DELETE FROM sesiones WHERE id_usuario = 11;
--
-- Luego eliminar auditoría asociada:
-- DELETE FROM auditoria_acciones WHERE id_usuario = 11;
--
-- Finalmente eliminar usuario:
-- DELETE FROM usuarios WHERE id_usuario = 11;

-- CONCLUSIÓN: Se RECOMIENDA usar ELIMINACIÓN LÓGICA
-- El usuario ya está desactivado (activo = FALSE), lo que es suficiente

-- ========================================
-- VERIFICACIÓN DE CAMBIOS CRUD
-- ========================================

-- Ver estados finales de usuarios modificados
SELECT 
    u.id_usuario,
    u.nombre_usuario,
    u.apellido_usuario,
    u.email,
    u.rol,
    u.activo,
    u.fecha_creacion
FROM usuarios u
WHERE u.id_usuario IN (2, 3, 11)
ORDER BY u.id_usuario;

-- Ver auditoría de cambios realizados
SELECT 
    a.id_auditoria,
    a.id_usuario,
    a.fecha_accion,
    a.tipo_accion,
    a.tabla_afectada,
    a.descripcion,
    a.resultado
FROM auditoria_acciones a
WHERE a.tipo_accion IN ('UPDATE', 'CREATE')
  AND a.fecha_accion >= DATE_SUB(NOW(), INTERVAL 1 DAY)
ORDER BY a.fecha_accion DESC;
