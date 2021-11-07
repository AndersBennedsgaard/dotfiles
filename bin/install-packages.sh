#!/bin/bash

set -e

SCRIPTFULLPATH=$(realpath $0)
BASEDIR=$(dirname $SCRIPTFULLPATH)

cat "$BASEDIR/../packages.txt" | xargs apt install -y
