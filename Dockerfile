# Build a virtualenv using the appropriate Debian release
# * Install python3-venv for the built-in Python3 venv module (not installed by default)
# * Install gcc libpython3-dev to compile C Python modules
# * In the virtualenv: Update pip setuputils and wheel to support building new packages
FROM debian:11-slim AS build

# hadolint ignore=DL3008,DL3009
RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes python3-venv gcc libpython3-dev && \
    python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip setuptools wheel

# Build the virtualenv as a separate step: Only re-execute this step when requirements.txt changes
FROM build AS build-venv
RUN /venv/bin/pip install --disable-pip-version-check dinosay 

# Copy the virtualenv into a distroless image
# hadolint ignore=DL3006
FROM gcr.io/distroless/python3-debian11
COPY --from=build-venv /venv /venv
COPY . /app
WORKDIR /app
ENTRYPOINT ["/venv/bin/dinosay", "-f", "/app/giraffe.txt", "\"Extract a token from a secret: kubectl get secret <my-secret> -n<my-namespace> -ojsonpath='{.data.token}' | base64 -d\""]
