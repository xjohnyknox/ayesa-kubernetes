# Examen Final - Kubernetes

## Instrucciones

El examen final de nuestro curso, se realizará en este repositorio dedicado.

### Proceso de entrega

1. **Fork del repositorio**
   - Realiza un fork del repositorio de examen a tu cuenta de GitHub
   - Esto creará una copia del repositorio en tu cuenta personal

2. **Crear rama personalizada**
   - Crea una rama con el formato: `nombre-apellido`
   - Ejemplo: `juan-perez`

3. **Estructura del repositorio**
   ```
   /
   ├── pregunta-1/
   │   ├── README.md        # Descripción del ejercicio
   │   └── respuesta/        # Aquí colocarás tus archivos YAML
   ├── pregunta-2/
   │   ├── README.md
   │   └── respuesta/
   └── ...
   ```

4. **Resolución de ejercicios**
   - Cada carpeta `pregunta-X` contiene un README con las instrucciones específicas
   - Coloca tus archivos YAML de solución en la carpeta `respuesta` correspondiente
   - Asegúrate de seguir exactamente la estructura y nombres de archivos solicitados

5. **Evaluación automática**
   - Al crear el Pull Request (PR), se activarán automáticamente los GitHub Workflows
   - Cada workflow evaluará un punto específico del examen
   - Podrás ver el resultado de cada evaluación en la pestaña "Actions" del PR
   - ✅ Verde: Punto correcto
   - ❌ Rojo: Punto incorrecto (revisar los logs para ver el error)

6. **Envío final**
   - Crea un Pull Request desde tu rama `nombre-apellido` hacia la rama `main` del repositorio original
   - Título del PR: "Solución Examen - Nombre Apellido"
   - No realices merge del PR, pues el instructor lo revisara con detalle, para saber si esta bien cada punto

### Importante

- No modifiques ningún archivo fuera de las carpetas `respuesta/`
- Asegúrate de que todos tus archivos YAML sean válidos sintácticamente
- Puedes realizar múltiples commits mientras trabajas
- Los workflows se ejecutarán en cada push a tu rama
- Tienes un máximo de 10 intentos por pregunta (10 push con correcciones)

### Criterios de evaluación

- Funcionalidad correcta según los requisitos (validado por workflows)
- Estructura y organización del código
- Buenas prácticas de Kubernetes
- Nomenclatura y consistencia

### Tiempo límite

- Tendrás 4 horas para completar el examen desde que hagas el primer commit
- El timestamp del último commit válido será considerado como tiempo de entrega

### Recursos permitidos

- Documentación oficial de Kubernetes
- Apuntes y ejercicios del curso
- No está permitido copiar soluciones de otros estudiantes

¡Éxito en tu examen!

