NB. built from project: ~Source/examples/unicode/unicode
NB. init

require 'droidwd wdclass gl2'

require 'jzgrid plot'

coclass 'judemo'
coinsert 'wdbase'
droidwd_run=: unicode_run

IFUNICODE=: 1
CELLALIGN=: 0
CELLFMT=: ',c'
CELLVALS=: 6146 35755 22079 12852 42854 92439
GRIDNAMES=: 'cellalign celldata cellfmt'

NB. util

n=. 'This demo shows examples of traditional Chinese characters in a form.'
NOTES=: n,' It assumes that your system and form font supports these characters.'



NB. demo data

PLOTDATA=: 1.5 2.7 2.7 2.1,2 0.4 2 4.4,:5.5 0.5 3.5 7.5

NB. =========================================================
NB. texts
t=. 0 : 0
0;OK;確定;
1;Close;關閉;
2;Show English;顯示漢語;
3;Apples;蘋果;
4;Bananas;香蕉;
5;Oranges;橙;
6;Hong Kong;香港;
7;United States;美國;
8;Australia;澳洲;
9;Singapore;新加坡;
10;United Kingdom;英國;
11;France;法國;
12;Fruit Sales;特價生果;
13;No problem;沒有問題;
)

t=. <;._2 &> <;._2 t
UNITEXTS=: (0 ". each {."1 t) 0 }"0 1 t

NB. following is UTF-16 Show English, actual text used is Show Chinese:
NB. 39023 31034 33521 35486

NB. =========================================================
unitext=: 3 : 0
((; {."1 UNITEXTS) i. y) { (1+IFUNICODE) {"1 UNITEXTS
)

NB. =========================================================
unitextr=: 3 : 0
((; {."1 UNITEXTS) i. y) { (1+-.IFUNICODE) {"1 UNITEXTS
)

NB. =========================================================
unitexts=: 3 : 0
((; {."1 UNITEXTS) i. y) { 1 2 {"1 UNITEXTS
)

NB. =========================================================
EDITTEXTS=: unitexts 13

NB. =========================================================
setdata=: 3 : 0
CELLDATA=: (unitext 6+i.6),.<&>CELLVALS
TOGGLE=: > unitextr 2
setplotdata''
)

NB. =========================================================
setplotdata=: 3 : 0
PLOTKEYS=: }. ; ',', each unitext 3 4 5
PLOTTITLE=: > unitext 12
'OK CLOSE'=: unitext 0 1
)


NB. win

NB. =========================================================
UNIDEMO=: 0 : 0
pc unicode;pn "Unicode Demo";
bin v;
cc notes static;cn "";
bin hs;
cc viewsource button;cn "View Source";
bin z;
bin hv;
cc edit0 edit;
wh 348 172;cc grid isigraph;
bin zv;
cc ok button;cn "";
cc cancel button;cn "";
cc toggle button;cn "";
bin szz;
wh 516 220;cc plot isigraph;
bin z;
pas 0 4;pcenter;
rem form end;
)

NB. =========================================================
unicode_run=: 3 : 0
wd UNIDEMO
wd 'set notes text *',NOTES
PForm=: 'unicode'
PFormhwnd=: wdqhwndp''
NB. wd 'pshow;pshow sw_hide'
grid=: '' conew 'jzgrid'
plot=: '' conew 'jzplot'
PForm__plot=: 'unicode'
PFormhwnd__plot=: wdqhwndp''
PId__plot=: 'plot'
show''
wd 'pshow;'
)

NB. =========================================================
unicode_toggle_button=: 3 : 0
read''
IFUNICODE=: -. IFUNICODE
show''
)

NB. =========================================================
unicode_viewsource_button=: 3 : 0
fview jpath '~addons/demos/wd/unicode.ijs'
)

NB. =========================================================
unicode_viewnotes_button=: 3 : 0
sminfo 'Unicode';ALLNOTES
)

NB. =========================================================
read=: 3 : 0
EDITTEXTS=: (<edit0) IFUNICODE } EDITTEXTS
)

NB. =========================================================
show=: 3 : 0
setdata''
glsel_jgl2_ 'grid'
glsel_jgl2_ 'plot'
wd 'set edit0 text *',IFUNICODE pick EDITTEXTS
wd 'set ok text *',OK
wd 'set cancel text *',CLOSE
wd 'set toggle text *',TOGGLE
)

NB. =========================================================
unicode_grid_paint=: 3 : 0
show__grid GRIDNAMES
wd'setinvalid plot'
)

NB. =========================================================
unicode_plot_paint=: 3 : 0
pd__plot 'reset'
pd__plot 'type bar'
pd__plot 'axes 1 0'
pd__plot 'xlabel ',":2001+i.4
pd__plot 'keystyle of'
pd__plot 'keypos ro'
pd__plot 'key ',PLOTKEYS
pd__plot 'title ',PLOTTITLE
pd__plot PLOTDATA
pd__plot 'show'
)

NB. =========================================================
unicode_close=: 3 : 0
destroy__grid ''
destroy__plot ''
wd'pclose'
)

NB. =========================================================
unicode_cancel_button=: 3 : 0
unicode_close''
)

unicode_run`start_droidwd@.(('Android'-:UNAME)>IFQT) coname''
