Expone el Deployment `api` como Service ClusterIP `api-svc`  
`port 80` → `targetPort 8080`.

Implementa en **respuesta.sh** el comando `kubectl expose` necesario.

```bash
#!/usr/bin/env bash
# Exponer el Deployment `api` como Service ClusterIP `api-svc`
...
```
