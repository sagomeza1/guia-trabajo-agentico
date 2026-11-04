# Antipatrones

Los diez errores que más caro salen al trabajar con agentes. Cada uno con síntoma, causa y antídoto.

---

## 1. Big bang

**Síntoma:** una sola petición produce veinte archivos y nadie sabe por dónde empezar.
**Causa:** se confunde "especificar bien" con "entregar todo de una".
**Antídoto:** contratos completos, construcción por porciones.

---

## 2. Refactor final

**Síntoma:** "cuando termine, que lo ordene todo".
**Causa:** se pospone la estructura porque no se ve el beneficio inmediato.
**Antídoto:** refactor cada dos o tres porciones, con la suite en verde.

---

## 3. Prompt vago

**Síntoma:** el resultado es plausible pero no es lo que pedías.
**Causa:** falta objetivo, contexto o criterio de done.
**Antídoto:** el brief de seis partes de **guia/07-delegacion.md**.

---

## 4. Criterio que no se puede refutar

**Síntoma:** discusiones de opinión al final de cada porción.
**Causa:** "debe ser rápido", "debe quedar limpio", "debe tener pruebas".
**Antídoto:** toda aceptación se convierte en una prueba o en un número.

---

## 5. Confiar sin revisar

**Síntoma:** el agente dice "listo", se hace commit y dos días después algo falla.
**Causa:** se acepta una afirmación como evidencia.
**Antídoto:** puerta de verificación con salida reproducible.

---

## 6. El agente aprueba su propio trabajo

**Síntoma:** el mismo actor implementa, verifica y decide que está bien.
**Causa:** comodidad.
**Antídoto:** separación de roles: el agente verifica, el humano aprueba.

---

## 7. Mezclar temas en un cambio

**Síntoma:** un commit que arregla un bug, renombra un módulo y actualiza dependencias.
**Causa:** "ya que estaba".
**Antídoto:** un tema por commit; lo demás se anota y se hace aparte.

---

## 8. Contexto infinito

**Síntoma:** sesiones de horas donde el agente repite decisiones y contradice el plan.
**Causa:** se arrastra toda la conversación en vez de resumir el estado.
**Antídoto:** una sesión por porción y documentos de contexto vivos.

---

## 9. Pruebas después

**Síntoma:** "primero que funcione, luego escribimos las pruebas".
**Causa:** la prueba se ve como trámite.
**Antídoto:** la prueba es el criterio de done, no un extra.

---

## 10. Documentación muerta

**Síntoma:** el AGENTS.md describe una arquitectura que ya no existe.
**Causa:** se actualiza solo cuando hay tiempo.
**Antídoto:** actualizar los documentos es parte de cerrar la porción.

---

## Tabla de bolsillo

| Si ves esto | Probablemente es | Haz esto |
| --- | --- | --- |
| "Ya quedó" | Falta de evidencia | Pide salida de comando |
| Diff enorme | Porción mal cortada | Parte en dos |
| Tres formas de lo mismo | Falta de contratos | Vuelve a Fase 0 |
| El agente pregunta todo | Brief incompleto | Añade alcance y límites |
| El agente decide todo | Brief sin criterios | Define el done |
| Todo se rompe al refactorizar | No hay suite | Pruebas primero |

---

## Qué sigue

Para elegir la herramienta adecuada: **guia/09-herramientas.md**.
