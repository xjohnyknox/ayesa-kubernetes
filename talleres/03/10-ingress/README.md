# Ingress en Kubernetes

Este ejercicio demuestra cómo configurar un Ingress básico en Kubernetes para exponer servicios HTTP/HTTPS.

## ¿Qué es un Ingress?

Un Ingress es un objeto de Kubernetes que gestiona el acceso externo a los servicios dentro de un clúster. Actúa como un "enrutador de tráfico" que puede proporcionar:
- Balanceo de carga
- Terminación SSL/TLS
- Enrutamiento basado en host y path
- Virtual hosting basado en nombres

## Componentes del ejemplo

El archivo `ingress.yaml` contiene tres componentes principales:

1. **Service (echo)**: Expone el deployment en el puerto 80
```yaml
apiVersion: v1
kind: Service
metadata:
  name: echo
spec:
  selector:
    app: echo
  ports:
  - port: 80
2. **Deployment (echo)**: Ejecuta el contenedor `ealen/echo-server`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: echo
spec:
  selector:
    matchLabels:
      app: echo
  template:
    metadata:
      labels:
        app: echo
    spec:
      containers:
      - name: echo
        image: ealen/echo-server
        ports:
        - containerPort: 80
```

3. **Ingress (echo-ing)**: Configura las reglas de enrutamiento
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: echo-ing
spec:
  ingressClassName: nginx
  rules:
  - host: echo.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: echo
            port:
              number: 80
```

## Requisitos previos

- Tener un Ingress Controller instalado (en este caso, nginx-ingress)
- Kubernetes cluster funcionando

## Despliegue

1. Aplicar la configuración:
```bash
kubectl apply -f ingress.yaml
```

2. Verificar que los recursos se han creado:
```bash
kubectl get ingress
kubectl get services
kubectl get pods
```

## Prueba local

Para probar el dominio `echo.example.com` en tu equipo local:

1. Obtén la IP del Ingress Controller:
```bash
kubectl get ingress echo-ing
```

2. Modifica el archivo `/etc/hosts` en tu sistema (requiere permisos de administrador):
```bash
sudo echo "INGRESS_IP echo.example.com" >> /etc/hosts
```
Reemplaza `INGRESS_IP` con la IP real obtenida.

3. Prueba el acceso:
```bash
curl -H "Host: echo.example.com" http://echo.example.com
```

## Verificación

Si todo está configurado correctamente:
- Accediendo a `http://echo.example.com` deberías ver la respuesta del echo-server
- El tráfico fluirá: Cliente → Ingress Controller → Service → Pod

## Troubleshooting

Si encuentras problemas:
1. Verifica que el Ingress Controller esté funcionando:
```bash
kubectl get pods -n ingress-nginx
```

2. Revisa los logs del Ingress:
```bash
kubectl describe ingress echo-ing
```

3. Comprueba que el servicio está respondiendo:
```bash
kubectl get svc echo
```


