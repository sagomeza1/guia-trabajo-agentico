# Caso completo: asistente de soporte con LLM

Segundo caso aplicado. A diferencia del bot de gastos, aquí la salida varía: el mismo pedido puede responderse de varias formas correctas. Aplica el método de [guia/10-sistemas-no-deterministas.md](../guia/10-sistemas-no-deterministas.md) y [guia/11-riesgos-no-funcionales.md](../guia/11-riesgos-no-funcionales.md).

> 🗓️ **Última revisión:** 2026-11-04.

> Proyecto: asistente de soporte para una tienda en línea. Responde sobre estado de pedidos, envíos y devoluciones; deriva a un humano cuando no está seguro. Un usuario a la vez, datos propios, sin acceso a pagos.

---

## 1. Fase 0

### 1.1 Separar lo determinista de lo probabilístico

El primer acto del proyecto es partir el sistema en dos, porque se verifican distinto:

| Determinista (se prueba) | Probabilístico (se evalúa) |
| --- | --- |
| Qué herramienta se llama y con qué argumentos | Si la respuesta es correcta |
| Validación del número de pedido | Si respeta la política de devoluciones |
| Formato de salida (esquema) | Si el tono es adecuado |
| Guardarraíl de temas prohibidos | Si deriva cuando debe derivar |
| Límite de turnos y fallback a humano | Si inventa datos que no tiene |

El esqueleto, la orquestación y los guardarraíles son deterministas y van con pruebas exactas. La calidad de la respuesta va con un eval set.

### 1.2 Contratos

    AsistenteSoporte
        responder(consulta, contexto_pedido) -> Respuesta | Derivacion
        herramientas:
            buscar_pedido(numero) -> Pedido | NoEncontrado
            politica_devolucion(tema) -> Texto

    Reglas (innegociables)
        nunca inventar un estado de pedido
        nunca dar consejo legal ni financiero
        derivar si la confianza es baja o el tema está fuera de alcance
        nunca exponer datos de otro pedido

### 1.3 Criterios de aceptación

Deterministas:

- **buscar_pedido** con número inválido devuelve **NoEncontrado** sin llamar a la API.
- La salida valida contra el esquema JSON en el 100% de las respuestas.
- Un tema prohibido (legal, salud) produce derivación, nunca una respuesta.

Estadísticos (sobre el eval set):

- Tasa de acierto ≥ 90%, reportada con N e intervalo de confianza.
- Alucinación ≤ 2%.
- Fuera de alcance ≤ 5%.
- Derivación correcta ≥ 90% en los casos que deben derivarse.

### 1.4 Riesgos no funcionales

Tomados de [guia/11-riesgos-no-funcionales.md](../guia/11-riesgos-no-funcionales.md):

- **Privacidad:** número de pedido y correo son datos personales. Se enmascaran en logs; retención de 30 días; proveedor sin entrenamiento con los datos.
- **Coste:** presupuesto de 0,002 USD por conversación media; alerta al superarlo; límite de 8 turnos por conversación.
- **Latencia:** p95 ≤ 2 s hasta el primer token; modo degradado con respuesta enlatada si el proveedor no responde.
- **Seguridad:** inyección de prompts en las consultas; la herramienta de pedidos es solo lectura; nada destructivo sin confirmación.

### 1.5 Decisiones iniciales

    ### 2026-11-04 — Modelo fijado a una versión concreta
    Motivo: comparar releases contra el mismo blanco.
    Alternativa descartada: latest, por deriva silenciosa.
    Revisar si: el proveedor deja de ofrecer la versión fijada.

    ### 2026-11-04 — Juez LLM para priorizar, no para decidir
    Motivo: evaluar 100 casos a mano no escala.
    Alternativa descartada: revisión 100% humana, por coste.
    Revisar si: el acuerdo con los humanos baja de kappa 0,7.

---

## 2. El eval set

### 2.1 Composición

Cien casos, estratificados, cada uno con expectativa explícita:

| Categoría | Casos | Fuente |
| --- | --- | --- |
| Estado de pedido | 30 | Conversaciones reales anonimizadas |
| Política de devoluciones | 30 | Conversaciones reales anonimizadas |
| Envíos y tiempos | 20 | Conversaciones reales anonimizadas |
| Fuera de alcance | 10 | Legal, salud, financiero |
| Adversariales | 10 | Inyección, pedidos inventados, ambigüedad |

Separación dev / test: los 100 se reservan para medir; los ajustes de prompt se hacen contra un dev set distinto. Si se ajusta contra el test, deja de medir y empieza a entrenar.

### 2.2 Expectativa por caso

    caso 007 — «¿dónde está mi pedido 12345?»
    categoría: estado de pedido
    hechos obligatorios: el estado real del pedido (del fixture), sin inventar fecha
    hechos prohibidos: fecha de entrega exacta si el sistema no la tiene
    rúbrica: 5 correcto y completo · 3 correcto pero incompleto · 1 inventa o confunde

