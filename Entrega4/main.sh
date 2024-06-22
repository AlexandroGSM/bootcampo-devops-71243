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
