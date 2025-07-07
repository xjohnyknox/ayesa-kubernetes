## Escenario
Antes de una actualización mayor necesitas documentar el comando
exacto para respaldar etcd.

## Tarea
Escribe en **respuesta.sh** **(NO LO EJECUTES)** el comando `etcdctl`
que tomaría un snapshot y lo guardaría en:
`/tmp/etcd-backup.db`

* Usa `--endpoints=https://127.0.0.1:2379`.
* Incluye los tres certificados estándar de un clúster kubeadm:
  * `--cacert=/etc/kubernetes/pki/etcd/ca.crt`
  * `--cert=/etc/kubernetes/pki/etcd/server.crt`
  * `--key=/etc/kubernetes/pki/etcd/server.key`

Se aceptan variables de entorno (`$ENDPOINTS`, `$CERT`, etc.)  
y comentarios. El script **no** debe ejecutar la orden,
solo dejarla escrita.

```bash
#!/usr/bin/env bash
# 👇 Rellena aquí tu comando
# mi codigo aquí
```
