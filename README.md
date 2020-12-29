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
minikube start --driver virtualbox
```
We only support using the Virtualbox driver, although the others should work
fine too.

Install the ingress controller and DNS addons
```
minikube addons enable ingress
minikube addons enable ingress-dns
```

To be able to pull private images Kubernetes needs your local docker credentials
```
kubectl create secret generic docker-config-json --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson
```

Apply the local dev config folder
```
kubectl apply -f local/
```

## Description of services

### local/database.yml

MySQL database used by the API and other services. This is called
database-proxy as in production it's a TCP proxy to an external cluster.

### local/database_init_script.yml

Secret holding an init script used by the database. Creates any databases and
users needed for local development.

### services/api/

The main app API. This is the backend of fling.email.
