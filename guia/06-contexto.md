# Contexto vivo

El agente no recuerda entre sesiones. Lo que no está escrito, no existe; y lo que está escrito de más, compite con lo importante.

---

## 1. El contexto es el recurso escaso

Un agente rinde mejor con contexto **relevante y reciente** que con contexto **abundante y viejo**. Tres síntomas de contexto enfermo:

- Repite decisiones que ya se tomaron.
- "Olvida" convenciones escritas en otro archivo.
- Propone cambios que contradicen el plan.

No es un problema de capacidad: es un problema de señal contra ruido.

---

## 2. Los tres documentos que sostienen el proyecto

### AGENTS.md

Qué es el proyecto, qué reglas se aplican, cómo se verifica y qué no se toca. Es lo primero que lee cualquier agente y lo primero que hay que actualizar cuando cambia una convención.

Plantilla en **plantillas/AGENTS.md**.

### plan.md

La lista de porciones con estado. Es la memoria del avance y evita que cada sesión empiece decidiendo qué hacer.

    ## Porciones
    - [x] 1. Registrar gasto
    - [x] 2. Listar gastos del mes
    - [ ] 3. Total por categoría
    - [ ] 4. Exportar a CSV

### decisiones.md

Registro ligero de arquitectura: fecha, decisión, motivo, alternativa descartada. Cuatro líneas por entrada, no un ensayo.

    ### 2026-11-04 — Archivo JSON en lugar de base de datos
    Motivo: volumen bajo y cero instalación.
    Alternativa descartada: SQLite, por costo de migración.
    Revisar si se superan 10.000 registros.

Plantilla en [plantillas/decisiones.md](../plantillas/decisiones.md).

---

## 3. Higiene de sesión

- **Una sesión, una porción.** Si la sesión ya resolvió tres cosas y empieza la cuarta, ábrela de nuevo con el contexto actualizado.
- **Resume antes de cerrar.** Deja escrito qué quedó, qué sigue y qué se descartó.
- **No arrastres conversaciones largas.** Un hilo de dos horas suele tener más ruido que señal.
- **Empieza por el plan, no por el código.** La primera instrucción de una sesión nueva debería ser leer el estado, no "continúa".

---

## 4. Qué meter y qué dejar fuera

**Meter:**
- El contrato del módulo que se va a tocar.
- La porción actual y su criterio de done.
- Las convenciones que aplican a ese archivo.
- El error o la salida que motiva el cambio.

**Dejar fuera:**
- La historia completa del proyecto.
- Documentos de módulos que no se tocan.
- Conversaciones anteriores sin resumir.
- Reglas contradictorias de dos versiones distintas.

---

## 5. Jerarquía de instrucciones

Cuando dos instrucciones se contradicen, el agente elegirá una y no siempre la que tú quieres. Define el orden:

1. Reglas del repositorio (AGENTS.md).
2. Especificación del proyecto.
3. Brief de la porción.
4. Preferencias de la conversación.

Si una regla no admite excepciones, no la dejes solo en el prompt: llévala a un lint, un test o CI.

---

## 6. Cuándo actualizar

- Al cerrar una porción: **plan.md**.
- Al tomar una decisión estructural: **decisiones.md**.
- Al cambiar una convención: **AGENTS.md**.
- Al cambiar el alcance: **objetivos-proyecto.md** y **especificaciones-proyecto.md**.

Actualizar es parte de cerrar, no una tarea aparte que se hace "algún día".

---

## 7. Qué sigue

Con el contexto ordenado, el problema pasa a ser cómo se encarga el trabajo: [guia/07-delegacion.md](../guia/07-delegacion.md).
