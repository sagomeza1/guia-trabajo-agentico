# Riesgos no funcionales

Privacidad, seguridad, coste, latencia y dependencia del proveedor no son "temas de producción": son requisitos que se deciden en la Fase 0 o se descubren en el peor momento. En un chatbot de atención al cliente pesan tanto como la calidad de la respuesta.

---

## 1. Por qué van en la Fase 0

Un requisito no funcional que aparece después obliga a rediseñar. Ejemplos reales:

- El proveedor no firma el acuerdo de tratamiento de datos y hay que cambiar de modelo en la semana del lanzamiento.
- El coste por conversación resulta diez veces mayor que el ingreso por cliente.
- El p95 de latencia duplica el tiempo de espera aceptable en el canal.
- Los registros guardan datos personales durante un año y nadie lo había decidido.

Ninguno es un bug: son decisiones que faltaban.

---

## 2. Privacidad y datos

Preguntas que deben tener respuesta escrita:

- ¿Qué datos personales entran al sistema y cuáles se envían al proveedor del modelo?
- ¿Se guardan prompts y respuestas? ¿Dónde, cuánto tiempo y quién accede?
- ¿El proveedor entrena con los datos? ¿Se puede desactivar?
- ¿En qué región se procesan los datos y qué exige la normativa aplicable?
- ¿Cómo se atiende el derecho de acceso, corrección y borrado?
- ¿Hay minimización: se envía solo lo necesario o el historial completo?
- ¿Los logs están enmascarados?

Mitigaciones típicas: anonimizar antes de enviar, retención corta, campos sensibles fuera del prompt, proveedor con retención cero, cifrado en reposo y en tránsito, registro de accesos.

**Evidencia:** documento de flujo de datos, configuración del proveedor y prueba de que el enmascarado funciona.

---

## 3. Seguridad

- **Inyección de prompts:** contenido del usuario o de documentos que intenta cambiar instrucciones. Se mitiga con separación de roles, validación de salida y permisos mínimos de herramientas.
- **Exfiltración:** el modelo revela instrucciones, datos de otros usuarios o secretos. Se mitiga con aislamiento por sesión y sin secretos en el contexto.
- **Herramientas:** cada herramienta que el agente puede llamar es superficie de ataque. Permisos mínimos, confirmación en acciones irreversibles.
- **Contenido generado:** enlaces, código o comandos que se ejecutan. Nunca ejecutar salida del modelo sin validación.
- **Abuso:** coste por denegación de servicio, automatización masiva, evasión de límites.

**Evidencia:** pruebas de inyección en el eval set, lista de herramientas y permisos, prueba de que un usuario no ve datos de otro.

---

## 4. Coste

- **Coste por conversación:** tokens de entrada, salida, herramientas y reintentos.
- **Presupuesto por release y por día**, con alerta al superarlo.
- **Palancas:** caché de respuestas, resumen de contexto, modelos más pequeños para tareas simples, límite de turnos y de longitud.
- **Coste de evaluar:** el eval set consume tokens; va en el presupuesto.
- **Coste oculto:** reintentos, streaming interrumpido, almacenamiento de logs.

**Evidencia:** coste medio medido en el eval set, y una prueba con el tráfico esperado.

---

## 5. Latencia y disponibilidad

- Define **p95**, no promedio: el usuario sufre la cola.
- Diferencia tiempo hasta el primer token y tiempo total.
- Timeouts, reintentos con retroceso y mensaje de degradación.
- Límites de tasa del proveedor y plan de contingencia.
- Modo degradado: respuesta sin modelo, respuesta enlatada o traslado a humano.

**Evidencia:** medición de p95 con carga representativa y prueba del modo degradado.

---

## 6. Calidad en el tiempo

- El proveedor cambia versiones y ajusta modelos sin avisar.
- El tráfico real cambia: nuevas preguntas, nuevos productos, nuevas estafas.
- Los prompts se acumulan y se contradicen.

Mitigación: versión del modelo fijada, eval set mensual con casos nuevos del tráfico real, monitoreo de tasa de fallback y de quejas.

---

## 7. Cumplimiento y transparencia

- Aviso claro de que se habla con un sistema automatizado, cuando aplique.
- Límites de dominio: qué no se responde (salud, legal, financiero) y cómo se deriva.
- Conservación de conversaciones según política, no por defecto.
- Sectores regulados: requisitos adicionales de auditoría y explicabilidad.

---

## 8. Dependencia del proveedor

- Aísla la llamada al modelo detrás de una interfaz propia.
- Versiona prompts como código.
- Mantén un eval set que permita comparar proveedores.
- Prueba una sustitución antes de necesitarla.

---

## 9. Cómo se integran en el flujo

1. En la Fase 0: lista de riesgos con dueño, mitigación y evidencia.
2. En cada porción: se marcan los riesgos que toca y la evidencia que deja.
3. En la puerta de release: coste, p95, privacidad y seguridad tienen su propia comprobación.
4. En el registro de decisiones: cada aceptación consciente de riesgo queda escrita.

---

## 10. Checklist

- [ ] Flujo de datos documentado y minimizado.
- [ ] Retención definida y aplicada.
- [ ] Proveedor sin entrenamiento con los datos, o decisión consciente.
- [ ] Pruebas de inyección y de aislamiento entre usuarios.
- [ ] Coste medio y presupuesto con alerta.
- [ ] p95 medido y modo degradado probado.
- [ ] Versión del modelo fijada.
- [ ] Aviso de automatización y límites de dominio.
- [ ] Sustitución de proveedor probada al menos una vez.
