### Kubernetes v1.32 — Pasos resumidos para aprovisionar el nodo **control-plane**

---

#### 1. Preparación básica del sistema

1. Actualiza índices de paquetes:

   ```bash
   sudo apt-get update -y
   ```
2. Desactiva el swap **y** evita que vuelva a activarse:

   ```bash
   sudo swapoff -a
   (crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab -
   ```
3. Activa módulos de red en el arranque:

   ```bash
   cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
   overlay
   br_netfilter
   EOF
   sudo modprobe overlay && sudo modprobe br_netfilter
   ```
4. Configura parámetros `sysctl` permanentes:

   ```bash
   cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
   net.bridge.bridge-nf-call-iptables  = 1
   net.bridge.bridge-nf-call-ip6tables = 1
   net.ipv4.ip_forward                 = 1
   EOF
   sudo sysctl --system
   ```
5. (Optativo) Ajusta DNS si tu entorno lo requiere: crea
   `/etc/systemd/resolved.conf.d/dns_servers.conf` y reinicia `systemd-resolved`.

---

#### 2. Instalación del runtime **CRI-O**

```bash
sudo apt-get install -y software-properties-common curl apt-transport-https ca-certificates
curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/Release.key \
     | sudo gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] \
      https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/ /" \
      | sudo tee /etc/apt/sources.list.d/cri-o.list
sudo apt-get update -y
sudo apt-get install -y cri-o
sudo systemctl enable crio --now
```

---

#### 3. Instalación de los binarios de Kubernetes (v **1.32.0-00**)

```bash
K8S_VERSION=1.32.0-00          # ⇐ ajusta si sale parche nuevo
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key \
     | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
      https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" \
      | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubelet=$K8S_VERSION kubeadm=$K8S_VERSION kubectl=$K8S_VERSION jq
sudo apt-mark hold kubelet kubeadm kubectl cri-o          # bloquea actualizaciones automáticas
```

---

#### 4. Configura **kubelet** con la IP del nodo

```bash
LOCAL_IP=$(ip -4 -o addr show eth1 | awk '{print $4}' | cut -d/ -f1)
cat <<EOF | sudo tee /etc/default/kubelet
KUBELET_EXTRA_ARGS=--node-ip=$LOCAL_IP
EOF
sudo systemctl daemon-reload && sudo systemctl restart kubelet
```

---

#### 5. Inicializa el plano de control

```bash
# Ajusta variables
CONTROL_IP=$LOCAL_IP
POD_CIDR=10.244.0.0/16
SERVICE_CIDR=10.96.0.0/12
NODENAME=$(hostname -s)

sudo kubeadm config images pull                       # precarga imágenes
sudo kubeadm init \
     --apiserver-advertise-address=$CONTROL_IP \
     --apiserver-cert-extra-sans=$CONTROL_IP \
     --pod-network-cidr=$POD_CIDR \
     --service-cidr=$SERVICE_CIDR \
     --node-name $NODENAME \
     --ignore-preflight-errors Swap
```

---

#### 6. Configura **kubectl** para el usuario actual

```bash
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---

#### 7. Guarda el comando *join* para los workers

```bash
CONFIG_DIR=/vagrant/configs
mkdir -p $CONFIG_DIR
sudo cp /etc/kubernetes/admin.conf $CONFIG_DIR/config
kubeadm token create --print-join-command | tee $CONFIG_DIR/join.sh
chmod +x $CONFIG_DIR/join.sh
```

---

#### 8. Instala la red **Calico** (v \<CALICO\_VERSION>)

```bash
CALICO_VERSION=3.28.0   # ejemplo
curl -LO https://raw.githubusercontent.com/projectcalico/calico/v${CALICO_VERSION}/manifests/calico.yaml
kubectl apply -f calico.yaml
```

---

#### 9. (Optativo) Despliega **Metrics Server**

```bash
kubectl apply -f https://raw.githubusercontent.com/techiescamp/kubeadm-scripts/main/manifests/metrics-server.yaml
```

---


