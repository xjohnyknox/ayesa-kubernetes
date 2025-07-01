# Talleres CKA - Certified Kubernetes Administrator
## Curso Ayesa

### 📋 Índice de Contenidos

Bienvenidos al curso de preparación para la certificación **Certified Kubernetes Administrator (CKA)**. Este repositorio contiene una serie de talleres prácticos diseñados específicamente para estudiantes de AYESA, preparándote para el examen oficial de CKA.

---

## 🚀 Estructura de los Talleres

### 📦 Taller 00: Introducción a Contenedores
**Carpeta:** `00/`
- Introducción a Docker y contenedores
- Docker Compose básico
- Conceptos fundamentales antes de Kubernetes
- **Archivos incluidos:**
  - `compose.yaml` - Ejemplo de Docker Compose
  - Documentación con imágenes explicativas

### 🐳 Taller 01: De Docker a Kubernetes
**Carpeta:** `01/`
- Migración de aplicaciones Docker a Kubernetes
- Instalación manual de Kubernetes
- Ejercicios prácticos con aplicaciones reales
- **Proyectos incluidos:**
  - **Python App** - Aplicación Python simple con Dockerfile
  - **WordPress** - Despliegue de WordPress con Docker Compose
  - **Voting App** - Aplicación de votación completa (microservicios)
    - Frontend de votación (Python/Flask)
    - Backend de resultados (Node.js)
    - Worker (C#/.NET)
    - Base de datos PostgreSQL y Redis
    - Generador de datos de prueba

### 🏗️ Taller 02: Pods y Deployments Básicos
**Carpeta:** `02/`
- Definición y creación de Pods
- Deployments de aplicaciones
- Gestión de almacenamiento persistente
- **Ejercicios prácticos:**
  - **Definición de Pod** - Primeros pasos con Pods y Nginx
  - **WordPress en Kubernetes** - Despliegue completo con base de datos
    - Persistent Volume Claims
    - Deployments de MySQL y WordPress
    - Servicios y exposición de aplicaciones
  - **WordPress con Kustomize** - Gestión declarativa avanzada

### ⚙️ Taller 03: Workloads y Servicios
**Carpeta:** `03/`
- ReplicaSets y Deployments avanzados
- DaemonSets
- Tipos de servicios (ClusterIP, NodePort, LoadBalancer)
- **Ejercicios destacados:**
  - **KubeDoom** - Herramienta divertida para aprender sobre pods
  - **ReplicaSets** - Aplicación Guestbook
  - **Deployments** - Gestión de aplicaciones
  - **Ejercicios de reparación** - Troubleshooting de manifiestos
  - **Apache** - Despliegue de servidor web
  - **DaemonSet** - Servicios en todos los nodos
  - **NodePort y ClusterIP** - Exposición de servicios
  - **MetalLB** - Load Balancer para bare metal

### 💾 Taller 04: Almacenamiento Persistente
**Carpeta:** `04/`
- Volúmenes en Kubernetes
- Persistent Volumes (PV) y Claims (PVC)
- Storage Classes
- **Ejercicios prácticos:**
  - **Event Simulator** - Generador de eventos para pruebas
  - **Configuración de volúmenes** - Montaje básico
  - **Persistent Volumes** - Creación y gestión de PV
  - **Persistent Volume Claims** - Solicitud de almacenamiento
  - **WebApp con PVC** - Aplicación web con almacenamiento persistente
  - **Storage Classes** - Almacenamiento dinámico
  - **Nginx con almacenamiento** - Servidor web persistente
  - **File Server** - Servidor de archivos completo

### 🔧 Taller 05: Configuración de Aplicaciones
**Carpeta:** `05/`
- ConfigMaps y Secrets
- Variables de entorno
- Montaje de configuraciones como volúmenes
- **Ejercicios prácticos:**
  - **Comandos** - Ejecución de comandos en contenedores
  - **ConfigMaps** - Gestión de configuración
    - Archivos de propiedades de juegos
    - Variables de entorno
    - Montaje como volúmenes
  - **Redis** - Configuración de base de datos
  - **Secrets** - Gestión segura de credenciales
    - Usuarios y contraseñas
    - Kustomize para secrets

### 📅 Taller 06: Scheduling y Recursos
**Carpeta:** `06/`
- Node Selection y Affinity
- Taints y Tolerations
- Gestión de recursos (CPU/Memory)
- Pod Security Constraints
- **Ejercicios avanzados:**
  - **Node Labels** - Etiquetado de nodos
  - **Node Selector** - Selección básica de nodos
  - **Node Affinity** - Afinidad avanzada de nodos
  - **Anti-Affinity** - Distribución de pods
  - **Pod Affinity** - Afinidad entre pods
  - **Node Name** - Asignación directa a nodos
  - **Topology Spread** - Distribución topológica
  - **Taints y Tolerations** - Control de scheduling
  - **Resource Management** - Límites y solicitudes de recursos

### 🔧 Taller 07: Mantenimiento del Clúster
**Carpeta:** `07/`
- Backup y restore de etcd
- Actualización de clúster con kubeadm
- Drain de nodos
- Mantenimiento de nodos
- **Ejercicios críticos:**
  - **Preparación del ambiente** - Setup del clúster
  - **Backup de etcd** - Respaldo de la base de datos del clúster
  - **kubeadm** - Administración del clúster
  - **Drain** - Mantenimiento seguro de nodos

### 🔐 Taller 08: Seguridad
**Carpeta:** `08/`
- RBAC (Role-Based Access Control)
- Service Accounts
- Network Policies
- **Ejercicios de seguridad:**
  - **RBAC** - Control de acceso basado en roles
  - **Service Accounts** - Cuentas de servicio
  - **Network Policies** - Políticas de red y microsegmentación
  - **Debug Pod** - Herramientas de debugging

### 🎯 Examen Final
**Carpeta:** `FINAL/`
- Ejercicio integral que combina todos los conceptos
- Simulación del examen CKA real
- Resolución de problemas complejos

---

## 🎯 Dominios del Examen CKA Cubiertos

### ✅ Arquitectura, Instalación y Configuración del Clúster (25%)
- **Talleres 00, 01, 07** - Instalación, configuración y mantenimiento

### ✅ Workloads y Scheduling (15%)
- **Talleres 02, 03, 06** - Pods, Deployments, ReplicaSets, Scheduling

### ✅ Servicios y Redes (20%)
- **Taller 03, 08** - Services, Network Policies, Load Balancing

### ✅ Almacenamiento (10%)
- **Taller 04** - Volumes, PV, PVC, Storage Classes

### ✅ Troubleshooting (30%)
- **Todos los talleres** - Debugging, logs, eventos, resolución de problemas

---

## 🚀 Cómo Usar Este Repositorio

### Prerrequisitos
- Conocimientos básicos de Linux
- Familiaridad con Docker (se cubre en Taller 00)
- Desplegar el clúster de Kubernetes (Usando el vagrantfile de [laboratorio](../laboratorio/Vagrantfile))

### Orden Recomendado
1. **Taller 00** - Fundamentos de contenedores
2. **Taller 01** - Transición a Kubernetes
3. **Taller 02** - Pods y Deployments básicos
4. **Taller 03** - Workloads y servicios
5. **Taller 04** - Almacenamiento persistente
6. **Taller 05** - Configuración de aplicaciones
7. **Taller 06** - Scheduling avanzado
8. **Taller 07** - Mantenimiento del clúster
9. **Taller 08** - Seguridad
10. **FINAL** - Examen de práctica

### Estructura de cada Taller
Cada directorio contiene:
- `README.md` - Instrucciones detalladas del taller
- Subdirectorios numerados con ejercicios específicos
- Archivos YAML listos para usar
- Scripts de automatización cuando corresponde

---

## 🛠️ Herramientas y Comandos Esenciales

### Comandos kubectl Fundamentales
```bash
# Información del clúster
kubectl cluster-info
kubectl get nodes
kubectl get namespaces

# Gestión de recursos
kubectl apply -f archivo.yaml
kubectl get pods -A
kubectl describe pod <nombre-pod>
kubectl logs <nombre-pod>
kubectl exec -it <pod> -- /bin/bash

# Troubleshooting
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl top nodes
kubectl top pods

# Configuración
kubectl config view
kubectl config current-context
kubectl config use-context <contexto>
```

### Aliases Recomendados para el Examen
```bash
alias k=kubectl
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
```

---

## 💡 Consejos Específicos para Estudiantes

### Preparación para el Examen
1. **Practica en inglés:** El examen es en inglés, familiarízate con la terminología
2. **Tiempo de práctica:** Dedica al menos 2-3 horas diarias durante 4-6 semanas
3. **Documentación oficial:** Usa siempre [kubernetes.io/docs](https://kubernetes.io/docs)
4. **Simulacros:** Practica con límite de tiempo (2 horas)

### Recursos en Español
- Documentación traducida disponible en algunos recursos
- Comunidad de Kubernetes España en Slack/Discord
- Meetups locales de Kubernetes en Madrid, Barcelona, etc.

---

## 🎓 Certificaciones Relacionadas

Después del CKA, considera:
- **CKAD** (Certified Kubernetes Application Developer)
- **CKS** (Certified Kubernetes Security Specialist)

---

## 📞 Soporte y Contacto

**Instructor:** [Johny Jimenez]  
**Email:** [xjohnyx@icloud.com]  

### Ayuda durante el Curso
- Revisa el README de cada taller antes de empezar
- Si encuentras errores, reporta en el issue tracker
- Pregunta en las sesiones de laboratorio

---

## 📄 Licencia

Material educativo desarrollado para Ayesa España.  
Uso exclusivo para estudiantes del curso CKA.

---

**¡Éxito en tu certificación CKA! 🎉**

> **Recuerda:** La certificación CKA es 100% práctica. Practica, practica y practica. Este repositorio te da todas las herramientas necesarias para aprobar.

---

## 📊 Progreso del Estudiante

Marca tu progreso:
- [ ] Taller 00 - Introducción a Contenedores
- [ ] Taller 01 - De Docker a Kubernetes  
- [ ] Taller 02 - Pods y Deployments Básicos
- [ ] Taller 03 - Workloads y Servicios
- [ ] Taller 04 - Almacenamiento Persistente
- [ ] Taller 05 - Configuración de Aplicaciones
- [ ] Taller 06 - Scheduling y Recursos
- [ ] Taller 07 - Mantenimiento del Clúster
- [ ] Taller 08 - Seguridad
- [ ] Examen Final - Simulacro CKA

**¡Cuando completes todos los talleres estarás listo para el examen oficial!**
