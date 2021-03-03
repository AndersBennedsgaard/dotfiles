alias nv='nvim'
alias vim='echo "Use nv instead"'
alias py='python3'

alias kk='kubectl'
# To enable shell completion for the alias
complete -F __start_kubectl kk
dashboard () {
    echo "Access the dashboard at:"
    echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
    echo "Bearer token:"
    echo $(kk -n kubernetes-dashboard describe secrets admin-user-token-czjcs | grep "token:" | awk '{print $2}')
    kubectl proxy
}
