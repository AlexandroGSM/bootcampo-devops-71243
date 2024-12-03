# **Implementación de Servicios Básicos en AWS con Terraform**

Este proyecto implementa recursos básicos en AWS utilizando Terraform. Los recursos incluyen:
- Una instancia EC2 configurada con Apache.
- Un volumen EBS montado en la instancia EC2.
- Un bucket S3 que almacena un archivo PDF (`desafio12.pdf`).
- Un rol de IAM que permite a la instancia EC2 acceder al bucket S3.

## **Archivos del Proyecto**

### **1. Archivo `main.tf`**
Define los recursos principales en AWS:
- **Instancia EC2**: Una máquina virtual que ejecuta Amazon Linux 2.
- **Grupo de Seguridad**: Permite tráfico HTTP (puerto 80) y SSH (puerto 22).
- **Volumen EBS**: Un almacenamiento adicional montado en `/desafios`.
- **Bucket S3**: Almacena el archivo `desafio12.pdf`.
- **Rol y Política de IAM**: Permiten a la instancia EC2 acceder al bucket S3.

### **2. Archivo `variables.tf`**
Define las variables utilizadas en `main.tf`:
- `aws_region`: Región de AWS donde se crean los recursos.
- `instance_type`: Tipo de instancia EC2 (por defecto, `t2.micro`).
- `volume_size`: Tamaño del volumen EBS en GB (por defecto, 2 GB).

### **3. Archivo `outputs.tf`**
Muestra información importante de los recursos creados:
- `instance_public_ip`: Dirección IP pública de la instancia EC2.
- `bucket_name`: Nombre del bucket S3.
- `ebs_volume_id`: ID del volumen EBS.

---

## **Recursos Implementados**

### **1. Instancia EC2**
- **AMI**: Amazon Linux 2 (`ami-0c02fb55956c7d316`).
- **Tipo**: `t2.micro` (compatible con el Free Tier).
- **Apache**: Instalado y configurado con una página de prueba.

### **2. Volumen EBS**
- **Tamaño**: 2 GB (por defecto, configurable mediante `variables.tf`).
- **Punto de Montaje**: `/desafios`.
- **Propósito**: Almacenar datos descargados desde el bucket S3.

### **3. Bucket S3**
- **Nombre**: `desafio12-bucket-asurraco`.
- **Contenido**: Archivo `desafio12.pdf` subido localmente.

### **4. IAM Role y Políticas**
- **Rol**: `ec2_s3_access_role`.
- **Permisos**:
  - `s3:ListBucket`: Permite listar los objetos en el bucket.
  - `s3:GetObject`: Permite descargar objetos desde el bucket.

---