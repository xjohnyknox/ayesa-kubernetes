# Ejercicio: Exponiendo NGINX con ClusterIP

## 1. Desplegar el Deployment de NGINX

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80``````

### Aplica el deployment:

```bash
kubectl apply -f nginx-deployment.yaml````


## 2. Crear el Servicio ClusterIP
```
apiVersion: v1
kind: Service
metadata:
  name: nginx-clusterip
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```

### Aplica el servicio:

`kubectl apply -f nginx-clusterip.yaml`

## 3. Probar el Servicio desde Dentro del Cluster

Crear un pod temporal para probar

`kubectl run -it --rm --image=curlimages/curl:latest curl -- sh`

Desde el pod, probar el servicio

`curl http://nginx-clusterip`

Deberías ver el HTML de bienvenida de NGINX.

## 4. Notas

El servicio ClusterIP solo es accesible dentro del cluster.

Puedes salir del pod de pruebas escribiendo exit.
