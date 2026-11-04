# Plantilla: registro de decisiones

Registro ligero de arquitectura. Una entrada por decisión, cuatro líneas. No es un ensayo: es memoria para la próxima sesión.

    ### [Fecha] — [Decisión en una frase]
    Motivo: [por qué se eligió]
    Alternativa descartada: [qué se consideró y por qué no]
    Revisar si: [condición que obligaría a reconsiderarla]

---

## Ejemplo

    ### 2026-11-04 — Archivo JSON en lugar de base de datos
    Motivo: volumen bajo y cero instalación para un solo usuario.
    Alternativa descartada: SQLite, por costo de migración y dependencia extra.
    Revisar si: se superan 10.000 registros o aparece un segundo usuario.

---

## Cuándo escribir una entrada

- Se elige una tecnología o una estructura.
- Se descarta una alternativa que alguien podría querer retomar.
- Se acepta una limitación consciente.
- Se cambia una regla de la especificación.

## Cuándo no

- Decisiones reversibles y locales (nombre de una variable).
- Detalles que ya están en el código o en el commit.
