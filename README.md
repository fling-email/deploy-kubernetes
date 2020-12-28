# Fling.email Kubernetes Deployment

## Running Locally

Start an instance of [Minikube](https://minikube.sigs.k8s.io/docs/start/)
```
minikube start --driver virtualbox
```
We only support using the Virtualbox driver, although the others should work fine too.

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
