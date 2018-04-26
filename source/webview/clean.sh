#!/bin/bash

S=~/deb/public/demos/wd/webview/lib

cd $S

for i in `find $S -type d ! -path '*/\.*'`; do
 cd $i
 rm -f *.*~
 rm -rf .DS_Store
done

cd $S

for f in *.js; do
 ~/bin/jsbeautify.sh $f
done
