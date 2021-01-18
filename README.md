# Gitops Demo

Simple demonstration of GitOps with Flux and Botkube

![diagram.png](https://github.com/robincher/gitops-demo/blob/master/assets/gitops-context.png)

# Preparation

## Technology Stack

- Minikube @ macOS
- Flux
- Botkube

```
# Install minikube on MacOS

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube

# Install fluxctl on MacOS
curl -LO https://github.com/fluxcd/flux/releases/download/1.21.1/fluxctl_darwin_amd64
sudo install fluxctl_darwin_amd64 /usr/local/bin/fluxctl
```

## Steps

1. Start minikube
2. Set-up flux
3. Small commit (Install botkube)

## License

[MIT LICENSE ](https://github.com/robincher/docker-compose-ghost-quickstart/blob/master/LICENSE)

## References

- [BotKube](https://www.botkube.io/examples/)
- [Starting with Flux](https://docs.fluxcd.io/)
- [Guide to GitOps](https://www.weave.works/technologies/gitops/)
