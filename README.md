# Integracja LMS i LibreQoS v0.1

# Skrypt integracyjny generuje pliki kolejek dla LibreQoS i wrzuca je na LibreQoS, 
# Generowanie konfigów napisane jest na bazie skryptu LMS

# Na tą chwilę skrypt wrzuca jedynie pełny konfig

## instalacja
cd /var/www/html/lms/
git clone https://github.com/interduo/LMSLibreQoS/ plugins/LibreQoS

## Edytujemy zmienne w pliku make-and-send-libreqosconf.sh
- LMSPATH - ścieżka LMS,
- QOSFILE - plik z wygenerowanym plikiem kolejek
- LIBREQOSHOST - nazwa hosta LibreQoS,
- LIBRESSHPORT - port SSH LibreQoS,
- LIBREQOSUSER - użytkownik SSH LibreQoS,
- LIBREQOSDIR - ścieżka do skryptów LibreQoS,


## Tworzymy sekcję konfiguracyjną libreqos w http://lms/?m=configlist lub lms.ini

[libreqos]

script_file = /etc/router/libreqos/ShapedDevices.csv

script_file_day = /tmp/removemesomeday_1

script_file_night = /tmp/removemesomeday_2

script_permission = -1

all_assignments = true

assignment_per_node = true

ignore_assignment_suspensions = false

#create_device_channels = true

begin = '#LMS customer queues file for LibreQoS - %date\n'

class_up = '%assignmentid, %cid, %h, %class, AP_A,,"%ips",, %downrate, %uprate, %downceil, %upceil, KOMENTARZ\n'

end = '#END OF FILE'
