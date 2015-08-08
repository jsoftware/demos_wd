NB. demosel.ijs      - main selection dialog

18!:55 <'jdemos'
coclass 'jdemos'

REQ=: 0 : 0
demos/isigraph/isdemo.ijs
demos/wdplot/plotdemo.ijs
games/minesweeper/uiwd.ijs
games/nurikabe/nurikabe.ijs
games/solitaire/solitaire.ijs
general/misc/numeric.ijs
graphics/bmp/bmp.ijs
graphics/color/rgb.ijs
graphics/gl2/gl2.ijs
graphics/viewmat/viewmat.ijs
math/deoptim/demo/eg_deoptim.ijs
math/lapack/lapack.ijs
math/eigenpic/eigenpic.ijs
math/misc/trig.ijs
stats/base/base.ijs
)

sububar=: I. @(e.&'_')@]}
maketitle=: ' '&sububar each @ cutopen ;._2
fexist=: 1:@(1!:4)@boxopen ::0:
qtmajor=: 0 ". ({.~ i.&'.') '/s' -.~ (}.~ i.&'/') wd 'version'
qtslim=: 's' e. wd 'version'

TITLESANDROID=: maketitle 0 : 0
cities dcities
coins dcoins
deoptim ddeoptim
eigenpictures deigenpic
events devents
isigraph disigraph
life dlife
minesweeper dminesweeper
plot dplot
unicode_simple dunisimple
)

TITLESQT=: maketitle 0 : 0
cities dcities
coins dcoins
deoptim ddeoptim
eigenpictures deigenpic
events devents
isigraph disigraph
isigrid disigrid
life dlife
minesweeper dminesweeper
nurikabe dnurikabe
plot dplot
samegame dsamegame
snake dsnake
solitaire dsolitaire
unicode_simple dunisimple
)

TITLES=: 3 : 0''
if. IFJA do.
  TITLESANDROID
else.
  TITLESQT
end.
)

NB. =========================================================
DEMOS=: 0 : 0
pc demos closeok;pn "Demos Select";
bin v;
cc static1 static;cn "static1";
bin h;
minwh 200 400;cc listbox listbox;
bin v;
cc ok button;cn "OK";
cc cancel button;cn "Cancel";
cc view button;cn "View Source";
bin szzz;
pas 4 2;pcenter;
rem form end;
)

NB. =========================================================
checkrequires=: 3 : 0
r=. <;._2 REQ
b=. fexist &> (<jpath '~addons/') ,each r
if. *./ b do. 1 return. end.
p=. (#~ 2>[: +/\'/'=]) each (-.b)#r
m=. 'This demo requires additional packages to be installed.'
m=. m,LF,;LF,&>p
m=. m,LF2,'Installation may take a few seconds.'
m=. m,' OK to install now?'
if. 0~:wdquery m do. 0 return. end.
load 'pacman'
'update' jpkg ''
'install' jpkg p
if. (UNAME-:'Android') *. (<'math/lapack') e. p do.
  require 'math/lapack'
  install_jlapack_ ::0: ''
end.
1
)

NB. =========================================================
demos_run=: 3 : 0
if. -. checkrequires'' do. return. end.
require 'gl2'
coinsert 'jgl2'
if. IFJA do.
  wd 'activity ', >coname'' return.
end.
if. wdisparent 'demos' do.
  wd 'psel demos;pshow;pactive' return.
