
---

## 3. Ejercicio: Servicio LoadBalancer (con MetalLB)

```markdown
# Ejercicio: Exponiendo NGINX con LoadBalancer (usando MetalLB)

## 1. Desplegar el Deployment de NGINX

(Usa el mismo manifiesto del ejercicio anterior o asegúrate de que ya esté desplegado)

---

## 2. Crear el Servicio LoadBalancer

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-lb
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```
### Aplica el servicio:
```bash
kubectl apply -f nginx-lb.yaml
```

## 3. Probar el Servicio desde Fuera del Cluster
Para probar el servicio LoadBalancer, necesitas conocer la IP externa asignada por MetalLB. Puedes obtener la IP del servicio con el siguiente comando:

```bash
kubectl get svc nginx-lb
```
Luego, desde tu máquina local, puedes hacer una solicitud al servicio usando la IP externa:

```bash
curl http://<EXTERNAL_IP>
```
Deberías ver el HTML de bienvenida de NGINX.

## 4. Notas
El servicio LoadBalancer asigna una IP externa que puede ser accedida desde fuera del cluster. Esto es útil para exponer servicios a Internet o a redes externas.
