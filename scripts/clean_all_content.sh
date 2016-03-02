#!/usr/bin/env bash
pushd .
cd $1
find . -name _content_.* -print | xargs /bin/rm -f
popd
