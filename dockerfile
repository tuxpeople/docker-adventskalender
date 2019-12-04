FROM alpine:latest
RUN apk add --no-cache bash
COPY zitate.txt /
COPY entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
