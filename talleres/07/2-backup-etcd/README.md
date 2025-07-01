# Práctica de Backup y Restore de etcd - CKA

Esta práctica te guiará a través del proceso completo de crear, verificar y restaurar un backup de etcd en Kubernetes.

## Requisitos previos
- Acceso a un clúster de Kubernetes con permisos de administrador
- Conocimiento básico de comandos kubectl
- Acceso SSH al nodo de control (control plane)

## Pasos de la práctica

### 1. Crear un objeto de prueba para verificar posteriormente

Primero, creamos un namespace y un ConfigMap que usaremos para validar que el backup y restore funcionan correctamente:

```bash
kubectl create ns etcd-backup-test
kubectl -n etcd-backup-test create configmap dummy --from-literal=foo=bar
```

### 2. Tomar la instantánea (snapshot) desde el pod de etcd en ejecución

Creamos un backup de etcd ejecutando el comando dentro del pod de etcd:

```bash
TS=$(date +%Y%m%d%H%M)
kubectl exec -n kube-system etcd-controlplane -- \
  sh -c 'ETCDCTL_API=3 etcdctl snapshot save /var/lib/etcd/backup-'$TS'.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key'
```

El archivo de backup ahora también existe en el host en la ruta `/var/lib/etcd/backup-$TS.db`.

### 3. **Verificación de integridad** – examinar el archivo

Usamos `etcdctl` para verificar el estado del snapshot:

```bash
kubectl exec -n kube-system etcd-controlplane -- \
  sh -c 'ETCDCTL_API=3 etcdctl --write-out=table snapshot status /var/lib/etcd/backup-'$TS'.db'
```

Deberías ver una tabla de una sola fila con valores distintos de cero en *REVISION* / *TOTAL KEYS* y un *TOTAL SIZE* razonable. (Sin salida o un error = archivo corrupto.)

### 4. **Verificación de consistencia** – restaurar en un directorio *temporal*

```bash
SNAP=/var/lib/etcd/backup-$TS.db
TMPDIR=/var/lib/etcd-restore-test
sudo rm -rf $TMPDIR
kubectl exec -n kube-system etcd-controlplane -- \
  sh -c 'ETCDCTL_API=3 etcdctl --data-dir '$TMPDIR' snapshot restore '$SNAP''
```

Si este comando termina sin errores, la instantánea es internamente sólida y puede desempaquetarse en un árbol de datos funcional.

*Nota: Todavía estás ejecutando con los datos originales; aún no hemos tocado el clúster en vivo.*

### 5. **Verificación funcional** – ensayo completo de restauración

**Realiza esto solo en un entorno de prueba o durante una ventana de mantenimiento.**

#### 5.1. **Eliminar el objeto de prueba** para poder verlo regresar:

```bash
kubectl delete ns etcd-backup-test
```

#### 5.2. **Detener el kubelet** (lo que detiene el pod estático de etcd):

```bash
sudo systemctl stop kubelet
```

#### 5.3. **Mover el directorio de datos actual y restaurar**:

```bash
sudo mv /var/lib/etcd /var/lib/etcd.bak.$TS
sudo sh -c 'ETCDCTL_API=3 etcdctl --data-dir /var/lib/etcd snapshot restore '$SNAP''
```

**Nota**: Usamos `ETCDCTL_API=3 etcdctl snapshot restore` ya que `etcdutl` no está disponible en esta versión de la imagen.

#### 5.4. **Iniciar kubelet**:

```bash
sudo systemctl start kubelet
```

El manifiesto del pod estático monta `/var/lib/etcd`, por lo que el pod se inicia con los datos recién restaurados.

#### 5.5. **Confirmar que el objeto de prueba ha regresado**:

```bash
kubectl get ns etcd-backup-test
```

Si el namespace y el ConfigMap han reaparecido, el ciclo de backup/restore está probado de extremo a extremo.

### 6. **(Opcional) Revertir** al estado previo a la prueba

Para volver al estado original:
1. Detener kubelet
2. Eliminar el directorio restaurado
3. Mover el directorio `.bak.$TS` de vuelta a `/var/lib/etcd`
4. Iniciar kubelet nuevamente

```bash
sudo systemctl stop kubelet
sudo rm -rf /var/lib/etcd
sudo mv /var/lib/etcd.bak.$TS /var/lib/etcd
sudo systemctl start kubelet
```

## Indicadores de éxito

Una práctica exitosa debe mostrar:

* `etcdctl snapshot status` imprime una fila con datos válidos
* `etcdctl snapshot restore` se completa sin errores
* Después de la restauración en vivo, Kubernetes muestra los objetos que existían al momento del snapshot (tu namespace `etcd-backup-test`)

## Notas importantes

- **Seguridad**: Nunca realices la restauración completa (paso 5) en un clúster de producción sin una ventana de mantenimiento planificada
- **Backup regular**: En producción, automatiza este proceso para crear backups regulares
- **Verificación**: Siempre verifica la integridad y consistencia de tus backups antes de necesitarlos
- **Documentación**: Mantén un registro de tus backups con fechas y contenido para facilitar la recuperación

## Comandos de referencia rápida

```bash
# Crear backup
TS=$(date +%Y%m%d%H%M)
kubectl exec -n kube-system etcd-controlplane -- \
  sh -c 'ETCDCTL_API=3 etcdctl snapshot save /var/lib/etcd/backup-'$TS'.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key'

# Verificar backup
kubectl exec -n kube-system etcd-controlplane -- \
  sh -c 'ETCDCTL_API=3 etcdctl --write-out=table snapshot status /var/lib/etcd/backup-'$TS'.db'

# Restaurar backup
sudo sh -c 'ETCDCTL_API=3 etcdctl --data-dir /var/lib/etcd snapshot restore /var/lib/etcd/backup-'$TS'.db'
```
