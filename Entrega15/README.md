# Desafío 15: Despliegue Completo con CI/CD

Este proyecto implementa una aplicación Flask con:
- MySQL como base de datos (con réplicas).
- Nginx como balanceador de carga.
- Docker Compose para orquestar los servicios.
- GitHub Actions para CI/CD, exponiendo el servicio mediante Ngrok.

---

## **Requisitos Previos**

1. Cuenta en GitHub configurada con secretos para CI/CD:
   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`
   - `VM_HOST`
   - `VM_USER`
   - `VM_PASSWORD`
   - `NGROK_AUTH_TOKEN`
2. Una máquina virtual accesible mediante SSH y con Docker instalado.
3. Docker Compose instalado en la VM.

---

## **Estructura del Proyecto**

- **`app.py`**: Aplicación Flask con rutas para interactuar con MySQL.
- **`init.sql`**: Script para inicializar la base de datos.
- **`nginx.conf`**: Configuración de Nginx como balanceador de carga.
- **`docker-compose.yml`**: Orquestación de servicios.
- **GitHub Actions**:
  - `.github/workflows/deploy.yml`: Configura el flujo de CI/CD.

---

## **Pasos para Ejecutar el Proyecto**

### **1. Despliegue Local con Docker Compose**

1. Construye y ejecuta los contenedores:
   ```bash
   docker-compose up -d --build
   ```

2. Verifica que todos los servicios estén corriendo:
   ```bash
   docker-compose ps
   ```

3. Accede a la aplicación en `http://localhost` y prueba los endpoints:
   - **GET /**: Obtiene todos los registros.
   - **POST /**: Inserta un nuevo registro.

---

### **2. Configurar CI/CD con GitHub Actions**

1. **Archivo de flujo de trabajo** (`.github/workflows/deploy.yml`):
   - Construye las imágenes Docker y las sube a Docker Hub.
   - Despliega el proyecto en la VM mediante SSH y Docker Compose.

2. **Configura los secretos** en el repositorio GitHub:
   - `DOCKER_USERNAME` y `DOCKER_PASSWORD` para Docker Hub.
   - `VM_HOST`, `VM_USER`, y `VM_PASSWORD` para acceder a la VM.
   - `NGROK_AUTH_TOKEN` para exponer el servicio con Ngrok.

---

### **3. Exponer el Servicio con Ngrok**

1. Accede a la VM mediante SSH:
   ```bash
   ssh <VM_USER>@<VM_HOST>
   ```

2. Inicia Ngrok en el puerto 80:
   ```bash
   ngrok http 80
   ```

3. Copia la URL proporcionada por Ngrok y utilízala para acceder a la aplicación.

---

## **Pruebas de la Aplicación**

### **1. Endpoints**
- **GET /**:
  ```bash
  curl https://<ngrok-url>/
  ```
  Respuesta esperada:
  ```json
  [{"id": 1, "name": "Usuario de Prueba"}]
  ```

- **POST /**:
  ```bash
  curl -X POST https://<ngrok-url>/ -H "Content-Type: application/json" -d '{"name": "Nuevo Usuario"}'
  ```
  Respuesta esperada:
  ```json
  {"message": "Data inserted"}
  ```

### **2. CI/CD**
1. Realiza un commit y un push a la rama `main`.
2. Verifica que los jobs en GitHub Actions se ejecutan correctamente:
   - Construcción de imágenes Docker.
   - Despliegue remoto en la VM.

3. Valida que la URL de Ngrok expone correctamente la aplicación.

---

## **Preguntas Resueltas**

1. **¿Cómo funciona el balanceador de carga con Nginx?**
   - Nginx distribuye las solicitudes entre las instancias de Flask (`flaskapp1` y `flaskapp2`) definidas en su configuración.

2. **¿Qué sucede si una instancia de MySQL falla?**
   - El esclavo puede seguir manejando las lecturas, pero las escrituras solo están disponibles en el maestro.

3. **¿Por qué usar CI/CD?**
   - Automatiza la construcción y el despliegue, reduciendo errores manuales y mejorando la eficiencia del equipo.

---

## **Conclusión**
Este proyecto demuestra un despliegue completo de una aplicación Flask con MySQL y Nginx, integrando CI/CD con GitHub Actions. La exposición segura mediante Ngrok permite probar y verificar su funcionamiento.
