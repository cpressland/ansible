set -gx EDITOR nvim
bind \cw backward-kill-word

if command -v eza 1>/dev/null 2>&1
    function ls
        eza -F --icons --git --group-directories-first --time-style long-iso --colour-scale all $argv
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

if type -q starship
    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
end

if status is-interactive
    atuin init fish --disable-up-arrow | source
end

if grep -q "WSL2" /proc/version
    alias pbcopy="clip.exe"
end
