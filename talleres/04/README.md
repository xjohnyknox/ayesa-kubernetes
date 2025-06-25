# Ejercicios Dia 04.

En este dia, tenemos los siguientes ejercicios:

- [Ejercicios Dia 04.](#ejercicios-dia-04)
  - [1-event-simulator](#1-event-simulator)
  - [2-configurar-volumen](#2-configurar-volumen)
  - [3-crear-pv](#3-crear-pv)
  - [4-crear-pvc](#4-crear-pvc)
  - [5-usando-pvc-en-webapp](#5-usando-pvc-en-webapp)
  - [6-preguntas](#6-preguntas)
  - [7-Storage-Class](#7-storage-class)
  - [8-despliegue-nginx](#8-despliegue-nginx)


## 1-event-simulator

Crea un pod llamado: `simulador-eventos`
Que use la imagen: `kodekloud/event-simulator`

Revisa si esta corriendo, y los logs que arroja.

**PREGUNTA:**
Si se elimina el pod, los logs se quedan o se borran?

## 2-configurar-volumen

Configura un volumen para almacenar estos logs en la carpeta dentro del nodo en k8s `/var/log/webapp` de nombre: `webapp`, con un VolumeMount: `/log`

Recuerda que esto es del tipo `hostPath`.

Revisa si se ven los logs.

## 3-crear-pv

Crear un `PersistentVolume` con los siguientes datos:
**PV Name:** pv-log
**Storage:** 100Mi
**Access Modes:** ReadWriteMany
**HostPath:** /pv/log
**Reclaim Policy:** Retain

## 4-crear-pvc

Crear un `PersistentVolumeClaim` con los siguientes datos:
`PVC Name:` claim-log-1
`Storage:` 50Mi
`Access Modes:` ReadWriteOnce

Ahora revisa el estado de los PV y PVC

**PREGUNTAS:**
1. Notas algo raro? Arreglalo.
2. Solicitamos `50Mi`, que capacidad tiene ahora el **PVC**?

## 5-usando-pvc-en-webapp

Reemplaza el `hostPath` del `simulador-eventos` con el nuevo `PVC`, con estos datos:
**Nombre:** webapp
**Imagen:** kodekloud/event-simulator
**Volume PersistentVolumeClaim** = claim-log-1
**Volume Mount:** /log

> Confirma que este sirviendo

## 6-preguntas

En base a lo hecho hasta ahora, vamos a responder estas preguntas:

1. Cuál es la **Reclaim Policy** para el **PV** `pv-log` ?


2. Qué pasa al PV si el PVC se elimina?

- [ ] No se borra, pero no queda disponible.
- [ ] Se borra el PV también.
- [ ] El PV queda disponible de nuevo.
- [ ] El PV se daña.


3. Intenta borrar el **PVC** y mira que pasa.

4. Por qué queda en ese estado?

R. Porque esta amarrado aún al pod en uso

5. Borra el pod, y mira qué pasó con el **PVC** ?

6. Ahora mira que pasa con el PV (Status) ?


## 7-Storage-Class

1. Cuántas StorageClasses hay en el cluster?

2. Cuál es el nombre del SC que no soporta aprovisionamiento de volúmenes dinámicos?

R. local-storage

3. Crea un nuevo storageclass asi:
   
**Nombre:** delayed-volume-sc
**Provisioner:** kubernetes.io/no-provisioner
**VolumeBindingMode:** WaitForFirstConsumer

## 8-despliegue-nginx

Crea un despliegue llamado **nginx**, con la imagen de **nginx-alpine** que haga uso de un **local-pvc** y haga un mount en el path **/var/www/html**
Debe quedar en estado **bound**
