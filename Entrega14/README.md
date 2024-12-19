# Desafío 14: Despliegue de Aplicación Flask con Kubernetes

Este proyecto implementa una aplicación Flask conectada a una base de datos MySQL y gestionada mediante Kubernetes. El entorno incluye balanceo de carga con Nginx y persistencia de datos.

---

## **Requisitos Previos**

1. Un clúster de Kubernetes configurado (puedes usar Minikube, Kind, o un clúster en la nube).
2. `kubectl` instalado y configurado para gestionar el clúster.
3. Token de autenticación para Ngrok.
4. Archivos YAML de despliegue, servicios, ingress y secretos.

---

## **Estructura del Proyecto**

- **`app.py`**: Aplicación Flask con endpoints para interactuar con MySQL.
- **`nginx.conf`**: Configuración de Nginx como balanceador de carga.
- **YAML Files**:
  - `flaskapp-deployment.yml`: Despliegue de la aplicación Flask.
  - `flaskapp-svc.yml`: Servicio para Flask.
  - `mysql-deployment.yml`: Despliegue de MySQL.
  - `mysql-svc.yml`: Servicio para MySQL.
  - `ingress.yml`: Configuración de Ingress para exponer los servicios.
  - `secrets.yml`: Credenciales de MySQL y Flask codificadas en Base64.
  - `kustomization.yml`: Archivo para agrupar los recursos con Kustomize.

---

## **Pasos para Desplegar el Proyecto**

### **1. Configurar el Namespace**

Aplica el namespace definido en `kustomization.yml`:
```bash
kubectl apply -k .
```

### **2. Verificar Recursos**

Confirma que todos los pods, servicios e ingress estén desplegados correctamente:
```bash
kubectl get pods -n dev
kubectl get svc -n dev
kubectl get ingress -n dev
```

### **3. Exponer el Servicio con Ngrok**

1. Obtén el puerto del controlador Ingress:
   ```bash
   INGRESS_PORT=$(kubectl -n ingress-nginx get svc ingress-nginx-controller -o jsonpath='{.spec.ports[0].nodePort}')
   ```

2. Ejecuta Ngrok:
   ```bash
   ngrok http $INGRESS_PORT
   ```

3. Copia la URL proporcionada por Ngrok y úsala para acceder a la aplicación.

---

## **Pruebas de la Aplicación**

### **Pruebas Funcionales**
1. **Endpoint Raíz:**
   - Método: `GET`
   - URL: `https://<ngrok-url>/`
   - Respuesta esperada:
     ```json
     {"message": "Bienvenido a Flaskapp!!"}
     ```

2. **Endpoint `/users`:**
   - Método: `GET`
   - URL: `https://<ngrok-url>/users`
   - Respuesta esperada: Lista de usuarios en la base de datos.

3. **Inserción de Datos:**
   - Método: `POST`
   - URL: `https://<ngrok-url>/users`
   - Body:
     ```json
     {"name": "Usuario de Prueba"}
     ```
   - Respuesta esperada:
     ```json
     {"message": "Data inserted"}
     ```

---

## **Preguntas Resueltas**

1. **¿Cuál es la diferencia entre volúmenes y bind mounts?**
   - **Volúmenes:** Gestionados por Kubernetes/Docker; ideales para producción.
   - **Bind mounts:** Vinculan directorios locales con los contenedores; útiles para desarrollo.

2. **¿Qué sucede si se elimina un volumen o bind mount?**
   - **Volumen:** Los datos almacenados desaparecen permanentemente.
   - **Bind mount:** Si se elimina el directorio del host, el contenedor pierde acceso a los datos.

---

## **Conclusión**
Este proyecto demuestra un despliegue completo de una aplicación web en Kubernetes, integrando componentes esenciales como Flask, MySQL y Nginx. Además, permite validar conceptos clave de persistencia, balanceo de carga y exposición segura de servicios.
