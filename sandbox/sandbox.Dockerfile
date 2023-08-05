#
# Ubuntu Jammy + Docker + Compose
#
# Instructions for Docker compose installation taken from:
# https://docs.docker.com/compose/install/
#

FROM nestybox/ubuntu-jammy-docker:latest

# install docker-compose
RUN curl -Lo /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" && \
    chmod +x /usr/local/bin/docker-compose

# install kind
RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64 && \
    chmod +x /usr/local/bin/kind

# install kubectl
RUN curl -Lo /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl

# set up python
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel

# install API dependencies
RUN pip install fastapi
RUN pip install uvicorn
RUN pip install pydantic
RUN pip install pexpect

COPY local-dev/run_sandbox.py /app/
COPY local-dev/run.sh /app/
RUN chmod +x /app/run.sh

WORKDIR /app

EXPOSE 8000
# TODO not closing on ^C
CMD ["/app/run.sh"]