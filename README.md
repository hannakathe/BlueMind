# Descripción del Proyecto: BlueMind

**Versión:** 0.1  
**Fecha:** 18/03/2025  

## 📌 Introducción
BlueMind es una plataforma digital interactiva diseñada para educar y sensibilizar a distintos públicos sobre la conservación de los océanos y el acceso al agua limpia. El sitio web busca combinar información educativa con elementos interactivos que fomenten el aprendizaje y la participación ciudadana en la preservación de los recursos hídricos.

## 📌 Propósito
El propósito principal de BlueMind es crear conciencia sobre la importancia de la conservación marina, proporcionando recursos educativos accesibles y promoviendo la divulgación científica sobre la conservación de los océanos y el agua limpia. Además, la plataforma ofrecerá herramientas interactivas para facilitar el aprendizaje y la participación de la comunidad.

## 📌 Alcance del Proyecto
La plataforma BlueMind incluirá:
- Secciones educativas con información sobre la conservación de los océanos y el acceso al agua limpia.
- Recursos didácticos para docentes y estudiantes.
- Un blog de divulgación científica con artículos y reportes actualizados.
- Un álbum de especies con imágenes y descripciones detalladas.
- Un mapa interactivo con datos sobre contaminación en distintas regiones del mundo.
- Funcionalidades interactivas, como reportes de contaminación por los usuarios y un sistema de comentarios y valoraciones en las publicaciones.

## 📌 Tecnología utilizada
- **Diseño UI/UX:** Figma.
- **Desarrollo:** Flutter/Dart.
- **Servicios en la nube:** para almacenamiento de archivos multimedia y datos del sistema.
- **Base de datos:** SQL o NoSQL para almacenar información de usuarios y contenido.
- **API de autenticación:** Integración con Firebase o Auth0.
- **Mapa interactivo:** Uso de API como Google Maps o Leaflet para visualizar la contaminación en tiempo real.
- **Sistema de gestión y moderación de contenido** en un panel de administración para gestionar usuarios, publicaciones y comentarios.

## 📌 Organización del Proyecto
El equipo de desarrollo está compuesto por cuatro integrantes: Roles(Investigación y análisis, Diseño UI/UX y documentación, Desarrollo y programación del sitio web e interactividad, Desarrollo y validación de funcionalidades, Pruebas de funcionalidad y accesibilidad)

- **Sebastián Mondragón**: .
- **Laura Espejo**: .
- **Hanna Abril**: .
- **Juan Castro**: .

Se utilizarán herramientas como **Figma, Flutter/Dart, Google Docs y Scrum** para la gestión del proyecto. La planificación se basará en una metodología ágil con reuniones semanales y fases iterativas de desarrollo, pruebas y ajustes antes del lanzamiento final en junio 2025.

## 📌 Estructura del Proyecto

El proyecto sigue una estructura de carpetas bien organizada para facilitar su desarrollo y mantenimiento. A continuación, se presenta una posible estructura del repositorio de código:

