
---

## 2. Ejercicio: Servicio NodePort

```markdown
# Ejercicio: Exponiendo NGINX con NodePort

## 1. Desplegar el Deployment de NGINX

(Usa el mismo manifiesto del ejercicio anterior o asegúrate de que ya esté desplegado)

---

## 2. Crear el Servicio NodePort

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30080 # Opcional, puedes omitir y Kubernetes asignará uno
  type: NodePort
````
### Aplica el servicio:
```bash
kubectl apply -f nginx-nodeport.yaml
```
## 3. Probar el Servicio desde Fuera del Cluster
Para probar el servicio NodePort, necesitas conocer la IP de uno de los nodos del cluster. Puedes obtener la IP del nodo con el siguiente comando:

```bash
kubectl get nodes -o wide
```
Luego, desde tu máquina local, puedes hacer una solicitud al servicio usando la IP del nodo y el puerto asignado (30080 en este caso):

```bash
curl http://<NODE_IP>:30080
```
Deberías ver el HTML de bienvenida de NGINX.

## 4. Notas

El servicio NodePort expone el servicio en el puerto especificado (ej. 30080) en todos los nodos del cluster.

Puedes acceder desde cualquier máquina que tenga red con el nodo (por ejemplo, tu laptop).


