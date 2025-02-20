# Dockerfile for the Tor hidden service
FROM debian:latest

RUN apt-get update -y
RUN apt-get install -y sudo
RUN apt-get install -y cron

COPY .env /usr/share/.env
COPY scripts/backup-files.sh /usr/share/scripts/backup-files.sh
COPY scripts/delete-old-backup.sh /usr/share/scripts/delete-old-backup.sh


RUN sudo install -m 0755 -o root -g root -t /usr/local/bin /usr/share/scripts/backup-files.sh
RUN sudo install -m 0755 -o root -g root -t /usr/local/bin /usr/share/scripts/delete-old-backup.sh


COPY .docker/cron/start.sh /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start
CMD ["/usr/local/bin/start"]