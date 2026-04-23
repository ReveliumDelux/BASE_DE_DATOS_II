# DIAGRAMA ENTIDAD-RELACIÓN: Health-Connect

## Estructura Visual de la BD

```
┌─────────────────────────┐
│      USUARIOS           │
├─────────────────────────┤
│ • id (PK)               │
│ • nombre                │
│ • email (UNIQUE)        │
│ • contraseña_hash       │
│ • role_id (FK → roles)  │
│ • estado                │
│ • telefono              │
│ • ultimo_acceso         │
│ • created_at            │
└─────────────────────────┘
         │
         │ n:1
         │
         ▼
┌─────────────────────────┐
│       ROLES             │
├─────────────────────────┤
│ • id (PK)               │
│ • nombre (UNIQUE)       │
│ • descripcion           │
│ • permisos (JSON)       │
└─────────────────────────┘

═══════════════════════════════════════════════════════════════════════

┌─────────────────────────────┐
│      PACIENTES              │
├─────────────────────────────┤
│ • id (PK)                   │
│ • cedula (UNIQUE)           │
│ • nombre                    │
│ • apellido                  │
│ • fecha_nacimiento          │
│ • sexo                      │
│ • telefono                  │
│ • email                     │
│ • direccion                 │
│ • ciudad                    │
│ • tipo_sangre               │
│ • alergias                  │
│ • medicamentos_actuales     │
│ • antecedentes_medicos      │
│ • contacto_emergencia_*     │
│ • estado                    │
│ • created_at                │
└─────────────────────────────┘
         │
         │ 1:n
         ├──────────────────────┬──────────────────────┬──────────────────────┐
         │                      │                      │                      │
         ▼                      ▼                      ▼                      ▼
    ┌──────────────┐  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐
    │SIGNOS_VITALES│  │CAPTURA_CLINICA   │  │COLA_URGENCIAS    │  │EXPEDIENTES   │
    ├──────────────┤  ├──────────────────┤  ├──────────────────┤  ├──────────────┤
    │ • id (PK)    │  │ • id (PK)        │  │ • id (PK)        │  │ • id (PK)    │
    │ • paciente_id│  │ • paciente_id    │  │ • paciente_id    │  │ • paciente_id│
    │ • sistolica  │  │ • motivo_consulta│  │ • triaje_id (FK) │  │ • num_exp    │
    │ • diastolica │  │ • síntomas       │  │ • prioridad      │  │ • tipo       │
    │ • freq_card  │  │ • duracion       │  │ • posicion       │  │ • f_apertura │
    │ • freq_resp  │  │ • severidad      │  │ • estado         │  │ • f_cierre   │
    │ • spo2       │  │ • medicamentos   │  │ • medico_asignado│  │ • medico_id  │
    │ • temperatura│  │ • antecedentes   │  │ • hora_ingreso   │  │ • estado     │
    │ • peso       │  │ • registrado_por │  │ • inicio_atencion│  │ • created_at │
    │ • altura     │  │ • created_at     │  │ • fin_atencion   │  └──────────────┘
    │ • imc        │  └──────────────────┘  │ • updated_at     │         │
    │ • reg_por_id │         │              └──────────────────┘         │
    │ • created_at │         │                       │                   │ 1:n
    └──────────────┘         │                       │                   │
              │               │                       │                   ▼
              │ n:1           │ n:1                   │ n:1      ┌──────────────────┐
              │               │                       │          │NOTAS_CLINICAS    │
              │               ▼                       ▼          ├──────────────────┤
              │    ┌──────────────────────┐ ┌──────────────────┐ │ • id (PK)        │
              │    │SUGERENCIAS_TRIAJE_IA │ │   TRIAJES        │ │ • expediente_id  │
              │    ├──────────────────────┤ ├──────────────────┤ │ • triaje_id      │
              │    │ • id (PK)            │ │ • id (PK)        │ │ • tipo_nota      │
              │    │ • captura_clinica_id │ │ • paciente_id    │ │ • contenido      │
              │    │ • prioridad          │ │ • sugerencia_id  │ │ • medico_id      │
              │    │ • puntuacion         │ │ • captura_id     │ │ • enfermero_id   │
              │    │ • criterios_eval(JSON)│ │ • prioridad_final│ │ • datos_relevantes
              │    │ • recomendaciones    │ │ • justificacion  │ │ • estado         │
              │    │ • modelo_ia          │ │ • validado_por   │ │ • created_at     │
              │    │ • confianza_%        │ │ • motivo_cambio  │ └──────────────────┘
              │    │ • estado             │ │ • estado         │
              │    │ • created_at         │ │ • created_at     │
              │    └──────────────────────┘ └──────────────────┘
              │             │                       │
              └─────────────┴──────────────────┬────┴─────┐
                                              │          │
                                              │ 1:n      │ 1:n
                                              │          │
                                              ▼          ▼
                            ┌──────────────────────┐  ┌──────────────────┐
                            │PROCEDIMIENTOS        │  │PRESCRIPCIONES    │
                            ├──────────────────────┤  ├──────────────────┤
                            │ • id (PK)            │  │ • id (PK)        │
                            │ • expediente_id      │  │ • expediente_id  │
                            │ • nombre             │  │ • medicamento    │
                            │ • descripcion        │  │ • dosis          │
                            │ • realizado_por      │  │ • frecuencia     │
                            │ • resultado          │  │ • duracion       │
                            │ • complicaciones     │  │ • indicaciones   │
                            │ • medicamentos_usados│  │ • prescrito_por  │
                            │ • created_at         │  │ • estado         │
                            └──────────────────────┘  │ • f_inicio       │
                                                      │ • f_fin          │
                            ┌──────────────────────┐  └──────────────────┘
                            │DERIVACIONES          │
                            ├──────────────────────┤  ┌──────────────────┐
                            │ • id (PK)            │  │AUDITORIA         │
                            │ • expediente_id      │  ├──────────────────┤
                            │ • especialidad       │  │ • id (PK)        │
                            │ • motivo_derivacion  │  │ • usuario_id     │
                            │ • urgencia           │  │ • accion         │
                            │ • derivado_por       │  │ • tabla_afectada │
                            │ • especialista_id    │  │ • registro_id    │
                            │ • estado             │  │ • datos_anteriores
                            │ • f_solicitada       │  │ • datos_nuevos   │
                            │ • f_realizacion      │  │ • detalles       │
                            │ • resultado          │  │ • ip_address     │
                            │ • created_at         │  │ • created_at     │
                            └──────────────────────┘  └──────────────────┘

═══════════════════════════════════════════════════════════════════════

┌────────────────────────────────────┐
│REPORTES_ESTADISTICAS               │
├────────────────────────────────────┤
│ • id (PK)                          │
│ • tipo_reporte                     │
│ • fecha_reporte                    │
│ • pacientes_total                  │
│ • triajes_rojo/naranja/etc         │
│ • tiempo_promedio_espera           │
│ • tiempo_promedio_atencion         │
│ • pacientes_atendidos              │
│ • created_at                       │
└────────────────────────────────────┘
```

