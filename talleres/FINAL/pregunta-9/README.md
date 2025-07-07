## Contexto del Ejercicio
Un pod llamado `broken-app` en el namespace `production` está fallando al iniciar. Los logs muestran errores de "permission denied" (permisos denegados) cuando intenta escribir en el archivo `/var/log/app.log`.

## Tareas a Realizar

### Parte 1: Diagnóstico del Problema
Ya identificaste el problema:

- **Namespace:** `production`
- **Pod afectado:** `broken-app`
- **Problema:** El pod no puede escribir en `/var/log/app.log` debido a permisos insuficientes

### Parte 2: Implementar la Solución
- **Requisito:** El pod debe ejecutarse como usuario ID 1000
- **Objetivo:** Permitir que el pod pueda escribir correctamente en el archivo de log
- **Herramienta:** Configurar el contexto de seguridad (securityContext) del pod

## Pista Importante
El contexto de seguridad se puede configurar tanto a nivel de pod como a nivel de contenedor. Asegúrate de verificar la configuración del `securityContext` y establecer el parámetro `runAsUser: 1000`.

