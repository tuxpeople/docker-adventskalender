# Docker-Adventskalender: one image per year, tagged with the year.
# The content of a year lives in years/<YEAR>/ (entrypoint.sh plus text
# files); the workflow builds every year with --build-arg YEAR=<YEAR>.

FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

ARG YEAR

LABEL org.opencontainers.image.title="adventskalender"
LABEL org.opencontainers.image.description="Docker-Adventskalender ${YEAR}: one door per day from 1 to 24 December"
LABEL org.opencontainers.image.vendor="tuxpeople"
LABEL org.opencontainers.image.source="https://github.com/tuxpeople/docker-adventskalender"
LABEL org.opencontainers.image.licenses="MIT"

# bash for the scripts, ncurses for tput (colours and boxes)
# hadolint ignore=DL3018
RUN apk upgrade --no-cache && \
    apk add --no-cache bash ncurses

WORKDIR /app
COPY --chmod=644 years/${YEAR}/ /app/
RUN chmod 755 /app/entrypoint.sh

ENV TERM=xterm-256color
USER 1000

ENTRYPOINT ["bash", "/app/entrypoint.sh"]
