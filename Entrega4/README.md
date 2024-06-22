# Proyecto de Automatización con Scripts Bash

Este proyecto contiene scripts para instalar Apache Tomcat 10 en un sistema Linux y realiza el copiado del archivo de configuración index.html.

## Contenido

- `main.sh`: Script principal que orquesta las funciones de instalación y configuración.
- `funciones.sh`: Script que contiene funciones reutilizables para detectar la distribución de Linux, el gestor de paquetes, y realizar la instalación y configuración de Tomcat.
- `index.html`: Archivo HTML simple que se desplegará en el directorio raíz de Tomcat.

## Requisitos

- Sistema operativo basado en Linux (Ubuntu, Fedora, Arch, openSUSE, etc.).
- Permisos de superusuario (sudo).

## Instrucciones de Uso

1. **Clona el repositorio**:

    ```bash
    git clone https://github.com/tuusuario/tu-repositorio.git
    cd tu-repositorio
    ```

2. **Concede permisos de ejecución a los scripts**:

    ```bash
    chmod +x funciones.sh
    chmod +x main.sh
    ```

3. **Ejecuta el script principal**:

    ```bash
    sudo ./main.sh
    ```

4. **Verifica el despliegue de `index.html`**:
   Abre tu navegador y visita `http://<tu-servidor>:8080` para ver la página desplegada.

## Explicación Técnica

### `main.sh`

Este script principal orquesta el flujo de instalación y configuración de Tomcat 10:

```bash
#!/bin/bash

# Incluir las funciones desde funciones.sh
source ./funciones.sh

log_message "Ejecución del script principal iniciada."

# Detectar la distribución de Linux
log_message "Ejecución de la función para detectar distribución"
detect_linux_distribution

# Detectar el gestor de paquetes
log_message "Ejecución de la función para detectar gestor de paquetes"
package_manager=$(detect_package_manager)

# Actualizar el gestor de paquetes
log_message "Ejecución de la función para actualizar gestor de paquetes"
update_package_manager "$package_manager"

# Instalar Apache Tomcat
log_message "Ejecución de la función para instalar Tomcat"
install_apache_tomcat "$package_manager"

# Función para verificar y crear el directorio raíz de Tomcat 10
log_message "Ejecución de la función para verificar y crear el directorio raíz de Tomcat 10"
check_and_create_tomcat_root

# Copiar el archivo index.html
log_message "Ejecución de la función para copiar archivo index.html"
copy_index_html

log_message "Ejecución del script principal completada."
funciones.sh
Este script contiene varias funciones reutilizables:


#!/bin/bash

# Función de logging
log_message() {
    local message=$1
    logger "$message"
}

# Función para detectar y mostrar la distribución de Linux instalada
detect_linux_distribution() {
    local distribution=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
    if [ -z "$distribution" ]; then
        distribution="Unknown"
    fi

    echo "Distribución de Linux detectada: $distribution"
    log_message "Distribución de Linux detectada: $distribution"
}

# Función para detectar el gestor de paquetes instalado
detect_package_manager() {
    local package_manager="Unknown"
    if command -v apt &>/dev/null; then
        package_manager="APT"
    elif command -v dnf &>/dev/null; then
        package_manager="DNF"
    elif command -v yum &>/dev/null; then
        package_manager="YUM"
    elif command -v pacman &>/dev/null; then
        package_manager="Pacman"
    elif command -v zypper &>/dev/null; then
        package_manager="Zypper"
    fi

    echo $package_manager
    log_message "Gestor de paquetes detectado: $package_manager"
}

# Función para actualizar el gestor de paquetes
update_package_manager() {
    local package_manager=$1
    case $package_manager in
        "APT")
            sudo apt update && sudo apt upgrade -y
            ;;
        "DNF")
            sudo dnf upgrade -y
            ;;
        "YUM")
            sudo yum upgrade -y
            ;;
        "Pacman")
            sudo pacman -Syu --noconfirm
            ;;
        "Zypper")
            sudo zypper update -y
            ;;
        *)
            echo "Gestor de paquetes no reconocido."
            log_message "Gestor de paquetes no reconocido."
            ;;
    esac
    log_message "Actualización del sistema completada usando $package_manager."
}

# Función para instalar Apache Tomcat
install_apache_tomcat() {
    local package_manager=$1
    case $package_manager in
        "APT")
            sudo apt install tomcat10 -y
            ;;
        "DNF")
            sudo dnf install tomcat10 -y
            ;;
        "YUM")
            sudo yum install tomcat10 -y
            ;;
        "Pacman")
            sudo pacman -S tomcat10 -y
            ;;
        "Zypper")
            sudo zypper install tomcat10 -y
            ;;
        *)
            echo "Gestor de paquetes no reconocido."
            log_message "Gestor de paquetes no reconocido."
            ;;
    esac
    log_message "Apache Tomcat instalado usando $package_manager."
}

# Función para verificar y crear el directorio raíz de Tomcat 10
check_and_create_tomcat_root() {
    local tomcat_root_dir="/usr/share/tomcat10-root/default_root"

    if [ -d "$tomcat_root_dir" ]; then
        echo "El directorio raíz de Tomcat ya existe en: $tomcat_root_dir"
        log_message "El directorio raíz de Tomcat ya existe en: $tomcat_root_dir."
    else
        echo "El directorio raíz de Tomcat no existe. Creando el directorio en: $tomcat_root_dir"
        log_message "El directorio raíz de Tomcat no existe. Creando el directorio en: $tomcat_root_dir."
        
        sudo mkdir -p "$tomcat_root_dir"
        
        echo "Directorio creado exitosamente."
        log_message "Directorio creado exitosamente."
    fi
}

# Función para copiar un archivo index.html al directorio raíz del servidor web
copy_index_html() {
    sudo cp ./index.html /usr/share/tomcat10-root/default_root/
    echo "Archivo index.html copiado al directorio raíz del servidor web."
    log_message "Archivo index.html copiado al directorio raíz del servidor web."
}
Contribuciones
Para contribuir a este proyecto, por favor sigue estos pasos:

Haz un fork del repositorio.
Crea una rama con tu nueva funcionalidad (git checkout -b feature/nueva-funcionalidad).
Realiza los cambios necesarios y confirma tus cambios (git commit -m 'Añadir nueva funcionalidad').
Empuja tus cambios a la rama (git push origin feature/nueva-funcionalidad).
Abre una Pull Request.