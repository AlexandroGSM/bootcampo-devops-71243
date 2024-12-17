# Desafío 13: Implementación de un Bucket S3 con Terraform

Este repositorio contiene el código Terraform para la creación automatizada de un bucket en Amazon S3, como parte del Desafío 13. Se utiliza un pipeline de GitHub Actions para automatizar el proceso de despliegue.

## Prueba de Concepto: Bucket S3

Se creó un recurso Amazon S3 con las siguientes especificaciones:

*   **Nombre del bucket:** `desafio13-bucket-asurraco`
*   **Región:** `us-east-1`
*   **Etiquetas:**
    *   `Name`: `Desafio13-S3`
    *   `Owner`: `Alexandro Surraco`

## Diagrama de Alto Nivel

_(Aquí se podría agregar un diagrama visual del flujo, si se dispone de uno. Por ejemplo, un esquema simple mostrando el flujo desde GitHub Push -> GitHub Actions -> Terraform -> AWS S3)_

## Estructura del Proyecto

El código fuente está organizado de la siguiente manera:

Proyecto/
├── main.tf       # Configuración del recurso S3
├── providers.tf  # Configuración del proveedor AWS
├── variables.tf  # Declaración de variables
├── outputs.tf    # Salidas de Terraform
└── .github/
└── workflows/
└── terraform.yml # Pipeline de GitHub Actions

## Explicación de los Archivos

### 1. `main.tf`

Define el recurso S3 a crear.

```terraform
resource "aws_s3_bucket" "bucket" {
  bucket = "desafio13-bucket-asurraco"
  tags = {
    Name  = "Desafio13-S3"
    Owner = "Alexandro Surraco"
  }
}

2.0 Flash Experimental. Podría no funcionar como se espera.
Por supuesto. He revisado el documento que proporcionaste y lo he formateado para que sea más legible y visualmente atractivo, listo para ser utilizado como un README.md en GitHub. Aquí te presento la versión mejorada:

Markdown

# Desafío 13: Implementación de un Bucket S3 con Terraform

Este repositorio contiene el código Terraform para la creación automatizada de un bucket en Amazon S3, como parte del Desafío 13. Se utiliza un pipeline de GitHub Actions para automatizar el proceso de despliegue.

## Prueba de Concepto: Bucket S3

Se creó un recurso Amazon S3 con las siguientes especificaciones:

*   **Nombre del bucket:** `desafio13-bucket-asurraco`
*   **Región:** `us-east-1`
*   **Etiquetas:**
    *   `Name`: `Desafio13-S3`
    *   `Owner`: `Alexandro Surraco`

## Diagrama de Alto Nivel

_(Aquí se podría agregar un diagrama visual del flujo, si se dispone de uno. Por ejemplo, un esquema simple mostrando el flujo desde GitHub Push -> GitHub Actions -> Terraform -> AWS S3)_

## Estructura del Proyecto

El código fuente está organizado de la siguiente manera:

Proyecto/
├── main.tf       # Configuración del recurso S3
├── providers.tf  # Configuración del proveedor AWS
├── variables.tf  # Declaración de variables
├── outputs.tf    # Salidas de Terraform
└── .github/
└── workflows/
└── terraform.yml # Pipeline de GitHub Actions


## Explicación de los Archivos

### 1. `main.tf`

Define el recurso S3 a crear.

resource "aws_s3_bucket" "bucket" {
  bucket = "desafio13-bucket-asurraco"
  tags = {
    Name  = "Desafio13-S3"
    Owner = "Alexandro Surraco"
  }
}
2. providers.tf
Configura el proveedor de AWS.

provider "aws" {
  region     = var.AWS_DEFAULT_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

3. variables.tf
Define las variables utilizadas.

Terraform

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "AWS_DEFAULT_REGION" {
  default = "us-east-1"
}
4. outputs.tf
Define las salidas de Terraform, en este caso el nombre del bucket creado.

Terraform

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}
5. terraform.yml
Define el pipeline de GitHub Actions para automatizar los comandos de Terraform.

YAML

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
          TF_TOKEN_app_terraform_io: ${{ secrets.TF_API_TOKEN }} # Utilizar Secrets de Github
        run: terraform init
      - name: Terraform Validate
        working-directory: ./Proyecto
        run: terraform validate
      - name: Terraform Plan
        working-directory: ./Proyecto
        run: terraform plan -no-color
      # Se agrega el paso de apply (opcional, usar con precaución)
      #- name: Terraform Apply
      #  working-directory: ./Proyecto
      #  run: terraform apply -auto-approve # Usar con extrema precaución en producción
Flujo del Pipeline
Desencadenador: El pipeline se activa con un push a la rama Entrega13.
Inicialización: Se ejecuta terraform init para inicializar el entorno de Terraform.
Validación: Se ejecuta terraform validate para verificar la sintaxis de la configuración.
Planificación: Se ejecuta terraform plan para mostrar los cambios que se aplicarán.
(Aplicación - Opcional): He agregado un paso comentado para terraform apply. Se debe usar con extrema precaución, especialmente en producción, y solo si se tiene un control estricto del flujo. Considera usar una confirmación manual o una revisión por pares antes de aplicar los cambios.
Resultado: El bucket S3 se crea en AWS (si se ejecuta el apply).
Mejoras Propuestas
Notificaciones: Integrar alertas (ej., Slack, correo electrónico) para notificar fallos o finalizaciones del pipeline.
Control de Estado: Usar Sentinel Policies (o similares) para validar que los cambios cumplen con los estándares de seguridad y configuración.
Monitoreo: Implementar herramientas de monitoreo (ej., CloudWatch) para el recurso S3 creado.
Gestión de Secretos: Utilizar un gestor de secretos como AWS Secrets Manager o HashiCorp Vault para las credenciales de AWS en lugar de variables de entorno directamente en el workflow.
Aprobación Manual: Antes del paso de terraform apply en el pipeline, implementar una aprobación manual para mayor control.
Backend Remoto: Configurar un backend remoto para el estado de Terraform (e.g., S3, Terraform Cloud) para trabajo en equipo y mayor seguridad.