```
BlueMind/
├── frontend/                   # Código del frontend en Flutter
│   ├── 📂 lib/                  # Carpeta principal de código fuente
│   │   ├── 📂 assets/            # Recursos gráficos (imágenes, íconos, fuentes)
│   │   ├── 📂 images/            # Imágenes de la aplicación
│   ├── 📂 components/            # Componentes reutilizables de UI (botones, tarjetas, etc.)
│   ├── 📂 pages/                 # Pantallas principales de la app
│   │   ├── home_view.dart       # Pantalla de inicio
│   │   ├── login_view.dart       # Pantalla de inicio de sesión
│   │   ├── register_view.dart    # Pantalla de registro
│   │   ├── profile_view.dart     # Pantalla de perfil de usuario
│   │   ├── blog_view.dart       # Pantalla de blog y artículos
│   │   ├── map_view.dart        # Mapa interactivo
│   │   ├── reports_view.dart     # Reportes de contaminación
│   │   ├── admin_view.dart       # Panel de administración
│   ├── 📂 providers/             # Providers para manejo de estado (Provider/Riverpod)
│   ├── 📂 services/              # Servicios (Auth, Firestore, API externos)
│   ├── 📂 models/                # Definición de clases y modelos de datos
│   ├── 📂 utils/                 # Funciones auxiliares y constantes
│   ├── 📜 main.dart              # Archivo principal de la aplicación Flutter
│   ├── 📜 pubspec.yaml           # Archivo de configuración de dependencias
│   ├── 📜 routes.dart            # Definición de rutas y navegación
│
├── 📂 backend/                   # Backend con Firebase y/o Python (opcional)
│   ├── 📂 firebase/               # Configuración de Firebase (Cloud Functions)
│   ├── 📜 app.py                  # Archivo principal (si se usa Flask/FastAPI)
│   ├── 📂 database/               # Lógica de base de datos
│   │   ├── models/                # Modelos de Firestore o SQL
│   │   ├── services/              # Servicios de conexión a Firestore
│   ├── 📂 routes/                 # Endpoints de la API
│   │   ├── auth_service.dart      # Lógica de autenticación
│   │   ├── user_service.dart      # CRUD de usuarios
│   │   ├── content_service.dart   # Gestión de contenido (blog y recursos)
│   │   ├── report_service.dart    # Gestión de reportes de contaminación
│   │   ├── notifications_service.dart # Notificaciones Firebase
│   ├── 📂 tests/                  # Pruebas del backend
│   │   ├── test_api.dart           # Pruebas de integración con APIs
│   ├── 📂 config/                 # Configuración del backend
│   │   ├── firebase_config.dart    # Configuración de Firebase
│   │   ├── environment.dart        # Variables de entorno
│   ├── 📜 requirements.txt         # Dependencias si se usa Python
│   ├── 📜 README.md                # Documentación del backend
│
├── 📂 docs/                        # Documentación general del proyecto
│   ├── 📜 guia_desarrollo.pdf       # Documento guía del desarrollo
│   ├── 📜 arquitectura.md           # Documentación sobre la arquitectura
│   ├── 📂 casos_de_uso/             # Diagramas de casos de uso
│   ├── 📂 secuencias/               # Diagramas de secuencia
│   ├── 📂 base_de_datos/            # Modelo de datos y estructura de Firestore
│   ├── 📂 api/                      # Documentación de API y endpoints
│   ├── 📂 pruebas/                  # Plan de pruebas y resultados
│   ├── 📂 informes/                  # Reportes y métricas del sistema
│   ├── 📂 presentación/              # Documentos para la defensa final
│
├── 📂 .github/                     # Configuración de GitHub Actions y CI/CD
│   ├── 📂 workflows/                 # Workflows de automatización
│
└── 📜 README.md                    # Documentación del proyecto

```
## **📌 Clonar el Repositorio**

### **📍 Opción 1: Usando Git (Recomendado)**
1. Abre una terminal o consola en tu computadora.
2. Navega hasta la carpeta donde quieres clonar el proyecto:
   ```sh
   cd ~/Documentos/Proyectos
   ```
3. Ejecuta el siguiente comando para clonar el repositorio:
   ```sh
   git clone https://github.com/hannakathe/BlueMind.git
   ```
4. Entra en la carpeta del proyecto:
   ```sh
   cd BlueMind
   ```

---

### **📍 Opción 2: Usando GitHub Desktop**
1. Abre **GitHub Desktop**.
2. Haz clic en **File** > **Clone Repository**.
3. En la pestaña **URL**, pega la siguiente dirección:
   ```
   https://github.com/hannakathe/BlueMind.git
   ```
4. Selecciona la carpeta donde quieres guardar el proyecto y haz clic en **Clone**.

## 📌 Clonar una Rama desde la Consola (Git)

### 📍 Opción 1: Crear una nueva rama a partir de otra y cambiar a ella
Si necesitas crear una nueva rama a partir de otra existente, sigue estos pasos:

1. **Asegúrate de estar en la rama desde la cual quieres clonar:**
   ```sh
   git checkout develop  # Cambia "develop" por la rama base
   ```

2. **Actualizar la rama base antes de crear una nueva:**
   ```sh
   git pull origin develop  # Asegúrate de tener la última versión
   ```

3. **Crear una nueva rama basada en la rama actual:**
   ```sh
   git checkout -b feature/nueva-funcionalidad
   ```

4. **Subir la nueva rama al repositorio remoto:**
   ```sh
   git push origin feature/nueva-funcionalidad
   ```

---

### 📍 Opción 2: Clonar una rama sin cambiar a ella inmediatamente
Si deseas crear una nueva rama a partir de otra sin cambiar a ella de inmediato:

