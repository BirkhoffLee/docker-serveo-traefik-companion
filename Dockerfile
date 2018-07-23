FROM debian:jessie

ADD https://storage.googleapis.com/serveo/download/2018-05-08/serveo-linux-amd64 /app/serveo

RUN chmod +x /app/serveo

EXPOSE 22 80

CMD [ "/app/serveo", "-private_key_path=/app/ssh_key", "-port=22", "-http_port=80", "-disable_telemetry" ]
