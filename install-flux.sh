# Create Flux NS
kubectl create ns flux

# Run Flux setup
export GHUSER="robincher"
fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/gitops-demo \
--git-branch=master \
--git-path=workloads \
--namespace=flux | kubectl apply -f -