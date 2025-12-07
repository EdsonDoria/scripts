#!/bin/bash

# diretório 
backup_dir="/backup"

# Cria se não existir
mkdir -p "$backup_dir"

# Criar com data
backup_file="$backup_dir/full_backup_$(date +%F).tar.gz"

# Usar o TAR
tar -czvf "$backup_file" /home /etc

# Mostrar a mensagem de concluido
echo "Backup created: $backup_file"
# ver merda