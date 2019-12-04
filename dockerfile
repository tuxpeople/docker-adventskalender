FROM alpine:latest
RUN apk add --no-cache bash
COPY zitate.txt /
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
