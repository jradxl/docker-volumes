# docker-volumes

Demonstating difference between Bind and Volume mounts

1. Data on the host will be hidden with the Bind Mount

2. Data using a COPY or RUN echo within the container can't be seen due to being in a staged image
   But running an ENTRYPOINT script, or representing an application start, such data would be seen on host by both mount types
   
3. But, using Volume mounts, the data can be lost if a "docker volume prune"  is carried out after the container is deleted
   -- worrying!
   

