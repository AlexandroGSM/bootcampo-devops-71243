# Creación de Cuenta y Gestión de Usuarios y Roles en AWS

## Objetivo
Este documento proporciona un instructivo paso a paso para la creación de una cuenta en AWS, y la gestión de usuarios y roles mediante el servicio IAM. Incluye la creación de grupos, usuarios y asignación de permisos específicos, como el acceso a facturación.

## Contenido

1. [Crear una Cuenta en AWS](#1-crear-una-cuenta-en-aws)
2. [Acceder a la Consola de AWS](#2-acceder-a-la-consola-de-aws)
3. [Crear un Grupo con Rol de Administrador](#3-crear-un-grupo-con-rol-de-administrador)
4. [Crear un Usuario con Rol de Administrador](#4-crear-un-usuario-con-rol-de-administrador)
5. [Crear un Usuario con Rol de Billing](#5-crear-un-usuario-con-rol-de-billing)
6. [Asignar Permisos de Billing](#6-asignar-permisos-de-billing)

## 1. Crear una Cuenta en AWS

1. Dirígete a [aws.amazon.com](https://aws.amazon.com) y haz clic en "Create an AWS Account".
2. Proporciona la información requerida, incluyendo los datos de pago. AWS ofrece una capa gratuita que permite utilizar muchos servicios sin costo durante el primer año.
3. Recibirás un correo electrónico de verificación. Sigue las instrucciones del correo para verificar tu cuenta.

## 2. Acceder a la Consola de AWS

1. Ingresa a la consola de AWS en [aws.amazon.com/console](https://aws.amazon.com/console).
2. Inicia sesión utilizando las credenciales de tu cuenta raíz (root).

## 3. Crear un Grupo con Rol de Administrador

1. Accede al servicio **IAM (Identity and Access Management)** desde la consola de AWS.
2. En el menú de navegación, selecciona **"User groups"**.
3. Haz clic en **"Create New Group"** y nombra el grupo, por ejemplo, `AdminGroup`.
4. En la sección **"Attach permissions policies"**, selecciona la política **AdministratorAccess**.
5. Completa la creación del grupo.

## 4. Crear un Usuario con Rol de Administrador

1. En IAM, selecciona **"Users"** y haz clic en **"Add user"**.
2. Ingresa un nombre de usuario, por ejemplo, `AdminUser`.
3. Selecciona el tipo de acceso:
   - **Programmatic access**: Para acceder mediante la CLI, SDK o APIs.
   - **AWS Management Console access**: Para acceder a la consola de AWS.
4. Configura una contraseña para el usuario.
5. En **"Set permissions"**, selecciona **"Add user to group"** y elige el grupo `AdminGroup`.
6. Revisa y crea el usuario. Anota las credenciales generadas.

## 5. Crear un Usuario con Rol de Billing

1. En IAM, selecciona **"Users"** y haz clic en **"Add user"**.
2. Ingresa un nombre de usuario, por ejemplo, `BillingUser`.
3. Selecciona el acceso a la consola de administración de AWS.
4. En **"Set permissions"**, selecciona **"Attach policies directly"**.
5. Busca y selecciona la política **Billing**.
6. Revisa y crea el usuario. Anota las credenciales generadas.

## 6. Asignar Permisos de Billing

1. Navega a **"My Account"** y selecciona **"Account settings"**.
2. En **"IAM User and Role Access to Billing Information"**, selecciona **"Edit"**.
3. Marca la casilla para activar el acceso de IAM a la información de facturación.
4. Guarda los cambios.

## Recursos

- [AWS IAM Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/)
- [AWS Management Console](https://aws.amazon.com/console)
