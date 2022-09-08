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
LIBREQOSMAGICCOMMAND="cd ${LIBREQOSDIR}; python3 LibreQoS.py 2>lastlog_std_err 1>lastlog_std_out"

#Generate LibreQoS ShapeDevices.csv file
php ${LMSPATH}/plugins/LMSLibreQoS/lms-makelibreqosconf.php

#Send config files to LibreQoS
scp -P${LIBRESSHPORT} "${QOSFILE}" ${LIBREQOSUSER}@${LIBREQOSHOST}:"${LIBREQOSDIR}"

#Spell a magic command in LibreQoS
ssh -p${LIBRESSHPORT} ${LIBREQOSUSER}@${LIBREQOSHOST} "${LIBREQOSMAGICCOMMAND}"
