# alpine-domoticz

## Domoticz docker container
This container is based on latest [alpine linux][1] (3.5), latest [domoticz][2] and [openzwave][3] commit

You can refer to the automatec build at [docker hub][4] too.


### Environment variables :
	
	TIMEZONE : set your timezone to be on time !


### Volumes : 

	/config : database, config and log files will be stored here


### Ports :

	9080 : domoticz interface and API



### Quick start :

	docker run -p 9080:9080 steevebrush/alpine-domoticz


### Fine tune :

The default timezone is set to Europe/Paris.
You can set the environment variable to yours by adding -e "TIMEZONE=YOUR/TIMEZONE" to the run command.

If you map the /config volume, your config, database an log will be keeped beetwen restarts and updates.

If you want to attach an usb device, like an openZwave stick, add --device=/dev/your_device

### Example with all set :

	docker run -e "TIMEZONE=Europe/Paris" -p 9080:9080 -v /config:/config --device=/dev/ttyUSB0 steevebrush/alpine-domoticz


### Finally, open WebUI and start configuring Domoticz :
open domoticz webUI : [http://localhost:9080][5] or your docker-server IP.

[1]: https://alpinelinux.org
[2]: https://www.domoticz.com
[3]: https://github.com/OpenZWave/open-zwave
[4]: https://hub.docker.com/r/steevebrush/alpine-domoticz/
[5]: http://localhost:9080