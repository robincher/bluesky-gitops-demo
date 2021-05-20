# Create Flux NS
kubectl create ns flux

# Script to pull flux-git-deploy secrets from AWS Secret Manager
#FLUX_GIT_SECRET=$( aws secretsmanager get-secret-value --secret-id platform/kubernetes/secret/flux/git-deploy-key  --query SecretString --output text)
#echo "$FLUX_GIT_SECRET" > ~/tmp/flux-secret.yaml

# Set-up Flux and memcache
#kubectl apply -f ~/tmp/flux-secret.yaml -n flux


# Run Flux setup
export GHUSER="robincher"
export REPOSITORY="bluesky-gitops-demo"
fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/${REPOSITORY} \
--git-branch=master \
--git-path=workloads \
--namespace=flux | kubectl apply -f -
