# Ejercicio: Implementación de Políticas de Red en Kubernetes

## Escenario
Trabajas para una empresa que tiene una aplicación multicapa implementada en Kubernetes. La aplicación consta de:

### Frontend (app=frontend): 
Servidores web que necesitan comunicarse con la API

### API (app=api): 
Servidores API que necesitan comunicarse con la base de datos

### Base de datos (app=db): 
Servidores de base de datos que solo deben aceptar conexiones de servidores API

### Monitoreo (app=monitoring): 
Herramientas de monitoreo que necesitan recopilar métricas de todos los servicios

## Problema de seguridad actual
Actualmente, todos los pods pueden comunicarse entre sí sin restricciones. El equipo de seguridad ha identificado esto como una vulnerabilidad importante y desea implementar políticas de red para garantizar:

- [ ] **Seguridad de la base de datos:** Solo los pods de API deben poder conectarse a los pods de la base de datos.
- [ ] **Seguridad de la API:** Solo los pods frontend deben poder conectarse a los pods de API.
- [ ] **Acceso de monitoreo:** Los pods de monitoreo deben poder conectarse a todos los pods de la aplicación para la recopilación de métricas.
- [ ] **Control de salida:** Todos los pods deben poder realizar consultas DNS, pero los pods de la base de datos no deben tener acceso a internet.

## Tareas

### Tarea 1: Configurar el entorno

- [ ] Crea un namespace llamado `app-segura`.

- [ ] Despliega la base de datos como un Deployment con:
  - 2 réplicas que usen la imagen `redis:alpine`
  - Labels/selectores `app: db` y `tier: database`
  - Puerto expuesto 6379/TCP
  - Requests → CPU 100m, Memoria 128Mi
  - Limits → CPU 500m, Memoria 256Mi
  - Expón la base de datos mediante un Service interno accesible en el puerto 6379

- [ ] Despliega la API como un Deployment con:
  - 2 réplicas que usen la imagen `nginx:alpine`
  - Labels/selectores `app: api` y `tier: backend`
  - Puerto expuesto 80/TCP
  - Requests → CPU 250m, Memoria 64Mi
  - Limits → CPU 500m, Memoria 128Mi
  - Expón la API mediante un Service interno accesible en el puerto 80

- [ ] Despliega el Frontend como un Deployment con:
  - 3 réplicas que usen la imagen `nginx:alpine`
  - Labels/selectores `app: frontend` y `tier: frontend`
  - Puerto expuesto 80/TCP
  - Requests → CPU 250m, Memoria 64Mi
  - Limits → CPU 500m, Memoria 128Mi
  - Expón el Frontend mediante un Service de tipo ClusterIP en el puerto 80

- [ ] Despliega el Monitoring como un Deployment con:
  - 1 réplica que use la imagen `alpine:latest`
  - Comando que lo mantenga en ejecución continua
  - Labels/selectores `app: monitoring` y `tier: monitoring`
  - Requests → CPU 100m, Memoria 32Mi
  - Limits → CPU 200m, Memoria 64Mi

> **Nota:** Para el despliegue del monitoreo, puedes usar un comando en el manifiesto como `command: ['sh', '-c', 'while true; do sleep 3600; done']` para mantener el pod en ejecución.

#### Verifica que entre todos los pods se puedan comunicar entre sí:

```bash
# Obtén los nombres de los pods 
kubectl get pods -n app-segura -o wide

# Prueba la conectividad desde el frontend hacia la API (debería funcionar)
kubectl exec -it -n app-segura deployment/frontend -- wget -qO- http://api-service

# Prueba la conectividad desde la API hacia la BD (debería funcionar)
kubectl exec -it -n app-segura deployment/api -- nc -z database-service 6379

# Prueba la conectividad desde el frontend hacia la BD (debería funcionar, pero esto debe no permitirse luego)
kubectl exec -it -n app-segura deployment/frontend -- nc -z database-service 6379
```

### Tarea 2: Implementar políticas de red

Ahora vamos a implementar políticas de red que aseguren la comunicación controlada entre los componentes. Debes crear **4 políticas de red**:

1. **Política para la base de datos (`database-netpol`):**
   - Solo permite ingreso desde pods de API y monitoreo
   - Solo permite salida para consultas DNS (puerto 53)
   - Bloquea acceso a internet

2. **Política para la API (`api-netpol`):**
   - Solo permite ingreso desde pods de frontend y monitoreo

3. **Política para el frontend (`frontend-netpol`):**
   - Solo permite ingreso desde pods de monitoreo

4. **Política para monitoreo (`monitoring-netpol`):**
   - Permite salida hacia todos los pods de la aplicación
   - Permite consultas DNS

#### Pruebas que deberían funcionar después de implementar las políticas:

```bash
# Test 1: El frontend debería poder acceder a la API
kubectl exec -it -n app-segura deployment/frontend -- wget -qO- http://api-service

# Test 2: La API debería acceder a la BD (debería funcionar)
kubectl exec -it -n app-segura deployment/api -- nc -z database-service 6379

# Test 3: El frontend NO debería acceder a la BD (debería fallar)
kubectl exec -it -n app-segura deployment/frontend -- nc -z database-service 6379

# Test 4: Monitoreo debería tener acceso a todos los servicios (debería funcionar)
kubectl exec -it -n app-segura deployment/monitoring -- nc -z api-service 80
kubectl exec -it -n app-segura deployment/monitoring -- nc -z database-service 6379
kubectl exec -it -n app-segura deployment/monitoring -- nc -z frontend-service 80

# Test 5: Verificar que el DNS aún funciona
kubectl exec -it -n app-segura deployment/database -- sh -c "apk add bind-tools && nslookup kubernetes.default.svc.cluster.local"
```

### Verificación de las políticas de red

```bash
# Listar todas las políticas de red
kubectl get networkpolicies -n app-segura

# Describir cada política para verificar su configuración
kubectl describe networkpolicy database-netpol -n app-segura
kubectl describe networkpolicy api-netpol -n app-segura
kubectl describe networkpolicy frontend-netpol -n app-segura
kubectl describe networkpolicy monitoring-netpol -n app-segura

# Verificar labels de los pods
kubectl get pods -n app-segura --show-labels
```

## Criterios de evaluación

- [ ] **Configuración correcta del entorno:** Todos los deployments y services funcionan correctamente
- [ ] **Políticas de red implementadas:** Las 4 políticas de red están creadas y configuradas correctamente
- [ ] **Seguridad de la base de datos:** Solo API y monitoreo pueden acceder a la BD
- [ ] **Seguridad de la API:** Solo frontend y monitoreo pueden acceder a la API
- [ ] **Acceso de monitoreo:** El monitoreo puede acceder a todos los servicios
- [ ] **Control de DNS:** Todos los pods pueden realizar consultas DNS
- [ ] **Restricción de internet:** Los pods de BD no tienen acceso a internet (solo DNS)

## Consejos adicionales

- Usa `kubectl logs` para debuggear problemas de conectividad
- Las políticas de red son aditivas - múltiples políticas pueden aplicar al mismo pod
- Recuerda que las políticas de red solo funcionan con CNI plugins compatibles (como Calico, Cilium, etc.)
- Puedes usar `kubectl get events -n app-segura` para ver eventos del namespace
- Para troubleshooting, puedes usar pods temporales con herramientas de red: `kubectl run test-pod --image=alpine --rm -it -n app-segura -- sh`
