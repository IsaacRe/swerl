# SoftWare Engineer Reinforcement Learning (SWERL)

This repo contains tools used to build SWERL, a dataset containing long-horizon agent playthroughs in the SWERL Sandbox. This sandbox wraps several components that are commonly used in a backend development tech stack, allowing an AI agent to hack in an isolated environment by making calls to the respective tools.

The run script uses a LangChain fork to facilitate agent interaction with the sandox through our iterative reprompting method, recording the interaction history in SWERL format.


## Sandbox
### Tools
The SWERL Sandbox includes the following components that are accessible through tools in the LangChain client.
- Local linux dev environment containerized with sysbox DinD, enabling internal docker daemon
- PostgreSQL database hosted in separate container
- K8s cluster containerized with sysbox KinD in separate container
- Apache Kafka server
- git

### Setup
#### Sysbox
Follow these [instructions](https://github.com/nestybox/sysbox/blob/master/docs/user-guide/install-package.md#installing-sysbox) to setup sysbox on your local machine.

##### WSL
If using WSL/WSL2, systemd must be enabled following these [instructions](https://askubuntu.com/questions/1379425/system-has-not-been-booted-with-systemd-as-init-system-pid-1-cant-operate).

### Running Sandbox
```bash
cd sandbox
docker build . -f sandbox.Dockerfile -t swerl_sandbox
docker run -p 8000:8000 --runtime=sysbox-runc --hostname=syscont swerl_sandbox
```

Make requests to the sandbox service:
```bash
curl -X POST http://localhost:8000/execute -d '{"exit":false,"code":"docker ps"}' -H "Content-Type: application/json"
```

You should see that the nested docker daemon is running:
```bash
{"message":"docker ps\r\nCONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES\r\nroot@sandbox:/app# "}
```

### SWERL Format


### Agent Loop
Highly modular, lightweight and with minimal inductive bias
