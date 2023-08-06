#!/bin/bash

# start docker
dockerd > /var/log/dockerd.log 2>&1 &

# setup kind cluster
kind create cluster --image=nestybox/kindestnode:v1.20.7

# start sandbox service
uvicorn sandbox_service:app --host 0.0.0.0 --port 8000 --workers 1