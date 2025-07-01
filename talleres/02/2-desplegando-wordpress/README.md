# Despliegue de WordPress + MySQL en Kubernetes

### 📋 Descripción del Proyecto

Este proyecto despliega una aplicación completa de **WordPress** con base de datos **MySQL** en un clúster de Kubernetes utilizando **Kustomize**.

### 🏗️ Arquitectura de la Aplicación

```
┌─────────────────┐    ┌─────────────────┐
│   WordPress     │────│     MySQL       │
│   (Frontend)    │    │   (Base de      │
│                 │    │    Datos)       │
│ - 2 réplicas    │    │ - 1 réplica     │
│ - Puerto 80     │    │ - Puerto 3306   │
│ - NodePort      │    │ - ClusterIP     │
└─────────────────┘    └─────────────────┘
         │                       │
         ▼                       ▼
┌─────────────────┐    ┌─────────────────┐
│ WordPress PVC   │    │   MySQL PVC     │
│   (3Gi)         │    │    (5Gi)        │
└─────────────────┘    └─────────────────┘
```

### 📁 Estructura de Archivos

```
2-desplegando-wordpress/
├── kustomization.yaml       # Archivo principal de Kustomize
├── mysql-secret.yaml        # Credenciales de la base de datos
├── mysql-pvc.yaml          # Volumen persistente para MySQL
├── wordpress-pvc.yaml      # Volumen persistente para WordPress
├── mysql-deployment.yaml   # Despliegue de MySQL
├── mysql-service.yaml      # Servicio interno de MySQL
├── wordpress-deployment.yaml # Despliegue de WordPress
├── wordpress-service.yaml  # Servicio NodePort de WordPress
└── README.md               # Este archivo
```

### 🎯 Objetivos de Aprendizaje CKA

Al completar este ejercicio, practicarás:

- ✅ **Deployments**: Creación y gestión de aplicaciones
- ✅ **Services**: ClusterIP y NodePort
- ✅ **Secrets**: Manejo seguro de credenciales
- ✅ **PersistentVolumes**: Almacenamiento persistente
- ✅ **Kustomize**: Gestión de manifiestos
- ✅ **Multi-tier Applications**: Aplicaciones de múltiples niveles
- ✅ **Troubleshooting**: Resolución de problemas

### 📦 Componentes Desplegados

#### 🔐 Secrets
- **mysql-secret**: Contiene credenciales de la base de datos
  - Usuario root: `admin123`
  - Base de datos: `wordpress`
  - Usuario: `wpuser`
  - Contraseña: `wppass123`

#### 💾 Persistent Volume Claims
- **mysql-pvc**: 5Gi para datos de MySQL
- **wordpress-pvc**: 3Gi para archivos de WordPress
- Ambos usan el **StorageClass por defecto**

#### 🗄️ MySQL Database
- **1 réplica** (aplicación con estado)
- **Estrategia Recreate** para almacenamiento persistente
- **Sondas de salud** (liveness y readiness)
- **Servicio ClusterIP** para acceso interno

#### 🌐 WordPress Frontend
- **2 réplicas** para alta disponibilidad
- **Servicio NodePort** (puerto 30080)
- Conecta a MySQL via `mysql-service:3306`
- **Sondas HTTP** para verificar estado

### 🚀 Instrucciones de Despliegue

#### Prerequisitos
```bash
# Verificar versión de Kubernetes
kubectl version --short

# Verificar que Kustomize esté disponible
kubectl kustomize --help

# Verificar el StorageClass por defecto
kubectl get storageclass
```

#### Paso 1: Verificar la Configuración de Kustomize

```bash
# Ver todos los recursos que se van a crear
kubectl kustomize .

# Validar que no hay errores de sintaxis
kubectl kustomize . --validate=true
```

#### Paso 2: Desplegar la Aplicación

```bash
# Aplicar todos los recursos con Kustomize
kubectl apply -k .

# Verificar el estado del despliegue
kubectl get all
```

#### Paso 3: Monitorear el Despliegue

```bash
# Ver el estado de los pods
kubectl get pods -w

# Verificar los servicios
kubectl get svc

# Verificar los PVCs
kubectl get pvc

# Ver los secrets
kubectl get secrets
```

### 🔍 Verificación y Acceso

#### Acceder a WordPress
```bash
# Obtener la IP del nodo
kubectl get nodes -o wide

# Acceder via navegador
# http://<IP_DEL_NODO>:30080
```

#### Verificar Conectividad de la Base de Datos

```bash
# Conectar al pod de MySQL
kubectl exec -it deployment/cka-mysql-deployment -- mysql -u wpuser -p

# Usar la contraseña: wppass123
# Verificar la base de datos
mysql> SHOW DATABASES;
mysql> USE wordpress;
mysql> SHOW TABLES;
```

### 🛠️ Comandos de Troubleshooting

```bash
# Ver logs de WordPress
kubectl logs deployment/cka-wordpress-deployment

# Ver logs de MySQL
kubectl logs deployment/cka-mysql-deployment

# Describir un pod con problemas
kubectl describe pod <nombre-del-pod>

# Verificar eventos del clúster
kubectl get events --sort-by=.metadata.creationTimestamp

# Verificar el estado de los PVCs
kubectl describe pvc mysql-pvc
kubectl describe pvc wordpress-pvc

# Probar conectividad entre pods
kubectl exec -it deployment/cka-wordpress-deployment -- ping cka-mysql-service
```

### 🎯 Ejercicios Adicionales para CKA

1. **Escalado**: Escala WordPress a 3 réplicas
   ```bash
   kubectl scale deployment cka-wordpress-deployment --replicas=3
   ```

2. **Rolling Update**: Actualiza la imagen de WordPress
   ```bash
   kubectl set image deployment/cka-wordpress-deployment wordpress=wordpress:6.5-apache
   ```

3. **Backup**: Crea un backup de los datos de MySQL
   ```bash
   kubectl exec deployment/cka-mysql-deployment -- mysqldump -u root -p<password> wordpress > backup.sql
   ```

4. **Resource Limits**: Modifica los límites de recursos y vuelve a aplicar

5. **Network Policies**: Crea políticas de red para restringir el tráfico

### 🧹 Limpieza

Para eliminar todos los recursos:

```bash
# Eliminar todos los recursos creados
kubectl delete -k .

# Verificar que todo se ha eliminado
kubectl get all
kubectl get pvc
kubectl get secrets
```

### 📚 Conceptos Clave para el CKA

- **Kustomize vs Helm**: Kustomize es nativo de kubectl
- **Persistent Storage**: Diferencia entre PV y PVC
- **Service Types**: ClusterIP vs NodePort vs LoadBalancer
- **Deployment Strategies**: Recreate vs RollingUpdate
- **Health Checks**: Liveness vs Readiness probes
- **Resource Management**: Requests vs Limits

### 🔗 Referencias Útiles

- [Documentación oficial de Kubernetes](https://kubernetes.io/docs/)
- [Guía de Kustomize](https://kustomize.io/)
- [Ejemplos de CKA](https://github.com/kelseyhightower/kubernetes-the-hard-way)

