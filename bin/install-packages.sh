#!/bin/bash

set -e

SCRIPTFULLPATH=$(realpath $0)
BASEDIR=$(dirname $SCRIPTFULLPATH)

echo "Install using apt:"
cat "$BASEDIR/../apt-packages.txt" | xargs apt install -y

echo "Install using snap:"
snap install --classic code
