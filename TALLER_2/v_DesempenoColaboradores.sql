CREATE OR REPLACE VIEW v_ActividadesPorPerfil AS
SELECT
    p.id AS perfil_id,
    p.nombre_perfil,
    p.descripcion,

    COUNT(u.id) AS cantidad_usuarios_con_este_perfil,

    IFNULL(SUM(a.puntos_otorgados IS NOT NULL), 0) AS total_actividades_participadas_por_perfil,


    IFNULL(AVG(a.puntos_otorgados), 0) AS promedio_puntos_por_usuario_en_este_perfil,

    (
        (SELECT COUNT(*) FROM actividades_fidelizacion) > 0
    ) * (
        (COUNT(a.id) / (SELECT COUNT(*) FROM actividades_fidelizacion)) * 100
    ) AS porcentaje_participacion_total

FROM perfiles p
LEFT JOIN usuarios u ON u.perfil_id = p.id
LEFT JOIN actividades_fidelizacion a ON a.usuario_id = u.id
GROUP BY p.id;
