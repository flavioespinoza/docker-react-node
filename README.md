# docker-react-node

The KRN (Koa React Node) stack starter demonstrates a working application that uses a Create-React-App frontend with a Node-Koa backend.

## Dependencies (Required)

You must have these tools installed to run this app:

  - [axios](https://github.com/mzabriskie/axios) - promise-based HTTP client
  - [foreman](https://github.com/strongloop/node-foreman) - a Procfile-based application utility
  - [node](https://nodejs.org/) - Backend JavaScript Runtime
  - [yarn](https://yarnpkg.com/lang/en/docs/install/#mac-stable) - Package manager for NPM modules
  - [koa](https://koajs.com/) - minimalist Node.js framework
  - [create-react-app](create-react-app) - JS library for building React user interfaces

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

Run with docker-compose:

```bash
docker-compose up
```

Navigate to: http://localhost:8080

Changes to any file will automatically be compiled and reflected in the app.

Stop with docker-compose:

```bash
docker-compose down
```


## Docker Image
Build Docker Image:

```bash
yarn docker:build
```
Push Docker Image to Docker Hub:

```bash
yarn docker:push
```

Build, then push with one command:

```bash
yarn docker:all
```

## Configuration (Required)

You must customize the environment to use different values for the Node Environment Variables. To do this, create a new file called `.env` in your root directory of the project, with the following environment variables:

```bash
# ------------------------------------------------------------------------------------------
# Node Backend & React Frontend
# ------------------------------------------------------------------------------------------
NODE_ENV="production"

HOST=5000

AUTH_ENV=prod

NODE_PATH=./src

PRISMA_MANAGEMENT_API_SECRET="your_api_key"

SENGRID_KEY="your_api_key"

JOTFORM_API_KEY="your_api_key"

# OpenID Connect Credentials
CLIENT_ID="your_client_id"
CLIENT_SECRET="your_client_secret"

URI_REDIRECT=http://localhost:8080/auth/openIdClient/redirect

URI_HOST=https://ra-authnet.resilient-networks.com/
URI_HOST_PD=https://exemplar.pd.authnet.webshield.io
​
URI_OPENID=https://ra-authnet.resilient-networks.com/openId/
URI_OPENID_PD=https://exemplar.pd.authnet.webshield.io:844/
​
URI_AUTH=https://ra-authnet.resilient-networks.com/openId/authenticate
URI_AUTH_PD=https://ra-authnet.resilient-networks.com/openId/authenticate
​
URI_TOKEN=https://ra-authnet.resilient-networks.com/openId/token
URI_TOKEN_PD=https://exemplar.pd.authnet.webshield.io:844/resilientAccess_token

URI_USERINFO=https://ra-authnet.resilient-networks.com/openId/userinfo
URI_USERINFO_PD=https://exemplar.pd.authnet.webshield.io:844/resilientAccess_userInfo

URI_LOGOUT=https://ra-authnet.resilient-networks.com/openId/logout
URI_LOGOUT_PD=https://exemplar.pd.authnet.webshield.io:844/resilientAccess_logout
​
SCOPE="openid admin profile email"
```