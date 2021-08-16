#!/bin/bash

alias disp="display"
alias ll='ls -alF'
alias la='ls -AF'
alias py="python3"

alias conflicts="git diff --name-only --diff-filter=U"
alias log='git log --all --decorate --oneline --graph'

alias mktar='tar -cvf'
alias untar='tar -xvf'

alias vim='nvim'
alias gs='git status'
alias gd='git diff'

container-ip() {
    if [ $# -eq 0 ]; then
        echo -e "$(docker ps -q | xargs docker inspect -f '{{.Name}}: \t{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}')"
    else    
        docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
    fi
}

container-stop () {
    if [ $# -eq 0 ]; then
        docker ps -q | xargs docker stop
    else
        docker stop "$1"
    fi
}

container-enter () {
    if [ $# -ne 1 ]; then
        echo "Only a single argument required"
        exit 1
    fi
    docker exec -it $1 /bin/bash
}

alias k='kubectl'
# To enable shell completion for the alias
complete -F __start_kubectl k
alias wpo='watch kubectl get pods'
alias wf='watch flux get all -A'
alias fsync='flux reconcile source git flux-system'
alias kga='kubectl api-resources --namespaced --verbs=list -o name | xargs -n 1 kubectl get --ignore-not-found --show-kind'
dashboard () {
    helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --set extraArgs="{--token-ttl=36000}" --wait &> /dev/null
    echo "Access the dashboard at:"
    echo "https://localhost:8443/"

    echo
    echo "Bearer token:"
    kubectl create serviceaccount dashboard-admin-sa &> /dev/null
    kubectl create clusterrolebinding dashboard-admin-sa --clusterrole=cluster-admin --serviceaccount=default:dashboard-admin-sa &> /dev/null
    kubectl get secret "$(kubectl get serviceaccount dashboard-admin-sa -o jsonpath='{.secrets[0].name}')" -o go-template="{{.data.token | base64decode}}"

    echo
    echo
    kubectl wait --for=condition=ready pod --selector="app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" &> /dev/null
    POD_NAME=$(kubectl get pods -n default -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
    kubectl -n default port-forward "$POD_NAME" 8443:8443
}
