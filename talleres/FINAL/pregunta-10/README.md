## Contexto del Ejercicio
Un nuevo miembro del equipo necesita acceso con kubectl al clúster. Esta persona solo debe poder ver pods y servicios en el namespace `development`, sin permisos para modificar o acceder a otros recursos o namespaces.

## Tareas a Realizar

### Parte 1: Crear el ServiceAccount
- **Nombre:** `dev-viewer`
- **Namespace:** `development`
- **Propósito:** Cuenta de servicio para el nuevo miembro del equipo

### Parte 2: Crear el Role
- **Nombre:** `pod-service-viewer`
- **Namespace:** `development`
- **Permisos:** Solo lectura (get, list, watch) para pods y services

### Parte 3: Crear el RoleBinding
- **Nombre:** `dev-viewer-binding`
- **Namespace:** `development`
- **Función:** Vincular el ServiceAccount con el Role creado

## Pasos Sugeridos para la Resolución

### 1. Crear el Namespace
- **Nombre:** `development`
- **Comando:** `kubectl create namespace development`
- **Verificación:** Confirmar que el namespace se ha creado correctamente

### 2. Crear el ServiceAccount
- Crear la cuenta de servicio en el namespace correcto
- Verificar que se ha creado correctamente

### 3. Definir el Role
- Especificar los recursos: `pods` y `services`
- Definir los verbos permitidos: `get`, `list`, `watch`
- Asegurar que el scope sea solo el namespace `development`

### 4. Establecer el RoleBinding
- Vincular el ServiceAccount con el Role
- Verificar que el binding se ha creado correctamente

### 5. Prueba de Permisos
- Verificar que el ServiceAccount puede ver pods y services
- Confirmar que no tiene permisos para otros recursos
- Verificar que no puede acceder a otros namespaces

## Recursos Involucrados
- **ServiceAccount**: Identidad para el acceso al clúster
- **Role**: Define qué acciones se pueden realizar y sobre qué recursos
- **RoleBinding**: Conecta el ServiceAccount con el Role

## Pista Importante
Los Role y RoleBinding son específicos del namespace, a diferencia de ClusterRole y ClusterRoleBinding que aplican a todo el clúster. Asegúrate de crear todos los recursos en el namespace `development`.

## Validación
Para verificar que tu solución funciona correctamente:
1. El ServiceAccount `dev-viewer` debe existir en el namespace `development`
2. El Role debe permitir solo `get`, `list`, `watch` en `pods` y `services`
3. El RoleBinding debe vincular correctamente el ServiceAccount con el Role
4. Probar el acceso usando `kubectl auth can-i` con la cuenta de servicio
5. Verificar que no puede acceder a otros recursos o namespaces
