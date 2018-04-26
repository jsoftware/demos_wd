#!/bin/bash
# make webview dist

S=~/deb/public/demos/wd/webview/lib
T=~/deb/addons/webview/dist
M=~/temp/jcc.js

rc() { rsync -c -r -L $1 $2; }

# ---------------
rm -f $M
mkdir -p $T/js
rc $S/js $T

cd $S
rc base.css $T
rc indexdist.html $T/index.html

F="util jfns barchart chart help linechart page0 page1 page2 page3 page4 \
 price report scatter slicer start";
for f in $F; do
  cat $f.js >> $M
done
rc $M $T/webview.js

