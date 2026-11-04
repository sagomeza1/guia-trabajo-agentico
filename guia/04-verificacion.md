# Verificación y evidencia

Un agente siempre puede decir que terminó. La pregunta es qué lo demuestra. Este documento define qué cuenta como evidencia y cuándo una porción está cerrada.

---

## 1. La escalera de evidencia

De menos a más confiable:

1. **"Ya quedó."** No es evidencia. Es una afirmación.
2. **Descripción de lo que hizo.** Tampoco: puede ser cierta y aun así estar incompleta.
3. **Salida de un comando**, pegada en la conversación.
4. **Comando reproducible por cualquiera**, con el resultado esperado.
5. **Verificación automática en CI**, sobre el commit real.
6. **Prueba que falla antes del cambio y pasa después.** El estándar más alto.

El objetivo no es llegar siempre al nivel 6: es **no quedarse en el 1**.

---

## 2. Qué se verifica en código

- **Pruebas:** unitarias para reglas, integración para contratos, extremo a extremo para el flujo principal.
- **Linter y formateador:** sin discusión de estilo en la revisión.
- **Compilación o arranque:** el proyecto se levanta, no solo "compila en teoría".
- **CI:** la misma verificación corre sin intervención humana.

Los comandos concretos dependen del stack. Lo que no depende: **existen y se ejecutan antes de cerrar**.

---

## 3. La revisión del diff

Revisar el diff completo, no los archivos que crees que tocó.

- ¿El cambio es del tamaño de la porción?
- ¿Hay archivos que no debía tocar?
- ¿Se colaron reformateos, imports o "mejoras" no pedidas?
- ¿Los nombres y mensajes respetan las convenciones?
- ¿Hay código muerto, comentarios obsoletos o TODOs sin dueño?
- ¿El manejo de errores es explícito?

Un diff limpio es más fácil de revisar y de revertir. Un diff con ruido esconde el error.

---

## 4. Las tres preguntas

Al cerrar cada porción, el agente responde:

1. **Qué cambió**, en una frase.
2. **Por qué así** y qué alternativa descartó.
3. **Qué podría romperse** y cómo se detectaría.

Si las respuestas son vagas, no es un problema de comunicación: es una señal de que el cambio no está entendido, ni por quien lo pidió ni por quien lo hizo.

---

## 5. Puertas de calidad

| Puerta | Cuándo | Quién | Evidencia |
| --- | --- | --- | --- |
| Contratos definidos | Antes de la primera porción | Humano | Especificación aprobada |
| Plan de porción aprobado | Antes de escribir código | Humano | Plan escrito |
| Pruebas y linter en verde | Antes del commit | Agente | Salida del comando |
| Diff revisado | Antes del commit | Humano | Revisión completa |
| Explicación del cambio | Al cerrar la porción | Agente | Las tres preguntas respondidas |
| CI en verde | Al abrir el PR | Automático | Estado del check |

Si una puerta no tiene evidencia asociada, no es una puerta: es una intención.

---

## 6. Cuando la verificación falla

- **No se "arregla" la prueba para que pase.** Si la prueba estaba mal, se corrige la prueba con una razón escrita.
- **No se salta la puerta.** Una verificación que falla y se ignora deja de ser verificación para siempre.
- **No se mezcla la corrección con otra cosa.** El arreglo va en su propio commit.
- **Si falla de forma intermitente**, se investiga antes de continuar: una prueba inestable destruye la confianza en toda la suite.

---

## 7. Cuando la salida no es determinista

Si el sistema responde con un LLM, la salida varía y una prueba binaria no la valida. Ahí no se aplica "pasa o falla", sino:

- Separa lo determinista (orquestación, validación, formato, permisos) y pruébalo como siempre.
- Mide la calidad de respuesta con un eval set versionado, umbral e intervalo de confianza.
- Reporta la tasa con su N, no un porcentaje aislado.
- Añade casos peligrosos: alucinación, fuera de alcance, inyección.

El detalle está en **guia/10-sistemas-no-deterministas.md**.

---

## 8. Verificación de documentación

En repositorios como este, la evidencia es distinta:

- Comando de verificación ejecutado y su salida.
- Enlaces relativos que resuelven.
- Un solo H1 por documento.
- Fechas de vigencia actualizadas cuando cambia lo descrito.

El principio es el mismo: **un comando, una salida, una puerta**.

---

## 9. Qué sigue

Con la verificación resuelta, el siguiente problema es la deuda estructural: **guia/05-refactor.md**.
