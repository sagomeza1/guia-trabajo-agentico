# AGENTS.md

Guía para agentes que editen este repositorio. Es documentación en español; no hay código de aplicación.

## Qué es este repositorio

Guía de trabajo agéntico: método híbrido para encargar, construir, verificar y cerrar trabajo hecho con agentes de IA. El documento central es [guia/01-modelo-hibrido.md](guia/01-modelo-hibrido.md); el resto lo desarrolla.

## Mapa de archivos

| Archivo | Contenido |
| --- | --- |
| **README.md** | Entrada, mapa, ruta de lectura e inicio rápido. |
| [guia/01-modelo-hibrido.md](guia/01-modelo-hibrido.md) | Los dos extremos, el modelo intermedio y sus principios. |
| [guia/02-fase-cero.md](guia/02-fase-cero.md) | Contratos, criterios de aceptación y estrategia de pruebas. |
| [guia/03-porciones.md](guia/03-porciones.md) | Porciones verticales, brief y bucle de trabajo. |
| [guia/04-verificacion.md](guia/04-verificacion.md) | Evidencia, puertas de calidad y revisión del diff. |
| [guia/05-refactor.md](guia/05-refactor.md) | Refactor continuo y protocolo seguro. |
| [guia/06-contexto.md](guia/06-contexto.md) | Contexto vivo, sesiones y documentos de proyecto. |
| [guia/07-delegacion.md](guia/07-delegacion.md) | Briefs, autonomía, permisos y paralelismo. |
| [guia/08-antipatrones.md](guia/08-antipatrones.md) | Errores frecuentes y antídotos. |
| [guia/09-herramientas.md](guia/09-herramientas.md) | Criterios para elegir y configurar herramientas. |
| [guia/10-sistemas-no-deterministas.md](guia/10-sistemas-no-deterministas.md) | Evals, criterios estadísticos y dobles de prueba para sistemas con LLM. |
| [guia/11-riesgos-no-funcionales.md](guia/11-riesgos-no-funcionales.md) | Privacidad, seguridad, coste, latencia y proveedor. |
| [ejemplo/caso-bot-gastos.md](ejemplo/caso-bot-gastos.md) | Caso completo, determinista. |
| [ejemplo/caso-asistente-soporte.md](ejemplo/caso-asistente-soporte.md) | Caso completo con LLM. |
| **plantillas/** | Plantillas copiables. |
| **CHANGELOG.md** | Historial de cambios. |
| **LICENSE** | CC BY 4.0, texto legal canónico. |

## Reglas de edición

- Español neutro y tuteo consistente. Sin anglicismos innecesarios; los términos técnicos se dejan en su forma original.
- Un solo H1 por archivo. Secciones en H2 y sin saltar niveles.
- Enlaces relativos entre documentos, nunca rutas absolutas.
- No dupliques contenido: si el tema ya existe en otro documento, enlázalo.
- No inventes comandos, versiones ni cifras. Si algo no está verificado, dilo explícitamente.
- Todo documento que describa comandos lleva su fecha de verificación.
- Este repositorio describe el método. Los detalles de una herramienta concreta van en [guia/09-herramientas.md](guia/09-herramientas.md) y, si son extensos, se enlazan al repositorio que los cubre.

## Flujo de trabajo

Antes de empezar: alcance, contexto, especificación, plan aprobado, implementación, verificación y cierre. No empieces por la implementación. El detalle está en [guia/03-porciones.md](guia/03-porciones.md).

## Verificación obligatoria

Antes de declarar terminado cualquier cambio:

    bash scripts/check-links.sh

Comprueba archivos obligatorios, un solo H1 por documento y enlaces relativos. Si falla, el trabajo no está terminado. En CI corre en cada push a **main** y en cada pull request.

## Antes de cerrar un cambio

1. Ejecuta la verificación y mira la salida.
2. Añade la entrada correspondiente en **CHANGELOG.md**.
3. Revisa el diff completo, no solo los archivos que tocaste.
4. Commits en español, en imperativo y con alcance claro.
5. Un pull request por tema; no mezcles correcciones con reescrituras.

## No tocar

- **LICENSE**: es el texto legal canónico de CC BY 4.0.
- No reformatees documentos completos solo por estilo; genera ruido en el diff.
- No modifiques el workflow de CI para saltarte una verificación que falla.
- No copies contenido de **prompts_vscode**; enlázalo.
