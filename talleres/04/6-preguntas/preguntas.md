## 6-preguntas

En base a lo hecho hasta ahora, vamos a responder estas preguntas:

1. Cuál es la **Reclaim Policy** para el **PV** `pv-log` ?


2. Qué pasa al PV si el PVC se elimina?

- [ ] No se borra, pero no queda disponible.
- [ ] Se borra el PV también.
- [ ] El PV queda disponible de nuevo.
- [ ] El PV se daña.


3. Intenta borrar el **PVC** y mira que pasa.

4. Por qué queda en ese estado?

R. Porque esta amarrado aún al pod en uso

5. Borra el pod, y mira qué pasó con el **PVC** ?

6. Ahora mira que pasa con el PV (Status) ?