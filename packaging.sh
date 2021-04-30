#!/usr/bin/env sh

go get github.com/mitchellh/gox
# https://github.com/mitchellh/gox
CGO_ENABLED=0 gox -osarch="windows/amd64 darwin/amd64 linux/amd64 linux/arm" -tags netgo -ldflags '-w -s'

dir=binaries
mkdir -p $dir;
rm -rf $dir/$f;

for f in rush_*; do
    mkdir -p $dir/$f;
    mv $f $dir/$f;
    cd $dir/$f;
    mv $f $(echo $f | perl -pe 's/_[^\.]+//g');
    tar -zcf $f.tar.gz rush*;
    mv *.tar.gz ../;
    cd ..;
    rm -rf $f;
    cd ..;
done;
