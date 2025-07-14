# 📝 Minuta Individual de Trabajo

**Nombre:** Lautaro  
**Fecha:** 14/07/2025  
**Sprint:** -
**Rol asignado:** [Dev Team]

---

## ✅ Tareas realizadas

Configuración y manejo de Docker con MongoDB:
Revisión y ajuste de docker-compose para el contenedor de MongoDB usando la imagen percona/mongodb.

Gestión de control de versiones (Git):
Modificación del archivo .gitignore para excluir las carpetas mongo-data y node_modules.

Pruebas y desarrollo de API REST:
Realización de peticiones GET para obtener todos los clientes y un cliente específico.
Prueba de peticiones POST para la creación de clientes nuevos.
Diagnóstico de problemas con peticiones PUT (actualización de clientes), detectando que en lugar de actualizar se agregan registros duplicados.

Observaciones:
Se avanzó significativamente en la integración entre Docker y MongoDB, identificando problemas comunes en el manejo de contenedores y volúmenes.
Buen control de versiones con mensajes claros y organización de archivos ignorados para evitar subir datos sensibles o innecesarios.

## 🧠 Problemas encontrados

-Contenedor MongoDB se apagaba automáticamente
  El contenedor de MongoDB se iniciaba pero se detenía inmediatamente después, sin dejar claro el motivo.
Se modificó la ruta del volumen para que se adapte correctamente al sistema operativo, asegurando que el directorio mongo-data estuviera accesible y con permisos adecuados.


-Exclusión incorrecta de archivos en Git
  La carpeta mongo-data fue subida accidentalmente al repositorio.
Se agregó correctamente /mongo-data/ al .gitignore, se eliminaron los archivos del index de Git y se hizo un commit con un mensaje claro: "Ignorar mongo-data agregándola a .gitignore".

-Método PUT duplicaba registros en lugar de actualizar
  Al enviar una petición PUT para actualizar un cliente, en lugar de modificarlo se agregaba uno nuevo.
Causa: Lógica incorrecta en el controlador. Solucionado.

## 🎯 Tareas hasta la próxima reunión
Seguir con el desarrollo de la api. Avanzar con la investigación sobre tecnologías del frontend (Angular)
