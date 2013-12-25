NB. demosel.ijs      - main selection dialog

require 'droidwd wdclass gl2 numeric stats'

18!:55 <'jdemos'
coclass 'jdemos'
coinsert 'jgl2 wdbase'
droidwd_run=: demos_run

sububar=: I. @(e.&'_')@]}
maketitle=: ' '&sububar each @ cutopen ;._2
fexist=: 1:@(1!:4)@boxopen ::0:

TITLESWIN=: maketitle 0 : 0
cities dcities
coins dcoins
controls dcontrols
eigenpictures deigenpic
events devents
grid dgrid
life dlife
isigraph... disigraph
opengl_simple... dopengllab
plot dplot
pousse dpousse
regular_expressions dregex
solitaire dsolitaire
socket_server dsockserver
socket_client dsockclient
splitter dsplitter
treeview dtreeview
unicode_simple dunisimple
unicode dunicode
)

NB. allout dallout

TITLESALL=: maketitle 0 : 0
cities dcities
cobrowse dcobrowse
coins dcoins
controls dcontrols
deoptim ddeoptim
eigenpictures deigenpic
events devents
form_edit dformedit
grid dgrid
isigraph... disigraph
life dlife
minesweeper dminesweeper
nurikabe dnurikabe
plot dplot
pousse dpousse
printer dprinter
regular_expressions dregex
scriptdoc dscriptdoc
solitaire dsolitaire
tabula dtabula
treemap dtreemap
unicode dunicode
unicode_simple dunisimple
)

TITLESANDROID=: maketitle 0 : 0
cities dcities
coins dcoins
controls dcontrols
deoptim ddeoptim
events devents
isigraph... disigraph
grid dgrid
life dlife
minesweeper dminesweeper
plot dplot
pousse dpousse
unicode dunicode
unicode_simple dunisimple
)

TITLESQT=: maketitle 0 : 0
cities dcities
coins dcoins
controls dcontrols
deoptim ddeoptim
events devents
isigraph... disigraph
grid dgrid
life dlife
minesweeper dminesweeper
nurikabe dnurikabe
opengl_demo dopengldem
opengl_simple dopenglsim
plot dplot
pousse dpousse
qt_demo dqtdemo
scriptdoc dscriptdoc
solitaire dsolitaire
unicode dunicode
unicode_simple dunisimple
)

TITLESQT2=: maketitle 0 : 0
cities dcities
coins dcoins
controls dcontrols
deoptim ddeoptim
events devents
isigraph... disigraph
grid dgrid
life dlife
minesweeper dminesweeper
nurikabe dnurikabe
opengl_demo dopengldem
opengl_simple dopenglsim
plot dplot
pousse dpousse
qt_demo dqtdemo
scriptdoc dscriptdoc
solitaire dsolitaire
unicode dunicode
unicode_simple dunisimple
)

TITLES=: 3 : 0''
if. IFQT do.
  ('s' e. wd 'version') {:: TITLESQT ;< TITLESQT2
elseif. 'Android'-:UNAME do.
  TITLESANDROID
elseif. do.
  TITLESALL
end.
)

NB. =========================================================
DEMOS=: 0 : 0
pc demos closeok;pn "Demos Select";
bin v;
cc static1 static;cn "static1";
bin h;
minwh 200 400;cc listbox listbox lbs_nosel;
bin v;
cc ok button;cn "OK";
cc cancel button;cn "Cancel";
bin szzz;
pas 4 2;pcenter;
rem form end;
)

NB. =========================================================
demos_run=: 3 : 0
if. wdisparent 'demos' do.
  wd 'psel demos;pshow;pactive' return.
end.
wd DEMOS
wd 'set static1 text *Select a demo from the list below:'
NB. TODO
wd 'set listbox items ',;DEL,each ({."1 TITLES),each DEL
wd 'set listbox select 0'
wd 'setfocus listbox'
wd 'pshow;'
evtloop''
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
dallout=: load bind (jpath '~addons/demos/wd/allout.ijs')
dcities=: load bind (jpath '~addons/demos/wd/citydemo.ijs')
dcobrowse=: load bind (jpath '~addons/gui/util/cobrowse.ijs')
dcoins=: load bind (jpath '~addons/demos/wd/coins.ijs')
dcontrols=: load bind (jpath '~addons/demos/wd/controls.ijs')
ddeoptim=: load bind (jpath '~addons/math/deoptim/demo/eg_deoptim.ijs')
ddialogs=: load bind (jpath '~addons/demos/wd/demoall.ijs')
deigenpic=: load bind (jpath '~addons/math/eigenpic/eigenpic.ijs')
devents=: load bind (jpath '~addons/demos/wd/events.ijs')
dgrid=: load bind (jpath '~addons/demos/wd/grid.ijs')
disigraph=: load bind (jpath '~addons/demos/isigraph/isdemo.ijs')
dlife=: load bind (jpath '~addons/demos/wd/life.ijs')
dminesweeper=: load bind (jpath '~addons/games/minesweeper/uiwd.ijs')
dnurikabe=: nurikabe__ @: (load bind (jpath '~addons/games/nurikabe/nurikabe.ijs'))
dopengl=: load bind (jpath '~addons/demos/wdopengl/gldemo/gldemo.ijs')`notsupport@.('Android'-:UNAME)
dopengllab=: load bind (jpath '~addonsr/demos/wdopengl/glsimple/gldemos.ijs')`notsupport@.('Android'-:UNAME)
dpaint=: load bind (jpath '~addons/demos/isigraph/paint.ijs')
dopenglsim=: load bind (jpath '~addons/demos/glsimple/gldemos.ijs')`notsupport@.('Android'-:UNAME)
dopengldem=: load bind (jpath '~addons/demos/gldemo/gldemo.ijs')`notsupport@.('Android'-:UNAME)
dplot=: load bind (jpath '~addons/demos/wdplot/plotdemo.ijs')
dpousse=: load bind (jpath '~addons/games/pousse/pousse.ijs')
dprinter=: load bind (jpath '~addons/demos/wd/printer.ijs')
dqtdemo=: load bind (jpath '~addons/ide/qt/demo/qtdemo.ijs')
dregex=: load bind (jpath '~addons/demos/wd/regdemo.ijs')
dsolitaire=: load bind (jpath '~addons/games/solitaire/solitaire.ijs')
dtabula=: load bind (jpath '~addons/math/tabula/tabula.ijs')
dtreemap=: load bind (jpath '~addons/graphics/treemap/demo.ijs')
dunicode=: load bind (jpath '~addons/demos/wd/unicode.ijs')
dunisimple=: load bind (jpath '~addons/demos/wd/unisimple.ijs')

NB. =========================================================
deigenpic=: 3 : 0
if. fexist jpath '~addons/math/lapack/lapack.ijs' do.
  load '~addons/math/eigenpic/eigenpic.ijs'
else.
  sminfo 'Eigenpicture';'This demo requires the LAPACK Addon'
end.
)

NB. =========================================================
dformedit=: 3 : 0
(<f=. jpath '~temp/formedit.ijs') 1!:2~ (1!:1) <jpath '~addons/demos/wd/life.ijs'
wdformedit f
)

NB. =========================================================
dscriptdoc=: 3 : 0
load 'scriptdoc'
scriptdoc jpath '~system/main/task.ijs'
)

NB. =========================================================
notsupport=: 3 : 0
sminfo 'This demo is not supported on ', UNAME
)

demos_run`start_droidwd@.IFJCDROID coname''
