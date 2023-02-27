# kute ⚓

<p align="center">
    <img src="assets/images/logo.png"/>
</p>

kute - **ku**bernetes **te**sts - assets for testing and experimenting with kubernetes.

## Install

To download and set up `minikube` execute the following command:

```sh
./setup.sh
```

Then to start `minikube` run the following command:

```sh
minikube start --extra-config=apiserver.service-node-port-range=8000-9000
```

To create a `hello-world` application which consists of [bare `nginx` server](https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/):

```sh
kubectl apply -f config/hello-world.yml
```

To check the status of deployment:

```sh
kubectl describe deployment foo
```

To call the deployment:

```sh
curl $(minkube ip):8080
```

To delete the deployment:

```sh
kubectl delete deployment foo
```

# Deployment

To deploy `kute` service run the following command (alias `drr` is defined in the [docker-tools](https://github.com/zeionara/bash-tools):

```sh
drr -p 8080:8080 kute:latest
```

To generate tokens, run the following command (alias `curll` is defined in [the gist](https://gist.github.com/zeionara/582902c79fc1a58c36b1b2c554a02b81)):

```sh
curllj
```

The command generates the following output:

```json
{
   "date" : "27-02-2023@21:33:02.22",
   "uuid" : "501d1b09-48d9-4ebf-8d75-870abed4ee29",
   "word" : "ralair"
}
```
