# Integracja LMS i LibreQoS v1.4
Skrypt integracyjny generuje pliki kolejek dla LibreQoS i wrzuca je na LibreQoS, 
Generowanie konfigów napisane jest na bazie skryptu LMS

## Instalacja
```
cd /var/www/html/lms/
git clone https://github.com/interduo/LMSLibreQoS/ plugins/LMSLibreQoS
```

## Edytujemy zmienne w pliku make-and-send-libreqosconf.sh
- LMSPATH - ścieżka LMS,
- QOSFILE - plik z wygenerowanym plikiem kolejek
- LIBREQOSHOST - nazwa hosta LibreQoS,
- LIBRESSHPORT - port SSH LibreQoS,
- LIBREQOSUSER - użytkownik SSH LibreQoS,
- LIBREQOSDIR - ścieżka do skryptów LibreQoS,

## Kopiujemy klucz publiczny SSH z użytkownika LMS na LibreQoS
```
ssh-copy-id uzytkownik@libreqoshost
```

## Tworzymy sekcję konfiguracyjną libreqos w http://lms/?m=configlist lub lms.ini
```
[libreqos]
script_file = /var/www/html/lms/plugins/LMSLibreQoS/ShapedDevices.csv
script_file_day = /tmp/removemesomeday_1
script_file_night = /tmp/removemesomeday_2
script_permission = -1
all_assignments = true
assignment_per_node = true
ignore_assignment_suspensions = false
#create_device_channels = true
begin = '#LMS customer queues file for LibreQoS - %date\n'
class_up = '%assignmentid,%cid,%h,%class,,,"%ips",,%downrate,%uprate,%downceil,%upceil,"KOMENTARZ"\n'
#end = '#END OF FILE'
```

## Tworzymy kolejnego hosta w LMS o nazwie np. LibreQoS (Konfiguracja --> Hosty)

Jeśli mamy wartość zmiennej *reload_type* jako *exec* to wariantowo:
a) rozbudowywujemy skrypt ze zmiennej reload_execcmd (np. /skrypt.sh %host ma spowodować uruchomienie plugins/LMSLibreQoS/make-and-send-libreqosconf.sh),
b) edytujemy wartość zmiennej reload_execcmd jako /var/www/html/lms/plugins/LMSLibreQoS/make-and-send-libreqosconf.sh

Po zmianie zobowiązań wybieramy Przeładowanie --> wybieramy hosta LibreQoS --> klikamy *Zapisz*
