#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd $DIR/..
rm -rf public/*
hugo
pushd public
git add -A .
popd
popd
