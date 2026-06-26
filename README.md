# Getting started with multicontainer on balena
Get up and running quickly with a multi-container setup on balena

This example will get you up and running quickly with a multicontainer setup on balena. This project is based on the [Docker Compose Quickstart](https://docs.docker.com/compose/gettingstarted/) that uses the Flask framework to feature a hit counter in Redis. You don't need to know anything about Redis or Flask to learn the core concepts presented here.

To get this project up and running, you'll need to [sign up](https://dashboard.balena-cloud.com/signup) for a balena account, create a fleet of one or more devices, and provision a device (device specific instructions can be found in our [getting started guide](https://balena.io/docs/getting-started).

Once you are set up, you can click the deploy button below, or clone this repo locally if you want to modify and/or experiment with it:


## What this example does
The docker-compose file defines the two services that will be run:

- The `web` service is a Flask web server build by the Dockerfile. It maps port 8000 on the host to port 5000 in the container.
- The `redis` service uses an official Redis image from the Docker Hub.

Find the local IP address of your device from the balenaCloud dashboard and replace <device-ip> with it in the address below:

`http://<device-ip>:8000`

Open this URL in a web browser on the same network as your balena device. You should see:

```
Hello from Docker! I have been seen 1 time(s).
```

Each time you refresh your browser, the counter will increment.

## Key concepts
- The docker-compose file simplifies the control of your entire application stack, making it easy to manage services, networks, and volumes in a single YAML configuration file. To run more than one container (service), you'll need to use a docker-compose file.
- Persist data with named volumes: the named volume `redis-data` stores data from the redis container on the host so it will not be lost when the ephemeral container restarts.
- The healthcheck script makes sure the redis service is healthy before the web server starts (see below)

## About healthchecks on balena

The docker-compose healthcheck command is only partially implemented in balenaOS. `depends_on` is limited to an array form and only verifies the container has started, not that it is healthy. To confirm a healthy redis container, we run a shell script when the web service starts. That script, `healthcheck.sh`, continuously pings the redis service in a loop. When that service provides a healthy response, the loop ends and the Flask web server is started. This is one simple example of managing container startup dependencies without the compose healthcheck. More in-depth possibilities include explicit readiness endpoints, startup wait logic, retry/backoff, and idempotent service initialization.