end.
wd DEMOS
wd 'set static1 text *Select a demo from the list below:'
NB. TODO
wd 'set listbox items ',;DEL,each ({."1 TITLES),each DEL
wd 'set listbox select 0'
wd 'setfocus listbox'
wd 'pshow'
)

NB. =========================================================
demos_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
demos_listbox_button=: 3 : 0
fn=. > {: (".listbox_select) { TITLES
fn~0
)

NB. =========================================================
demos_enter=: demos_ok_button=: demos_listbox_button
demos_cancel_button=: demos_close

NB. =========================================================
demos_view_button=: 3 : 0
f=. }. > {: (".listbox_select) { TITLES
select. <f
case. 'cities' do. textview f;1!:1 <jpath '~addons/demos/wd/citydemo.ijs'
case. 'coins' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/demos/wd/coins/'
case. 'deoptim' do. textview f;1!:1 <jpath '~addons/math/deoptim/demo/eg_deoptim.ijs'
case. 'eigenpic' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/math/eigenpic/'
case. 'events' do. textview f;1!:1 <jpath '~addons/demos/wd/',f,'.ijs'
case. 'isigrid' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/demos/wd/isigrid'
case. 'isigraph' do. browse_j_ 'http://jsoftware.com/wsvn/addons/trunk/demos/isigraph/'
case. 'life' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/demos/wd/life/'
case. 'minesweeper' do. browse_j_ 'http://jsoftware.com/wsvn/addons/trunk/games/minesweeper'
case. 'nurikabe' do. browse_j_ 'http://jsoftware.com/wsvn/addons/trunk/games/nurikabe'
case. 'plot' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/graphics/plot/source/dev/demo'
case. 'pousse' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/demos/wd/coins/'
case. 'solitaire' do. browse_j_ 'http://jsoftware.com/wsvn/addons/trunk/games/solitaire/'
case. 'unisimple' do. textview f;1!:1 <jpath '~addons/demos/wd/',f,'.ijs'
case. 'samegame' do. textview f;1!:1 <jpath '~addons/demos/wd/samegame/samegame.qml'
case. 'snake' do. textview f;1!:1 <jpath '~addons/demos/wd/snake/qml/snake/snake.qml'
end.
)

NB. =========================================================
dcities=: load bind (jpath '~addons/demos/wd/citydemo.ijs')
dcobrowse=: load bind (jpath '~addons/gui/util/cobrowse.ijs')
dcoins=: load bind (jpath '~addons/demos/wd/coins.ijs')
ddeoptim=: load bind (jpath '~addons/math/deoptim/demo/eg_deoptim.ijs')
ddialogs=: load bind (jpath '~addons/demos/wd/demoall.ijs')
deigenpic=: load bind (jpath '~addons/math/eigenpic/eigenpic.ijs')
devents=: load bind (jpath '~addons/demos/wd/events.ijs')
disigrid=: load bind (jpath '~addons/demos/wd/isigrid.ijs')
disigraph=: load bind (jpath '~addons/demos/isigraph/isdemo.ijs')
dlife=: load bind (jpath '~addons/demos/wd/life.ijs')
dminesweeper=: load bind (jpath '~addons/games/minesweeper/uiwd.ijs')
dnurikabe=: nurikabe__ @: (load bind (jpath '~addons/games/nurikabe/nurikabe.ijs'))
dpaint=: load bind (jpath '~addons/demos/isigraph/paint.ijs')
dplot=: load bind (jpath '~addons/demos/wdplot/plotdemo.ijs')
dpousse=: load bind (jpath '~addons/games/pousse/pousse.ijs')
dprinter=: load bind (jpath '~addons/demos/wd/printer.ijs')
dregex=: load bind (jpath '~addons/demos/wd/regdemo.ijs')
dsolitaire=: load bind (jpath '~addons/games/solitaire/solitaire.ijs')
dtabula=: load bind (jpath '~addons/math/tabula/tabula.ijs')
dtreemap=: load bind (jpath '~addons/graphics/treemap/demo.ijs')
dunisimple=: load bind (jpath '~addons/demos/wd/unisimple.ijs')
dsamegame=: wd bind ('quickview2 samegame "', '"',~jpath '~addons/demos/wd/samegame/samegame.qml')`notsupport@.((qtslim>'Android'-:UNAME)+.qtmajor=4)
dsnake=: wd bind ('quickview1 snake "', '"',~jpath '~addons/demos/wd/snake/qml/snake/snake.qml')`notsupport@.((qtslim+.'Android'-:UNAME)+.qtmajor=5)

NB. =========================================================
notsupport=: 3 : 0
sminfo 'This demo is not supported on ', UNAME, ' ', wd 'version'
)

demos_run''
