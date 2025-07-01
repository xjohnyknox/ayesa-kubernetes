# Preparando el ambiente para los laboratorios

Para realizar los laboratorios de esta sección, necesitamos asegurarnos de tener un cluster Kubernetes con la siguiente configuración mínima:

- 1 nodo master (control plane)
- 2 nodos workers

## Verificación de la configuración

1. Primero, debemos asegurarnos que en el archivo `laboratorio/settings.yaml` tengamos configurado al menos 2 workers:

```yaml
nodes:
  control:
    cpu: 2
    memory: 2048
  workers:
    count: 2    # Asegúrate que este valor sea 2 o mayor
    cpu: 1
    memory: 2048
```

2. Una vez verificada la configuración, podemos crear nuestro cluster ejecutando:

```bash
cd laboratorio
vagrant up
```

3. Espera a que el proceso de creación termine. Podrás ver cómo se crean las máquinas virtuales:
   - control-plane
   - node01
   - node02

4. Para verificar que todos los nodos están correctamente unidos al cluster, ejecuta:

```bash
vagrant ssh control-plane -c "kubectl get nodes"
```

Deberías ver una salida similar a esta:

```
NAME          STATUS   ROLES           AGE     VERSION
control-plane Ready    control-plane   10m     v1.28.x
node01        Ready    worker          8m      v1.28.x
node02        Ready    worker          8m      v1.28.x
```

Ahora que tenemos nuestro cluster listo con la configuración necesaria, podemos proceder con los siguientes laboratorios.
