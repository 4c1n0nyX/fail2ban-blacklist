# fail2ban-blacklist
Script en bash que permite el bloqueo de direcciones IP en Fail2ban desde archivo de lista negra en txt.

**MODO DE USO:**

Para poder usarlo, es necesario que creemos un filtro nuevo en jail, pudiendo ser añadido desde jail.local, o creando un nuevo .conf en la ruta jail.d

**/etc/fail2ban/jail.d/blaclistip.conf**

En dicho archivo añadiremos lo siguiente:

[blacklistip]
enabled = true
bantime = -1

Luego, crearemos un filtro específico como pantalla para que esta regla funcione. Lo haremos en la siguiente ruta:

**/etc/fail2ban/filter.d/blacklistip.conf**

En el añadiremos lo siguiente:

[INCLUDES]

[Definition]

#failregex = ''

[Init]

Teniendo estos achivos creados, procedemos a reinicar fail2ban

**systemctl restart fail2ban**

Comprobamos que tenemos la regla creada adecuadamente:

**fail2ban-client status**

Ahora, procedemos a crear el script de la siguiente manera:

#!/bin/bash
# Ruta al archivo de texto con las IPs
archivo_ips="**/ruta/del/archivo/lista_negra.txt**"
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

Al hacer esto, guardamos, y procedemos a darles permiso de ejecución y posteriormente, ejecutarlo. En este caso, el script fue llamado **block.sh**

chmod +x block.sh

./block.sh

Con esto ya las direcciones IP deberian empezar a añadirse a fail2ban y seguidamente en IPTABLES.

**CONSIDERACIONES IMPORTANTES:**

La lista de IP a bloquear debe estar en orden por línea. Ejemplo:

192.168.0.1
192.168.0.2
192.168.0.3
192.168.0.4

Espero que les sea de mucha ayuda!!
