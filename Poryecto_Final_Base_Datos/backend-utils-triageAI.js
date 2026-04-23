// ============================================================
// UTILS/TRIAGE-AI.JS - LÓGICA DE IA PARA TRIAJE
// ============================================================

/**
 * Sistema de IA para priorización clínica inicial
 * NO diagnostica - solo asiste en priorización de triaje
 */

class TriageAI {
    constructor() {
        this.modelo = 'HealthConnect-Triage-v1.0';
    }

    /**
     * Analiza signos vitales y síntomas para generar sugerencia de triaje
     * @param {Object} clinicalData - Datos clínicos del paciente
     * @returns {Object} - Sugerencia con prioridad y criterios
     */
    analyzeClinical(clinicalData) {
        let score = 0;
        let criteria = [];
        let priority = 'azul';
        let confidence = 0;

        const {
            sbp, dbp,          // Tensión arterial sistólica/diastólica
            hr,                 // Frecuencia cardíaca
            rr,                 // Frecuencia respiratoria
            spo2,               // Saturación de oxígeno
            temp,               // Temperatura
            symptoms,           // Síntomas descritos
            severity            // Severidad reportada (leve/moderada/severa)
        } = clinicalData;

        // ============================================================
        // CRITERIOS CRÍTICOS - TRIAJE ROJO (INMEDIATO)
        // ============================================================

        // SpO2 crítico
        if (spo2 < 90) {
            score += 40;
            criteria.push('Saturación de oxígeno < 90% (CRÍTICA)');
        }

        // Frecuencia cardíaca crítica
        if (hr > 120 || hr < 40) {
            score += 35;
            criteria.push(`Frecuencia cardíaca anormal: ${hr} bpm`);
        }

        // Tensión arterial crítica
        if (sbp > 180 || sbp < 70 || dbp > 120) {
            score += 35;
            criteria.push(`Tensión arterial crítica: ${sbp}/${dbp} mmHg`);
        }

        // Temperatura muy elevada o muy baja
        if (temp > 40 || temp < 35) {
            score += 30;
            criteria.push(`Temperatura extrema: ${temp}°C`);
        }

        // Frecuencia respiratoria crítica
        if (rr > 30 || rr < 8) {
            score += 30;
            criteria.push(`Frecuencia respiratoria anormal: ${rr} rpm`);
        }

        // Síntomas de emergencia inmediata
        const emergencySympoms = [
            'paro cardíaco', 'inconsciencia', 'convulsión',
            'hemorragia severa', 'asfixia', 'shock',
            'dolor torácico severo', 'dificultad respiratoria severa'
        ];
        
        if (symptoms && emergencySympoms.some(s => symptoms.toLowerCase().includes(s))) {
            score += 45;
            criteria.push('Síntomas de emergencia inmediata detectados');
        }

        // ============================================================
        // CRITERIOS ROJO/NARANJA (MUY URGENTE)
        // ============================================================

        // SpO2 bajo pero no crítico
        if (spo2 >= 90 && spo2 < 94) {
            score += 25;
            criteria.push(`Saturación de oxígeno baja: ${spo2}%`);
        }

        // FC elevada
        if ((hr > 110 && hr <= 120) || (hr >= 40 && hr < 50)) {
            score += 20;
            criteria.push(`Frecuencia cardíaca elevada: ${hr} bpm`);
        }

        // TA elevada
        if ((sbp > 160 && sbp <= 180) || (dbp > 110 && dbp <= 120)) {
            score += 20;
            criteria.push(`Tensión arterial elevada: ${sbp}/${dbp} mmHg`);
        }

        // Temp moderadamente elevada
        if (temp > 38.5 && temp <= 40) {
            score += 15;
            criteria.push(`Temperatura elevada: ${temp}°C`);
        }

        // FR moderadamente anormal
        if ((rr > 24 && rr <= 30) || (rr >= 12 && rr < 15)) {
            score += 15;
            criteria.push(`Frecuencia respiratoria anormal: ${rr} rpm`);
        }

        // Síntomas moderados-severos
        if (severity === 'severa') {
            score += 25;
            criteria.push('Síntomas de severidad alta reportados');
        }

        // ============================================================
        // CRITERIOS AMARILLO (URGENTE)
        // ============================================================

        // SpO2 límite bajo
        if (spo2 >= 94 && spo2 < 96) {
            score += 10;
            criteria.push(`Saturación de oxígeno en límite bajo: ${spo2}%`);
        }

        // FC ligeramente elevada
        if ((hr > 100 && hr <= 110) || (hr >= 50 && hr < 60)) {
            score += 8;
            criteria.push(`Frecuencia cardíaca ligeramente elevada: ${hr} bpm`);
        }

        // TA ligeramente elevada
        if ((sbp > 140 && sbp <= 160) || (dbp > 90 && dbp <= 110)) {
            score += 8;
            criteria.push(`Tensión arterial ligeramente elevada: ${sbp}/${dbp} mmHg`);
        }

        // Temp moderada
        if (temp > 38 && temp <= 38.5) {
            score += 8;
            criteria.push(`Temperatura moderadamente elevada: ${temp}°C`);
        }

        // FR ligeramente anormal
        if ((rr > 20 && rr <= 24) || (rr >= 16 && rr < 20)) {
            score += 5;
            criteria.push(`Frecuencia respiratoria ligeramente elevada: ${rr} rpm`);
        }

        // Síntomas moderados
        if (severity === 'moderada') {
            score += 12;
            criteria.push('Síntomas de severidad moderada reportados');
        }

        // Síntomas comunes de urgencia (dolor, mareo, etc)
        const urgentSymptoms = ['dolor', 'mareo', 'náusea', 'vómito', 'cefalea'];
        if (symptoms && urgentSymptoms.some(s => symptoms.toLowerCase().includes(s))) {
            score += 8;
            criteria.push('Síntomas de urgencia detectados');
        }

        // ============================================================
        // DETERMINACIÓN DE PRIORIDAD
        // ============================================================

        if (score >= 100) {
            priority = 'rojo';
            confidence = Math.min(95, score);
        } else if (score >= 70) {
            priority = 'naranja';
            confidence = Math.min(95, score - 20);
        } else if (score >= 40) {
            priority = 'amarillo';
            confidence = Math.min(85, score - 10);
        } else if (score >= 15) {
            priority = 'verde';
            confidence = Math.min(80, score);
        } else {
            priority = 'azul';
            confidence = Math.min(75, score + 20);
        }

        // ============================================================
        // RECOMENDACIONES
        // ============================================================

        let recommendations = [];

        switch (priority) {
            case 'rojo':
                recommendations = [
                    'URGENCIA INMEDIATA - Requiere evaluación médica urgente',
                    'Monitoreo continuo de signos vitales',
                    'Evaluación médica dentro de 5 minutos',
                    'Considerarprocedimientos de estabilización'
                ];
                break;
            case 'naranja':
                recommendations = [
                    'MUY URGENTE - Evaluación médica recomendada',
                    'Monitoreo de constantes vitales',
                    'Evaluación médica dentro de 10 minutos',
                    'Preparación para procedimientos si es necesario'
                ];
                break;
            case 'amarillo':
                recommendations = [
                    'URGENTE - Evaluación médica en menos de 30 minutos',
                    'Mantener monitoreo de cambios',
                    'Valoración clínica de síntomas',
                    'Estar alerta a cambios de estado'
                ];
                break;
            case 'verde':
                recommendations = [
                    'POCO URGENTE - Puede esperar 1-2 horas',
                    'Mantener monitoreo de signos vitales',
                    'Evaluación en turno normal',
                    'Comunicar cambios al personal'
                ];
                break;
            case 'azul':
                recommendations = [
                    'NO URGENTE - Atención rutinaria',
                    'Puede ser evaluado en horario regular',
                    'No requiere monitoreo especial',
                    'Proceder según protocolos normales'
                ];
                break;
        }

        return {
            priority,
            score,
            confidence: parseFloat(confidence.toFixed(2)),
            criteria,
            recommendations,
            model: this.modelo,
            timestamp: new Date().toISOString()
        };
    }

    /**
     * Valida si los datos son suficientes para análisis
     */
    validateData(clinicalData) {
        const required = ['sbp', 'dbp', 'hr', 'rr', 'spo2', 'temp'];
        const missing = required.filter(field => 
            clinicalData[field] === undefined || clinicalData[field] === null
        );
        
        return {
            isValid: missing.length === 0,
            missingFields: missing
        };
    }

    /**
     * Calcula IMC
     */
    calculateIMC(weight, height) {
        if (weight && height) {
            const heightInMeters = height / 100;
            return parseFloat((weight / (heightInMeters * heightInMeters)).toFixed(2));
        }
        return null;
    }
}

module.exports = new TriageAI();
