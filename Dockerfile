FROM busybox:1.35.0

COPY . /app
WORKDIR /app
ENTRYPOINT ["./entrypoint.sh"]
