FROM nickhx/docker_ubuntu_base

# warning: apt-get install should run with apt-get update, if not, we'll find docker error code 100.
RUN apt-get update && \
    apt-get install -y redis-server
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

#daemontools, auto start redis process
RUN mkdir -p /etc/bootservices/redis
RUN echo "#!/bin/bash\n exec redis-server /etc/redis/redis.conf" > /etc/bootservices/redis/run
RUN chmod +x /etc/bootservices/redis/run

EXPOSE 6379

ENTRYPOINT ["/usr/bin/svscan", "/etc/bootservices/"]