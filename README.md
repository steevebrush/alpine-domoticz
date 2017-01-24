# alpine-domoticz

## domoticz docker container
based on latest alpine linux (3.5),latest domoticz and openzwave commit

Usefull infos :

env TIMEZONE Europe/Paris : set your timezone to be on time !
config container path : /config : database, config and log files will be stored here
exposed port 9080 : domoticz interfaces 

example : docker run -e "TIMEZONE=Europe/Paris" -p 9080:9080 -v /config:/config steevebrush/alpine-domoticz

if you want to attach an usb device, like an openZwave stick, add --device=<device_id>

example : docker run -e "TIMEZONE=Europe/Paris" -p 9080:9080 -v /config:/config --device=/dev/ttyUSB0 steevebrush/alpine-domoticz

open domoticz webUI : http://localhost:9080
