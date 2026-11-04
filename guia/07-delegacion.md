# Delegación: briefs, autonomía y permisos

Delegar no es pedir. Es definir un resultado, un límite y una forma de comprobarlo. Este documento cubre cómo se encarga el trabajo y cuánta autonomía se concede.

---

## 1. Anatomía de un brief

Todo brief tiene seis partes. Si falta una, el agente la completará por su cuenta.

1. **Objetivo:** resultado observable, en una frase.
2. **Contexto:** qué documentos leer y qué ya se intentó.
3. **Alcance:** qué puede tocar.
4. **No tocar:** qué no puede tocar, aunque parezca razonable.
5. **Criterio de done:** la comprobación que debe pasar.
6. **Evidencia:** qué debe mostrar al terminar.

### Ejemplo completo

    Objetivo: que el comando "listar --mes" muestre los gastos del mes indicado, ordenados por fecha.
    Contexto: lee AGENTS.md, especificaciones-proyecto.md y el contrato de RegistroGasto. La porción 2 ya dejó el listado sin filtro.
    Alcance: src/gastos/listar.py, src/gastos/cli.py y pruebas de listar.
    No tocar: el formato del archivo de datos, el módulo de reportes ni las dependencias.
    Criterio de done: con tres gastos de octubre y dos de noviembre, "listar --mes 2026-11" devuelve exactamente dos, en orden.
    Evidencia: salida de pytest con la prueba nueva y el diff del commit.

Un brief así se puede ejecutar sin preguntas y se puede revisar sin adivinar.

---

## 2. Niveles de autonomía

No todo requiere el mismo control. Declara el nivel antes de empezar:

| Nivel | Qué puede hacer el agente | Cuándo usarlo |
| --- | --- | --- |
| **L0 — Consulta** | Solo responder y proponer | Decisiones de diseño, dudas |
| **L1 — Propone y espera** | Escribe un plan; no toca archivos | Cambios estructurales |
| **L2 — Ejecuta y reporta** | Implementa la porción y muestra evidencia | Trabajo normal |
| **L3 — Ejecuta y cierra** | Implementa, verifica y deja listo para revisar | Tareas repetitivas y bien acotadas |

L3 no significa "sin revisión": significa que la revisión ocurre al final, sobre el diff, no paso a paso. Sigue siendo un humano quien aprueba.

**Nunca L3:** borrar datos, tocar credenciales, publicar, gastar dinero, cambiar configuración del sistema.

---

## 3. Permisos y límites

Un límite que no está escrito no existe. Los que más se olvidan:

- Carpetas y archivos fuera del proyecto.
- Dependencias nuevas.
- Cambios en el esquema de datos o migraciones.
- Commits, push y pull requests.
- Servicios externos, correo, publicaciones.
- Secretos y variables de entorno.

Regla: **lo irreversible se aprueba antes; lo reversible se reporta después.**

---

## 4. Trabajo en paralelo

Se puede repartir una porción grande entre varios agentes si los cortes son limpios. No se puede repartir lo que comparte archivos.

Antes de paralelizar:

- Cada tarea tiene contrato propio y criterio propio.
- Los archivos no se solapan.
- Alguien integra y verifica al final.

Si dos tareas tocan el mismo archivo, no son paralelas: son una secuencia disfrazada.

---

## 5. Cómo revisar la entrega

1. Mira la evidencia, no el resumen.
2. Revisa el diff completo.
3. Pregunta qué podría romperse.
4. Comprueba que el alcance se respetó: ni menos, ni más.
5. Si hay algo que no entiendes, pide la explicación antes de aprobar.

El objetivo de la revisión no es desconfiar: es mantener la comprensión de lo que se va a mantener.

---

## 6. Errores de delegación

- **"Hazme esto" sin criterio:** el agente elige el criterio por ti.
- **"Haz lo que creas mejor":** garantiza decisiones que no puedes auditar.
- **Brief que crece a mitad de tarea:** el alcance se desdibuja y la verificación pierde sentido.
- **Pedir tres cosas en un mensaje:** se entrega una bien y dos a medias.
- **No decir qué no tocar:** el agente "mejora" algo que no debía.

---

## 7. Qué sigue

Los errores anteriores tienen nombre y se repiten: [guia/08-antipatrones.md](../guia/08-antipatrones.md).
