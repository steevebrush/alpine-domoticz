# alpine-domoticz

## domoticz docker container based on alpine linux and latest domoticz commit

config container path: /config
exposed port : 9080

docker run -p 9080:9080 -v /config:/config steevebrush/domoticz 

