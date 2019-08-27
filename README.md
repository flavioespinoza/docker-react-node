# docker-react-node

code-base for the [docker-react-node](https://cloud.docker.com/u/flavioespinoza/repository/docker/flavioespinoza/docker-react-node) Docker image 

## Local Dev Environment (Required)
You must have these tools installed on your MacOS or Linux development environment.

  - [yarn](https://yarnpkg.com/lang/en/docs/install/#mac-stable) - JS package manager that replaces the npm client for use with the npm registry
  - [node](https://nodejs.org/en/download/) - JS run-time environment for backend applications
  - [docker - Linux](https://docs.docker.com/install/#server) - Container platform used to build, run and share any application
  - [docker-compose - Linux](https://docs.docker.com/compose/install/#install-compose) - Tool for defining and running multi-container docker applications
  - [docker - MacOS](https://docs.docker.com/docker-for-mac/install/) - Includes **docker-compose**

## Getting Started

Install dependencies with `yarn` then use `docker-compose` to run on your local development environment.

**IMPORTANT**: For Linux based systems I strongly recommend using the Ubuntu 18.04 Linux distribution for your local development environment.

1. Clone github repo:

	```bash
	git clone https://github.com/flavioespinoza/docker-react-node.git
	```
1. CD into the cloned directory:

	```bash
	cd docker-react-node
	```

1. Install dependencies with yarn:

	```bash
	yarn
	```
	
1. Start the development environment:

	```bash
	docker-compose up
	```

This will start up the frontend-server on http://localhost:8080 and the backend-server on port 5000.

**IMPORTANT**: The frontend-server and backend-server are continually watched and will automatically reload if changes are made to the source.