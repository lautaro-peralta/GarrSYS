#📝 Minuta Individual de Trabajo

Nombre: Tomás
Fecha: 20/09/2025
Sprint: -
Rol asignado: dev

✅ Tareas realizadas

Se ajusta zona.routes para llamar rolesMiddleware([Rol.ADMIN]) en lugar de pasar la función directamente.
Ahora las operaciones de creación, actualización y eliminación de zonas validan correctamente que el usuario tenga rol ADMIN.
Se crea validacion para que siempre exista una zona que sea "sede central"

🧩 Problemas encontrados

Antes no se realizaba control sobre las sedes centrales, lo que permitía que el sistema quedara sin ninguna zona marcada como sede central.



