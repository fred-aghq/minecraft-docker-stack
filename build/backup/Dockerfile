FROM alpine:3.11
RUN apk update &&  apk add rsync
COPY ./backup.sh /data/backup.sh
ENTRYPOINT ["sh", "/data/backup.sh"]