# Ejercicio Final.

En este dia, tenemos los siguientes ejercicios:

- [Ejercicio Final.](#ejercicio-final)
  - [Creando un Namespace:](#creando-un-namespace)
  - [Creando un pod:](#creando-un-pod)
  - [Creando un replicaset:](#creando-un-replicaset)
  - [Creando un deployment:](#creando-un-deployment)
  - [Crea un ServiceAccount:](#crea-un-serviceaccount)
  - [Crea un ClusterRole](#crea-un-clusterrole)
  - [Affinity Rules:](#affinity-rules)
  - [Documentación:](#documentación)




## Creando un Namespace:

Crea un Namespace llamado `ejercicio-final`

## Creando un pod:

Crea un pod que use labels: 
`ejercicio:final`

## Creando un replicaset:

Crea un manifiesto para tener un RS, que se llame `gb-front-end`
Y que use esta imagen: `gcr.io/google_samples/gb-frontend:v3`
Y que tenga `3 replicas`.


## Creando un deployment:

Crea un deployment con 3 replicas, de la imagen nginx, con el comando sleep 3600.

Que incluya el label: 

`tipo: deployment`

Y que se llame: `mi-deployment`



## Crea un ServiceAccount:

Crea un **ServiceAccount** llamado "ejercicio-SA" dentro del namespace: `ejercicio-final`

## Crea un ClusterRole

Crea un **ClusterRole** llamado "ejercicio-clusterrole" que tenga permisos para listar, crear y borrar pods y servicios en **todos los namespaces**

Aplica el Binding apropiado a ese ClusterRole para el ejercicio-SA y ejercicio-clusterrole


## Affinity Rules:

Crea 2 deployments asi:

`app-deployment-1 con 1 replica de la imagen nginx, label: app = deployment1, tier=frontend`
.
`app-deployment-2 con 1 replica de la imagen nginx, label: app = deployment2, tier=backend`



`Deployment 1` debe tener una regla anti-affinity para asegurarse que no corra en el nodo donde corra el `Deployment 2`.
`Deployment 2` debe tener una regla de afinidad, para asegurarse que corra en el mismo nodo donde corra el `Deployment 1`.

## Documentación:

Proporcionar un archivo `PASOS.md` que explique lo que hiciste para lograr cada punto.

> NOTA: Todo debe estar en la carpeta FINAL