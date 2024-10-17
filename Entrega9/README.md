# 🚀 Guía para Crear Instancia EC2, S3 y EBS en AWS

Este documento proporciona un paso a paso para la creación y configuración de una **Instancia EC2**, un **Bucket S3** y un **Volumen EBS** en AWS.

## 📝 Índice

1. [Creación de una Instancia EC2](#1-creación-de-una-instancia-ec2)
2. [Configuración de S3](#2-configuración-de-s3)
3. [Crear y Asociar un EBS](#3-crear-y-asociar-un-ebs)

---

## 1. Creación de una Instancia EC2

### 1.1 Acceso a EC2
- Ingresar a la consola de AWS.
- En la barra de búsqueda, buscar **EC2** y seleccionar el servicio.
- Hacer clic en **Lanzar Instancia**.

### 1.2 Configuración de la instancia
- Seleccionar el sistema operativo (en este caso, **Linux**).
- Configurar las claves de acceso para la instancia (SSH keys).
- Configurar la red y la subred, asegurándote de elegir la zona de disponibilidad correcta (ej. `us-east-1a`).

### 1.3 Configuración del Grupo de Seguridad
- Crear un **Grupo de Seguridad** con las reglas necesarias:
  - Permitir tráfico HTTP (puerto 80), HTTPS (puerto 443) y SSH (puerto 22).

### 1.4 Configurar Almacenamiento y Script de Inicio (User Data)
- Configurar el almacenamiento según las necesidades de la instancia.
- Añadir el siguiente script en la sección **User Data** para instalar Apache y servir una página HTML simple:

    ```bash
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><h1>Apache está funcionando</h1></html>" > /var/www/html/index.html
    ```

### 1.5 Lanzar la Instancia
- Revisar el resumen de configuración y hacer clic en **Lanzar Instancia**.

---

## 2. Configuración de S3

### 2.1 Acceso a S3
- En la barra de búsqueda de la consola de AWS, buscar **S3** y seleccionar la primera opción.
- Hacer clic en **Crear Bucket**.

### 2.2 Configuración del Bucket
- Configura el bucket asegurándote de que la **región sea la misma** que la de tu instancia EC2.
- Configura las opciones según lo requerido y crea el bucket.

---

## 3. Crear y Asociar un EBS

### 3.1 Creación del Volumen EBS
- En el panel de **EC2**, selecciona **Volúmenes** en el menú lateral izquierdo.
- Hacer clic en **Crear Volumen**, asegurándote de que esté en la **misma zona** que la instancia EC2.

### 3.2 Asociar Volumen EBS a EC2
- Selecciona el volumen recién creado.
- Hacer clic en **Acciones** > **Asociar Volumen** y seleccionar la instancia EC2.

### 3.3 Montar y Formatear el Volumen EBS
- Conéctate a la instancia EC2 mediante SSH y ejecuta los siguientes comandos para formatear y montar el volumen:

    ```bash
    sudo mkfs -t ext4 /dev/xvdb
    sudo mkdir /desafíos
    sudo mount /dev/xvdb /desafíos
    ```

### 3.4 Configurar el Montaje Automático (`fstab`)
- Agrega el volumen al archivo `/etc/fstab` para que se monte automáticamente en cada reinicio:

    ```bash
    sudo vim /etc/fstab
    ```

### 3.5 Descargar Archivos desde S3
- Instalar AWS CLI en la instancia:

    ```bash
    sudo yum install aws-cli -y
    ```

- Configura la CLI de AWS:

    ```bash
    aws configure
    ```

- Ejecuta el siguiente comando para descargar un archivo desde S3 al volumen EBS:

    ```bash
    aws s3 cp s3://entregable9estudiait/Desafío9-aws-BootcampDevops.pdf /desafíos/
    ```

---

## ⚡ Conclusión

Siguiendo estos pasos, habrás creado y configurado exitosamente una instancia **EC2**, un **Bucket S3** y un **Volumen EBS** en AWS. Recuerda eliminar los recursos no utilizados para evitar costos innecesarios.

---

💡 **Nota:** Asegúrate de seguir las mejores prácticas de seguridad, como la configuración correcta de permisos de seguridad y el manejo adecuado de las claves de acceso.
