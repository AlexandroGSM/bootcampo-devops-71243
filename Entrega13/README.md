# 🚀 **Desafío 13 - Pipeline CI/CD con Terraform Cloud y GitHub Actions**

---

## 📋 **Descripción del Proyecto**
Este proyecto implementa un pipeline automatizado utilizando **Terraform Cloud**, **GitHub Actions** y **AWS**. Como prueba de concepto (PoC), se decidió aprovisionar un **bucket S3** en AWS de forma automática a través de un flujo CI/CD.

---

## 🛠️ **Tecnologías Utilizadas**
- **Terraform Cloud**: Backend remoto para almacenar el estado y ejecutar planes/applies.
- **GitHub Actions**: Orquestación del pipeline CI/CD.
- **AWS (Amazon Web Services)**: Proveedor donde se aprovisiona el bucket S3.

---

## 🎯 **Objetivo de la PoC**
El objetivo es demostrar la integración entre **Terraform Cloud** y **GitHub Actions** para aprovisionar infraestructura cloud automáticamente.

---

## 📂 **Estructura del Proyecto**

```plaintext
Proyecto/
├── main.tf         # Configuración del recurso S3
├── providers.tf    # Configuración del proveedor AWS
├── variables.tf    # Declaración de variables
├── outputs.tf      # Salidas de Terraform
└── .github/
    └── workflows/
        └── terraform.yml  # Pipeline CI/CD en GitHub Actions
```

---

## 🚀 **Flujo del Pipeline**

1. **Desencadenador**:  
   El pipeline se activa automáticamente con un `push` al branch **Entrega13**.

2. **Ejecución de Pasos**:
   - **`terraform init`**: Inicializa el backend de Terraform.
   - **`terraform validate`**: Valida los archivos de configuración.
   - **`terraform plan`**: Genera el plan de ejecución.
   - **Auto-Apply**: Terraform Cloud aplica los cambios automáticamente.

3. **Resultado**:  
   Se crea un bucket S3 en AWS con las siguientes especificaciones:  
   - **Nombre del bucket**: `desafio13-bucket-asurraco`  
   - **Etiquetas**:  
     - `Name`: Desafio13-S3  
     - `Owner`: Alexandro Surraco  

---

## 📄 **Archivos Clave**

### **main.tf**
Define el recurso S3 que se crea en AWS:
```hcl
resource "aws_s3_bucket" "bucket" {
  bucket = "desafio13-bucket-asurraco"

  tags = {
    Name  = "Desafio13-S3"
    Owner = "Alexandro Surraco"
  }
}
```

### **providers.tf**
Configura el proveedor de AWS:
```hcl
provider "aws" {
  region     = var.AWS_DEFAULT_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}
```

### **variables.tf**
Declara las variables utilizadas en el proveedor:
```hcl
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "AWS_DEFAULT_REGION" {
  default = "us-east-1"
}
```

### **terraform.yml**
Pipeline en GitHub Actions:
```yaml
name: Terraform

on:
  push:
    branches: [Entrega13]

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.5.0

      - name: Terraform Init
        working-directory: ./Proyecto
        env:
          TF_TOKEN_app_terraform_io: ${{ secrets.TF_API_TOKEN }}
        run: terraform init

      - name: Terraform Validate
        working-directory: ./Proyecto
        run: terraform validate

      - name: Terraform Plan
        working-directory: ./Proyecto
        run: terraform plan -no-color
```

---

## 🛠️ **Requisitos Previos**
Antes de ejecutar el proyecto, asegúrate de contar con lo siguiente:

1. **Cuenta en AWS** con credenciales IAM configuradas.
2. **Cuenta en Terraform Cloud**.
3. **Repositorio en GitHub** con las siguientes credenciales configuradas en **Secrets**:
   - `TF_API_TOKEN`: Token de Terraform Cloud.
   - `AWS_ACCESS_KEY_ID`: Clave de acceso AWS.
   - `AWS_SECRET_ACCESS_KEY`: Clave secreta AWS.
4. **Terraform CLI** instalado localmente (opcional para pruebas manuales).

---

## 📈 **Ejecución del Pipeline**
1. Realiza un `push` o `pull request` al branch **`Entrega13`**.
2. GitHub Actions ejecutará automáticamente el pipeline:
   - Inicialización y validación de Terraform.
   - Ejecución del plan y aplicación automática en Terraform Cloud.
3. Terraform Cloud aplicará los cambios y creará el recurso en AWS.

---

## 💡 **Mejoras Propuestas**
1. **Notificaciones**: Integrar notificaciones por correo o Slack al finalizar el pipeline.
2. **Monitoreo**: Implementar monitoreo del bucket S3 con CloudWatch.
3. **Seguridad**: Usar **AWS Secrets Manager** para almacenar credenciales en lugar de variables directas.

---


---