```sh
git branch feature/nueva-funcionalidad develop  # Crea la rama sin moverte a ella
```

Para cambiarte a la nueva rama después de crearla:

```sh
git checkout feature/nueva-funcionalidad
```

---

## 📌 Clonar una Rama desde GitHub Desktop

1. **Abrir GitHub Desktop** y asegurarte de que tienes el repositorio abierto.
2. Hacer clic en **Current Branch** en la parte superior.
3. En la ventana emergente, seleccionar la rama base desde la cual quieres crear la nueva.
4. En la barra de búsqueda, escribir el nombre de la nueva rama y hacer clic en **Create Branch**.
5. GitHub Desktop cambiará automáticamente a la nueva rama.
6. Si necesitas subir la nueva rama al repositorio, haz clic en **Publish Branch**.

---

## 📌 Verificar las Ramas Existentes
Si necesitas verificar qué ramas existen en el repositorio:

- Para ver las ramas locales:
  ```sh
  git branch
  ```

- Para ver las ramas remotas:
  ```sh
  git branch -r
  ```

- Para ver todas las ramas (locales y remotas):
  ```sh
  git branch -a
  ```


## 📌 Definición del Flujo de Trabajo en GitHub
Para mantener la organización y evitar conflictos en el código, seguimos un flujo de trabajo basado en **GitFlow**, asegurando un desarrollo estructurado y colaborativo.

### 📍 Ramas del Repositorio

**`main`** → Versión estable del proyecto.
- Esta rama **solo contiene código en producción**.
- No se hacen cambios directos aquí. Cualquier nueva funcionalidad o corrección de errores pasa primero por `develop` y luego se fusiona a `main` mediante un **Pull Request aprobado**.

**`develop`** → Rama de desarrollo.
- Aquí se integran las nuevas funcionalidades antes de pasar a `main`.
- Todo el código nuevo debe ser probado en esta rama antes de considerar su despliegue.

**`feature/nombre-de-la-funcionalidad`** → Ramas de nuevas características.
- Cada desarrollador crea una rama **a partir de `develop`** para trabajar en una funcionalidad específica.
- Ejemplo de nombre: `feature/autenticacion-google`.
- Una vez terminada la funcionalidad, se hace un **Pull Request a `develop`**.

**`hotfix/nombre-del-bug`** → Ramas para corregir errores críticos en producción.
- Se crean directamente desde `main` si hay un error grave que necesita solución inmediata.
- Ejemplo de nombre: `hotfix/correccion-login`.
- Una vez corregido, se fusiona en `main` y `develop`.

**`release/nombre-de-version`** → Ramas para preparación de versiones.
- Se crean cuando se está listo para lanzar una nueva versión estable.
- Aquí se hacen pruebas finales y ajustes menores antes de fusionarlo con `main`.

### 📍 Proceso de Revisión de Código (Pull Requests en GitHub)
Para garantizar calidad en el código y evitar conflictos, se seguirán estos pasos:

1. Cada desarrollador **creará su propia rama** a partir de `main` con el formato: `feature/nombre-de-la-funcionalidad`.
2. Una vez completado el desarrollo, se hará un **Pull Request (PR) en GitHub** desde la rama de la funcionalidad hacia `main`.
3. Mínimo **dos integrantes deben revisar y aprobar** el PR antes de fusionarlo. Se utilizarán revisores asignados en **Scrum**.
4. Se ejecutarán **pruebas unitarias y de integración** antes de aceptar el PR.  
5. Después de aprobarse el PR, se hará un **merge** a la rama `main`.

### 📍 Flujo de Trabajo en Git (Terminal)

1. **Actualizar el código local** antes de empezar a trabajar:
   ```sh
   git pull origin develop
   ```

2. **Crear una nueva rama para la funcionalidad en la que trabajarás:**
   ```sh
   git checkout -b feature/nombre-de-la-funcionalidad
   ```

3. **Desarrollar la funcionalidad** y hacer commits frecuentes:
   ```sh
   git add .
   git commit -m "Descripción breve del cambio realizado"
   ```

4. **Subir la rama al repositorio remoto:**
   ```sh
   git push origin feature/nombre-de-la-funcionalidad
   ```

5. **Crear un Pull Request (PR) en GitHub** para fusionar los cambios en `develop`.

6. **Revisión y aprobación:** Otro desarrollador del equipo debe revisar el código antes de aprobar el PR.

