# AWS CloudFormation Template Project

Este repositorio contiene plantillas de AWS CloudFormation para desplegar recursos en AWS de manera automática y reproducible.

## Descripción

Este proyecto proporciona una plantilla de CloudFormation que despliega los siguientes recursos:
- **EC2 Instance**: Una instancia de EC2 con tipo configurable.
- **S3 Bucket**: Un bucket de S3 con un nombre único.
- **Security Group**: Un grupo de seguridad que permite el acceso SSH y HTTP.

### Recursos incluidos

1. **Instancia EC2**: Se crea una instancia EC2 utilizando el tipo de instancia que se especifique en los parámetros.
2. **Bucket S3**: Se crea un bucket S3 que puede ser usado para almacenar archivos.
3. **Security Group**: Define reglas para permitir tráfico SSH (puerto 22) y HTTP (puerto 80) desde cualquier dirección IP.

## Requisitos previos

1. Tener una cuenta de AWS configurada.
2. Tener instalados y configurados los [AWS CLI](https://aws.amazon.com/cli/)
3. Asegurarse de tener permisos para crear los recursos necesarios (EC2, S3, Security Groups).

## Uso

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/aws-cloudformation-project.git
cd aws-cloudformation-project


2. Implementar el Stack
Para crear el stack usando la plantilla, ejecuta el siguiente comando en la terminal:

aws cloudformation create-stack --stack-name mi-stack --template-body file://template.yaml --parameters ParameterKey=InstanceType,ParameterValue=t2.micro

Reemplaza mi-stack con el nombre que quieras dar al stack y asegúrate de ajustar los parámetros según sea necesario.

3. Eliminar el Stack
Para eliminar el stack y todos los recursos creados, usa este comando:
aws cloudformation delete-stack --stack-name mi-stack
