# fail2ban-blacklist
Script en bash que permite el bloqueo de direcciones IP en Fail2ban desde archivo de lista negra en txt.
<br>
<br>
## MODO DE USO:
Para poder usarlo, es necesario que creemos un filtro nuevo en jail, pudiendo ser añadido desde jail.local, o creando un nuevo .conf en la ruta jail.d
<br><br>
**_/etc/fail2ban/jail.d/blaclistip.conf_**

<br>

En dicho archivo añadiremos lo siguiente:

<br>

[blacklistip]

enabled = true

bantime = -1

<br>

Luego, crearemos un filtro específico como pantalla para que esta regla funcione. Lo haremos en la siguiente ruta:

<br>

_**/etc/fail2ban/filter.d/blacklistip.conf**_

<br>

En el añadiremos lo siguiente:

<br>

[INCLUDES]

[Definition]

#failregex = ''

[Init]

<br>

Teniendo estos achivos creados, procedemos a reinicar fail2ban

<br>

_**systemctl restart fail2ban**_

<br>

Comprobamos que tenemos la regla creada adecuadamente:

<br>

_**fail2ban-client status**_

<br>

Ahora, procedemos a descargar el script, procedemos a darles permiso de ejecución y posteriormente, ejecutarlo. En este caso, el script fue llamado **block.sh**

<br>

_chmod +x block.sh_

<br>

_./block.sh_

<br>

Con esto ya las direcciones IP deberian empezar a añadirse a fail2ban y seguidamente en IPTABLES.

<br>

## CONSIDERACIONES IMPORTANTES:

<br>

La lista de IP a bloquear debe estar en orden por línea. Ejemplo:

<br>

192.168.0.1

192.168.0.2

192.168.0.3

192.168.0.4

<br>

Espero que les sea de mucha ayuda!!
