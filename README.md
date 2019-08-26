# docker-react-node

The KRN (Koa React Node) stack starter demonstrates a working application that uses a Create-React-App frontend, with a Node and Koa backend.

## Dependencies

  - [axios](https://github.com/mzabriskie/axios) - promise-based HTTP client
  - [foreman](https://github.com/strongloop/node-foreman) - a Procfile-based application utility
  - [Node](https://nodejs.org/) - Backend JavaScript Runtime
  - [koa](https://koajs.com/) - minimalist Node.js framework
  - [react](https://facebook.github.io/react/) - JS library for building user interfaces


## Getting Started

To run a development environment, you can use the `start-dev` command. This will start up a development web server on port 3000, and a nodemon-watched API server on port 5000. These development servers will automatically reload if changes are made to the source.

1. Install dependencies:

	```bash
	yarn
	```
	
1. Start the development environment:

	```bash
	yarn start-dev
	```

## Docker Compose

Build images:
```bash
docker-compose build
```

Run:
```bash
docker-compose up
```

## Configuration (Optional)

By default, the server will expect to connect to a MongoDB instance running on localhost:27017. However, you can customize the environment to use different values for the MongoDB host. To do that, you can create a `.env` file for specifying credential information for MongoDB. 

Create a new file called `.env`, with the following YAML:

```bash
MONGO_URL=mongodb://localhost:27017/comments
MONGO_USER=username
MONGO_PASSWORD=password
```