#!/bin/bash

set -e

SCRIPTFULLPATH=$(realpath $0)
BASEDIR=$(dirname "$SCRIPTFULLPATH")

echo
echo "Install using apt:"
xargs apt install -y < "$BASEDIR/../apt-packages.txt"

echo
echo "Install using snap:"
snap install --classic code

echo
echo "Install using pip:"
pip3 install -r "$BASEDIR/../pip-packages.txt"
