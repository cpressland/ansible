# ansible

Quick setup script for dotfiles and other essential configuration

## macOS

### Usage

On a fresh Mac, execute the following:

Ensure the Terminal/iTerm has Full Disk Access else some settings will fail to Apply:

![Full Disk Access](img/full_disk_access.png)

```shell
# Install Xcode-CLT
$ xcode-select --install
# Install Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install Ansible
$ brew install ansible
# Run this playbook
$ ansible-playbook macos.yaml
```

## WSL

```shell
# Ensure Ubuntu is fully patched.
$ sudo apt update && sudo apt -y upgrade
# Install Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.bashrc
$ eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Install Ansible
$ brew install ansible
# Run this playbook
$ ansible-playbook wsl.yaml
```

## TODO

- Manage Dock Icons once https://github.com/kcrawford/dockutil/pull/131 is merged
