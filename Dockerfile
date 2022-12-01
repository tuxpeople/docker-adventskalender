FROM bash:5.2.12-alpine3.16

COPY . /app
WORKDIR /app
ENTRYPOINT ["./entrypoint.sh"]
