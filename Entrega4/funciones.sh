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