#!/bin/bash
# Integracja LMS i LibreQoS
# Skrypt integracyjny generuje pliki kolejek dla LibreQoS,
# Generowanie konfigów napisane na bazie skryptu LMS lms-maketcnew.php

LMSPATH='/var/www/html/lms'
QOSFILE="${LMSDIR}/plugins/LMSLibreQoS/ShapedDevices.csv"

LIBRESSHPORT=22
LIBREQOSHOST='libreqoshost'
LIBREQOSUSER='root'
LIBREQOSDIR='~/LibreQoS/v1.2/'

#Generate LibreQoS ShapeDevices.csv file
${LMSPATH}/plugins/LMSLibreQoS/lms-makelibreqosconf.php

#Send config files to LibreQoS
scp -P${LIBRESSHPORT} "${QOSFILE}" ${LIBREQOSUSER}@${LIBREQOSHOST}:"${LIBREQOSDIR}"

#Spell a magic command in LibreQoS
ssh -p${LIBRESSHPORT} ${LIBREQOSUSER}@${LIBREQOSHOST} ${LIBREQOSMAGICCOMMAND}