7. **Fusionar la rama en `develop`** una vez aprobado el PR.
   ```sh
   git checkout develop
   git merge feature/nombre-de-la-funcionalidad
   ```

8. **Eliminar la rama de la funcionalidad después de la fusión:**
   ```sh
   git branch -d feature/nombre-de-la-funcionalidad
   ```

### 📍 Flujo de Trabajo en GitHub Desktop

1. **Actualizar el código local:**
   - Abre **GitHub Desktop**.
   - Asegúrate de estar en la rama `develop`.
   - Haz clic en **Fetch origin** y luego en **Pull** para actualizar el código.

2. **Crear una nueva rama para la funcionalidad:**
   - Haz clic en **Current Branch**.
   - Escribe `feature/nombre-de-la-funcionalidad` y selecciona **Create new branch**.

3. **Desarrollar la funcionalidad y hacer commits frecuentes:**
   - Realiza los cambios en el código en tu editor de preferencia.
   - Vuelve a **GitHub Desktop** y verás los cambios en la sección **Changes**.
   - Escribe un mensaje de commit y haz clic en **Commit to feature/nombre-de-la-funcionalidad**.

4. **Subir la rama al repositorio remoto:**
   - Haz clic en **Push origin** para subir la rama a GitHub.

5. **Crear un Pull Request (PR) en GitHub:**
   - En GitHub Desktop, haz clic en **Create Pull Request**.
   - Esto abrirá GitHub en el navegador donde podrás asignar revisores y agregar una descripción.

6. **Revisión y aprobación:** Otro miembro del equipo revisará el código antes de fusionarlo.

7. **Fusionar la rama en `develop`:**
   - Una vez aprobado, fusiona el Pull Request en GitHub.

8. **Eliminar la rama después de la fusión:**
   - En GitHub Desktop, cambia a la rama `develop`.
   - En **Current Branch**, selecciona la rama eliminada y haz clic en **Delete branch**.

## 📌 Integración con Google Docs para la documentación
**¿Qué se debe hacer?**  
1. **Configurar Google Drive para el equipo**  
   - Crear una carpeta compartida en **Google Drive**.  
   - Dar permisos de edición a todo el equipo de desarrollo.  

2. **Estructurar documentos base**  
   - Documento para **Backlog y sprints** (seguimiento del desarrollo).  
   - Documento para **documentación técnica** (base de datos, APIs, arquitectura).  
- Documentar avances semanales en un **Google Doc compartido**.  

##  📌 Metodología y Herramientas
El desarrollo seguirá una **metodología ágil** con reuniones semanales para evaluar avances y ajustar estrategias. Se usarán herramientas como:

- **Gestión del proyecto**: Trello para la planificación y seguimiento de tareas.
- **Diseño UI/UX**: Figma para la creación de wireframes y prototipos.
- **Desarrollo web**: Flutter/Dart.
- **Base de datos**: SQL o NoSQL.
- **Servicios externos**: Firebase/Auth0 para autenticación, Google Maps o Leaflet para mapas, almacenamiento en la nube para multimedia y documentos.

# **📌 Resumen General de Sprints**
| **Sprint** | **Fechas** | **Objetivo Principal** |
|-----------|------------|----------------------|
| **Sprint 1** | 13 mar - 27 mar | Configuración del entorno y autenticación básica |
| **Sprint 2** | 27 mar - 10 abr | UI principal y gestión de usuarios |
| **Sprint 3** | 10 abr - 24 abr | Blog, comentarios y biblioteca científica |
| **Sprint 4** | 24 abr - 8 may | Mapas, reportes de contaminación y favoritos |
| **Sprint 5** | 8 may - 22 may | Panel de administración, chatbot y optimización |
| **Sprint 6** | 22 may - 31 may | PWA, gamificación y lanzamiento final |

## 📌 Conclusión
BlueMind es una plataforma educativa innovadora diseñada para concienciar sobre la conservación de los océanos y el acceso al agua limpia. Con un enfoque en accesibilidad, usabilidad y sostenibilidad, ofrecerá contenido interactivo y educativo para diversos públicos. Su desarrollo sigue un enfoque iterativo con tecnologías modernas y buenas prácticas en UI/UX y gestión de proyectos, asegurando una plataforma eficiente y de alto impacto ambiental y educativo.
