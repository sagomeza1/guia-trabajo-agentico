# Sistemas no deterministas

Todo lo anterior sigue aplicando cuando la salida no es fija. Lo que cambia es **cómo se comprueba**. Un chatbot con LLM no se valida con "la prueba pasa o falla": se valida separando lo determinista de lo probabilístico y midiendo lo segundo con criterios estadísticos.

---

## 1. Qué cambia

| | Software determinista | Sistema con LLM |
| --- | --- | --- |
| Misma entrada | Misma salida | Distribución de salidas |
| Verificación | Pasa / falla | Tasa de acierto con intervalo |
| Criterio | Aserción exacta | Umbral sobre un conjunto |
| Regresión | Test rojo | Caída de métrica más allá de un margen |
| Evidencia | Salida del comando | Reporte de evaluación versionado |

La trampa habitual: tratar una corrida como si fuera la verdad. Una respuesta buena no demuestra calidad; cincuenta respuestas medidas sí acotan algo.

---

## 2. Separa lo determinista de lo probabilístico

La mayor parte de un sistema con LLM **sí es determinista** y se prueba como siempre:

- Parseo de la entrada y validación de campos.
- Orquestación: qué herramienta se llama, con qué argumentos, en qué orden.
- Plantillas, formato de salida, límites de longitud.
- Reglas de negocio: cálculos, permisos, filtros.
- Guardarraíles: bloqueo de temas, enmascarado de datos, límites de coste.

Eso va con pruebas normales, dobles de prueba y aserciones exactas.

Lo probabilístico es la **calidad de la respuesta**: corrección, fidelidad al contexto, tono, utilidad. Eso se mide con un conjunto de evaluación, no con una aserción.

Regla: **si puedes escribir la respuesta esperada, es una prueba. Si solo puedes describir qué la hace aceptable, es una evaluación.**

---

## 3. El conjunto de evaluación

Un conjunto de evaluación (eval set) es una colección versionada de casos con su expectativa.

Qué debe tener:

- **Procedencia real:** tickets, conversaciones o consultas reales anonimizadas, no inventadas por el mismo que implementó.
- **Estratificación:** por intención, dificultad, longitud, idioma y tipo de usuario. Un promedio global esconde el fallo de un segmento.
- **Casos límite y adversarios:** intentos de manipulación, preguntas fuera de alcance, datos incompletos, ambigüedad.
- **Expectativa explícita:** respuesta de referencia, hechos obligatorios, hechos prohibidos o rúbrica.
- **Tamaño suficiente:** 30–50 casos por categoría para iterar; 200 o más cuando la métrica se usa para decidir un release.
- **Separación dev / test:** el conjunto de test no se usa para ajustar prompts. Si se usa, deja de medir y empieza a entrenar.
- **Versionado:** el eval set es un artefacto con fecha y cambios registrados.

Sin conjunto versionado no hay comparación posible: cada release se mide contra un blanco distinto.

---

## 4. Criterios estadísticos

Una tasa sin incertidumbre es una opinión con decimales.

### 4.1 Reporta intervalo, no solo el punto

Con 45 aciertos de 50, la tasa observada es 90%. El intervalo de confianza al 95% (Wilson) es aproximadamente **78,6% – 95,7%**. Es decir: el sistema puede estar en 96% o en 79%, y no lo sabes.

Consecuencia práctica: **con 50 casos no puedes distinguir una mejora de 5 puntos de una racha.**

### 4.2 Fija el umbral y el tamaño antes

- Umbral mínimo por métrica y por segmento (no solo global).
- Número de corridas por caso si la varianza importa: 3–5 y reporta la distribución.
- Margen de regresión aceptable: por ejemplo, "no caer más de 3 puntos porcentuales con el mismo eval set".
- Si el margen es menor que el intervalo de confianza, el criterio no es medible con ese N.

### 4.3 Distingue tipos de error

Un promedio único oculta lo que más importa. Reporta por separado:

- **Falso negativo peligroso:** no responde algo que debía (abandono).
- **Falso positivo peligroso:** responde con seguridad algo incorrecto (el peor caso en atención al cliente).
- **Fuera de alcance:** responde lo que no debía responder.

