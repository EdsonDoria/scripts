#!/bin/bash
# Inicia o script e indica que será interpretado pelo bash
tar -czvf /backup/full_backup_$(date +%F).tar.gz /home /etc