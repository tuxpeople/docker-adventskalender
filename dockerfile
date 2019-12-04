FROM alpine:latest
RUN apk add --no-cache bash
COPY zitate.txt entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
