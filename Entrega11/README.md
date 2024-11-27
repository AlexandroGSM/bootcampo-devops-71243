# 🚀 **Automatización de Despliegue con Ansible y Jenkins**

Este proyecto implementa un flujo CI/CD utilizando **Jenkins**, **Ansible** y servidores web con **Nginx** y **Tomcat**, permitiendo la configuración y despliegue automatizado de aplicaciones.

---

## **📑 Índice**
1. [💡 Introducción](#-introducción)
2. [📋 Requisitos Previos](#-requisitos-previos)
3. [⚙️ Configuración de los Servidores](#️-configuración-de-los-servidores)
4. [🔧 Configuración de Ansible](#-configuración-de-ansible)
5. [🌐 Instalación y Configuración de Ngrok](#-instalación-y-configuración-de-ngrok)
6. [🛠️ Configuración de Jenkins](#️-configuración-de-jenkins)
7. [📂 Configuración de Git](#-configuración-de-git)
8. [✅ Pruebas y Ejecución](#-pruebas-y-ejecución)
9. [📈 Cómo Funciona](#-cómo-funciona)

---

## 💡 **Introducción**

Este proyecto facilita el despliegue de un archivo HTML (`index.html`) en servidores web mediante un pipeline automatizado que integra GitHub, Jenkins y Ansible.

---

## 📋 **Requisitos Previos**

- Servidores configurados:
  - **Jenkins**
  - **Ansible**
  - **Nginx**
  - **Tomcat**
- Conexión SSH establecida entre los servidores.
- Claves SSH generadas y configuradas.

---

## ⚙️ **Configuración de los Servidores**

### **1️⃣ Instalación de herramientas necesarias**
#### **Servidor Ansible:**
```bash
sudo apt update
sudo apt install ansible -y
```

#### **Servidor Jenkins:**
```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
```

### **2️⃣ Generación de claves SSH necesarias**

#### **En Jenkins:**
```bash
ssh-keygen -t rsa -b 4096
ssh-copy-id -i ~/.ssh/id_rsa.pub usuario_ansible@<servidor-ansible>
```

#### **En Ansible:**
```bash
ssh-keygen -t rsa -b 4096
ssh-copy-id -i ~/.ssh/id_rsa.pub usuario_ansible@<servidor-nginx>
ssh-copy-id -i ~/.ssh/id_rsa.pub usuario_ansible@<servidor-tomcat>
```

---

## 🔧 **Configuración de Ansible**

### **1️⃣ Configuración del inventario**
Crear el archivo `hosts.ini`:
```ini
[webservers]
server-nginx ansible_host=<servidor-nginx> ansible_user=usuario_ansible
server-tomcat ansible_host=<servidor-tomcat> ansible_user=usuario_ansible
```

### **2️⃣ Archivo ansible.cfg**
Crear el archivo `ansible.cfg`:
```ini
[defaults]
inventory = /ruta/al/hosts.ini
remote_user = usuario_ansible
host_key_checking = False
```

### **3️⃣ Playbook**
[Ver el Playbook completo aquí](#playbook).

---

## 🌐 **Instalación y Configuración de Ngrok**

### **1️⃣ Instalación**
```bash
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update && sudo apt install ngrok
```

### **2️⃣ Configuración inicial**
Autentica Ngrok:
```bash
ngrok config add-authtoken <TU_TOKEN>
```

Ejecuta Ngrok para exponer Jenkins:
```bash
ngrok http 8080
```

---

## 🛠️ **Configuración de Jenkins**

### **1️⃣ Instalación y configuración inicial**
Accede a Jenkins desde la URL pública proporcionada por Ngrok.

Instala los siguientes plugins:
- **Pipeline**
- **Git Plugin**
- **SSH Agent Plugin**

### **2️⃣ Credenciales**
1. **SSH para Ansible**:
   - Tipo: `SSH Username with private key`.
   - Configuración:
     - Username: `usuario_ansible`.
     - Private Key: Copia la clave privada generada en Ansible.
     - ID: `ansible-ssh-credentials`.

2. **Acceso a GitHub**:
   - Tipo: `SSH Username with private key`.
   - Configuración:
     - Username: tu usuario de GitHub.
     - Private Key: Clave privada generada en Jenkins.
     - ID: `github-ssh`.

### **3️⃣ Pipeline**
Ejemplo de pipeline:
```groovy
pipeline {
    agent any
    stages {
        stage('Clonar Repositorio') {
            steps {
                git credentialsId: 'github-ssh', url: 'https://github.com/usuario/repo.git'
            }
        }
        stage('Ejecutar Playbook') {
            steps {
                sshagent(['ansible-ssh-credentials']) {
                    sh 'ansible-playbook -i /ruta/al/hosts.ini /ruta/al/playbook.yml'
                }
            }
        }
    }
}
```

---

## 📂 **Configuración de Git**

### **1️⃣ Configurar el repositorio**
Clona el repositorio en Jenkins:
```bash
git clone git@github.com:usuario/repo.git
```

### **2️⃣ Configurar el webhook**
En GitHub:
1. Ve a `Settings > Webhooks > Add Webhook`.
2. Configura:
   - **Payload URL**: URL pública de Ngrok (`https://<subdominio>.ngrok.io/github-webhook/`).
   - **Content Type**: `application/json`.
   - **Events**: `Push events`.

---

## ✅ **Pruebas y Ejecución**

1. Realiza un cambio en el archivo `index.html`.
2. Confirma y envía los cambios:
   ```bash
   git add index.html
   git commit -m "Actualización"
   git push origin master
   ```
3. Verifica:
   - Que Jenkins ejecute el pipeline automáticamente.
   - Que el archivo `index.html` se despliegue en los servidores.

---

## 📈 **Cómo Funciona**

1. **GitHub**: Almacena el código fuente y envía notificaciones al realizar cambios.
2. **Jenkins**: Recibe el webhook, ejecuta el pipeline y gestiona la conexión con Ansible.
3. **Ansible**: Configura servidores, despliega archivos y valida servicios.
4. **Servidores Web**:
   - **Nginx**: Sirve contenido estático en su directorio raíz.
   - **Tomcat**: Sirve contenido dinámico o estático desde el directorio `webapps`.

---
