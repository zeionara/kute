# kute

kute - **ku**bernetes **te**sts - assets for testing and experimenting with kubernetes.

## Install

To download and set up `minikube` execute the following command:

```sh
./setup.sh
```

Then to start `minikube` run the following command:

```sh
minikube start
```

To create a `hello-world` application which consists of [bare `nginx` server](https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/):

```sh
kubectl apply -f config/hello-world.yml
```

To check the status of deployment:

```sh
kubectl describe deployment foo
```

To delete the deployment:

```sh
kubectl delete deployment foo
```
