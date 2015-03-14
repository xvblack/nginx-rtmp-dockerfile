# Version: 0.0.1

FROM xvblack/build-essential
MAINTAINER xvblack "xvblue@gmail.com"
RUN apt-get update
RUN apt-get install -y \
	git \
	libpcre3 \
	libpcre3-dev \
	openssl \
	libssl-dev
RUN mkdir -p /src
RUN git clone https://github.com/nginx/nginx /src/nginx
RUN git clone https://github.com/arut/nginx-rtmp-module /src/nginx-rtmp-module
WORKDIR /src/nginx
RUN ./configure --add-module=/src/nginx-rtmp-module --prefix=/opt/nginx --sbin-path=/usr/sbin/nginx \
--conf-path=/opt/nginx/nginx.conf --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock \
--with-http_ssl_module 
RUN make
RUN make install
RUN mkdir -p /opt/nginx/
ADD nginx.conf /opt/nginx/nginx.conf
CMD nginx
EXPOSE 1935 8080
