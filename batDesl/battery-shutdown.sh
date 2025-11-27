#!/bin/bash

# Configurações
BATTERY_THRESHOLD=5  # Altere para a porcentagem desejada
CHECK_INTERVAL=30    # Intervalo de verificação em segundos

while true; do
    # Obter porcentagem da bateria (Modicar a BAT comforme tua maquina)
    battery_percentage=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
    battery_status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)
    
    # Verificar se está na bateria e abaixo do limite
    if [ "$battery_status" = "Discharging" ] && [ -n "$battery_percentage" ] && [ "$battery_percentage" -le "$BATTERY_THRESHOLD" ]; then
        # Notificar usuário
        notify-send "Bateria Crítica" "Bateria em ${battery_percentage}%. Desligando em 30 segundos..." -u critical
        
        # Esperar um pouco para o usuário ver a notificação
        sleep 30
        
        # Fechar Firefox graciosamente
        if pgrep firefox > /dev/null; then
            echo "Fechando Firefox..."
            pkill -SIGTERM firefox
            # Esperar o Firefox fechar
            sleep 10
        fi
        
        # Desligar o sistema
        systemctl poweroff
        exit 0
    fi
    
    sleep $CHECK_INTERVAL
done