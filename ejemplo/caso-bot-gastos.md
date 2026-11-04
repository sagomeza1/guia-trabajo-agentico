# Caso completo: bot de gastos

> 🗓️ **Última revisión:** 2026-11-04.

El método aplicado sobre un proyecto pequeño y realista. Sirve como referencia de qué se escribe, qué se pide y qué se verifica en cada paso.

> Proyecto: registrar gastos personales desde la terminal, listarlos por mes y totalizar por categoría. Un solo usuario, datos locales, sin servidor.

---

## 1. Fase 0

### objetivos-proyecto.md (resumen)

- **Problema:** registrar gastos en notas sueltas impide saber en qué se va el dinero.
- **Objetivo:** registrar un gasto en menos de 10 segundos y consultar el total del mes.
- **Incluye:** alta, listado por mes, total por categoría.
- **Fuera de alcance:** presupuestos, multi-usuario, sincronización, interfaz gráfica.
- **Éxito:** 30 gastos registrados en un mes, total correcto al céntimo.

### Contratos

    RegistroGasto
        crear(fecha, monto, categoria, nota) -> Gasto
        listar(desde, hasta) -> Lista<Gasto>
        totalPorCategoria(desde, hasta) -> Mapa<categoria, Monto>

    Reglas
        monto > 0
        fecha <= hoy
        categoria en {comida, transporte, vivienda, ocio, otros}

### Decisiones iniciales

- Almacenamiento: archivo JSON local. Motivo: volumen bajo, cero instalación. Se revisa si se superan 10.000 registros.
- Interfaz: línea de comandos. Motivo: el objetivo es rapidez de registro.
- Pruebas: pytest, con un archivo temporal por prueba.

### Estrategia de pruebas

- Unitarias: validaciones y cálculos de totales.
- Integración: alta y listado sobre el archivo temporal.
- Manual: revisar que el comando sea cómodo de usar.

---

## 2. Plan de porciones

    - [x] 1. Registrar gasto con validaciones
    - [x] 2. Listar gastos del mes
    - [ ] 3. Total por categoría
    - [ ] 4. Exportar a CSV
    - [ ] 5. Refactor de la capa de almacenamiento

Cada una deja el sistema ejecutable. La 5 no agrega funcionalidad: paga la deuda acumulada por las tres primeras.

---

## 3. Porción 1: registrar gasto

**Brief**

    Objetivo: registrar un gasto desde la terminal y guardarlo en el archivo de datos.
    Contexto: lee AGENTS.md y las especificaciones. No hay código todavía.
    Alcance: crear src/, src/gastos/, la interfaz de registro y su prueba.
    No tocar: nada fuera de src/.
    Criterio de done: "gasto 25000 comida" guarda un registro válido; "gasto -5 comida" falla sin escribir.
    Evidencia: salida de pytest y diff del primer commit.

**Qué salió mal en el primer intento**

El agente implementó la validación de fecha comparando con la fecha del sistema en UTC, y a las 20:00 en Bogotá rechazaba gastos del mismo día. No era un error de código: era un contrato incompleto. La regla decía "fecha <= hoy" sin decir en qué zona horaria.

**Corrección:** se actualizó el contrato ("fecha <= hoy en la zona del usuario") y se agregó la prueba del caso. La lección quedó en **decisiones.md**.

---

## 4. Porción 2: listar por mes

**Brief**

    Objetivo: que "listar --mes 2026-11" muestre los gastos de ese mes, ordenados por fecha.
    Contexto: la porción 1 dejó el registro y el archivo de datos.
    Alcance: src/gastos/listar.py, el subcomando en cli.py y sus pruebas.
    No tocar: el formato del archivo ni el módulo de registro.
    Criterio de done: con tres gastos de octubre y dos de noviembre, devuelve exactamente dos, en orden.
    Evidencia: salida de pytest con la prueba nueva.

**Revisión del diff:** apareció un cambio no pedido en el módulo de registro (un "pequeño arreglo de estilo"). Se revirtió y se anotó como deuda para el refactor. El alcance se respetó después.

---

## 5. Porción 3: total por categoría

Antes de pedirla, el agente propone el plan:

1. Agregar totalPorCategoria al contrato y a la implementación.
2. Reutilizar el filtro por rango de fechas de la porción 2.
3. Agregar prueba con tres categorías y un mes vacío.
4. Exponer "total --mes" en la CLI.

Se aprueba. La implementación reutiliza el filtro en lugar de duplicarlo: buena señal de que los contratos estaban bien.

---

## 6. Refactor (porción 5)

Después de tres porciones, el archivo de almacenamiento tiene tres funciones que abren y cierran el archivo por su cuenta.

**Alcance:** extraer una capa de almacenamiento con lectura y escritura únicas. **Sin cambios de comportamiento.**
**Criterio de done:** las 14 pruebas existentes pasan sin modificarse.
**Evidencia:** pytest en verde antes y después, diff separado del de funcionalidad.

Resultado: el módulo de reportes deja de conocer el formato del archivo. La siguiente funcionalidad (CSV) se vuelve trivial.

---

## 7. Qué demuestra el caso

- La Fase 0 evita el error de zona horaria antes de que exista el código.
- Las porciones pequeñas hacen visible el cambio no pedido.
- La verificación con pruebas convierte "creo que funciona" en "esto falla si se rompe".
- El refactor a tiempo evita el refactor final.
- La deuda anotada no se olvida: se paga en una porción propia.

---

## 8. Qué habría pasado con los extremos

- **Generar todo de una:** el error de zona horaria habría quedado enterrado en 600 líneas, sin prueba que lo delatara.
- **Parte por parte sin plan:** el archivo de datos habría tenido tres formatos distintos y el refactor final habría tocado todo a la vez.
