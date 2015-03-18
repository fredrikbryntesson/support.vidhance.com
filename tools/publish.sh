#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd $DIR/..
rm -rf public/*
hugo
pushd public
git add -A .
echo "Please enter commit message:"
read MESSAGE
git commit -m "$MESSAGE"
git push -f
popd
popd
