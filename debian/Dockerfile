FROM debian
USER root 
# Create app directory
WORKDIR /usr/src/app

RUN apt-get -y update && \
    apt-get -y install net-tools && \
    apt-get -y install tcpdump && \
    apt-get -y install iptables

COPY ./* ./

EXPOSE 80 443 3000 22
CMD [ "./setup.sh" ]
