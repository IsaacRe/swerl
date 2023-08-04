#
# Ubuntu Jammy + Docker + Compose
#
# Instructions for Docker compose installation taken from:
# https://docs.docker.com/compose/install/
#

FROM nestybox/ubuntu-jammy-docker:latest

# install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# set up python
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel

# start docker
RUN dockerd > /var/log/dockerd.log 2>&1 &
# set up sandbox API
RUN pip install fastapi
RUN pip install uvicorn
RUN pip install pydantic
RUN pip install pexpect

COPY local-dev/run_sandbox.py /app/
COPY local-dev/run.sh /app/
RUN chmod +x /app/run.sh
WORKDIR /app

EXPOSE 8000
CMD ["/app/run.sh"]