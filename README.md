# Dotfiles

My dotfile configuration

## Installation

```bash
sudo apt update
sudo apt -y install git python3-pip
ssh-keygen -t ed25519
```

Log into Github.com, and add `~/.ssh/id_ed25519.pub` to [keys](https://github.com/settings/keys).

Start a new terminal (to load the SSH keys into `git`), and install the dotfiles using Ansible, with:

```bash
git clone git@github.com:AndersBennedsgaard/dotfiles.git
cd dotfiles

pip install --user ansible

# $HOME/.local/bin is most likely not in $PATH
export PATH="$PATH:$HOME/.local/bin"

ansible-galaxy install -r requirements.yaml
ansible-playbook main.yaml -K
```

When changing the shell of a user (i.e. to `/bin/zsh`) you need to log out and in again, for this to take effect.

## Development

Testing can either be done with Vagrant (recommended) or Docker.

### Vagrant

A Vagrantfile is located at the root of the project, which runs a `generic/ubuntu2204` box with the Ansible playbook as the provisioner.
Boot up the VM and run the playbook with:

```bash
vagrant up
```

Run the playbook again, after the VM is running:

```bash
vagrant provision
```

Destroy the VM with:

```bash
vagrant destroy
```

When asked for the BECOME password, use `vagrant` (which is also the username)

### Docker

A container with Ubuntu 20.04 is used for testing, which runs `sshd` with the ssh-keys found in `docker/ssh/`.
By running the container with the name `ansible-test`, Ansible can ssh into the container and deploy the playbook.
To build and run the container, use the following:

```bash
docker build -t ansible-test:latest docker/
docker run --name ansible-test -d --rm -p 2222:22 ansible-test:latest
```

Run the playbook with:

```sh
ansible-playbook main.yaml -i tests/inventory
```
