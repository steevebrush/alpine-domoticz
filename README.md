# alpine-domoticz

## Domoticz docker container
This container is based on latest [alpine linux][1] (3.6), latest [domoticz][2] commit, latest [openzwave][3] commit and I add the [broadlink python lib][6] for my new MP1 wifi power switch (should work also with others broadlink devices).
This container is size optimized : 128MB 

You can refer to the automatic build at [docker hub][4] too.
### Environment variables :		
 			
 	TIMEZONE : set your timezone to be right on time !
	ex : docker run -e "TIMEZONE"="Europe/Paris" steevebrush/alpine-domoticz
	
### Volumes : 

	/config : database, config and log files will be stored here. You can use it to store your scripts also
	ex : docker run -v /my_config_dir:/config steevebrush/alpine-domoticz

### Ports :

	9080 : domoticz interface and API
	ex : docker run -p my_local_port:9080 steevebrush/alpine-domoticz

### Quick start :
	
	docker run -p 9080:9080 steevebrush/alpine-domoticz (config directory will be erased at each start)
	docker run -p 9080:9080 -v /my_config_dir:/config steevebrush/alpine-domoticz (config directory will be saved)

### Fine tune :

If you map the /config volume, your config, database, log and everything else will be keeped beetwen restarts and updates.
If you want to attach an usb device, like an openZwave stick, add --device=/dev/your_device

### Example with all set :

Everything is setup : incoming port, timezone, data directory and usb device

	docker run -p 9080:9080 -e "TIMEZONE"="Europe/Paris" -v /config:/config --device=/dev/ttyUSB0 steevebrush/alpine-domoticz


### Finally, open WebUI and start configuring Domoticz :
open domoticz webUI : [http://localhost:9080][5] or your http://your_docker-server_IP:9080

[1]: https://alpinelinux.org
[2]: https://www.domoticz.com
[3]: https://github.com/OpenZWave/open-zwave
[4]: https://hub.docker.com/r/steevebrush/alpine-domoticz/
[5]: http://localhost:9080
[6]: https://github.com/mjg59/python-broadlink
