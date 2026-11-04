# Refactor continuo

El refactor al final del proyecto es el cambio más grande, con la menor verificación y el mayor riesgo. Este documento propone hacerlo en dosis pequeñas, todo el tiempo.

---

## 1. Por qué no al final

- **Es el cambio más grande:** toca todo a la vez.
- **Tiene la menor red:** si no había pruebas antes, no hay forma de saber qué se rompió.
- **Llega cuando hay prisa:** el proyecto "ya funciona" y hay que entregar.
- **Mezcla dos objetivos:** mejorar la estructura y no cambiar el comportamiento, con el mismo diff.

El resultado típico: un refactor que arregla tres cosas y rompe dos que nadie notó.

---

## 2. Cadencia

- Refactoriza **cada dos o tres porciones**.
- Antes y después: la suite en verde.
- El refactor es **una porción propia**: alcance, criterio y commit separados.
- Si no hay suite, el primer trabajo es tenerla. Refactorizar sin pruebas es reescribir a ciegas.

---

## 3. Señales de que toca refactorizar

- La misma lógica aparece en tres lugares.
- Un módulo cambió por motivos de otros dos.
- Agregar una porción pequeña obliga a tocar cinco archivos.
- Hay nombres que ya no describen lo que hacen.
- Cuesta explicar el flujo sin dibujar flechas.

Ninguna es una emergencia. Todas se acumulan.

---

## 4. Protocolo seguro

1. **Define el alcance:** qué se mueve, qué se renombra, qué se extrae. Y qué **no** cambia.
2. **Verifica que el comportamiento no cambia:** la suite debe estar en verde antes de empezar.
3. **Un paso mecánico a la vez:** mover, renombrar, extraer. No rediseñar en el mismo paso.
4. **Commit por paso.** Si algo falla, se revierte ese paso, no todo.
5. **Verifica después de cada paso**, no al final.
6. **Documenta la decisión** en **decisiones.md** si cambia la estructura.

---

## 5. Refactor contra reescritura

| Refactor | Reescritura |
| --- | --- |
| Comportamiento constante | Comportamiento puede cambiar |
| Pasos pequeños y verificables | Todo o nada |
| Se puede revertir por partes | Difícil de revertir |
| Se hace con la suite en verde | A menudo sin red |

Si necesitas una reescritura, trátala como un proyecto nuevo: Fase 0, porciones, verificación. No la llames refactor.

---

## 6. La regla del boy scout, con límite

"Deja el código mejor de lo que lo encontraste" es buena regla y mala excusa: no autoriza a limpiar todo lo que se ve.

- Sí: renombrar una variable confusa en el archivo que estás tocando.
- No: reformatear un módulo entero "ya que estaba".
- Sí: extraer una función que apareció por tercera vez.
- No: rediseñar la capa de datos mientras arreglas un bug.

El límite es el diff que se puede revisar en una sentada.

---

## 7. Deuda registrada

Cuando detectes deuda y decidas no pagarla ahora:

- Anótala en **decisiones.md** o en el plan, con motivo y costo estimado.
- Si es un riesgo, conviértela en porción.
- Si es cosmética, déjala escrita y sigue.

La deuda no registrada es la que se olvida hasta que duele.

---

## 8. Qué sigue

El refactor y la verificación dependen del contexto que el agente tiene disponible: [guia/06-contexto.md](../guia/06-contexto.md).
