FROM bash:5.2.12-alpine3.16
COPY entrypoint.sh /app/
COPY giraffe.txt /app/
ENTRYPOINT ["/app/entrypoint.sh"]
