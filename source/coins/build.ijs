
writesourcex_jp_ '~Addons/demos/wd/source/coins';'~Addons/demos/wd/coins.ijs'

mkdir_j_ jpath '~Addons/demos/coins'
mkdir_j_ jpath '~Demos/coins'

NB. ---------------------------------------------------------
f=: 3 : 0
('~Addons/demos/coins/',y) fcopynew '~Addons/demos/wd/source/coins/',y
)

f each <;._2 (0 : 0)
boards.ijs
draw.ijs
help.ijs
manifest.ijs
mouse.ijs
move.ijs
util.ijs
win.ijs
)

'~Addons/demos/coins/coins.jproj' fcopynew '~Addons/demos/wd/source/coins/coinsdemo.jproj'
'~Addons/demos/coins/init.ijs' fcopynew '~Addons/demos/wd/source/coins/initdemo.ijs'

NB. ---------------------------------------------------------
t=. LF,'writesourcex_jp_ ''~Demos/coins'';''~Demos/coins/coins.ijs'''
t fwrites '~Addons/demos/coins/build.ijs'

NB. ---------------------------------------------------------
t=. 0 : 0

load '~Demos/coins/coins.ijs'

NB. try BOARD=1, 2 or 3
BOARD=: 0

init''
coin_run''
)

t fwrites '~Addons/demos/coins/run.ijs'

NB. =========================================================
f=: 3 : 0
('~Demos/coins/',y) fcopynew '~Addons/demos/coins/',y
)

f each {."1 [ 2 dir '~Addons/demos/coins'
