#!/bin/bash

set -e

SCRIPTFULLPATH=$(realpath $0)
BASEDIR=$(dirname "$SCRIPTFULLPATH")

echo "Install using apt:"
xargs apt install -y < "$BASEDIR/../apt-packages.txt"

echo "Install using snap:"
snap install --classic code
