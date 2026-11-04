# Plantilla: AGENTS.md

Archivo que leen los agentes antes de tocar el proyecto. Corto, concreto y actualizado.

    # AGENTS.md

    ## Qué es este proyecto
    [Una o dos frases: qué hace y para quién.]

    ## Mapa
    | Ruta | Contenido |
    | --- | --- |
    | src/ | Código de aplicación |
    | tests/ | Pruebas |
    | docs/ | Especificaciones y decisiones |

    ## Reglas
    - Lenguaje y versión: [ej. Python 3.12]
    - Estilo: [linter y formateador, con comando]
    - Idioma del código: [inglés / español]
    - Manejo de errores: [excepciones / resultados]
    - Dependencias nuevas: [permitidas / requieren aprobación]

    ## Verificación obligatoria
        [comando único de pruebas y linter]

    Si falla, el trabajo no está terminado.

    ## No tocar
    - [Rutas o archivos]
    - [Configuración de CI]
    - [Credenciales y variables de entorno]

    ## Antes de cerrar
    1. Verificación en verde y salida pegada.
    2. Diff completo revisado.
    3. plan.md y decisiones.md actualizados.
    4. Commit en imperativo, un tema por commit.

---

## Reglas para mantenerlo útil

- Menos de una pantalla.
- Solo lo que cambia el comportamiento del agente.
- Si una regla no admite excepciones, llévala a un lint o a CI.
- Actualizarlo es parte de cerrar una porción.
