FROM alpine:3.4
MAINTAINER stéphane BROSSE <stevebrush@gmail.com>

RUN apk add --no-cache git \
	 build-base cmake \
	 libssl1.0 openssl-dev \
	 boost-dev \
	 boost-thread \
	 boost-system \
	 boost-date_time \
	 sqlite sqlite-dev \
	 curl libcurl curl-dev \
	 libusb libusb-dev \
	 coreutils \
	 zlib zlib-dev \
	 udev eudev-dev \
	 python3-dev \
	 linux-headers && \
	 git clone --depth 2 https://github.com/OpenZWave/open-zwave.git /src/open-zwave && \
	 cd /src/open-zwave && \
	 make -j4 && \
	 ln -s /src/open-zwave /src/open-zwave-read-only && \
	 git clone --depth 2 https://github.com/domoticz/domoticz.git /src/domoticz && \
	 cd /src/domoticz && \
	 git fetch --unshallow && \
	 cmake -DCMAKE_BUILD_TYPE=Release . && \
	 make -j4 && \
	 rm -rf /src/domoticz/.git && \
	 rm -rf /src/open-zwave/.git && \
	 apk del git cmake linux-headers libusb-dev zlib-dev openssl-dev boost-dev sqlite-dev build-base eudev-dev coreutils curl-dev python3-dev

VOLUME /config

EXPOSE 9080

ENTRYPOINT ["/src/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log", "-sslwww", "0"]
CMD ["-www", "9080"]