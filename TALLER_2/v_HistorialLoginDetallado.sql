CREATE OR REPLACE VIEW v_HistorialLoginDetallado AS
SELECT
    l.id,
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    u.cargo AS cargo_usuario,
    l.fecha_hora_login,
    l.estado_login,

    TIMESTAMPDIFF(
        MINUTE,
        (
            SELECT l2.fecha_hora_login
            FROM login l2
            WHERE l2.usuario_id = u.id 
              AND l2.fecha_hora_login < l.fecha_hora_login
            ORDER BY l2.fecha_hora_login DESC
            LIMIT 1
        ),
        l.fecha_hora_login
    ) AS tiempo_desde_anterior_login

FROM login l
JOIN usuarios u ON u.id = l.usuario_id
ORDER BY u.id, l.fecha_hora_login;
