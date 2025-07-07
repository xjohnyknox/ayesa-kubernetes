# Ejercicio
Una aplicación necesita almacenamiento persistente que se mantenga disponible incluso cuando los pods se reinicien. El almacenamiento debe tener un tamaño de 1Gi y utilizar la clase de almacenamiento predeterminada del clúster.

## Tareas a Realizar
### Parte 1: Crear el PersistentVolumeClaim

```yaml
Nombre: app-storage
Capacidad: 1Gi
Modo de acceso: ReadWriteOnce
Clase de almacenamiento: Usar la clase predeterminada del clúster
```

### Parte 2: Crear el Pod

```yaml
Nombre: storage-pod
Requisito: Debe montar el PVC creado en la ruta /data dentro del contenedor
Imagen: Puedes usar cualquier imagen base (por ejemplo, nginx o busybox)
```

## Pista Importante
El modo de acceso `ReadWriteOnce` significa que el volumen puede ser montado como lectura-escritura por un solo nodo a la vez.

## Validación
Para verificar que tu solución funciona correctamente:

- Crea un archivo en `/data` dentro del pod
- Elimina el pod
- Recrea el pod con la misma configuración
- Verifica que el archivo sigue existiendo en `/data`


