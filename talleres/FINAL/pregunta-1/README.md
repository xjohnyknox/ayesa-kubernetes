## Escenario
Un nuevo pod de producción debe ejecutarse solo en en el nodo worker llamado: `node-01`.

## Tarea
Añade la etiqueta `env=prod` al nodo `node-01`.
Crea un despliegue de un pod con `3 replicas` que se ejecute en el nodo `node-01` y que tenga la etiqueta `env=prod`, que use la imagen `nginx/nginx:stable-perl` y que tenga un puerto `80` expuesto, adicional, esa imagen debe sacarse del repositorio `public.ecr.aws`.

### Entrega
Modifica **respuesta.txt** para ejecutar los comandos necesarios:

