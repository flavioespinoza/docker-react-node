# docker-react-node

The MERN stack starter demonstrates a working application that uses a Create-React-App frontend, with a Node and Koa backend, and MongoDB. It shows how the client can make client HTTP requests and maintain persistent sessions. 

## Dependencies

  - [axios](https://github.com/mzabriskie/axios) - promise-based HTTP client
  - [foreman](https://github.com/strongloop/node-foreman) - a Procfile-based application utility
  - [mongoose](http://mongoosejs.com/) - mongodb object modelling
  - [express](https://expressjs.com/) - minimalist Node.js framework
  - [react](https://facebook.github.io/react/) - JS library for building user interfaces


## Getting Started

To run a development environment, you can use the `start-dev` command. This will start up a development web server on port 3000, and a nodemon-watched API server on port 5000. These development servers will automatically reload if changes are made to the source.

1. Install dependencies:

	```bash
	yarn
	```

1. Install [MongoDB](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)

1. Start the development environment:

	```bash
	yarn start-dev
	```

## Docker Compose

If you use Docker and Docker Compose, you can start the entire project with:

```bash
docker-compose up
```

## Configuration (Optional)

By default, the server will expect to connect to a MongoDB instance running on localhost:27017. However, you can customize the environment to use different values for the MongoDB host. To do that, you can create a `.env` file for specifying credential information for MongoDB. 

Create a new file called `.env`, with the following YAML:

```yaml
MONGO_URL=mongodb://localhost:27017/comments
MONGO_USER=username
MONGO_PASSWORD=password
```

or instead, you can use the equivalent JSON:

```json
{
  "mongo": {
    "url": "mongodb://localhost:27017/comments",
    "user": "username",
    "password": "password"
  }
}
```

Where the URL, username, and password are set to your preferences.

## Docker Development run

If you would like to run the development tools inside of a docker container, you can set up a local Docker development environment by building the image:

```bash
docker build -f Dockerfile-tools -t mern-example:latest .
```

And running the image:

```bash
docker run -v ${PWD}:/usr/app -p 3000:5000 -t mern-example:latest
```

## Kubernetes

You can use Helm and our bundled chart for quickly deploying your application.

### Locally with minikube

You can use minikube for creating a local testing cluster. Start up your cluster:

```bash
minikube start
```

Make sure you set your Docker environment to use it. This is important so that the cluster has your Docker images.

```bash
eval $(minikube docker-env)
```

Build your Docker image and give it a tag:

```bash
docker build -t mkrn-example:latest .
```

Install the Helm chart located in `helm/mern` on to your cluster:

```bash
helm install helm/mern
```

If using minikube, you will need to add port forwarding to be able to view your application:

```bash
kubectl port-forward <pod_name> <external_port>:3000

kubectl port-forward mern-deployment-789311257-36s62 32111:3000
```


Open your browser to http://localhost:32111

If you want to update your application, you can build a new image with a new version tag, e.x. `docker build -t mern:v2 .`. Update the version tag in `helm/mern/values.yml`.

Then, roll out a new release with:

```bash
helm upgrade <deployment_name> helm/mern
helm upgrade limping-bee .
```

### On Bluemix Kubernetes

***Build the Docker image***

1. Start the Docker engine on your local computer

2. Log the local Docker client in to IBM Bluemix Container Registry

```bash
bx cr login
```

> This will configure your local Docker client with the right credentials to be able to push images to the Bluemix Container Registry

3. Retrieve the name of the namespace you are going to use to push your Docker images

```bash
bx cr namespace-list
```

> If you don't have a namespace, you can create one with `bx cr namespace-add my_namespace` for example.

4. Build the Docker image of the service

> In the following steps, make sure to replace <namespace> with your namespace name

```bash
docker build -t registry.ng.bluemix.net/<namespace>/mern-example:v1 .
```

5. Push the image to the registry

```
docker push registry.ng.bluemix.net/<namespace>/mern-example:v1
```

***Create a Kubernetes cluster***

1. Create a Kubernetes cluster in Bluemix

```bash
bx cs cluster-create <cluster-name>
```

> Note that you can also use an existing cluster

2. Wait for you cluster to be deployed. This step can take awhile, you can check the status of your cluster by using:


```bash
bx cs clusters
```

3. Ensure that the cluster workers are ready:

```bash
bx cs workers <cluster-name>
```

***Deploy the Service***

1. Retrieve the cluster configuration


```bash
bx cs cluster-config <cluster-name>
```

Output:

```bash
Downloading cluster config for mycluster-robert
OK
The configuration for mycluster-robert was downloaded successfully. Export environment variables to start using Kubernetes.

export KUBECONFIG=/home/rfdickerson/.bluemix/plugins/container-service/clusters/mycluster-robert/kube-config-hou02-mycluster-robert.yml
```

2. Copy and paste the `export KUBECONFIG=...` line into your shell.

3. Confirm the configuration worked by retrieving the cluster nodes.

```bash
kubectl get nodes
```

4. Edit your `helm/mern/Values.yaml` with your namespace

```yaml
replicaCount: 3
revisionHistoryLimit: 1
image:
  repository: registry.ng.bluemix.net/<namespace>/mern-example
  tag: v1
  pullPolicy: IfNotPresent
service:
  name: Node
  type: NodePort
  containerPort: 3000
  env: production
services:
  mongo:
     url: mongo
     name: comments
```

> replace the namespace with your namespace used when pushing your container. You can change the number of relicaCount too.

5. Install the Helm tiller

```bash
helm init
```

6. Install the Helm chart

```bash
helm install helm/mern
```

7. If you need to upgrade an existing deployment, you can use `helm upgrade`.

Find out your deployment name:

```bash
helm ls
```

```bash
NAME         	REVISION	UPDATED                 	STATUS  	CHART     	NAMESPACE
elegant-puma 	5       	Wed Jun 28 12:01:58 2017	DEPLOYED	mern-0.0.1	default
```

then to update the deployment, use:

```bash
helm upgrade elegant-puma helm/mern
```