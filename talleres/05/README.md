# Ejercicios Dia 05.

En este dia, tenemos los siguientes ejercicios:

- [Ejercicios Dia 05.](#ejercicios-dia-05)
  - [1-comandos](#1-comandos)
    - [4.yaml](#4yaml)
  - [2-configmaps](#2-configmaps)
  - [3-redis](#3-redis)
  - [4-secrets](#4-secrets)
    - [1](#1)
    - [2](#2)
    - [3](#3)
  - [4](#4)
  - [5](#5)


## 1-comandos

Vamos a ver como funciona ejecutar comandos dentro de un pod, de diferentes maneras.

Revisa y aplica cada manifiesto.

### 4.yaml

Crear manifiesto que corra un Pod, llamado ejercicio4
En ese pod, tener 3 contenedores asi:
 1. ubuntu, con la imagen ubuntu:latest
 2. debian, con la imagen debian:latest
 3. oraclelinux, con la imagen oraclelinux:8
 Y que en cada uno muestre su version del sistema

## 2-configmaps

Vamos a crear un configMap asi:

`kubectl create configmap game-config --from-file=./`

Ahora vamos a ver como lo creo:

`kubectl describe configmap game-config`

Sigamos, en este caso viendo como podemos crear un configmap desde un archivo con variables de entorno:

Crea un archivo llamado: `game-env-file.properties`, con este contenido:

```
enemies=aliens
lives=3
allowed="true"
```

Y aplicalo a un nuevo configmap:

```
kubectl create configmap game-config-env-file --from-env-file=./game-env-file.properties
```

Y ya que hablamos de juegos, podemos usar el valor literal desde la terminal, para crear configmaps.

`kubectl create configmap special-config --from-literal=player.name=pepito --from-literal=player.type=paladin`

Ahora, mostremos estas variables de entorno en un container:

`kubectl apply -f player.yaml`

Y miremos sus logs.

## 3-redis

Aqui vamos a probar con Redis (cache) para pasar valores al pod en modo ConfigMap.

Primero vamos a aplicar los manifiestos del config y el pod:

Dejando en blanco el de redis:

```
kubectl apply -f redis-config.yaml
kubectl apply -f redis-pod.yaml
```

Verifiquemos que tiene el configmap:

```
❯ kubectl describe configmap redis-config
Name:         redis-config
Namespace:    default
Labels:       <none>
Annotations:  <none>
Data
====
redis-config:
----
BinaryData
====
Events:  <none>
```

> Parece estar en blanco.

```
❯ kubectl exec -it redis -- redis-cli
127.0.0.1:6379> CONFIG GET maxmemory
1) "maxmemory"
2) "0"
 
127.0.0.1:6379> CONFIG GET maxmemory-policy
1) "maxmemory-policy"
2) "noeviction"
```
Sale el maxmemory en 0, y el noeviction.

Ahora, modifica el configmap de redis, para usar estas variables:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-redis-config
data:
  redis-config: |
    maxmemory 2mb
    maxmemory-policy allkeys-lru    
```

Aplica ese nuevo manifiesto

kubectl apply -f redis-config.yaml

Revisa que este bien:

```
❯ kubectl describe configmap redis-config
Name:         redis-config
Namespace:    event-simulator
Labels:       <none>
Annotations:  <none>
Data
====
redis-config:
----
maxmemory 2mb
maxmemory-policy allkeys-lru
----
BinaryData
====
Events:  <none>
```

> Revisemos con el redis-cli, haber si ya tomo los valores.

NO? --> El pod necesita ser eliminado y crear uno nuevo que tome toda la nueva configuración.

Miremos.
kubectl exec -it redis -- redis-cli

Muy bien!!!

> No olvides eliminar todos los recursos antes de seguir con un nuevo ejercicio.

## 4-secrets

Vamos a empezar a utilizar secretos.

### 1

Primero, vemos que tenemos dos archivos en texto plano con credenciales importantes.

Vamos a crear un secret, usando kustomization.

Aplica el kustomization.yaml
`kubectl apply -k .`

Revisa y muestra que el secret `db-user-pass` tenga los datos indicados:

### 2

Vamos a aplicar el archivo `1.yaml`, para tener el secret `api-secrets`

Muestralo y averigua que si tenga los secrets, decodificalos y revisa que esten bien.

### 3 

Vamos a aplicar el archivo `2.yaml`, para tener el secret `api-secrets` funcionando como volumen dentro de un pod.

Ingresa al pod, y ejecuta un:

`cat /etc/foo/config.yaml`

Y comprueba que los secretos se montaron correctamente.

## 4
Aplica el manifiesto `3.yaml`, y revisa cuantos pod crea.
Ahora, muestra los logs del container `dotfile-test-container` y luego del `show-content`.

Que notaste?

## 5
Aplica el manifiesto `4.yaml` y revisa que le falta.

Ahora crea un secreto con estos valores:

```
nombre: db-secret
DB_Host=mibasededatos
DB_User=root
DB_Password=password123
```

> `kubectl create secret generic db-secret --from-literal=DB_Host=sql01 --from-literal DB_User=root --from-literal DB_Password=password123`

Borra el pod y vuelvelo a crear.

Expone el puerto 8080 para mirar si la aplicación esta corriendo bien.