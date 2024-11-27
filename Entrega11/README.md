Automatización de Despliegue con Ansible y Jenkins

1. Introducción
Este proyecto implementa un pipeline CI/CD utilizando Ansible y Jenkins para automatizar la configuración y despliegue de aplicaciones web en servidores con Nginx y Tomcat.

2. Requisitos Previos
Servidores configurados:
Jenkins (192.168.1.20)
Ansible (192.168.1.21)
Nginx (192.168.1.23)
Tomcat (192.168.1.22)
Conexión SSH establecida entre los servidores.
3. Configuración de los Servidores
3.1 Instalación de herramientas necesarias
En el servidor Ansible:


sudo apt update
sudo apt install ansible -y
En el servidor Jenkins:


sudo apt update
sudo apt install openjdk-17-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
3.2 Generación de claves SSH necesarias
En el servidor Jenkins (192.168.1.20):


ssh-keygen -t rsa -b 4096
ssh-copy-id -i ~/.ssh/id_rsa.pub asurraco@192.168.1.21
En el servidor Ansible (192.168.1.21):


ssh-keygen -t rsa -b 4096
ssh-copy-id -i ~/.ssh/id_rsa.pub asurraco@192.168.1.22
ssh-copy-id -i ~/.ssh/id_rsa.pub asurraco@192.168.1.23
4. Configuración de Ansible
4.1 Inventario
Crear el archivo hosts.ini:


[webservers]
server-nginx ansible_host=192.168.1.23 ansible_user=usuario_ansible
server-tomcat ansible_host=192.168.1.22 ansible_user=usuario_ansible
4.2 ansible.cfg
Crear el archivo ansible.cfg:


[defaults]
inventory = /ruta/al/hosts.ini
remote_user = usuario_ansible
host_key_checking = False
4.3 Playbook
Consulta el Playbook completo aquí.

5. Instalación y Configuración de Ngrok
5.1 Instalación

curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update && sudo apt install ngrok
5.2 Configuración inicial
Autentica Ngrok:


ngrok config add-authtoken <TU_TOKEN>
Ejecuta Ngrok para exponer Jenkins:


ngrok http 8080
6. Configuración de Jenkins
6.1 Instalación y Configuración Inicial
Accede a Jenkins en: https://<SUBDOMINIO>.ngrok.io.

Instala los siguientes plugins:

Pipeline
Git Plugin
SSH Agent Plugin
6.2 Credenciales
SSH para Ansible:

Tipo: SSH Username with private key.
Configuración:
Username: usuario_ansible.
Private Key: Copia la clave privada generada en Ansible.
ID: ansible-ssh-credentials.
Acceso a GitHub:

Tipo: SSH Username with private key.
Configuración:
Username: tu usuario de GitHub.
Private Key: Clave privada generada en Jenkins.
ID: github-ssh.
6.3 Pipeline
Ejemplo de pipeline:

groovy

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
7. Configuración de Git
7.1 Configurar el repositorio
Clona el repositorio en Jenkins:

git clone git@github.com:usuario/repo.git
7.2 Configurar el webhook
En GitHub:

Ve a Settings > Webhooks > Add Webhook.
Configura:
Payload URL: https://<SUBDOMINIO>.ngrok.io/github-webhook/.
Content Type: application/json.
Events: Push events.
8. Pruebas y Ejecución
Realiza un cambio en el archivo index.html.
Confirma y envía los cambios:

git add index.html
git commit -m "Actualización"
git push origin master
Verifica:
Que Jenkins ejecute el pipeline automáticamente.
Que el archivo index.html se despliegue en los servidores.
9. Cómo Funciona
Este flujo utiliza Jenkins para automatizar la ejecución de un playbook de Ansible que:

Configura los servidores.
Instala servicios (Nginx, Java, Tomcat).
Despliega un archivo estático.
Verifica el estado final y notifica resultados.
