FROM alpine:latest
RUN apk add --no-cache bash
COPY zitate.txt /
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
