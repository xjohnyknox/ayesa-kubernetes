# Ejercicios Dia 08.

En este dia, tenemos los siguientes ejercicios:

- [Ejercicios Dia 08.](#ejercicios-dia-08)
  - [1-rbac](#1-rbac)
  - [2-serviceaccount](#2-serviceaccount)
  - [3-network-policy](#3-network-policy)


## 1-rbac

Creamos la carpeta certs

Y dentro, generamos una llave para el nuevo user:

`openssl genrsa -out goku.key 2048`

Ahora vamos por el Certificate Request

`openssl req -new -key goku.key -out goku.csr -subj "/CN=goku/O=sayayin"`

Miremos que ca.crt y ca.key estan en el home del nodo: ls ~/.kube/config/ 

Ahora vamos a generar el CRT

`openssl x509 -req -in goku.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out goku.crt -days 500`

Ahora podemos crear el user en kube/config:

`kubectl config set-credentials goku --client-certificate=goku.crt --client-key=goku.key`

Y pongamos contexto:

`kubectl config set-context goku-context --cluster=minikube --user=goku`

Y revisemos que si salga en:

`kubectl config view`

Usemos ese nuevo contexto:

`kubectl config use-context goku-context`

Y verificamos que estemos en el:

`kubectl config current-context`

E intentemos crear un namespace.


Vamos a desplegar el archivo `1.yaml` PERO usando el contexto de minikube que si tiene permisos.

Y ahora vamos a aplicar el manifiesto 2.yaml, para dar rol de crear y borrar pods en ese namespace.

`kubectl apply -f 2.yaml`

## 2-serviceaccount

Vamos a desplegar los manifiestos 1, 2, 3, y 4, pero primero leelos.

Ahora vamos a correr el pod

`kubectl run test-pod -n 2-serviceaccount-namespace --image=busybox --command -- sleep 3600`

Y vamos a probar la comunicación entre pods:

`kubectl exec -it test-pod -n 2-serviceaccount-namespace -- wget -q -O - frontend`


NO BORRES estos recursos.

## 3-network-policy

Vamos a agregar el manifiesto sobre el ejercicio anterior:

`kubectl apply -f network-policy.yaml`

Y vamos a probar si se bloqueo la comunicación entre pods:

`kubectl exec -it test-pod -n 2-serviceaccount-namespace -- wget -q -O - frontend`

Vemos que falla por el ingress bloqueado.

Ahora para ver que el frontend si puede comunicarse con el backend en el mismo namespace, vamos a crear un pod de debug y testear la comunicación:

`kubectl apply -f debug-pod.yaml`

Y hagamos la prueba:

`kubectl exec -it debug-pod -n 2-serviceaccount-namespace -- wget -q -O - backend`

Y como pudimos ver, el request fue valido, porque ambos pods estan en el mismo namespace, y la network policy solo restringe el trafico desde fuentes externas.
