FROM alpine:latest
MAINTAINER stéphane BROSSE <stevebrush@gmail.com>

ENV TIMEZONE Europe/Paris

RUN apk add --no-cache git tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	date && \
    git clone --depth 2 https://github.com/domoticz/domoticz.git /src/domoticz && \
	cd /src/domoticz && \
	git fetch --unshallow && \
	sed -i -e "s/sys\/errno.h/errno.h/g" /src/domoticz/hardware/csocket.cpp && \
	sed -i -e "s/sys\/signal.h/signal.h/g" /src/domoticz/hardware/serial/impl/unix.cpp

RUN apk add --no-cache git \
    	build-base cmake \
    	libressl-dev \
	 	zlib-dev \
	 	libcurl curl-dev \
	 	boost-dev \
	 	sqlite-dev \
	 	lua5.2-dev \
	 	mosquitto-dev \
	 	libusb-compat libusb-compat-dev \
	 	python3 python3-dev \
	 	udev eudev-dev \
	 	boost-thread \
	 	boost-system \
	 	boost-date_time \
	 	coreutils && \
	 sed -i -e "s/sys\/poll.h/poll.h/g" /usr/include/boost/asio/detail/socket_types.hpp

RUN git clone --depth 2 https://github.com/OpenZWave/open-zwave.git /src/open-zwave && \
	cd /src/open-zwave && \
	make && \
	ln -s /src/open-zwave /src/open-zwave-read-only


RUN	cd /src/domoticz && \
    cmake -DCMAKE_BUILD_TYPE=Release -Wno-dev . && \
	make && \
	rm -rf /src/domoticz/.git

RUN	rm -rf /src/open-zwave/.git && \
    apk del git build-base \
     cmake \
     libressl-dev \
     zlib-dev \
     curl-dev \
     boost-dev \
     sqlite-dev \
     lua5.2-dev \
     mosquitto-dev \
     libusb-compat-dev \
     python3-dev \
     eudev-dev \
     coreutils

VOLUME /config

EXPOSE 9080

ENTRYPOINT ["/src/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log", "-sslwww", "0"]
CMD ["-www", "9080"]