---

## Relaciones Clave

### 1. USUARIOS → ROLES (n:1)
- Cada usuario tiene UN rol
- Los roles definen permisos

### 2. PACIENTES → SIGNOS_VITALES (1:n)
- Un paciente tiene múltiples registros de signos vitales
- Historial completo de constantes

### 3. PACIENTES → CAPTURA_CLINICA (1:n)
- Múltiples capturas clínicas por paciente
- Cada captura genera triaje

### 4. CAPTURA_CLINICA → SUGERENCIAS_TRIAJE_IA (1:n)
- Una captura genera una sugerencia de IA
- La IA analiza síntomas y signos vitales

### 5. SUGERENCIAS_TRIAJE_IA → TRIAJES (1:1)
- Sugerencia es validada por personal médico
- Genera triaje final

### 6. TRIAJES → COLA_URGENCIAS (1:1)
- Todo triaje crea entrada en cola
- Paciente entra a esperar atención

### 7. PACIENTES → EXPEDIENTES (1:n)
- Un paciente puede tener múltiples expedientes
- Cada episodio de atención es un expediente

### 8. EXPEDIENTES → NOTAS_CLINICAS (1:n)
- Un expediente contiene múltiples notas
- Evolución progresiva del paciente

### 9. EXPEDIENTES → PROCEDIMIENTOS (1:n)
- Múltiples procedimientos por expediente
- Registro de intervenciones

### 10. EXPEDIENTES → PRESCRIPCIONES (1:n)
- Medicamentos prescritos durante atención
- Histórico de medicamentos

### 11. EXPEDIENTES → DERIVACIONES (1:n)
- Derivaciones a especialidades
- Seguimiento de referenciaciones

---

## Índices de Optimización

```sql
-- Búsquedas frecuentes
CREATE INDEX idx_pacientes_cedula ON pacientes(cedula);
CREATE INDEX idx_usuarios_email ON usuarios(email);

-- Queries por fecha
CREATE INDEX idx_signos_vitales_fecha ON signos_vitales(created_at);
CREATE INDEX idx_triajes_fecha ON triajes(created_at);

-- Queries por estado
CREATE INDEX idx_cola_urgencias_estado ON cola_urgencias(estado);
CREATE INDEX idx_expedientes_estado ON expedientes(estado);

-- Queries combinadas
CREATE INDEX idx_cola_urgencias_prioridad_estado ON cola_urgencias(prioridad, estado);
CREATE INDEX idx_triajes_prioridad_fecha ON triajes(prioridad_final, created_at);
```

---

## Vistas Pre-calculadas

### 1. v_pacientes_en_cola
Muestra pacientes en espera con tiempos de espera

### 2. v_triajes_hoy
Resumen de triajes del día por prioridad

### 3. v_expedientes_activos
Expedientes abiertos con contador de notas y procedimientos

---

## Procedimientos Almacenados

### sp_crear_triaje
Crea triaje, actualiza sugerencia de IA e inserta en cola

### fn_generar_numero_expediente
Genera número único de expediente

---

## Consideraciones de Seguridad

1. **Encriptación:** Contraseñas con bcrypt
2. **Auditoría:** Tabla de auditoria registra cambios
3. **Validación:** Constraints en BD
4. **Integridad:** Foreign keys referencial
5. **Privacidad:** Datos sensibles protegidos

---

**Diagrama ER generado para Health-Connect © 2026**
