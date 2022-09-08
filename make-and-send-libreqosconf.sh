#!/bin/bash
# Integracja LMS i LibreQoS
# Skrypt integracyjny generuje pliki kolejek dla LibreQoS,
# Generowanie konfigów napisane na bazie skryptu LMS lms-maketcnew.php

LMSPATH='/var/www/html/lms'
QOSFILE='/etc/router/libreqos/ShapedDevices.csv'

LIBRESSHPORT=22
LIBREQOSHOST='libreqos'
LIBREQOSUSER='root'
LIBREQOSDIR='~/LibreQoS/v1.2/'

#generate LibreQoS ShapeDevices.csv file
${LMSPATH}/bin/lms-makelibreqosconf.php

#send config files to LibreQoS
scp -P${LIBRESSHPORT} "${QOSFILE}" $LIBREQOSUSER}@${LIBREQOSHOST}:"${LIBREQOSDIR}"