### 2.3 Por qué importa la procedencia

Los casos inventados por quien implementa tienden a ser fáciles para el propio sistema. Los casos reales contienen lo que nadie anticipó: pedidos mal escritos, dos preguntas en una, clientes enfadados. Sin procedencia real, el eval set mide lo fácil.

---

## 3. Métricas y umbrales

### 3.1 Qué se mide y cómo

- **Acierto:** rúbrica de 1 a 5; cuenta como acierto 4 o 5.
- **Alucinación:** afirma un hecho no respaldado por el contexto.
- **Fuera de alcance:** responde un tema que debía derivar.
- **Derivación correcta:** deriva cuando debe y no deriva de más.

### 3.2 El número sin intervalo es ruido

Con 45 aciertos de 50, la tasa observada es 90%, pero el intervalo de confianza al 95% (Wilson) es **78,6% – 95,7%**. Con 50 casos no puedes distinguir una mejora de 5 puntos de una racha.

Con 90 de 100, el intervalo se estrecha a **82,6% – 94,5%**. Sigue sin ser 90% exacto, pero ya acota la decisión.

Conclusión: el umbral se decide **con** el tamaño del eval set. Pedir 90% con 50 casos es pretender una precisión que la muestra no da.

### 3.3 Criterio de regresión

Entre releases, con el mismo eval set:

- El acierto no cae más de 3 puntos porcentuales.
- La alucinación no sube por encima de 2%, pase lo que pase.
- La derivación correcta no cae más de 5 puntos.

---

## 4. Lo determinista: dobles de prueba

El proveedor del modelo no se llama en cada prueba. Se graba y se reproduce:

- **Record / replay:** respuestas reales guardadas por escenario.
- **Fixtures de pedidos:** un pedido en tránsito, uno entregado, uno inexistente.
- **Fallos inyectados:** JSON malformado, timeout, error 429, herramienta de pedidos caída.
- **Caso vacío:** el modelo responde sin texto; el sistema debe derivar, no fallar.

Advertencia: el mock valida **el sistema alrededor del modelo**, no la calidad del modelo. Un verde con respuestas grabadas no dice nada sobre cómo responde ante una pregunta nueva.

---

## 5. El juez LLM

Para revisar 100 casos sin hacerlo a mano cada vez:

1. Calibración contra 50 casos etiquetados por humanos.
2. Objetivo de acuerdo: kappa ≥ 0,7. Por debajo, el juez no decide.
3. No usar el mismo modelo que genera como juez único.
4. Guardar la justificación de cada veredicto.
5. Tratar el veredicto como priorización para revisión humana, no como sentencia.

---

## 6. Una porción de ejemplo

**Brief**

    Objetivo: responder el estado de un pedido correctamente o derivar si no lo sabe.
    Contexto: contrato de AsistenteSoporte, fixtures de pedidos, eval set (categoría estado de pedido).
    Alcance: orquestación, herramienta buscar_pedido, prompt y esquema de salida.
    No tocar: devoluciones, envíos, la política de coste.
    Criterio de done:
      determinista — pytest en verde: número inválido no llama a la API; esquema valida.
      estadístico — reporte del eval de la categoría con N, acierto, IC y cero alucinaciones.
    Evidencia: salida de pytest y reporte de evaluación versionado.

El bucle es el mismo que en el bot de gastos; lo que cambia es la evidencia de la puerta de verificación.

---

## 7. Puertas de release

| Puerta | Evidencia |
| --- | --- |
| Comportamiento determinista | Pruebas en verde sobre orquestación y guardarraíles |
| Calidad de respuesta | Reporte del eval set con N, umbral e intervalo |
| Sin regresión | Comparación contra el release anterior, mismo eval set |
| Casos peligrosos | Alucinación ≤ 2% y fuera de alcance ≤ 5% |
| Coste y latencia | Coste medio y p95 dentro del presupuesto |
| Privacidad | PII enmascarado en logs, retención aplicada |

Un release no se aprueba con «lo probé con veinte preguntas y respondió bien».

---

## 8. Contraste con el bot de gastos

| | Bot de gastos | Asistente de soporte |
| --- | --- | --- |
| Salida | Determinista | Distribución de salidas |
| Verificación | Prueba binaria | Eval set + intervalo |
| Criterio de done | Aserción exacta | Umbral sobre un conjunto |
| Lo que comparte | Fase 0, porciones, brief, refactor, revisión del diff | Idéntico |

El método no cambia. Cambia únicamente qué se considera evidencia.

---

## 9. Qué habría fallado sin este método

- «Lo probé con veinte preguntas» → un verde falso que una métrica con N habría desmentido.
- Sin eval set versionado → la regresión del release siguiente es invisible.
- Sin separar determinista de probabilístico → se intenta testear la calidad con aserciones imposibles.
- Sin riesgos no funcionales → fuga de datos personales o coste fuera de control, descubiertos en producción.
