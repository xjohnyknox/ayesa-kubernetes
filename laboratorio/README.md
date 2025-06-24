# Entorno de Laboratorio Local de Kubernetes 🚢

Un entorno **minimalista** pensado específicamente para la preparación del examen **CKA (Certified Kubernetes Administrator)**. Crea un clúster local con **Vagrant** y **VirtualBox**, configurado para parecerse al entorno del examen (Kubernetes v1.32).

---

## 🎯 Características

* Topología ligera con **1 nodo control plane + 1 nodo worker** (optimizado en recursos)
* **Kubernetes v1.32** (alineado con la versión del examen)
* **Provisionado automático** con Vagrant + VirtualBox
* Preconfigurado para escenarios tipo CKA

---

## 📋 Requisitos previos

Asegúrate de tener instalado:

* **VirtualBox** (última versión)
* **Vagrant** (última versión)
* **8 GB de RAM** libres como mínimo
* **40 GB de espacio** en disco

Comprueba que tu máquina los cumple:

```bash
./scripts/check-requirements.sh
```

---

## 🚀 Inicio rápido

### 1. Clona el repositorio

```bash
git clone https://github.com/xjohnyknox/ayesa-kubernetes.git
cd laboratorio
```

### 2. Levanta el clúster

```bash
vagrant up
```

Este proceso:

1. Crea las VM en VirtualBox (1 control plane, 1 worker)
2. Instala Kubernetes v1.32
3. Configura red y seguridad
4. Inicializa el clúster
5. Añade el nodo worker

### 3. Accede a tu clúster

SSH al nodo control plane:

```bash
vagrant ssh control-plane
```

Verifica el clúster:

```bash
kubectl get nodes
kubectl get pods -A
```

---

## 💻 Usar el clúster desde tu máquina host

1. Copia el **kubeconfig** desde el control plane:

   ```bash
   vagrant ssh control-plane -c "sudo cat /etc/kubernetes/admin.conf" > kubeconfig.yaml
   ```

2. Exporta la variable `KUBECONFIG`:

   ```bash
   export KUBECONFIG=$(pwd)/kubeconfig.yaml
   ```

3. Prueba la conexión:

   ```bash
   kubectl cluster-info
   ```

---

## 🔧 Especificaciones del clúster

| Componente               | Configuración              |
| ------------------------ | -------------------------- |
| Versión Kubernetes       | **1.32**                   |
| Control Plane            | **2 CPU**, **2 GB RAM**    |
| Nodo Worker              | **2 CPU**, **2 GB RAM**    |
| Runtime de contenedores  | **cri-o**             |
| Plugin de red            | **Calico**                 |
| StorageClass por defecto | **Local Path Provisioner** |

---

## 🛠️ Operaciones habituales

| Acción                  | Comando              |
| ----------------------- | -------------------- |
| **Detener** el clúster  | `vagrant halt`       |
| **Arrancar** de nuevo   | `vagrant up`         |
| **Destruir** el clúster | `vagrant destroy -f` |

---

