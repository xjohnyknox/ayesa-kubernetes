# 🚀 Despliegue de WordPress + MySQL en Kubernetes con Kustomize

Bienvenido/a. En este laboratorio aprenderás a desplegar una aplicación multi-tier real (WordPress + MySQL) en Kubernetes, usando buenas prácticas de manifiestos y almacenamiento persistente. Este ejercicio está alineado con los objetivos del examen CKA y te ayudará a practicar conceptos clave.

---

## 📂 Estructura de los Manifiestos

```
talleres/02/2-desplegando-wordpress/
├── README.md                  # Guía y explicación del laboratorio
├── namespace.yaml             # Namespace dedicado para aislar los recursos
├── mysql-secrets.yaml         # Secret con credenciales de MySQL
├── mysql-pvc.yaml             # PVC para datos persistentes de MySQL
├── mysql-deployment.yaml      # Deployment de MySQL
├── mysql-service.yaml         # Service ClusterIP para MySQL
├── wordpress-pvc.yaml         # PVC para archivos de WordPress
├── wordpress-deployment.yaml  # Deployment de WordPress
└── wordpress-service.yaml     # Service NodePort para WordPress
```

---

## 🎯 Objetivos de Aprendizaje

- Crear y gestionar **Namespaces** para aislar entornos.
- Usar **Secrets** para manejar credenciales de forma segura.
- Definir y consumir **PersistentVolumeClaims**.
- Desplegar aplicaciones multi-tier con **Deployments** y **Services**.
- Exponer servicios con **NodePort** y **ClusterIP**.
- Practicar troubleshooting y comandos esenciales para el CKA.

---

## 🏗️ Arquitectura de la Solución

```
┌──────────────┐      ┌──────────────┐
│  WordPress   │ <--> │   MySQL      │
│  (Frontend)  │      │ (Database)   │
└─────┬────────┘      └─────┬────────┘
      │                     │
┌─────▼─────┐         ┌─────▼─────┐
│ PVC WP    │         │ PVC MySQL │
└───────────┘         └───────────┘
```

- **WordPress**: 1 réplica, expuesto por NodePort (`30080`).
- **MySQL**: 1 réplica, acceso interno por ClusterIP.
- Ambos usan almacenamiento persistente (PVC).
- Namespace: `prueba-con-wordpress`.

---

## ⚙️ Despliegue Paso a Paso

### 1. Prerrequisitos

- Acceso a un clúster Kubernetes funcional.
- `kubectl` y soporte para `kustomize` (nativo en kubectl ≥1.14).
- StorageClass por defecto configurado.

### 2. Revisión de los Manifiestos

Puedes revisar todos los recursos que se crearán con:

```bash
kubectl kustomize .
```

### 3. Despliegue

Aplica todos los recursos en el namespace dedicado:

```bash
kubectl apply -k .
```

### 4. Verifica el Estado

```bash
kubectl get all -n prueba-con-wordpress
kubectl get pvc -n prueba-con-wordpress
kubectl get secrets -n prueba-con-wordpress
```

### 5. Acceso a WordPress

1. Obtén la IP de un nodo del clúster:
   ```bash
   kubectl get nodes -o wide
   ```
2. Accede desde tu navegador a:  
   `http://<IP_DEL_NODO>:30080`

---

## 🛠️ Troubleshooting y Comandos Útiles

- Ver logs:
  ```bash
  kubectl logs deployment/wordpress -n prueba-con-wordpress
  kubectl logs deployment/mysql -n prueba-con-wordpress
  ```
- Describir recursos:
  ```bash
  kubectl describe pod <nombre-pod> -n prueba-con-wordpress
  kubectl describe pvc <nombre-pvc> -n prueba-con-wordpress
  ```
- Ver eventos:
  ```bash
  kubectl get events -n prueba-con-wordpress --sort-by=.metadata.creationTimestamp
  ```

---

## 💡 Retos y Extensiones

- Escala WordPress a 2 o más réplicas y observa el comportamiento.
- Añade sondas de liveness/readiness a los deployments.
- Cambia la contraseña de la base de datos usando un nuevo Secret.
- Realiza un backup de la base de datos desde el pod de MySQL.
- Limita los recursos (CPU/memoria) de los pods.

---

## 📚 Recursos Recomendados

- [Documentación oficial de Kubernetes](https://kubernetes.io/docs/)
- [Kustomize](https://kustomize.io/)

---

> **Recuerda:** Practica los comandos, experimenta con los manifiestos y no dudes en romper y arreglar el entorno. ¡Así se aprende Kubernetes para el CKA!

---

**¡Mucho éxito y a practicar!**

