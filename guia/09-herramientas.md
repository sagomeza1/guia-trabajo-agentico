# Herramientas

> 🗓️ **Última revisión:** 2026-11-04.

El método es independiente de la herramienta. Pero no todas las herramientas permiten aplicarlo igual. Este documento explica qué pedirle a una y cómo encaja cada tipo.

---

## 1. Qué debe permitir una herramienta agéntica

- **Ver el plan antes de ejecutar.** Sin esto, no hay puerta de aprobación.
- **Mostrar el diff completo**, no un resumen de cambios.
- **Controlar el contexto:** qué archivos ve, cuándo se reinicia la sesión.
- **Ejecutar comandos y ver la salida.** Sin verificación, no hay evidencia.
- **Respetar límites:** rutas, permisos, aprobaciones explícitas.
- **Dejar rastro:** historial de cambios y comandos ejecutados.

Si falta alguna, el flujo se puede hacer igual, pero con más trabajo manual.

---

## 2. Tipos de herramienta

| Tipo | Fortaleza | Debilidad | Encaje |
| --- | --- | --- | --- |
| Agente en el editor | Contexto del proyecto y diff a la vista | Sesiones largas y contexto que crece | Ciclo diario de porciones |
| Agente en terminal | Automatización y comandos | Menos visibilidad del cambio | Tareas repetitivas y scripts |
| Chat sin proyecto | Rápido para dudas | No ve el código real | Diseño, explicación, revisión |
| Agentes en paralelo | Velocidad en tareas independientes | Integración y conflictos | Porciones con cortes limpios |

La regla: **la herramienta debe hacer visible el cambio, no esconderlo**.

---

## 3. Configuración mínima

- Instrucciones del proyecto en un archivo versionado (AGENTS.md o equivalente).
- Comando de verificación único y documentado.
- Linter y formateador configurados antes de la primera porción.
- CI que ejecute la verificación en cada push.
- Permisos declarados: qué puede tocar el agente sin preguntar.

---

## 4. GitHub Copilot en VS Code

Copilot cubre bien el ciclo dentro del editor: planificación, generación, diff y ejecución de comandos. Los detalles de comandos y configuración cambian entre versiones y están documentados en otro repositorio:

- [prompts_vscode](https://github.com/sagomeza1/prompts_vscode) — configuración del entorno, comandos vigentes y flujo de arranque con especificación completa.

Este repositorio no repite esos comandos a propósito: describe el método que se aplica **con** ellos, y qué hacer después del arranque.

---

## 5. Cómo evaluar una herramienta nueva

1. ¿Puedo ver el plan antes de que ejecute?
2. ¿Puedo revisar el diff completo?
3. ¿Puedo limitar qué archivos toca?
4. ¿Puedo ejecutar la verificación desde ahí?
5. ¿Qué pasa cuando la sesión se hace larga?

Si la respuesta a las cinco es sí, la herramienta sirve para este flujo. Si no, sirve para otra cosa.

---

## 6. Qué sigue

El método se completa con los sistemas no deterministas y los riesgos no funcionales: [guia/10-sistemas-no-deterministas.md](../guia/10-sistemas-no-deterministas.md) y [guia/11-riesgos-no-funcionales.md](../guia/11-riesgos-no-funcionales.md). El caso aplicado completo está en [ejemplo/caso-bot-gastos.md](../ejemplo/caso-bot-gastos.md).
