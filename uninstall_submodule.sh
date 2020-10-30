#!/bin/bash
# https://gist.github.com/myusuf3/7f645819ded92bda6677

PLUGIN=$1

FILE=".gitmodules"
CONFIG=".git/config"

git commit -am "Commit before removal of $PLUGIN"

lineNum="$(grep -nm 1 $PLUGIN $FILE | cut -d: -f1)"
PATH="$(head -n $(lineNum + 1) | tail -1 | awk '{ print $3 }')"
#.gitmodules linenumber + 1 | awk '{ print $3 }'
URL="$(head -n $(lineNum + 2) | tail -1 | awk '{ print $3 }')"
#.gitmodules linenumber + 2 | awk '{ print $3 }'
sed '$lineNum,$(lineNum+2)d' $FILE
# delete linenumber to linenumber + 2

git commit $FILE

lineNum="$(grep -nm 1 $PLUGIN $CONFIG | cut -d: -f1)"
sed '$lineNum,$(lineNum+2)d' $CONFIG
# delete linenumber to linenumber + 1

git rm --cached $PATH
rm -rf .git/modules/$PATH

git commit -am "Removed submodule"

rm -rf $PATH