En un chatbot de clientes, una alucinación segura vale más que diez respuestas tibias.

---

## 5. Cómo se califica

De más barato y determinista a más caro y subjetivo:

1. **Aserciones estructurales:** JSON válido, campos presentes, longitud, enlaces existentes, citas que aparecen en el contexto.
2. **Coincidencia con referencia:** exact match o solapamiento de hechos obligatorios, no similitud de texto.
3. **Rúbrica humana** sobre una muestra: criterios de 1 a 5 con descripción de cada nivel y dos evaluadores en los casos dudosos.
4. **Juez LLM:** útil para volumen, pero solo si está calibrado.

### Reglas para el juez LLM

- Calíbralo contra un lote etiquetado por humanos y mide el acuerdo (kappa). Si el acuerdo es bajo, el juez no sirve.
- No uses el mismo modelo que genera como juez único.
- Controla sesgos conocidos: posición de las opciones, longitud de la respuesta, tono seguro.
- Guarda las justificaciones del juez: sin ellas no se puede auditar.
- Trátalo como aproximación para priorizar, no como veredicto final en decisiones de riesgo.

### Lo que no mide

BLEU, ROUGE y similares miden parecido de forma, no verdad ni utilidad. Sirven para traducción o resumen con referencia; no para decidir si un chatbot respondió bien.

---

## 6. El generador simulado

Los dobles de prueba no desaparecen: cambian de sitio.

- **Proveedor grabado (record / replay):** respuestas reales guardadas por escenario. Prueba el sistema alrededor del modelo, de forma reproducible y sin coste.
- **Fixtures por escenario:** respuesta correcta, respuesta vacía, JSON malformado, timeout, error 429, contenido fuera de política.
- **Simulador de usuario:** un guion de turnos para probar flujos de varios pasos, con objetivos y salidas esperadas.
- **Inyección de fallos:** latencia, corte de streaming, herramienta caída.

Advertencia: el mock valida **tu sistema**, no la calidad del modelo. Un verde con respuestas grabadas no dice nada sobre cómo responde el modelo real ante una pregunta nueva.

---

## 7. Reproducibilidad

- Temperatura 0 reduce la varianza; no la elimina. El muestreo, el hardware y la versión del modelo influyen.
- Fija y registra la versión o snapshot del modelo en cada evaluación. Un cambio silencioso del proveedor invalida la comparación.
- Repite N veces y reporta media y dispersión, no una sola corrida.
- Registra el eval set, el prompt, los parámetros y la fecha: sin eso, el número no es evidencia.

---

## 8. Puertas para sistemas probabilísticos

| Puerta | Evidencia |
| --- | --- |
| Comportamiento determinista | Pruebas en verde sobre orquestación y guardarraíles |
| Calidad de respuesta | Reporte del eval set con N, métrica, umbral e intervalo |
| Sin regresión | Comparación contra el release anterior en el mismo eval set |
| Casos peligrosos | Tasa de alucinación y de fuera de alcance por debajo del umbral |
| Coste y latencia | p95 y coste medio por conversación dentro del presupuesto |
| Deriva | Muestra periódica del tráfico real revisada por humanos |

Un release no se aprueba con "probé veinte preguntas y respondió bien".

---

## 9. Coste de evaluar

- Evaluar cuesta tokens y tiempo: presupuesta como parte del desarrollo, no como extra.
- Subconjunto rápido (20–30 casos críticos) en cada pull request; suite completa antes del release.
- Cachea respuestas cuando el caso es estable, pero invalida la caché al cambiar prompt o modelo.
- El coste de evaluar es una fracción del coste de un fallo público.

---

## 10. Lo que no cambia

El modelo híbrido sigue aplicando:

- La Fase 0 define contratos y criterios, ahora también criterios estadísticos.
- Las porciones siguen siendo verticales y verificables.
- El refactor sigue siendo continuo.
- La revisión del diff y la explicación del agente siguen siendo obligatorias.

Lo único que cambia es la definición de evidencia: **para lo determinista, un comando; para lo probabilístico, un reporte con intervalo.**

---

## Qué sigue

Los riesgos que no son de calidad ni de funcionalidad: **guia/11-riesgos-no-funcionales.md**.
