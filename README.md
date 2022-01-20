# Fling.email Kubernetes Deployment

## Deploying

```
// TODO :)
```

## Running Locally

This is the primary method of development when working on the fling.email
service.

Start an instance of [Minikube](https://minikube.sigs.k8s.io/docs/start/)
```
minikube start --driver docker
```
We only support using the Docker driver, although the others should work fine.


To be able to pull private images Kubernetes needs your local docker credentials
```
kubectl create secret generic docker-config-json --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson
```

Apply the local dev config folder
```
kubectl apply -f local/
```

Add a section to your `/etc/hosts` file to point the local domains to the
Kubernetes instance.
```
192.168.49.2 api.fling.local
192.168.49.2 smtp.fling.local
```
The IP address may not be the same here, use `minikube ip` to find it.

## Description of services

### local/database.yml

MySQL database used by the API and other services. This is called
database-proxy as in production it's a TCP proxy to an external cluster.

### local/database_init_script.yml

Secret holding an init script used by the database. Creates any databases and
users needed for local development.

### local/mailhog.yml

Local SMTP server with a web interface to view messages.

### services/api/

The main app API. This is the backend of fling.email.
