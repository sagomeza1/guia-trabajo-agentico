# Porciones verticales

Una porción es la unidad de trabajo del modelo híbrido. Todo lo demás —brief, verificación, commit, refactor— se organiza alrededor de ella.

---

## 1. Qué es una porción

Una funcionalidad **de punta a punta**: entra por donde entra el usuario y termina en el almacenamiento o en la respuesta, pasando por todas las capas necesarias.

- "El usuario registra un gasto y queda guardado" es una porción.
- "Escribir el repositorio de gastos" no lo es: es una capa, y no se puede probar sola contra el objetivo.
- "Agregar el campo nota al formulario, al modelo, a la base y a la lista" sí lo es: atraviesa todo.

**Criterio:** al terminar la porción, alguien puede usar la funcionalidad completa, no una parte.

---

## 2. Vertical contra horizontal

| Horizontal (evitar) | Vertical (preferir) |
| --- | --- |
| Capa de datos completa | Un flujo completo con los datos mínimos |
| Todos los endpoints sin lógica | Un endpoint con su lógica y su prueba |
| Toda la interfaz sin backend | Una pantalla conectada a un dato real |

El corte horizontal produce semanas sin nada demostrable. El vertical produce algo que se puede enseñar, probar y corregir.

---

## 3. Reglas de tamaño

- Cabe en **una sesión** de trabajo y en **un commit**.
- Tiene **un** criterio de aceptación propio.
- Deja el sistema **ejecutable**: nada de ramas a medias durante días.
- Si no cabe, se parte. Si no se puede partir, falta un contrato en la Fase 0.

Señal de que es demasiado grande: el brief ocupa más de una pantalla o usa la palabra "y" tres veces en el objetivo.

---

## 4. Patrones para cortar

- **Por flujo de usuario:** crear, listar, editar, borrar. Cada uno es una porción.
- **Por caso borde:** primero el camino feliz, después validaciones, después errores.
- **Por dato:** primero un tipo de registro, después varios.
- **Por riesgo:** primero lo incierto y lo que puede invalidar el diseño; lo repetitivo al final.
- **Por integración:** primero con datos falsos, después con la fuente real.

Empieza siempre por la porción que, si falla, cambia el plan.

---

## 5. El brief de una porción

    Objetivo: [resultado observable, una frase]
    Contexto: [documentos y archivos relevantes]
    Alcance: [qué puede tocar]
    No tocar: [rutas, módulos, decisiones cerradas]
    Criterio de done: [prueba o comprobación concreta]
    Evidencia esperada: [salida de test, diff, captura]

Plantilla completa en [plantillas/brief-porcion.md](../plantillas/brief-porcion.md).

### Ejemplo

    Objetivo: registrar un gasto desde la línea de comandos y guardarlo en el archivo de datos.
    Contexto: especificaciones-proyecto.md, contrato de RegistroGasto, porción 1 ya cerrada.
    Alcance: src/gastos/registrar.py y su prueba.
    No tocar: el formato del archivo de datos ni el módulo de reportes.
    Criterio de done: "gasto 25000 comida" agrega una línea válida y "gasto -5 comida" falla sin escribir.
    Evidencia: salida de pytest y diff del commit.

---

## 6. El bucle de trabajo

1. **Plan.** El agente propone pasos y archivos. Se aprueba antes de escribir código.
2. **Implementación.** Acotada a la porción. Sin reformateos ni "de paso arreglo esto".
3. **Verificación.** Pruebas, linter y CI. Si falla, la porción sigue abierta.
4. **Revisión del diff.** Completa, no solo los archivos que crees que tocó.
5. **Explicación.** El agente responde: qué cambió, por qué así, qué podría romperse.
6. **Commit.** Un tema, un mensaje en imperativo.

Si el paso 5 no se puede responder con claridad, la porción no está lista: falta contexto o el diseño es confuso.

---

## 7. Definición de terminado

Una porción está terminada cuando:

- El criterio de aceptación se cumple y hay evidencia de ello.
- Las pruebas existentes siguen pasando.
- El diff está revisado y acotado.
- La explicación del cambio es comprensible para alguien que no lo escribió.
- El plan y las decisiones quedaron actualizados.

No está terminada porque el agente diga que sí.

---

## 8. Commits

- Un tema por commit.
- Mensaje en imperativo: "agrega validación de monto", no "agregué validaciones varias".
- Si el commit necesita la palabra "y" para describirse, probablemente son dos.
- Nunca se mezcla refactor con funcionalidad.

---

## 9. Cómo saber si la porción está bien cortada

- Se puede describir sin explicar la arquitectura.
- Se puede probar sin levantar todo el sistema.
- Si se abandona a medias, no deja el proyecto roto.
- Al terminarla, el siguiente paso es obvio.

Si no cumple estas cuatro, vuelve a la Fase 0: probablemente falta un contrato.
