## Descripción del Ejercicio
Necesitas crear un PersistentVolume (PV) que use almacenamiento local en el nodo `cka-worker`, luego crear un PersistentVolumeClaim (PVC) que se vincule a este PV, y finalmente validar su funcionalidad montándolo en un pod.

⚠️ **Importante**: Este ejercicio simula el almacenamiento local típico en exámenes CKA donde no hay aprovisionamiento dinámico disponible.

## Tareas

### Tarea 1: Preparar el Directorio Local
1. Acceder al nodo `cka-worker`
2. Crear el directorio `/mnt/local-storage/data-pvc`
3. Configurar permisos adecuados

### Tarea 2: Crear el StorageClass
Crea un StorageClass llamado `local-storage` con:
- **Provisioner**: `kubernetes.io/no-provisioner`
- **VolumeBindingMode**: `WaitForFirstConsumer`

### Tarea 3: Crear el PersistentVolume
Crea un PersistentVolume llamado `local-data-pv` con:
- **Tamaño**: 5 Gi
- **StorageClass**: `local-storage`
- **Modo de Acceso**: ReadWriteOnce
- **Ruta local**: `/mnt/local-storage/data-pvc`
- **Afinidad de nodo**: `cka-worker`

### Tarea 4: Crear el PVC
Crea un PersistentVolumeClaim llamado `data-pvc` con:
- **Tamaño**: 5 Gi
- **StorageClass**: `local-storage`
- **Modo de Acceso**: ReadWriteOnce
- **Namespace**: default

### Tarea 5: Validar y Probar
1. Verificar que el PVC se vincule al PV
2. Crear un pod que monte el PVC
3. Verificar que los datos persistan

## Comandos Esperados y Soluciones

### Pod de Prueba
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    command: ["/bin/sh"]
    args: ["-c", "echo 'Test data from local storage' > /data/test.txt && nginx -g 'daemon off;'"]
    volumeMounts:
    - name: data-volume
      mountPath: /data
  volumes:
  - name: data-volume
    persistentVolumeClaim:
      claimName: data-pvc
  nodeSelector:
    kubernetes.io/hostname: cka-worker
```

### Comandos de Verificación
```bash
# Verificar que el pod esté corriendo en cka-worker
kubectl get pod test-pod -o wide

# Verificar contenido del archivo
kubectl exec test-pod -- cat /data/test.txt

# Verificar en el nodo directamente
ssh cka-worker
cat /mnt/local-storage/data-pvc/test.txt
```

## Guía de Resolución de Problemas

### Problemas Comunes y Soluciones

1. **PVC atascado en estado "Pending"**
   - **Causa**: El PV no existe o no coincide con los requisitos del PVC
   - **Solución**: Verificar que el PV esté creado y disponible
   ```bash
   kubectl get pv
   kubectl describe pv local-data-pv
   ```

2. **PV no disponible**
   - **Causa**: Directorio no existe en el nodo o permisos incorrectos
   - **Solución**: Verificar en el nodo cka-worker
   ```bash
   ssh cka-worker
   ls -la /mnt/local-storage/data-pvc
   ```

3. **Pod no puede montar el volumen**
   - **Causa**: Pod no está programado en el nodo correcto
   - **Solución**: Asegurar nodeSelector o verificar afinidad de nodo

4. **Acceso denegado al directorio**
   - **Causa**: Permisos insuficientes en el directorio local
   - **Solución**: Ajustar permisos en el nodo
   ```bash
   sudo chmod 777 /mnt/local-storage/data-pvc
   ```

5. **StorageClass no encontrado**
   - **Causa**: StorageClass no fue creado
   - **Solución**: Crear el StorageClass primero
   ```bash
   kubectl get sc local-storage
   ```

## Diferencias Clave con Almacenamiento Dinámico

### Almacenamiento Local vs Dinámico
- **Local**: Requiere creación manual del PV y preparación del nodo
- **Dinámico**: El PV se crea automáticamente cuando se solicita el PVC
- **Portabilidad**: Los volúmenes locales están atados a un nodo específico
- **Persistencia**: Los datos persisten incluso si se elimina el pod o PVC

### Consideraciones Especiales
- El pod DEBE ejecutarse en el nodo donde está el volumen local
- `WaitForFirstConsumer` retrasa el binding hasta que un pod use el PVC
- Los volúmenes locales no son portables entre nodos

## Lista de Verificación
- [ ] Directorio `/mnt/local-storage/data-pvc` existe en `cka-worker`
- [ ] StorageClass `local-storage` está creado
- [ ] PV `local-data-pv` está disponible y usa el directorio correcto
- [ ] PVC `data-pvc` está en estado "Bound"
- [ ] Pod se ejecuta en el nodo `cka-worker`
- [ ] Los datos escritos al volumen son visibles en el nodo
- [ ] Los datos persisten después de eliminar y recrear el pod

## Lista de Verificación
- [ ] PVC `data-pvc` existe en el namespace default
- [ ] PVC tiene tamaño de 5Gi
- [ ] PVC usa StorageClass `fast`
- [ ] PVC está en estado "Bound"
- [ ] PVC puede ser montado en un pod
- [ ] Los datos escritos al volumen persisten

## Preguntas de Aprendizaje Extendido
1. ¿Qué sucede si eliminas el pod pero mantienes el PVC?
2. ¿Qué pasa si el nodo `cka-worker` se vuelve inaccesible?
3. ¿Por qué es importante `WaitForFirstConsumer` en volúmenes locales?
4. ¿Cómo migrarías los datos a otro nodo si fuera necesario?
5. ¿Cuál es la diferencia entre `Retain`, `Recycle` y `Delete` en reclaim policies?
6. ¿Cómo verificarías que el directorio local tiene suficiente espacio?

