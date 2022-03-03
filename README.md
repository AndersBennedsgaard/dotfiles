# Dotfiles

My dotfile configuration

## Installation

```bash
apt update && apt install git
ssh-keygen -t ed25519
```

Log into Github.com, and add `~/.ssh/id_ed25519.pub` to [keys](https://github.com/settings/keys).

Install the dotfiles using Ansible, with:

```bash
git clone git@github.com:AndersBennedsgaard/dotfiles.git
cd dotfiles

pip insall ansible

ansible-galaxy install -r requirements.yaml
ansible-playbook main.yaml -K
```

## Development

A container with Ubuntu 20.04 is used for testing, which runs `sshd` with the ssh-keys found in `ssh/`.
By running the container with the name `ansible-test`, Ansible can ssh into the container and deploy the playbook.
To build and run the container, use the following:

```bash
docker build -t ansible-test:latest -f docker/Dockerfile .
docker run --name ansible-test -d --rm -p 2222:22 ansible-test:latest
```

Run the playbook with:

```sh
ansible-playbook tests/main.yaml -i tests/inventory
```
