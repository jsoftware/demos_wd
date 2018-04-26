NB. build webview demo

S=: jpath '~Addons/demos/wd/source/webview'
R=: jpath '~Addons/demos/wd/webview'
T=: jpath '~addons/demos/wd/webview'
mkdir_j_ R,'/js'
mkdir_j_ T,'/js'

hostcmd 'rsync -c -r ',S,'/lib/js/* ',R,'/js'
hostcmd 'rsync -c -r ',S,'/lib/js/* ',T,'/js'

f=: 3 : 0
'f t'=. 2$boxxopen y
(freads S,'/',f) fwritenew R,'/',t
(freads S,'/',f) fwritenew T,'/',t
)

f 'lib/base.css';'base.css'
f 'lib/indexdist.html';'index.html'
f 'base/comms.ijs';'comms.ijs'

F=: cutopen 0 : 0
util
jfns
barchart
chart
help
linechart
page0
page1
page2
page3
page4
price
report
scatter
slicer
start
)

f=: 3 : 0
freads S,'/lib/',y,'.js'
)

dat=. ;f each F
dat fwritenew R,'/webview.js'
dat fwritenew T,'/webview.js'

dat=. readsource_jp_ S,'/base'
dat=. dat,readsource_jp_ S,'/report'
dat=. dat,'webview_qtwebview_ 0'
dat fwritenew R,'/webview.ijs'
dat fwritenew T,'/webview.ijs'
