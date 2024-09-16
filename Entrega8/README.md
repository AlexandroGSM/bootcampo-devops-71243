# Comparativa de Precios en AWS para Múltiples Regiones

## Objetivo
El objetivo de este proyecto es comparar los costos de una infraestructura en la nube utilizando servicios de AWS en tres regiones distintas. Los servicios evaluados incluyen EC2, S3, CloudFront, RDS y DynamoDB.

## Servicios Evaluados

1. **EC2 Instances**:
   - 3 instancias **t3.large** en cada región.
   - Cada instancia tiene un volumen EBS de 500GB.
   - Snapshots diarios de los volúmenes EBS.

2. **S3 Storage**:
   - 1 bucket S3 con clase de almacenamiento **Standard**.
   - 1 bucket S3 con clase de almacenamiento **Glacier**.

3. **CloudFront**:
   - Distribución de CloudFront con el bucket S3 Standard como origen.

4. **RDS (Relational Database Service)**:
   - Base de datos relacional **db.t3.medium** con 100GB de almacenamiento.

5. **DynamoDB**:
   - Una tabla de DynamoDB con 100 unidades de lectura y 100 unidades de escritura.

## Regiones Evaluadas

1. **us-east-1** (Virginia del Norte)
2. **eu-west-1** (Irlanda)
3. **ap-south-1** (Mumbai)

## Comparativa de Precios

| **Servicio**         | **us-east-1 (Virginia)** | **eu-west-1 (Irlanda)** | **ap-south-1 (Mumbai)** |
|----------------------|--------------------------|-------------------------|-------------------------|
| **EC2 Instances**     | $210.45                  | $247.63                 | $232.06                 |
| **S3 Standard**       | $93.16                   | $93.16                  | $112.96                 |
| **S3 Glacier**        | $29494.32                | $29494.63               | $41673.38               |
| **CloudFront**        | No se entiende           | No se entiende          | No se entiende          |
| **RDS**               | $144.18                  | $153.78                 | $194.10                 |
| **DynamoDB** (Inicial) | $180.00                  | $203.40                 | $205.20                 |
| **DynamoDB** (Mensual) | $151.14                  | $171.15                 | $172.33                 |


