FROM busybox

# Create app directory
WORKDIR /usr/src/app

COPY ./* ./

EXPOSE 80 443 3000 22
CMD [ "./setup.sh" ]
