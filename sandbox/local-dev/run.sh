#!/bin/bash

# start docker
dockerd > /var/log/dockerd.log 2>&1 &

# start sandbox service
uvicorn run_sandbox:app --host 0.0.0.0 --port 8000 --workers 1