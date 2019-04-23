NB. demosel.ijs      - main selection dialog

18!:55 <'jdemos'
coclass 'jdemos'

onStart=: demos_run

REQ=: 0 : 0
demos/isigraph/isdemo.ijs
demos/wdplot/plotdemo.ijs
games/2048/ui_wd.ijs
games/minesweeper/uiwd.ijs
games/solitaire/solitaire.ijs
general/misc/numeric.ijs
graphics/bmp/bmp.ijs
graphics/color/rgb.ijs
graphics/viewmat/viewmat.ijs
math/deoptim/demo/eg_deoptim.ijs
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
isigraph disigraph
life dlife
minesweeper dminesweeper
plot dplot
solitaire dsolitaire
unicode_simple dunisimple
)

TITLESQT=: maketitle 0 : 0
2048 d2048
cities dcities
coins dcoins
deoptim ddeoptim
events devents
isigraph disigraph
isigrid disigrid
life dlife
minesweeper dminesweeper
plot dplot
samegame dsamegame
solitaire dsolitaire
unicode_simple dunisimple
webview dwebview
)

TITLES=: 3 : 0''
if. IFJA do.
  TITLESANDROID
else.
  t=. TITLESQT
  if. (805<{.0".}.({.~ i.&'/')9!:14'')+.(qtslim>'Android'-:UNAME)+.qtmajor=4 do.
    t=. t #~ -. ({."1 t) = <'samegame'
  end.
  if. JQTVER_jqtide_ < 5006000 do.
    t=. t #~ -. ({."1 t) = <'webview'
  end.
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
bin szzz;
pas 4 2;pcenter;
rem form end;
)

NB. =========================================================
DEMOSJA=: 0 : 0
pc demos closeok;pn "Demos Select";
bin v;
cc static1 static;cn "static1";
wh _1 _2;cc listbox listbox;
bin z;
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
if. IFJA do.
  missing=: p
  'yes no' wdquery m
  return.
end.
if. 0~:wdquery m do. 0 return. end.
load 'pacman'
'update' jpkg ''
'install' jpkg p
1
)

NB. =========================================================
demos_run=: 3 : 0
if. -.IFJA do.
  if. -. checkrequires'' do. return. end.
end.
coinsert 'jgl2'
if. wdisparent 'demos' do.
  wd 'psel demos;pshow;pactive' return.
end.
wd IFJA{::DEMOS;DEMOSJA
wd 'set static1 text *Select a demo from the list below:'
wd 'set listbox items ',;DEL,each ({."1 TITLES),each DEL
wd 'set listbox select 0'
wd 'setfocus listbox'
wd 'pshow'
checkrequires^:IFJA ''
)

NB. =========================================================
demos_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
demos_listbox_select=: 3 : 0
fn=. > {: (".listbox_select) { TITLES
fn~0
)

NB. =========================================================
demos_enter=: demos_ok_button=: demos_listbox_select
demos_cancel_button=: demos_close

NB. =========================================================
demos_listbox_button=: 3 : 0
f=. }. > {: (".listbox_select) { TITLES
select. <f
case. '2048' do. textview f;1!:1 <jpath '~addons/games/2048/engine.ijs'
case. 'cities' do. textview f;1!:1 <jpath '~addons/demos/wd/citydemo.ijs'
case. 'coins' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/demos/wd/coins/'
case. 'deoptim' do. textview f;1!:1 <jpath '~addons/math/deoptim/demo/eg_deoptim.ijs'
case. 'events' do. textview f;1!:1 <jpath '~addons/demos/wd/',f,'.ijs'
case. 'isigrid' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/demos/wd/isigrid'
case. 'isigraph' do. browse_j_ 'http://jsoftware.com/wsvn/addons/trunk/demos/isigraph/'
case. 'life' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/demos/wd/life/'
case. 'minesweeper' do. browse_j_ 'http://jsoftware.com/wsvn/addons/trunk/games/minesweeper'
case. 'plot' do. browse_j_ 'http://jsoftware.com/wsvn/public/trunk/graphics/plot/source/dev/demo'
case. 'solitaire' do. browse_j_ 'http://jsoftware.com/wsvn/addons/trunk/games/solitaire/'
case. 'unisimple' do. textview f;1!:1 <jpath '~addons/demos/wd/',f,'.ijs'
case. 'samegame' do. textview f;1!:1 <jpath '~addons/demos/wd/samegame/samegame.qml'
case. 'webview' do. textview f;1!:1 <jpath '~addons/demos/wd/webview/webview.js'
end.
)

NB. =========================================================
d2048=: load bind (jpath '~addons/games/2048/ui_wd.ijs')
dcities=: load bind (jpath '~addons/demos/wd/citydemo.ijs')
dcobrowse=: load bind (jpath '~addons/gui/util/cobrowse.ijs')
dcoins=: load bind (jpath '~addons/demos/wd/coins.ijs')
ddeoptim=: load bind (jpath '~addons/math/deoptim/demo/eg_deoptim.ijs')
ddialogs=: load bind (jpath '~addons/demos/wd/demoall.ijs')
devents=: load bind (jpath '~addons/demos/wd/events.ijs')
disigrid=: load bind (jpath '~addons/demos/wd/isigrid.ijs')
disigraph=: load bind (jpath '~addons/demos/isigraph/isdemo.ijs')
dlife=: load bind (jpath '~addons/demos/wd/life.ijs')
dminesweeper=: load bind (jpath '~addons/games/minesweeper/uiwd.ijs')
dpaint=: load bind (jpath '~addons/demos/isigraph/paint.ijs')
dplot=: load bind (jpath '~addons/demos/wdplot/plotdemo.ijs')
dprinter=: load bind (jpath '~addons/demos/wd/printer.ijs')
dregex=: load bind (jpath '~addons/demos/wd/regdemo.ijs')
dsolitaire=: load bind (jpath '~addons/games/solitaire/solitaire.ijs')
dtabula=: load bind (jpath '~addons/math/tabula/tabula.ijs')
dtreemap=: load bind (jpath '~addons/graphics/treemap/demo.ijs')
dunisimple=: load bind (jpath '~addons/demos/wd/unisimple.ijs')
dsamegame=: wd bind ('quickview2 samegame "', '"',~jpath '~addons/demos/wd/samegame/samegame.qml')
dwebview=: load bind (jpath '~addons/demos/wd/webview/webview.ijs')

demos_dialog_positive=: 3 : 0
wd 'mb toast "install addons" 0'
load 'pacman'
'update' jpkg ''
'install' jpkg missing
wd 'mb toast finished'
)

demos_run`wd@.IFJA 'activity ', >coname''
