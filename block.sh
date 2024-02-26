#!/bin/bash

# Ruta al archivo de texto con las IPs
archivo_ips="/ruta/al/archivo/lista_negra.txt"

# Recorrer las IPs del archivo
while read ip; do
  # Verificar si la IP ya está bloqueada
  if fail2ban-client get blacklistip banip $ip | grep -q "Banned"; then
    echo "La IP $ip ya está bloqueada"
  else
    # Agregar la IP a la lista de IPs bloqueadas de Fail2ban
    fail2ban-client set blacklistip banip $ip
    echo "La IP $ip ha sido bloqueada"
  fi
done < $archivo_ips
