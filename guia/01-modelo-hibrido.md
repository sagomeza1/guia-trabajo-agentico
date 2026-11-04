# El modelo híbrido

> 🗓️ **Última revisión:** 2026-11-04.

Este documento explica por qué el trabajo con agentes falla en los extremos y qué se hace en el medio. Es la base de todo lo demás.

---

## 1. Los dos extremos

### A. Especificar todo y generar todo

El humano escribe objetivos, especificaciones y restricciones; el agente produce el proyecto completo. Funciona sorprendentemente bien en la primera entrega.

### B. Parte por parte, refactor al final

El humano pide una pieza, la revisa, pide la siguiente y, cuando todo funciona, pide un refactor general.

| | **A. Generar todo** | **B. Parte por parte** |
| --- | --- | --- |
| Ventaja principal | El problema llega resuelto; poca improvisación | Se entiende lo que se construye; errores tempranos |
| Riesgo principal | El dueño no sabe qué hay dentro | La arquitectura se improvisa pieza a pieza |
| Falla cuando | Hay que cambiar, depurar o escalar | El proyecto crece y el refactor final rompe lo que servía |
| Sensación inicial | "Ya está listo" | "Voy entendiendo" |
| Costo diferido | Deuda de comprensión | Deuda estructural |

---

## 2. Qué cuesta cada extremo

**Deuda de comprensión.** El código funciona y nadie sabe por qué. El día que falla, el dueño no puede diagnosticar; el día que hay que cambiar algo, depende otra vez del agente; el día que el agente no tiene el contexto completo, el cambio rompe algo lejano. No se paga al principio: se paga en la primera urgencia.

**Deuda estructural.** Cada pieza se construyó con la arquitectura que le pareció al agente en ese momento. Al final hay que unificar, y el refactor general toca todo a la vez: es el cambio más grande, con la menor capacidad de verificación y el mayor riesgo. Si algo se rompe, no se sabe qué lo rompió.

Los dos extremos comparten una causa: **las decisiones importantes se toman en el momento equivocado**. En A se toman todas antes de saber nada; en B se van tomando sobre la marcha.

---

## 3. El modelo intermedio

    Fase 0        Fase 1        Fase 2        Fase 3
    Contratos  →  Porción   →   Porción   →   Porción   →  ...
    (humano)      (agente)      (agente)      (agente)
                     ↓             ↓             ↓
                  verificar     verificar     verificar
                     ↓             ↓             ↓
                  refactor      refactor      refactor
                  (cada 2-3 porciones)

- **Fase 0:** el humano decide estructura, contratos y criterios. No escribe código, pero tampoco lo delega.
- **Porciones:** funcionalidad de punta a punta, verificable, que deja el sistema ejecutable.
- **Verificación:** cada porción termina con evidencia, no con una afirmación.
- **Refactor:** continuo y pequeño, nunca una fase final.

**El principio que lo sostiene todo:** el criterio se decide una vez y se escribe; la construcción avanza en porciones verificables.

---

## 4. Principios

1. **Entiende en proporción al riesgo que vas a cargar.** Lo que vas a mantener se entiende a fondo; lo accesorio se aísla con pruebas y se trata como caja negra.
2. **Nada está terminado sin evidencia.** "Ya quedó" no es un criterio de aceptación.
3. **El humano decide la estructura; el agente ejecuta dentro de ella.** Lo que no se escribe antes, el agente lo inventa.
4. **Refactorizar es una tarea, no una fase.** Tiene alcance, evidencia y commit propios.
5. **Una porción, un tema, un commit.** Si algo se rompe, se sabe qué lo rompió.

---

## 5. Qué decide quién

| Decisión | Humano | Agente |
| --- | --- | --- |
| Objetivo y alcance | Sí | No |
| Arquitectura y contratos | Sí | Propone, no decide |
| Criterios de aceptación | Sí | No |
| Implementación de la porción | Aprueba el plan | Sí |
| Verificación | Revisa la evidencia | Ejecuta |
| Merge | Sí | No |

El agente puede proponer y verificar; **no puede aprobar su propio trabajo**. Esa separación es lo que hace confiable el flujo.

---

## 6. Cómo elegir el modo

- **A puro** si el proyecto es desechable, o si existe una suite de pruebas que permita validarlo sin leer el código.
- **B puro** si estás aprendiendo y el objetivo es entender, aceptando el costo de reescritura.
- **Híbrido (por defecto)** si el proyecto se va a mantener, va a crecer o lo va a tocar otra persona.

El modo se declara al inicio. Cambiarlo a mitad de camino sin decirlo es la forma más común de terminar con lo peor de los dos.

---

## 7. Señales de que estás en el extremo equivocado

**Demasiado A:**
- No puedes explicar qué hace un módulo sin abrir el código.
- Cada cambio pequeño requiere pedirle al agente que "revise todo".
- Nadie sabe qué pruebas existen ni qué cubren.

**Demasiado B:**
- Hay tres formas distintas de hacer lo mismo en el mismo proyecto.
- El refactor pendiente lleva semanas creciendo.
- Cada porción nueva toca archivos de porciones anteriores.

En ambos casos, la salida no es empezar de nuevo: es escribir lo que falta (contratos, criterios, pruebas) y seguir desde ahí.

---

## 8. Qué sigue

Si aceptas el modelo, el orden de lectura es:

1. [guia/02-fase-cero.md](../guia/02-fase-cero.md) — qué decides antes de empezar.
2. [guia/03-porciones.md](../guia/03-porciones.md) — cómo se parte el trabajo.
3. [guia/04-verificacion.md](../guia/04-verificacion.md) — qué cuenta como terminado.
