# Fase 0: contratos y esqueleto

La Fase 0 es la única parte del trabajo que no se delega. No escribe código: escribe las decisiones que hacen que el código se pueda construir por partes sin que todo se acople.

> Si esta fase queda vacía, el agente la completará por su cuenta, y lo hará de forma plausible pero arbitraria.

---

## 1. Qué se decide

### 1.1 Módulos y responsabilidades

Qué hace cada módulo y, sobre todo, **qué no hace**. Un módulo con dos responsabilidades es dos módulos que aún no se separaron.

### 1.2 Contratos entre módulos

Firmas de funciones, esquemas de datos y formato de las interfaces. Es lo que permite que dos porciones construidas en semanas distintas encajen.

    interfaz RegistroGasto:
        crear(fecha, monto, categoria, nota) -> Gasto
        listar(desde, hasta) -> Lista<Gasto>
        total(desde, hasta) -> Monto

    reglas:
        monto > 0
        categoria ∈ {comida, transporte, vivienda, otros}
        fecha no puede ser futura

El contrato no necesita implementación: necesita ser explícito.

### 1.3 Criterios de aceptación

Una frase verificable por módulo o por porción. "Verificable" significa que alguien puede decir sí o no sin opinar.

| Mal criterio | Buen criterio |
| --- | --- |
| "Debe funcionar rápido" | "Listar 1.000 gastos en menos de 300 ms" |
| "Debe tener pruebas" | "Cobertura de líneas ≥ 80% en el módulo de gastos" |
| "Debe validar los datos" | "Monto ≤ 0 devuelve error de validación y no guarda" |
| "Interfaz amigable" | "Crear un gasto requiere máximo 3 pasos desde el inicio" |

### 1.4 Estrategia de pruebas

Qué se prueba y con qué. No hace falta una pirámide perfecta; hace falta saber dónde duele si algo falla.

- **Unitarias:** reglas de negocio puras (validaciones, cálculos).
- **Integración:** el contrato entre dos módulos.
- **Extremo a extremo:** el flujo principal del usuario, uno o dos, no todos.
- **Manual:** lo que no vale la pena automatizar, declarado como tal.

### 1.5 Estructura y convenciones

- Carpetas y nombres.
- Idioma del código y de los mensajes.
- Manejo de errores: excepciones, códigos de retorno o resultados.
- Formato de logs.
- Herramientas obligatorias: linter, formateador, versión del lenguaje.

### 1.6 Fuera de alcance

Lo que **no** se va a hacer, escrito. Es la sección que evita que el agente "mejore" el proyecto por su cuenta.

---

## 2. La trampa de los criterios blandos

Un criterio que no se puede refutar no es un criterio. Si al terminar la porción la respuesta honesta es "bueno, más o menos", el criterio estaba mal escrito.

Regla práctica: **si no puedes imaginar la prueba que lo demuestra, no está listo.**

---

## 3. Salida de la fase

Tres documentos, cortos:

1. **objetivos-proyecto.md** — qué se construye, para quién y qué queda fuera.
2. **especificaciones-proyecto.md** — stack, arquitectura, contratos, criterios y estrategia de pruebas.
3. **plan.md** — lista de porciones con estado.

Plantillas en **plantillas/objetivos-proyecto.md** y **plantillas/especificaciones-proyecto.md**.

---

## 4. Puerta de salida

La Fase 0 termina cuando puedes responder sin dudar:

- ¿Cuáles son los módulos y qué hace cada uno?
- ¿Cuál es el contrato entre ellos?
- ¿Cómo se comprueba que una porción está bien?
- ¿Qué queda explícitamente fuera?

Si alguna respuesta es "depende", todavía no terminó.

---

## 5. Errores típicos

- **Escribir la Fase 0 y no usarla.** Si el agente nunca la lee, es decoración.
- **Contratos tan detallados que son código.** El contrato describe qué, no cómo.
- **Criterios que solo el humano entiende.** Si no se puede convertir en una prueba, no sirve.
- **Dejar la arquitectura "para cuando haga falta".** Se decide justo cuando hay prisa, que es el peor momento.

---

## 6. Qué sigue

Con los contratos escritos, el trabajo se parte en porciones: **guia/03-porciones.md**.
