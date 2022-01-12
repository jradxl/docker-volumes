FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
LABEL maintainer="CUSTOM NGINX Docker Maintainers <docker-maint@nginx.com>"

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y procps nano curl gettext-base nginx ca-certificates \
    && dpkgArch="$(dpkg --print-architecture)" \
    && echo "The architecture is: $dpkgArch" \
    && apt-get remove --purge --auto-remove -y \
    && rm -rf /var/lib/apt/lists/* \
    # create a docker-entrypoint.d directory
    && mkdir /root/docker-entrypoint.d

RUN mkdir -p /test1 #Not test2
RUN mkdir -p /test3 #Not test4

COPY docker-entrypoint.sh /root

VOLUME ["/root/test1"] #Volume
VOLUME ["/root/test2"] #Volume
VOLUME ["/root/test3"] #Bind
VOLUME ["/root/test4"] #Bind

#RUN set -x \
# forward request and error logs to docker log collector
#    && ln -sf /dev/stdout /var/log/nginx/access.log \
#    && ln -sf /dev/stderr /var/log/nginx/error.log \
#    && chown www-data /var/log/nginx/access.log \
#    && chown www-data /var/log/nginx/error.log

EXPOSE 80
STOPSIGNAL SIGQUIT

##Prepared Latest in build, but are mounts valid when run?
## NO, they are not in final image
RUN echo -e "Written within build 1" > /root/test1/test1-a.txt \
 && echo -e "Written within build 2" > /root/test2/test1-b.txt \
 && echo -e "Written within build 3" > /root/test3/test1-c.txt \
 && echo -e "Written within build 4" > /root/test4/test1-d.txt

ENTRYPOINT ["/root/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

##Ignored
RUN echo -e "Written within build 1 late" > /root/test1/test2-a.txt \
 && echo -e "Written within build 2 late" > /root/test2/test2-b.txt \
 && echo -e "Written within build 3 late" > /root/test3/test2-c.txt \
 && echo -e "Written within build 4 late" > /root/test4/test2-d.txt
