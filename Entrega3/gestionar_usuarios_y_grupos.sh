#!/bin/bash

# Variables globales
grupos=("Desarrollo" "Operaciones" "Ingenieria")
usuarios=("Usuario1" "Usuario2" "Usuario3" "Usuario4" "Usuario5" "Usuario6")
PASSWORD="password123"

# Función para registrar en el syslog
log_syslog() {
    logger -t user_admin "$1"
}

# Crear grupos
for grupo in "${grupos[@]}"; do
    sudo groupadd "$grupo"
    log_syslog "Grupo '$grupo' creado."
done

# Asignación de usuarios a grupos, añadir contraseña y establecer permisos.
index=0
for grupo in "${grupos[@]}"; do
    for i in {1..2}; do
        user="${usuarios[index]}"
        
        # Crear el usuario y añadirlo al grupo
        if sudo useradd -G "$grupo" -s /bin/bash "$user"; then
            log_syslog "Usuario '$user' creado y añadido al grupo '$grupo'."
            
            # Establecer la contraseña del usuario
            echo "$user:$PASSWORD" | sudo chpasswd
            log_syslog "Contraseña establecida para el usuario '$user'."
            
            # Crear directorio home del usuario
            sudo mkdir -p "/home/$user"
            log_syslog "Directorio home '/home/$user' creado."
            
            # Establecer propietario y permisos del directorio home
            sudo chown "$user:$user" "/home/$user"
            sudo chmod 755 "/home/$user"
            log_syslog "Permisos establecidos para el directorio '/home/$user'."
        else
            log_syslog "Error al crear el usuario '$user'."
        fi
        index=$((index + 1))
    done
done

