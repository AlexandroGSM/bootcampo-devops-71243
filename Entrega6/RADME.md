# Bootcamp DevOps - Entrega 6: Jenkins y Apache

## Descripción del Proyecto

Este proyecto demuestra la configuración de un pipeline de CI/CD utilizando Jenkins para automatizar el despliegue de una aplicación web simple en un servidor Apache. 
El sistema consta de dos máquinas virtuales: una para Jenkins (VM1) y otra para el servidor web Apache (VM2).

## Componentes del Sistema

- **VM1 (Jenkins Server)**: Aloja Jenkins y actúa como el controlador principal del pipeline.
- **VM2 (Apache Server)**: Actúa como nodo esclavo de Jenkins y aloja el servidor web Apache.

## Configuración

### VM1 (Jenkins Server)

1. Instalación de Jenkins
2. Configuración de Ngrok para exponer Jenkins
3. Generación de claves SSH para la comunicación con VM2

### VM2 (Apache Server)

1. Instalación de Apache
2. Configuración de OpenSSH para permitir conexiones desde Jenkins
3. Instalación de Java para el agente Jenkins

## Pipeline de Jenkins

El pipeline realiza las siguientes tareas:

1. Verifica la instalación de Apache en VM2
2. Despliega un archivo `index.html` actualizado en el servidor Apache

## Archivo Jenkinsfile

```groovy
pipeline {
    agent any
    stages {
        stage('Check Apache') {
            steps {
                sh 'systemctl is-active apache2 || (echo "Apache is not running" && exit 1)'
            }
        }
        stage('Deploy to Apache') {
            steps {
                sh 'echo "<h1>Hello from Jenkins Pipeline</h1>" | sudo /bin/tee /var/www/html/index.html'
            }
        }
    }
}
Configuración de Seguridad

Se configuró sudo en VM2 para permitir la ejecución de comandos específicos sin contraseña.
Se utilizan claves SSH para la autenticación entre Jenkins y el nodo esclavo.

Problemas Comunes y Soluciones

Problema de Permisos: Resuelto ajustando los permisos en /var/www/html y configurando sudo.
Java no encontrado en VM2: Solucionado instalando Java y configurando JAVA_HOME.
Problemas de Conexión SSH: Resueltos verificando y ajustando la configuración de SSH en ambas VMs.

Contribuciones
Las contribuciones a este proyecto son bienvenidas. Por favor, abre un issue o un pull request para sugerir cambios o mejoras.
