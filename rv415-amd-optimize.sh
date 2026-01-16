#!/bin/bash

set -e

echo "== Otimizando Debian 13 para Samsung RV415 (AMD Bobcat) =="

# Verifica root
if [ "$EUID" -ne 0 ]; then
  echo "Execute como root (sudo)."
  exit 1
fi

echo "-> Ajustando parâmetros do GRUB..."

GRUB_FILE="/etc/default/grub"
PARAMS="quiet splash acpi_osi=Linux pcie_aspm=off loglevel=3"

if grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=' "$GRUB_FILE"; then
  sed -i "s|^GRUB_CMDLINE_LINUX_DEFAULT=.*|GRUB_CMDLINE_LINUX_DEFAULT=\"$PARAMS\"|" "$GRUB_FILE"
else
  echo "GRUB_CMDLINE_LINUX_DEFAULT=\"$PARAMS\"" >> "$GRUB_FILE"
fi

echo "-> Atualizando GRUB..."
update-grub

echo "-> Instalando e configurando governor de CPU (ondemand)..."

apt update
apt install -y cpufrequtils

CPUFREQ_FILE="/etc/default/cpufrequtils"
echo 'GOVERNOR="ondemand"' > "$CPUFREQ_FILE"

systemctl enable cpufrequtils
systemctl restart cpufrequtils

echo "-> Blacklist do módulo i2c_piix4 (silenciar SMBus timeout)..."

BLACKLIST_FILE="/etc/modprobe.d/blacklist-i2c.conf"
if ! grep -q "blacklist i2c_piix4" "$BLACKLIST_FILE" 2>/dev/null; then
  echo "blacklist i2c_piix4" >> "$BLACKLIST_FILE"
fi

echo "-> Atualizando initramfs..."
update-initramfs -u

echo "== Ajustes concluídos com sucesso =="
echo "Reinicie o sistema para aplicar tudo."
