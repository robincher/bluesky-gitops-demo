# Bluesky Gitops Demo

Demonstration of GitOps with Flux and Botkube for alerting

For the first part of this demo, please go to [Bluesky Sample ReactApp](https://github.com/robincher/bluesky-sample-react-app)

# Preparation

## Technology Stack

- Minikube @ macOS
- Flux
- Botkube
- Sample App built with React Boilerplate

## Workflow

![bluesky-wf-gitops.png](https://github.com/robincher/bluesky-gitops-demo/blob/master/assets/bluesky-wf-gitops.png)

### Steps

1. Following the container image pushed, the gitops repository (right here) can be updated with the new container image reference.
2. Flux will observe any changes to the bluesky-gitops-demo repository, and apply the corresponding updates to the workload or configurations running in the kubernetes cluster.

## Implementation

### Install Flux CLI and Minikube

```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube

# Install fluxctl on MacOS
curl -LO https://github.com/fluxcd/flux/releases/download/1.21.1/fluxctl_darwin_amd64
sudo install fluxctl_darwin_amd64 /usr/local/bin/fluxctl

# Give permission to store Kube config (Optional)
sudo chmod 777 $HOME/.kube

# Start Minikube
minikube start
```

#### Set-up Flux in MiniKube

```
# Create Flux NS
kubectl create ns flux

# Run Flux setup
export GHUSER="your-account-name"
export REPOSITORY="your-repository-name"
fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/${REPOSITORY}\
--git-branch=master \
--git-path=workloads \
--namespace=flux | kubectl apply -f -
```

Retrive the SSH Key generated by flux, and establish a trust between Flux (in the cluster) and the corresponding git repository.

For Github repostiroy, just go to **Setting**, and add it into **Deploy Key**

### Add a commit

Update the replica to 2 for the bluesky-app Deployment

```
#bluesky-app.yaml
#
spec:
  progressDeadlineSeconds: 600
  replicas: 1 --> 2
...
...
```

#### Make Service accessible through Minikube

Standard way to expose a service to the internet

```
minikube service bluesky-app-service
```

#### Update the code tag

```
#bluesky-app.yaml
spec:
    containers:
    - image: enpapex/bluesky-react-sample-app:${tag}
...
...
```

#### Botkube set-up

1. Add BotKube App to Slack workspace, and record down the Bot (Slack) Token

2. Update secrets @ botkube-communication-secret (Not a good practice using clear text!)

```
stringData:
  comm_config.yaml: |
    # Communication settings
    communications:
      # Settings for Slack
      slack:
        enabled: true
        channel: 'operations'
        token: 'SLACK_TOKEN'
        notiftype: short
```

## License

[UNLICENSED ](https://github.com/robincher/bluesky-gitops-demo/blob/master/LICENSE)

## References

- [BotKube](https://www.botkube.io/examples/)
- [Starting with Flux](https://docs.fluxcd.io/)
- [Guide to GitOps](https://www.weave.works/technologies/gitops/)
- [Setting up Docker Daemon](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)
- [Minikube Mechanics](https://kubernetes.io/docs/tutorials/hello-minikube/)
