# Guía de trabajo agéntico

Guía práctica para trabajar con agentes de IA en proyectos que se mantienen en el tiempo. No enseña a escribir prompts sueltos: define **cómo se encarga, se construye, se verifica y se cierra** trabajo hecho por un agente.

> 🗓️ **Vigencia:** primera versión, **2026-11-04**. Los comandos concretos de cada herramienta cambian entre versiones; esta guía describe el método, no los botones.

---

## La idea central

**El criterio se decide una vez y se escribe; la construcción avanza en porciones verificables.**

Es el punto medio entre dos extremos que fallan por motivos opuestos:

- **Especificarlo todo y generar todo:** el proyecto sale, pero nadie sabe qué hay dentro. Deuda de comprensión.
- **Hacer parte por parte sin plan:** se entiende cada pieza, pero la arquitectura se improvisa y el refactor final rompe lo que funcionaba.

Este repositorio documenta el modelo híbrido: contratos decididos por el humano, construcción incremental por porciones, verificación con evidencia y refactor continuo.

---

## Para quién es

- Personas que ya usan agentes y quieren dejar de improvisar el flujo.
- Equipos pequeños que necesitan que el trabajo del agente sea revisable.
- Quien viene de "generar todo de una" y descubre que no puede mantener el resultado.

No hace falta experiencia previa con agentes, pero sí haber escrito código o especificaciones alguna vez.

---

## Mapa de la guía

| Documento | Qué resuelve |
| --- | --- |
| [guia/01-modelo-hibrido.md](guia/01-modelo-hibrido.md) | Por qué los dos extremos fallan y cuál es el modelo intermedio. |
| [guia/02-fase-cero.md](guia/02-fase-cero.md) | Qué decides tú antes de que el agente escriba una línea: contratos, criterios, pruebas. |
| [guia/03-porciones.md](guia/03-porciones.md) | Cómo partir el trabajo en porciones verticales y cómo se encarga cada una. |
| [guia/04-verificacion.md](guia/04-verificacion.md) | Qué cuenta como evidencia y cuándo algo está realmente terminado. |
| [guia/05-refactor.md](guia/05-refactor.md) | Cómo refactorizar sin esperar al final y sin romper lo que funciona. |
| [guia/06-contexto.md](guia/06-contexto.md) | Cómo mantener el contexto vivo entre sesiones y evitar que el agente olvide. |
| [guia/07-delegacion.md](guia/07-delegacion.md) | Anatomía de un brief, niveles de autonomía, permisos y trabajo en paralelo. |
| [guia/08-antipatrones.md](guia/08-antipatrones.md) | Los diez errores que más caro salen, con su antídoto. |
| [guia/09-herramientas.md](guia/09-herramientas.md) | Qué pedirle a una herramienta agéntica y cómo encaja cada tipo. |
| [guia/10-sistemas-no-deterministas.md](guia/10-sistemas-no-deterministas.md) | Cómo se verifica lo que no da siempre la misma salida: eval sets e intervalos. |
| [guia/11-riesgos-no-funcionales.md](guia/11-riesgos-no-funcionales.md) | Privacidad, seguridad, coste, latencia y dependencia del proveedor. |
| [ejemplo/caso-bot-gastos.md](ejemplo/caso-bot-gastos.md) | El método aplicado de principio a fin sobre un proyecto pequeño. |
| **plantillas/** | Plantillas listas para copiar: brief, plan, decisiones, AGENTS, objetivos y especificaciones. |

---

## Ruta recomendada

1. [guia/01-modelo-hibrido.md](guia/01-modelo-hibrido.md) — para entender la decisión de fondo.
2. [guia/02-fase-cero.md](guia/02-fase-cero.md) — para arrancar un proyecto sin improvisar.
3. [guia/03-porciones.md](guia/03-porciones.md) y [guia/04-verificacion.md](guia/04-verificacion.md) — el ciclo diario.
4. [guia/06-contexto.md](guia/06-contexto.md) — cuando la sesión empieza a degradarse.
5. [ejemplo/caso-bot-gastos.md](ejemplo/caso-bot-gastos.md) — para ver todo junto antes de aplicarlo.

---

## Inicio rápido en cinco pasos

1. Escribe **objetivos-proyecto.md** y **especificaciones-proyecto.md** (plantillas incluidas).
2. Define los contratos: módulos, interfaces, modelo de datos y criterios de aceptación.
3. Parte el trabajo en porciones que quepan en una sesión y en un commit.
4. Para cada porción: brief, plan aprobado, implementación, verificación, diff revisado, explicación.
5. Refactoriza cada dos o tres porciones, con la suite en verde antes y después.

Si un paso no deja evidencia, no está hecho.

---

## Qué no es este repositorio

- **No es un recetario de comandos.** Los comandos de cada herramienta cambian; el método no.
- **No es una copia de [prompts_vscode](https://github.com/sagomeza1/prompts_vscode).** Ese repositorio cubre la configuración de GitHub Copilot en VS Code y el arranque con especificación completa. Este cubre el ciclo de trabajo completo, con énfasis en la construcción incremental.
- **No promete autonomía total.** Un agente que se aprueba a sí mismo no es un agente confiable.

---

## Verificación del repositorio

Los cambios de documentación se comprueban antes de cerrar:

    bash scripts/check-links.sh

Valida archivos obligatorios, un solo H1 por documento y enlaces relativos. Corre también en CI en cada push a **main** y en cada pull request.

---

## Licencia

Contenido bajo [Creative Commons Attribution 4.0 International](LICENSE). Puedes reutilizarlo y adaptarlo citando a **sagomeza1** e indicando si hubo cambios.
