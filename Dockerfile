FROM bash:5.2.12-alpine3.16
RUN mkdir /app && apk add --no-cache ncurses
WORKDIR /app
COPY . /app
ENTRYPOINT ["bash", "/app/entrypoint.sh"]