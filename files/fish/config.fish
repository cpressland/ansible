bind \cw backward-kill-word

if command -v eza 1>/dev/null 2>&1
    function ls
        eza -F --icons --git --group-directories-first --time-style long-iso --colour-scale $argv
    end
end

if command -v bat 1>/dev/null 2>&1
  function cat
    bat --paging=never $argv
  end
end

if command -v flux 1>/dev/null 2>&1
  flux completion fish | source
end

if command -v kubectl 1>/dev/null 2>&1
  kubectl completion fish | source
end

if command -v direnv 1>/dev/null 2>&1
  direnv hook fish | source
end

function _maybe_source
    if [ -f $argv ]
        source $argv
    end
end

_maybe_source $HOME/.iterm2_shell_integration.fish
_maybe_source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

function b2k
    for subscription in (az account list --output json 2>/dev/null | jq -r ".[].id")
        az account set --subscription $subscription
        for cluster in (az aks list | jq -r '.[] | "\(.resourceGroup):\(.name)"')
            set cluster_rg (string split ":" $cluster)[1]
            set cluster_name (string split ":" $cluster)[2]
            az aks get-credentials --overwrite-existing --resource-group $cluster_rg --name $cluster_name
        end
    end
    kubelogin convert-kubeconfig -l azurecli
end

function iterm2_print_user_vars
    set -l kube_context (kubectl config current-context)
    set -l kube_namespace (kubectl config view --minify --output 'jsonpath={..namespace}')
    set -l git_branch (git branch 2> /dev/null | grep \* | cut -c3-)

    iterm2_set_user_var kube_context "$kube_context"
    iterm2_set_user_var kube_namespace "$kube_namespace"
    iterm2_set_user_var git_branch "$git_branch"
end

function fish_prompt
    echo (set_color brmagenta)'$ '
end
