# Ejercicios Dia 02.

En este dia, tenemos los siguientes ejercicios:

- [Ejercicios Dia 02.](#ejercicios-dia-02)
  - [1-definicion-de-pod](#1-definicion-de-pod)
  - [2-desplegando-wordpress](#2-desplegando-wordpress)
  - [3-wordpress](#3-wordpress)

## 1-definicion-de-pod

En este ejercicio vamos a ver como es la estructura básica de un pod en kubernetes.

**Tip:** Se generó con el comando:

 `kubectl run contenedor-nginx --image nginx --labels=app=miapp,tipo=frontend --dry-run=client -o yaml > 1-definicion-de-pod.yaml`

![Alt text](image.png)

Y luego vamos a aplicar dicho pod:

`kubectl apply -f 1-definicion-de-pod.yaml`

Recordando que cada tipo de recurso en kubernetes va enlazado con la versión del api que usa:

![Alt text](image-1.png)

## 2-desplegando-wordpress

En este ejercicio, vas a desplegar el mismo docker-compose de wordpress, PERO esta vez en modo kubernetes (PV, PVC, Deployment, servicios).

**Tip:** 

- Revisa el estado de los contenedores, y también sus logs, nunca esta de mal empezar por allí.


Comandos a utilizar:

`kubectl apply -f archivo1,archivo2,archivo3`

`kubectl delete -f archivo1,archivo2,archivo3`

`kubectl get all -n NAMESPACE`

`kubectl logs NombrePod`

`kubectl describe pod NombrePod`

`kubectl get events`

## 3-wordpress

```
cat <<EOF >./kustomization.yaml
secretGenerator:
- name: mysql-pass
  literals:
  - password=UnaNuevaContraseña
EOF
```

Agregalos al archivo de kustomization

```
cat <<EOF >>./kustomization.yaml
resources:
  - mysql-deployment.yaml
  - wordpress-deployment.yaml
EOF
```

Aplicalos al cluster:

`kubectl apply -k ./`

Revisa que el secreto exista:

`kubectl get secrets`

Revisa que el PVC exista:

`kubectl get pvc`

Verifica que el pod este corriendo (RUNNING), dale unos minutos:

`kubectl get pods`

Revisa el servicio de wordpress:

`kubectl get services wordpress`

Abre la url del servicio:

`minikube service wordpress --url`

Una vez finalizado, elimina los recursos:

`kubectl delete -k ./`
